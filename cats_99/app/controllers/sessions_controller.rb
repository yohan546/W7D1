class SessionsController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new 
  end

  def create
    user = User.new(user_params)

    if user.save
      login!(user)
      redirect_to user_url(user)
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def destroy
    current_user.reset_session_token! 
    session[:session_token] = nil 
    #unsure of syntax, was not covered in demo 
    #is a conditional required? 
  end 




  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
