module Api
  module V1
    class CampgroundsController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        campgrounds = Campground.order('created_at DESC')
        render json: {status: 'SUCCESS', message: 'Loaded campgrounds', data: campgrounds}
      end

      def show
        campground = Campground.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded campground', data: campground}
      end

      def create
        campground = Campground.new(campground_params)

        if campground.save
          render json: {status: 'SUCCESS', message: 'Campground saved', data: campground}
        else
          render json: {status: 'ERROR', message: 'Unable to save campground', data: campground.errors}
        end

      end

      def destroy
        campground = Campground.find(params[:id])
        campground.destroy
        render json: {status: 'SUCCESS', message: 'Deleted campground', data: campground}
      end

      def update
        campground = Campground.find(params[:id])
        if campground.update_attributes(campground_params)
          render json: {status: 'SUCCESS', message: 'Campground update', data: campground}
        else
          render json: {status: 'ERRORS', message: 'Unable to update campground', data: campground.errors}
        end
      end
      private

      def campground_params
        params.permit(:name, :description)
      end
    end
  end
end
