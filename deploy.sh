docker build -t sunsplash/docker-demo-complex-client:latest -t sunsplash/docker-demo-complex-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t sunsplash/docker-demo-complex-api:latest -t sunsplash/docker-demo-complex-api:$GIT_SHA -f ./api/Dockerfile ./api
docker build -t sunsplash/docker-demo-complex-worker:latest -t sunsplash/docker-demo-complex-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push sunsplash/docker-demo-complex-client:latest
docker push sunsplash/docker-demo-complex-client:$GIT_SHA
docker push sunsplash/docker-demo-complex-api:latest
docker push sunsplash/docker-demo-complex-api:$GIT_SHA
docker push sunsplash/docker-demo-complex-worker:latest
docker push sunsplash/docker-demo-complex-worker:$GIT_SHA

kubectl apply -f k8s # this works because we configured the google cloud sdk in our before_install section of the .travis.yml file
kubectl set image deployments/client-deployment client=sunsplash/docker-demo-complex-client:$GIT_SHA
kubectl set image deployments/api-deployment api=sunsplash/docker-demo-complex-api:$GIT_SHA
kubectl set image deployments/worker-deployment worker=sunsplash/docker-demo-complex-worker:$GIT_SHA