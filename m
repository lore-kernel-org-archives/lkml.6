Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425386AbeE1Q2p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:28:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:59310 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425368AbeE1Q2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:28:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,453,1520924400";
   d="gz'50?scan'50,208,50";a="43460277"
Date: Tue, 29 May 2018 00:27:57 +0800
From: kbuild test robot <lkp@intel.com>
To: Greg Thelen <gthelen@google.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: drivers/nvme/host/rdma.c:554: undefined reference to
 `rdma_disconnect'
Message-ID: <201805290052.ogLXW8GV%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   786b71f5b754273ccef6d9462e52062b3e1f9877
commit: 9533b292a7acc62c294ebcbd9e1f9f9d52adb10b IB: remove redundant INFINIBAND kconfig dependencies
date:   3 weeks ago
config: x86_64-randconfig-s2-05282235 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 9533b292a7acc62c294ebcbd9e1f9f9d52adb10b
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/nvme/host/rdma.o: In function `nvme_rdma_stop_queue':
>> drivers/nvme/host/rdma.c:554: undefined reference to `rdma_disconnect'
>> drivers/nvme/host/rdma.c:555: undefined reference to `ib_drain_qp'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_free_dev':
>> drivers/nvme/host/rdma.c:332: undefined reference to `ib_dealloc_pd'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_unmap_data':
>> drivers/nvme/host/rdma.c:1065: undefined reference to `ib_mr_pool_put'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_map_sg_fr':
>> drivers/nvme/host/rdma.c:1124: undefined reference to `ib_mr_pool_get'
   drivers/nvme/host/rdma.c:1134: undefined reference to `ib_mr_pool_put'
>> drivers/nvme/host/rdma.c:1132: undefined reference to `ib_map_mr_sg'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_wr_error':
>> drivers/nvme/host/rdma.c:1007: undefined reference to `ib_wc_status_msg'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_create_qp':
>> drivers/nvme/host/rdma.c:258: undefined reference to `rdma_create_qp'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_destroy_queue_ib':
>> drivers/nvme/host/rdma.c:402: undefined reference to `ib_mr_pool_destroy'
>> drivers/nvme/host/rdma.c:409: undefined reference to `ib_destroy_qp'
>> drivers/nvme/host/rdma.c:410: undefined reference to `ib_free_cq'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_free_queue':
>> drivers/nvme/host/rdma.c:570: undefined reference to `rdma_destroy_id'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_alloc_queue':
>> drivers/nvme/host/rdma.c:511: undefined reference to `__rdma_create_id'
>> drivers/nvme/host/rdma.c:523: undefined reference to `rdma_resolve_addr'
   drivers/nvme/host/rdma.c:544: undefined reference to `rdma_destroy_id'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_find_get_device':
>> drivers/nvme/host/rdma.c:365: undefined reference to `__ib_alloc_pd'
   drivers/nvme/host/rdma.c:383: undefined reference to `ib_dealloc_pd'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_create_queue_ib':
>> drivers/nvme/host/rdma.c:447: undefined reference to `__ib_alloc_cq'
>> drivers/nvme/host/rdma.c:485: undefined reference to `rdma_destroy_qp'
   drivers/nvme/host/rdma.c:487: undefined reference to `ib_free_cq'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_addr_resolved':
>> drivers/nvme/host/rdma.c:1461: undefined reference to `rdma_resolve_route'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_route_resolved':
>> drivers/nvme/host/rdma.c:1512: undefined reference to `rdma_connect'
   drivers/nvme/host/rdma.o: In function `nvme_rdma_conn_rejected':
>> drivers/nvme/host/rdma.c:1436: undefined reference to `rdma_reject_msg'

vim +554 drivers/nvme/host/rdma.c

71102307 Christoph Hellwig 2016-07-06  345  
71102307 Christoph Hellwig 2016-07-06  346  static struct nvme_rdma_device *
71102307 Christoph Hellwig 2016-07-06  347  nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
71102307 Christoph Hellwig 2016-07-06  348  {
71102307 Christoph Hellwig 2016-07-06  349  	struct nvme_rdma_device *ndev;
71102307 Christoph Hellwig 2016-07-06  350  
71102307 Christoph Hellwig 2016-07-06  351  	mutex_lock(&device_list_mutex);
71102307 Christoph Hellwig 2016-07-06  352  	list_for_each_entry(ndev, &device_list, entry) {
71102307 Christoph Hellwig 2016-07-06  353  		if (ndev->dev->node_guid == cm_id->device->node_guid &&
71102307 Christoph Hellwig 2016-07-06  354  		    nvme_rdma_dev_get(ndev))
71102307 Christoph Hellwig 2016-07-06  355  			goto out_unlock;
71102307 Christoph Hellwig 2016-07-06  356  	}
71102307 Christoph Hellwig 2016-07-06  357  
71102307 Christoph Hellwig 2016-07-06  358  	ndev = kzalloc(sizeof(*ndev), GFP_KERNEL);
71102307 Christoph Hellwig 2016-07-06  359  	if (!ndev)
71102307 Christoph Hellwig 2016-07-06  360  		goto out_err;
71102307 Christoph Hellwig 2016-07-06  361  
71102307 Christoph Hellwig 2016-07-06  362  	ndev->dev = cm_id->device;
71102307 Christoph Hellwig 2016-07-06  363  	kref_init(&ndev->ref);
71102307 Christoph Hellwig 2016-07-06  364  
11975e01 Christoph Hellwig 2016-09-05 @365  	ndev->pd = ib_alloc_pd(ndev->dev,
11975e01 Christoph Hellwig 2016-09-05  366  		register_always ? 0 : IB_PD_UNSAFE_GLOBAL_RKEY);
71102307 Christoph Hellwig 2016-07-06  367  	if (IS_ERR(ndev->pd))
71102307 Christoph Hellwig 2016-07-06  368  		goto out_free_dev;
71102307 Christoph Hellwig 2016-07-06  369  
71102307 Christoph Hellwig 2016-07-06  370  	if (!(ndev->dev->attrs.device_cap_flags &
71102307 Christoph Hellwig 2016-07-06  371  	      IB_DEVICE_MEM_MGT_EXTENSIONS)) {
71102307 Christoph Hellwig 2016-07-06  372  		dev_err(&ndev->dev->dev,
71102307 Christoph Hellwig 2016-07-06  373  			"Memory registrations not supported.\n");
11975e01 Christoph Hellwig 2016-09-05  374  		goto out_free_pd;
71102307 Christoph Hellwig 2016-07-06  375  	}
71102307 Christoph Hellwig 2016-07-06  376  
71102307 Christoph Hellwig 2016-07-06  377  	list_add(&ndev->entry, &device_list);
71102307 Christoph Hellwig 2016-07-06  378  out_unlock:
71102307 Christoph Hellwig 2016-07-06  379  	mutex_unlock(&device_list_mutex);
71102307 Christoph Hellwig 2016-07-06  380  	return ndev;
71102307 Christoph Hellwig 2016-07-06  381  
71102307 Christoph Hellwig 2016-07-06  382  out_free_pd:
71102307 Christoph Hellwig 2016-07-06  383  	ib_dealloc_pd(ndev->pd);
71102307 Christoph Hellwig 2016-07-06  384  out_free_dev:
71102307 Christoph Hellwig 2016-07-06  385  	kfree(ndev);
71102307 Christoph Hellwig 2016-07-06  386  out_err:
71102307 Christoph Hellwig 2016-07-06  387  	mutex_unlock(&device_list_mutex);
71102307 Christoph Hellwig 2016-07-06  388  	return NULL;
71102307 Christoph Hellwig 2016-07-06  389  }
71102307 Christoph Hellwig 2016-07-06  390  
71102307 Christoph Hellwig 2016-07-06  391  static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
71102307 Christoph Hellwig 2016-07-06  392  {
eb1bd249 Max Gurtovoy      2017-11-28  393  	struct nvme_rdma_device *dev;
eb1bd249 Max Gurtovoy      2017-11-28  394  	struct ib_device *ibdev;
eb1bd249 Max Gurtovoy      2017-11-28  395  
eb1bd249 Max Gurtovoy      2017-11-28  396  	if (!test_and_clear_bit(NVME_RDMA_Q_TR_READY, &queue->flags))
eb1bd249 Max Gurtovoy      2017-11-28  397  		return;
eb1bd249 Max Gurtovoy      2017-11-28  398  
eb1bd249 Max Gurtovoy      2017-11-28  399  	dev = queue->device;
eb1bd249 Max Gurtovoy      2017-11-28  400  	ibdev = dev->dev;
71102307 Christoph Hellwig 2016-07-06  401  
f41725bb Israel Rukshin    2017-11-26 @402  	ib_mr_pool_destroy(queue->qp, &queue->qp->rdma_mrs);
f41725bb Israel Rukshin    2017-11-26  403  
eb1bd249 Max Gurtovoy      2017-11-28  404  	/*
eb1bd249 Max Gurtovoy      2017-11-28  405  	 * The cm_id object might have been destroyed during RDMA connection
eb1bd249 Max Gurtovoy      2017-11-28  406  	 * establishment error flow to avoid getting other cma events, thus
eb1bd249 Max Gurtovoy      2017-11-28  407  	 * the destruction of the QP shouldn't use rdma_cm API.
eb1bd249 Max Gurtovoy      2017-11-28  408  	 */
eb1bd249 Max Gurtovoy      2017-11-28 @409  	ib_destroy_qp(queue->qp);
71102307 Christoph Hellwig 2016-07-06 @410  	ib_free_cq(queue->ib_cq);
71102307 Christoph Hellwig 2016-07-06  411  
71102307 Christoph Hellwig 2016-07-06  412  	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
71102307 Christoph Hellwig 2016-07-06  413  			sizeof(struct nvme_completion), DMA_FROM_DEVICE);
71102307 Christoph Hellwig 2016-07-06  414  
71102307 Christoph Hellwig 2016-07-06  415  	nvme_rdma_dev_put(dev);
71102307 Christoph Hellwig 2016-07-06  416  }
71102307 Christoph Hellwig 2016-07-06  417  
f41725bb Israel Rukshin    2017-11-26  418  static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
f41725bb Israel Rukshin    2017-11-26  419  {
f41725bb Israel Rukshin    2017-11-26  420  	return min_t(u32, NVME_RDMA_MAX_SEGMENTS,
f41725bb Israel Rukshin    2017-11-26  421  		     ibdev->attrs.max_fast_reg_page_list_len);
f41725bb Israel Rukshin    2017-11-26  422  }
f41725bb Israel Rukshin    2017-11-26  423  
ca6e95bb Sagi Grimberg     2017-05-04  424  static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
71102307 Christoph Hellwig 2016-07-06  425  {
ca6e95bb Sagi Grimberg     2017-05-04  426  	struct ib_device *ibdev;
71102307 Christoph Hellwig 2016-07-06  427  	const int send_wr_factor = 3;			/* MR, SEND, INV */
71102307 Christoph Hellwig 2016-07-06  428  	const int cq_factor = send_wr_factor + 1;	/* + RECV */
71102307 Christoph Hellwig 2016-07-06  429  	int comp_vector, idx = nvme_rdma_queue_idx(queue);
71102307 Christoph Hellwig 2016-07-06  430  	int ret;
71102307 Christoph Hellwig 2016-07-06  431  
ca6e95bb Sagi Grimberg     2017-05-04  432  	queue->device = nvme_rdma_find_get_device(queue->cm_id);
ca6e95bb Sagi Grimberg     2017-05-04  433  	if (!queue->device) {
ca6e95bb Sagi Grimberg     2017-05-04  434  		dev_err(queue->cm_id->device->dev.parent,
ca6e95bb Sagi Grimberg     2017-05-04  435  			"no client data found!\n");
ca6e95bb Sagi Grimberg     2017-05-04  436  		return -ECONNREFUSED;
ca6e95bb Sagi Grimberg     2017-05-04  437  	}
ca6e95bb Sagi Grimberg     2017-05-04  438  	ibdev = queue->device->dev;
71102307 Christoph Hellwig 2016-07-06  439  
71102307 Christoph Hellwig 2016-07-06  440  	/*
0b36658c Sagi Grimberg     2017-07-13  441  	 * Spread I/O queues completion vectors according their queue index.
0b36658c Sagi Grimberg     2017-07-13  442  	 * Admin queues can always go on completion vector 0.
71102307 Christoph Hellwig 2016-07-06  443  	 */
0b36658c Sagi Grimberg     2017-07-13  444  	comp_vector = idx == 0 ? idx : idx - 1;
71102307 Christoph Hellwig 2016-07-06  445  
71102307 Christoph Hellwig 2016-07-06  446  	/* +1 for ib_stop_cq */
ca6e95bb Sagi Grimberg     2017-05-04 @447  	queue->ib_cq = ib_alloc_cq(ibdev, queue,
ca6e95bb Sagi Grimberg     2017-05-04  448  				cq_factor * queue->queue_size + 1,
ca6e95bb Sagi Grimberg     2017-05-04  449  				comp_vector, IB_POLL_SOFTIRQ);
71102307 Christoph Hellwig 2016-07-06  450  	if (IS_ERR(queue->ib_cq)) {
71102307 Christoph Hellwig 2016-07-06  451  		ret = PTR_ERR(queue->ib_cq);
ca6e95bb Sagi Grimberg     2017-05-04  452  		goto out_put_dev;
71102307 Christoph Hellwig 2016-07-06  453  	}
71102307 Christoph Hellwig 2016-07-06  454  
71102307 Christoph Hellwig 2016-07-06  455  	ret = nvme_rdma_create_qp(queue, send_wr_factor);
71102307 Christoph Hellwig 2016-07-06  456  	if (ret)
71102307 Christoph Hellwig 2016-07-06  457  		goto out_destroy_ib_cq;
71102307 Christoph Hellwig 2016-07-06  458  
71102307 Christoph Hellwig 2016-07-06  459  	queue->rsp_ring = nvme_rdma_alloc_ring(ibdev, queue->queue_size,
71102307 Christoph Hellwig 2016-07-06  460  			sizeof(struct nvme_completion), DMA_FROM_DEVICE);
71102307 Christoph Hellwig 2016-07-06  461  	if (!queue->rsp_ring) {
71102307 Christoph Hellwig 2016-07-06  462  		ret = -ENOMEM;
71102307 Christoph Hellwig 2016-07-06  463  		goto out_destroy_qp;
71102307 Christoph Hellwig 2016-07-06  464  	}
71102307 Christoph Hellwig 2016-07-06  465  
f41725bb Israel Rukshin    2017-11-26 @466  	ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
f41725bb Israel Rukshin    2017-11-26  467  			      queue->queue_size,
f41725bb Israel Rukshin    2017-11-26  468  			      IB_MR_TYPE_MEM_REG,
f41725bb Israel Rukshin    2017-11-26  469  			      nvme_rdma_get_max_fr_pages(ibdev));
f41725bb Israel Rukshin    2017-11-26  470  	if (ret) {
f41725bb Israel Rukshin    2017-11-26  471  		dev_err(queue->ctrl->ctrl.device,
f41725bb Israel Rukshin    2017-11-26  472  			"failed to initialize MR pool sized %d for QID %d\n",
f41725bb Israel Rukshin    2017-11-26  473  			queue->queue_size, idx);
f41725bb Israel Rukshin    2017-11-26  474  		goto out_destroy_ring;
f41725bb Israel Rukshin    2017-11-26  475  	}
f41725bb Israel Rukshin    2017-11-26  476  
eb1bd249 Max Gurtovoy      2017-11-28  477  	set_bit(NVME_RDMA_Q_TR_READY, &queue->flags);
eb1bd249 Max Gurtovoy      2017-11-28  478  
71102307 Christoph Hellwig 2016-07-06  479  	return 0;
71102307 Christoph Hellwig 2016-07-06  480  
f41725bb Israel Rukshin    2017-11-26  481  out_destroy_ring:
f41725bb Israel Rukshin    2017-11-26  482  	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
f41725bb Israel Rukshin    2017-11-26  483  			    sizeof(struct nvme_completion), DMA_FROM_DEVICE);
71102307 Christoph Hellwig 2016-07-06  484  out_destroy_qp:
1f61def9 Max Gurtovoy      2017-11-06 @485  	rdma_destroy_qp(queue->cm_id);
71102307 Christoph Hellwig 2016-07-06  486  out_destroy_ib_cq:
71102307 Christoph Hellwig 2016-07-06 @487  	ib_free_cq(queue->ib_cq);
ca6e95bb Sagi Grimberg     2017-05-04  488  out_put_dev:
ca6e95bb Sagi Grimberg     2017-05-04  489  	nvme_rdma_dev_put(queue->device);
71102307 Christoph Hellwig 2016-07-06  490  	return ret;
71102307 Christoph Hellwig 2016-07-06  491  }
71102307 Christoph Hellwig 2016-07-06  492  
41e8cfa1 Sagi Grimberg     2017-07-10  493  static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
71102307 Christoph Hellwig 2016-07-06  494  		int idx, size_t queue_size)
71102307 Christoph Hellwig 2016-07-06  495  {
71102307 Christoph Hellwig 2016-07-06  496  	struct nvme_rdma_queue *queue;
8f4e8dac Max Gurtovoy      2017-02-19  497  	struct sockaddr *src_addr = NULL;
71102307 Christoph Hellwig 2016-07-06  498  	int ret;
71102307 Christoph Hellwig 2016-07-06  499  
71102307 Christoph Hellwig 2016-07-06  500  	queue = &ctrl->queues[idx];
71102307 Christoph Hellwig 2016-07-06  501  	queue->ctrl = ctrl;
71102307 Christoph Hellwig 2016-07-06  502  	init_completion(&queue->cm_done);
71102307 Christoph Hellwig 2016-07-06  503  
71102307 Christoph Hellwig 2016-07-06  504  	if (idx > 0)
71102307 Christoph Hellwig 2016-07-06  505  		queue->cmnd_capsule_len = ctrl->ctrl.ioccsz * 16;
71102307 Christoph Hellwig 2016-07-06  506  	else
71102307 Christoph Hellwig 2016-07-06  507  		queue->cmnd_capsule_len = sizeof(struct nvme_command);
71102307 Christoph Hellwig 2016-07-06  508  
71102307 Christoph Hellwig 2016-07-06  509  	queue->queue_size = queue_size;
71102307 Christoph Hellwig 2016-07-06  510  
71102307 Christoph Hellwig 2016-07-06 @511  	queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
71102307 Christoph Hellwig 2016-07-06  512  			RDMA_PS_TCP, IB_QPT_RC);
71102307 Christoph Hellwig 2016-07-06  513  	if (IS_ERR(queue->cm_id)) {
71102307 Christoph Hellwig 2016-07-06  514  		dev_info(ctrl->ctrl.device,
71102307 Christoph Hellwig 2016-07-06  515  			"failed to create CM ID: %ld\n", PTR_ERR(queue->cm_id));
71102307 Christoph Hellwig 2016-07-06  516  		return PTR_ERR(queue->cm_id);
71102307 Christoph Hellwig 2016-07-06  517  	}
71102307 Christoph Hellwig 2016-07-06  518  
8f4e8dac Max Gurtovoy      2017-02-19  519  	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR)
0928f9b4 Sagi Grimberg     2017-02-05  520  		src_addr = (struct sockaddr *)&ctrl->src_addr;
8f4e8dac Max Gurtovoy      2017-02-19  521  
0928f9b4 Sagi Grimberg     2017-02-05  522  	queue->cm_error = -ETIMEDOUT;
0928f9b4 Sagi Grimberg     2017-02-05 @523  	ret = rdma_resolve_addr(queue->cm_id, src_addr,
0928f9b4 Sagi Grimberg     2017-02-05  524  			(struct sockaddr *)&ctrl->addr,
71102307 Christoph Hellwig 2016-07-06  525  			NVME_RDMA_CONNECT_TIMEOUT_MS);
71102307 Christoph Hellwig 2016-07-06  526  	if (ret) {
71102307 Christoph Hellwig 2016-07-06  527  		dev_info(ctrl->ctrl.device,
71102307 Christoph Hellwig 2016-07-06  528  			"rdma_resolve_addr failed (%d).\n", ret);
71102307 Christoph Hellwig 2016-07-06  529  		goto out_destroy_cm_id;
71102307 Christoph Hellwig 2016-07-06  530  	}
71102307 Christoph Hellwig 2016-07-06  531  
71102307 Christoph Hellwig 2016-07-06  532  	ret = nvme_rdma_wait_for_cm(queue);
71102307 Christoph Hellwig 2016-07-06  533  	if (ret) {
71102307 Christoph Hellwig 2016-07-06  534  		dev_info(ctrl->ctrl.device,
d8bfceeb Sagi Grimberg     2017-10-11  535  			"rdma connection establishment failed (%d)\n", ret);
71102307 Christoph Hellwig 2016-07-06  536  		goto out_destroy_cm_id;
71102307 Christoph Hellwig 2016-07-06  537  	}
71102307 Christoph Hellwig 2016-07-06  538  
5013e98b Sagi Grimberg     2017-10-11  539  	set_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags);
71102307 Christoph Hellwig 2016-07-06  540  
71102307 Christoph Hellwig 2016-07-06  541  	return 0;
71102307 Christoph Hellwig 2016-07-06  542  
71102307 Christoph Hellwig 2016-07-06  543  out_destroy_cm_id:
71102307 Christoph Hellwig 2016-07-06 @544  	rdma_destroy_id(queue->cm_id);
eb1bd249 Max Gurtovoy      2017-11-28  545  	nvme_rdma_destroy_queue_ib(queue);
71102307 Christoph Hellwig 2016-07-06  546  	return ret;
71102307 Christoph Hellwig 2016-07-06  547  }
71102307 Christoph Hellwig 2016-07-06  548  
71102307 Christoph Hellwig 2016-07-06  549  static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
71102307 Christoph Hellwig 2016-07-06  550  {
a57bd541 Sagi Grimberg     2017-08-28  551  	if (!test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
a57bd541 Sagi Grimberg     2017-08-28  552  		return;
a57bd541 Sagi Grimberg     2017-08-28  553  
71102307 Christoph Hellwig 2016-07-06 @554  	rdma_disconnect(queue->cm_id);
71102307 Christoph Hellwig 2016-07-06 @555  	ib_drain_qp(queue->qp);
71102307 Christoph Hellwig 2016-07-06  556  }
71102307 Christoph Hellwig 2016-07-06  557  
71102307 Christoph Hellwig 2016-07-06  558  static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
71102307 Christoph Hellwig 2016-07-06  559  {
5013e98b Sagi Grimberg     2017-10-11  560  	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
a57bd541 Sagi Grimberg     2017-08-28  561  		return;
a57bd541 Sagi Grimberg     2017-08-28  562  
bd9f0759 Sagi Grimberg     2017-10-19  563  	if (nvme_rdma_queue_idx(queue) == 0) {
bd9f0759 Sagi Grimberg     2017-10-19  564  		nvme_rdma_free_qe(queue->device->dev,
bd9f0759 Sagi Grimberg     2017-10-19  565  			&queue->ctrl->async_event_sqe,
bd9f0759 Sagi Grimberg     2017-10-19  566  			sizeof(struct nvme_command), DMA_TO_DEVICE);
bd9f0759 Sagi Grimberg     2017-10-19  567  	}
bd9f0759 Sagi Grimberg     2017-10-19  568  
71102307 Christoph Hellwig 2016-07-06  569  	nvme_rdma_destroy_queue_ib(queue);
71102307 Christoph Hellwig 2016-07-06 @570  	rdma_destroy_id(queue->cm_id);
71102307 Christoph Hellwig 2016-07-06  571  }
71102307 Christoph Hellwig 2016-07-06  572  

:::::: The code at line 554 was first introduced by commit
:::::: 7110230719602852481c2793d054f866b2bf4a2b nvme-rdma: add a NVMe over Fabrics RDMA host driver

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@fb.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--yrj/dFKFPuw6o+aM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICBIpDFsAAy5jb25maWcAlDzLduQ2rvt8RZ3OZmaRxO7uOLnnHi9YElXFlB5skqqHNzqO
XZ34jNvu8WOS/P0FQKlEUpAnN4u0RYAUCeINqL795tuFeH15/HL9cndzfX//1+K348Px6frl
eLv4fHd//N9F3izqxi1krtz3gFzePbz++cOfP190Fx8XH78//+n7s++ebs4Xm+PTw/F+kT0+
fL777RUWuHt8+Obbb7KmLtQKcJfKXf41PO5pevQ8PqjaOtNmTjV1l8usyaUZgU3rdOu6ojGV
cJfvjvefLz5+B7v57uLjuwFHmGwNMwv/ePnu+unmd9zxDze0ued+993t8bMfOc0sm2yTS93Z
VuvGBBu2TmQbZ0Qmp7CqascHendVCd2ZOu/g0LarVH35/ue3EMT+8sN7HiFrKi3cuNDMOhEa
LHd+MeDVUuZdXokOUeEYTo6bJZhdEbiU9cqtR9hK1tKorFNWIHwKWLYrdrAzshRObWWnG1U7
aewUbb2TarV2KdnEoVsLnJh1RZ6NULOzsur22Xol8rwT5aoxyq2r6bqZKNXSwBnh+ktxSNZf
C9tluqUN7jmYyNayK1UNl6yuAjrRpqx0re60NLSGMFIkhBxAslrCU6GMdV22buvNDJ4WK8mj
+R2ppTS1IDHQjbVqWcoExbZWS7j9GfBO1K5bt/AWXcE9r2HPHAYRT5SE6crliHLVACXg7j+8
D6a1oAdo8mQvJBa2a7RTFZAvB0EGWqp6NYeZS2QXJIMoQfJGtI2wosYN582ua4oCSH959uft
Z/jv5uz0H79oq02zlAHPFWrfSWHKAzx3lQy4Rq+cAKoB629laS8/DuPwj9dATci7ynzqdo0J
rmnZqjKHw8pO7v1KNlIMbg1MgmQoGvhf54TFyaAUv12sSMneL56PL69fRzW5NM1G1h1s1FY6
1IhAc1lv4aigo4C6LtAXmYHbJwWggAPevYPVT+egsc5J6xZ3z4uHxxd8YaDsRLkF+QQOw3nM
MFy3axI52ABXyrJbXSnNQ5YAec+DyqtQk4SQ/dXcjJn3l1doP05nDXYVHjWF097eQsAdvgXf
X709u2EIHe24HwPzJNoSxLOxrhYVXNw/Hh4fjv8Mrs/uhGZWswe7VTqQln4A/81cGRIF9AIw
f/Wpla1kt+15B4SiMYdOODByaxavtRIUK7MZUgfJBZE8EgB3BKKdaA9+FHSRi5QKDToj5SAz
IICL59dfn/96fjl+GWXmZKhAPkn2GRsGILtudjwkW4ecjCN5UwmwtdGYVRWHBGoalCec+DBd
vLIKMWcBk/eEuwL3xsDlkWYUoIl4LCOtNFtvJCrwlOItgpeUgR72eihSxFYLY2W/u9M1hyuT
ci4sc+cZekm2aWFtf2l5k6r4ECUXLpD5ELIFa52jsS4F2sBDVjJ3R/p1O+GZk8XH9UB/145x
MwIgqlaRZ/Cit9HAx+pE/kvL4lUN2pfc+1DEk+7uy/HpmWPL9RUaetXkKgtJXDcIUXnJCySB
WcgaHCa8biKIie6FdgIexQ/u+vlfixfY0uL64Xbx/HL98ry4vrl5fH14uXv4bdybU9nGezFZ
1rS186xxetVWGZeAkQbstpBV6IpGXBZvaXOUzkyCvgFUxyKhhUQXdXo6k7ULOyWyBvVQadcB
OPAWM/DB9kD80H+PMFCrpEP46uk6sJuyRENaNXUM8b6zXGXLUoXMgrBC1BCnXF58nA6CsyGK
wD1HyLJp0hVoqHdifxxdHXpxky3xdhI/BHz/+n1gFdSmD38mI3QP43DZ4AoFKEhVuMv3ZyNt
wXvfdFYUMsE5/xDp+xa8Je/9gPuce2mac/nqFkKNpShFnU0dQ/JGl6hRYJm2xoAF/NGuKFs7
623CHs/f/xzol5VpWh3oAvKyiTXDMBJMXhbx/LLc9HM5jUcAf77AsRTKdCwkK0DfiDrfqTwM
qUCqYvTRDvtxrXJW4XqoicKwfrAAVr6ik6WL9e78/Hq53KpMMjOBuVIRTfYpTcHMI5PBzEL/
BgxORl756FMgO1heqYA3MwMCT8TMwYB8CegUdjkABNqAOAx9W9p4uCswNAVGJqBZwOzKnH0R
BpAH5j3IREBV8tdNwA/0LCpY2Fu+wNs2+eBJj6vnb7ipAJx1UQEWu6fhnMCNpufAF82yU9CG
LgNdL+ZX6oQ7EjSMkXn/1Luhg7zW4JuoGpyT8AYICdR0JjU5L5RbSRxJnVm9ge2UwuF+AoWn
I/bzyp7ZSgUetkKOCV4MQlGBru8mHoW/+clwsQZBDh0T71R7KxyMkrZMn7u6UqGeDjSeLAtQ
S2FEPn9cAa5a0Ua7ap3cJ4/A/8HyuokOp1a1KIuAJ+kA4QA5QOGAXUfRslABC4l8q2BTPbUC
OsCUpTBGhTTfIMqhstORLiL1aZQOPKSRIi2ti+Gds9qB4qoi54KVIdEzbhJWq7PhHkaGwgxO
Lrk1PGPCW7qT00kOSp/+1Menz49PX64fbo4L+Z/jAzhgAlyxDF0wcBQDzyVa4vTmPiWCQDhL
t63I/2f2sa387MG0RasM2UCz4eSzFMtI45XtkiUmIgKpzEoO0eo8Gpoh9IM6A9LSVLxacLKi
aKDbgmNcqIzCllBkmkKVkVtAWoHSiAHzZEbYdSI7G7mXWTLW+AWZkZ50pB50GQoSXe8bE0Ge
veQEr04TTr+0lYaQZilD+QOvFiKIjTyAigHRx5RMuLxLF+lXxVRQkejGSYaLNi0LoKjCY7Ug
6SDuaOEy9LcT1wn5Cj1GcNXBK9+JIPbdGDnZCC2ugLDojgEwjfYnx/ejcysxRw2X4c5L8KKt
fUVAGgO2R9W/yCxmH0KL9O2YjaAV102zSYCY+IZnp1Zt0zIBpIWbxFitD6ETSqIqAU3tVHEY
DPsUwYLv4RMs7MZ8itCnG7vdWjkZhxMnxxickgM4UhgRk/miGcmSRq5Apda5L1f0198JndIk
KzlCAJ7XPwlsvQNNIsWG5DCBVWoPfDaCLe0hQSKfDRiiNTVEL0CuyDqkGpW5w7UwOUYV5GM6
iYnZwQedLMK8f1CnpqdL3lZp6pLIzAmupyuEXT7EKXw+Kr5kz3c+UsoqjXWKlOB+1OdWZ2B5
00Yp/HFfVmao0TvQQFEQMzdOM1fgrumyXak6Mg3B8Jx1AwyiEwo70TpxAmMg3GjNuYFTRLiZ
thT/ZTXg62YmhTBFRg9+7hRecJRbg5rz114YjENS6oP0y70jDbGJbA+BZ1IhqXqcJkFmtFCN
iTfZl2UwNP27eJ1ucw6XyjvgJrAMbZvCdTkcIdU9VZP3GFpmaIoDB67J2xIUMZoJ9FHRDWOO
K/fKobKm1CiSl1F9NJ38gWk1bVoGTe0ZvoBVu/GssbLKrBuURecWCVGYpXowoaNbOuUffRi0
uCtTqGe8Ps85tVZAW+UzJ6fychA0WgF2mlPftLFtX89lKQ9SpMCe9IUHsws8nDdA6XTPCux0
DnSabrD03oa2YhgZohhfA8ua7Xe/Xj8fbxf/8t7z16fHz3f3UaoSkfrNMm8i6OCb+Vgi0HQx
jFEUhOJbCUiXeOMyWaTH+NB9ZPVSiPOx+4kLwNHXBDUTcg/FOBb9+8uzRPZSYfR5fDAeoSj0
oLbuh0/bieZ4MLttwOurfHw2pV/HmuxUDJyJugZMxevtHoySZMAf4eL0XudQXrYEN60N1Nky
zidijsVmVgFPfWojL3rIviztih0s1XI6jh0KK6NCDTmAsPydx8NZlVN7AFVPIkuG0N2Sj5D8
ghjYFTyp6UzgRzVaRBQmMdHXTy932E2zcH99PT77ZH8fMQlwPskrhngc0zVcxFrZvLEjahDw
F4obJnr3ei8+ffWp05majKGNDHMD/XCfrvSlu2Zhb34/3r7eR0Gwanwmrm6aKAM2jOegVZHe
fJKwR8qKT8yph/pqv3Qy2s+9fPfw+Pg1KLnCtv/WuwO8zWEpzZsbXLIbFLY+D2K6mpolQIg0
+CsotfM5dOEaDANMtUsw0GRTrTenZajSNo9idhwCqf8hJ9ItZYH/oO8cVxcDXMrGdDsjtA6d
0DEx7bn46fHm+Pz8+LR4AS6m+tTn4/XL69Mx4Ieh4SRKT1RcRh4byAopIKSQPr0cTkHg/j3Y
TS5xgsBKkwBHir4p80LZNae9IZRt8HIiFgW9AeYz5yUeXwJepaxz7PfpE3qzmH6tUlteOyCK
qMZ1+sQ9s1PguKKrliqRJRqbzc7j8ife6lsBCqHKNs6JeV4GznPekR66uzj/+wCcsFUWPPRV
rKKB7ALVRbjwMDbd4EiBuPjYj2621Wn9sRFjW72ta0+ve6NqmaIOJa3TIr8AfdYNChNtgCs5
NFjDc1EGtdr8HBlqbTNeu6Ds8en/CoWf90KGIrVuZy6Zrgvz8H2jmy/mXYQo5fk8zHMpqgL0
ecdTIQwpocHX6mAu6JS2isHOZvFAH/MmLaBYYN/GI5WqVdVWFIIVolLlIaiqIgLddebKyga6
B7GBpf2Wp8MgTNPBDKIt0YZRtJYuzfXlVSRbK7CeIGBVxZEc1CLADx4eBb0hoJM1RgBgJQ5c
lnUQvp1qotY8P3cty0jn1tRYaDHoWqHyhij/8pwHgmqagvoNTAAwMMpPX3JPw/4JwrYpQbLg
oJxkeZxAMfSTkrihxXyMk1RAixmDMikYGyWcpZphMNKfRpoGPHCqW/VNdiieGL5yDimxXhiM
9QNYBy/lSmSH9AUA9Ow2v1rMd8Mgxo52DdZnCvJJzssvvQUNSgtfHh/uXh6fokgpTKH1slpT
QvxLcDcTHDDbvFM/Rc2oe5i7zQCVDFWzC7kSj3N+Men/llYXap+qgKHTp5NVWw4x82jMft7w
alFlpsFO8Tnq22Q/wNUqDymDgz9SI+hc4UivD3C8PDedS9vZfcM5plBZMOkpZeAuu9USkzmc
0wWWAoQyM4dQLJCafwcAdow6rkclwvh9gM9l8fs8EDpEfkXBNBqfwPzyVpZ4ut57QFcxCsV9
xsUDKc8/S2O4xW5Dridm5QJ9V6LYlYPTgSmVVmJP8PH69uxs2hPMb2gAnk5TiboVHCTNlw17
l1aG+ikg2x6C10pyoC38D8meUnbEoCJf5zekO9espFvH4eVktbm0J5Y24+AhGu7I/k/ThYP3
sAojb8/WCuTR5MzCPVHAzyuT5FYPWTcOU81z4/2hIpcoRhjCtaaej8ROM4D8zZZtSNAlOK3a
+bgWzdnH6IT+XgY01F8uPijFwkm1qVIrk5w6XOyUtmXwOEUypgLAALK+vfdZG0wJBruoWqai
srEB/w40JBb03Y25ufx49j8XsQTPRgAxoZnIYL0DqbTU5IH2iu/sY1Lac0rAV7vcWndxdTL6
eGITHDErpajJb43crJkumSvdNJySv1q2aBGGJ+tL75H17L8XAEpqPmIYZlG9d9zgIF30GcJQ
TL2Myv6FNEaeCoHEOuj08IkFrEgSylC1eKvZwQfVQ69XD/Uh3HYo7ySmwvpu0y1YtKIUK85c
aSxlBzwNUYGmdsm4nwH0CfihdbauBNuMgKZRo1rzXtVknwl8vB8y4hhsdEuIcDFbYVqduguI
hG4eBnLVwMEjql9gZle+sxrTkbsg5KicCbsI4amzAu5JXcnZ8UEnDKbzbAaN5AOrZOh2T1xx
ooRg7DrcBeaPiP/TUomvvsTktJH2DyK7Km5DGyEQrL0RUpaBZXe+KN/1zDE21BSKU8y+fhnp
kqvu/OyMM25X3fsfzxLUDzFqsgq/zCUsc1KU2DUS6E1qIok7P04M74G6NSvsxo/8fw+ippZD
mgUflBH1rMSFZ7QDCqMYkBqDHzid9z5M2GeIzf/IPZzbPcyndg+Y/z5ygXqJShzqSEWmKLMx
3ZD3XvKqE/wrPHqZu2n/HLkXJTinOv6+gxk60Rq/8uP85F6Q5twLHsf7Bac85OMfx6cFRFHX
vx2/HB9eKBMpMq0Wj18xyR5kI/uv6wKHrf/cbkxtDjdRdbaUMuJkGMOSEo1zl1eBndvIJAUb
jvYfep2PNxpBV1k4LXnzXK4PQL7344S8++TDtaB/aD4NgXQKyA1PAwsRj9pJ7cY7/vipZ1+5
xCk6/LSTRvreML8RijJt8JntGEZkQ4fKis07+rV0Zvx20p3qKGQj3PTS/P4gCCms383cW4zc
dsBVxqhchp9fxiuBVpj/jIYwREqKpXAQ3xzS0da5yNXEwS28u0nGClFPduFmCoCenA1rAQlG
STcjgUOiJrKBRtJihjdLvilOwCqfXMQJONmp0pWa3+q4qFitwEyiHp7bOsZPleBKxj1JUEe0
GnzzPN1eCmPY7409ZshVDe+3eaI2tROgS/maEaEM4Y/XYXNHHLBUkya8PG8v+fy3nzvT2O53
2FrXoLvk1s0baPAXpyNGORdaTjoXhvG+ySteEQHs+3Ltiqk8JrK2h6iNvxmN5bIGgvcV+CZv
3gz8zcqqd0NP2eAxLI/9muFDrEXxdPz36/Hh5q/F88113NAwCFWcgSYxWzVb/AjTYM/gDDj9
EukE7AOO0WIPgCH+w9lBYz9v5tlJSHcrtv+PKVgkoA8+OE+Im9DUOYREdf5fTwCw/oNHNtSP
aBV/xsBiDEebgZ/OMQN/c9tvbffEKJ9TRlncPt39xxfJGU9cT1KwEZLOqP6Dr5+vJPaa/U0k
8HNkDjbZl0WMqrk2O3rjR18cAw9wyFM//379dLydulPxutiM8WWkg7q9P8YyEhuOYYSoWoJ/
mHzyFIIrWbfsyTwN028vaQ/L1+dhx4t/gBJfHF9uvv9nkFwP+x5Qyft8bjxWVf4hwaSPfKOk
Df6B5azzs3XkuIH/hT7PsuV0EK5F/WBsjpneb9VkgP3OGGGfWmU2Nnn9vOOYoc/jcxu9hx3/
NAAZPtcuxwgdR0TYd4cDyCulpN8rmFJKhdU/HNAmOZAWVuXJin2/7hj89XYRb3Eicte3R6yf
AOy4uHl8eHl6vL/3H/B+/fr4BLzi8fLj891vDztgZERdZI/whz2hRBfW5TuqzE/7dmDi74/P
L8F7OOHeVjk7VT7cfn28e0jfh4U7SoKzk57/uHu5+Z1/Y3hRO6woQuzlwvC3/6WXuOEQCw31
MmYTzAdzfRIwMQ8bgfoBSiGT7cSPYj+E8W2P0HOU2Xdu31Eakv++bVgPNinrlWL7jk9IcSf7
+Kq2wt47lY2cOsAwS1VPhyvcUZflcjtoLHP99e4We5o8uSc0HmY6q378ac+8SNtuz4wj/sXP
PP5K1u+nxzF7gnxIUjwHWyyHiFf+ebx5fbn+9f5IP+i0oCLiy/Pih4X88np/nWjppaqLymHr
7rgkPMRf1lCBBpMZJ9uMrb5rCQ5z+E1cv5bNjNJxktsDKmW5Dh1cvc+UjKpbfHg/lgRnjNE+
/KGatIGtb+TFAnB78dHnTKq4mNP/jkY607cZbIntmvDT4prcNCJyfXz54/HpX2jAJ4YPHIiN
dIFipGeQCrEaB9ta7cMD4zOh8On0kvVSi/CrQXyi30pKhuh7yC/RkG2XHbY4ZYcE11cvZDJK
HzNZpzKbAIB6TRVl7LHROMqV9UPDyvwXZRXHFsqTe2QJ7T/gwt904M29PrVFdlT956JFQPKd
AVkpbGRcAKJrnT53+TrTyTZwmNLMc9tABCMMD0eKKD3zszUeuEJxA+7n0rAeo3NtHbVI20MN
jNxsVNwa57G3jkvHIqzNp0vheNFELSx4F53gmuUIIq0O6ybDGP6UU9qOHKKk7EODxFjplghy
Goxf5BkXy5y+6NSwnwanqH6tLzPgpQwFmIAkvsmGMs0NI02ZYSN2gw6ID4CDcN34JcyBl354
D/y5eqvr94STtcuwR2ZQ2AP88t3N6693N+/i1av8x7lubuCeC555ki+nYAR/Lguz/Fj8iflJ
O91LXHGYTtHrA/kLoGgqHX1MAxjp106noRM5AgtkVL6Swawh5ECHDnQ2GMQXcJLSHy0MxaVf
G3Yx07w+4iANVPxzbwPI9671+3kDAZQEB+1Xpl9OeQtOrb1vIZT/x9iTLTeOI/krin3Y6I6Y
nrYkH/JGzAMIkiLLvExQEl0vDLetnnK0j4qya7b37xcJgCQSTFB+qEOZCRA3MhN5lGi9FeCD
XhTqGZHqWqwif7hKBwOWdQJPZIO1GpgAEcQNqGySsMbtAZuNhn64BSS5lwEh2Trwy3qxYeB6
WQcqhJTzDcAkTNDBrnoCKV/RhhZAMEYUQeUcFZSNUdp8h7wMvtRR7G2FP3CXxpZ4pOxxiozp
GGqy4mucoXCHYZy5cFeR04bgqK74EBrM7D5ph2Wi9lqrmNN3KbW8/PH0enxcvLyBo4DFQdlF
O3OYEHu0VfM2EYz6+j/uf/z7+OGrtmH1Fi41HNCMIhlsXF9mqfrTbZYqFLyap0gyNGMUhfu2
PksN6g+lx/x0icyjLCZp6fVPUKppPNGzIv58fUXsPfxGImA5HYNxikwSfbrH4M7eUkp6ini8
C+fr5FXucQbwkJdVA555lXfxS5Hv4dvMnmogZl8Y1s1dFXmnRZMFlefEmpJ6IypRtPKWAXmM
3g2Gxg57ReBD7t1OhiDaT0L+UGRyW36u1REvTtQlGd/PDhecxeqe+HQB6jWeoDOc9dzIpJUy
DJ+lyVbNfCUmiPD8+pn00E+aMz77vQljOSFQIT7gHXmumiJWjNV8s0sRf67R5aGwJWyCwpW1
KZLkTmiN0wzNTWO2q59GMQknemZOxc/1DrTAvquvp+B6H899U3CPuEzR9vqGz7UQDsJiO9tE
fcDOk8g7cpZgZ2ubpASOHu30bxWKe3Vx6UA1Yyl/WSKlg8kZetHFaFekdcngGOlS6gDDBHj3
YBzeM1NcWs2VLCI0/+5nabcnm8qhISgK8MrTXyIbUkSe9kvEHA7HdneQacxwTDSDV6GPHN5z
pNgL9LW9cJXTGii5Yh2GYLkyXrPVXiw+fty/vsPDA3jHf7w9vD0vnt/uHxd/3D/fvz6AwvF9
+jChKwSDvBLWuq9ZhmIXVm5bNIKp24vGeREsoeGw43uWX/XsvfcIthyCFX1dO4tHwg61x8lW
YTPPaoGCGXdHPy6n9Zd76nQ3tQfTOgBWT6Y1mVbsETIN0sNaa2xxO2Hn1MDJKr1jJ9fpsI42
Vpn779+fnx6UgmPx7fj8XZU06P/5lCok7kSpFNeyvnPqJB5kfSBwRUOeQLBkrWr1VtDLrboG
JLyC0GmgWORMg9MNwlqV2K4MqzRcQoCZ3oxAso1y9CUqrYxo68ANf53QcOAh8boZUHWlrx3f
KhkIm4ZiBTXFoPtySvZCUeSa7Tv1F9sscltuyuqmUxjZoOkXa3aY6YmUjnYQisHbFDk9roZp
QLhqwQHRd8AcPWHEX48fc0veVCAJVdzQuNvWLICXp7JGC8YsrolOTy+bATy+ehllZNxFgS5L
d1QJMVhXDKBeh6x7IQELztPw3dd8U1EHRKvhwrFHfECvJ8eMqt6ENEzuH/7SFkyTwj5rAbgV
uS0qwK8uDLag8OLozU0hjE5av1eAPoODBhoZWvnoRMKW9COSr4QnXpWin7bAh4XvOpOkv+ho
9Gsyom8DAfwtKvjd5ZEs3KV0MEaLQl7XnionX2cNFYpRiXG2GfiqqWYMVRV6bz0xK4DNACpA
ZIc6Fvbsb+FYHX6ZjeH87tJtLlcNhOtwopEb/D5jhTnJaIcXHYdN6dRQZhYNwNIIgIzpsuch
DAgaeIchKlOIyIuRDb1en61pZG4HiVV92pytlrfjcIywbruv0TxZqHxfU4tAn1l2Z80p5n3/
zDI7FHjGV/YHWcMyWrPYri5IeMYqKuJ0lZSY546iCDpygfiEEdoVmfmPiu2bgmKI0X7KViHN
n5BUcstqIu8rq4pvQQ0pR9YvYQHxrUQJGVLIugK555gKyENUVlZRsdemN+NgWEDlKbZHCri9
7pVXG6iedVxDgb7XVYbNFRSk24py/LqCwPJw39m6wo66ngj85GYMiPDjAEhCaznWAgTlCarg
Atn8mqjh6jmwTkuygxaNeaD37Ne6BeO4uw6HPQ5u0fswhA/+kk5fCIz1xuLj+I4TJai23TQo
4p/azXUp+YqySJH7XMLymmkLKBO56eGv48eivn98ehukN0sFy+QuGicCfnUhyxlE1N1jRXZd
5uhSKcXUhJG1/5Sb8tV05fH4n6eHI2Vwlt+k5DvmJdilWMdydau9kEcIu+Nl3kEczThsSXhi
w++YpSfitmWV/AGsoN0lAAWcDm0CuO1h0mEJXoS6m6FrgQVF9pNv7tsJSGQTkFa7oa9zlnGQ
qSD6uS86pSTLIjp+P9RgRgBXq/6m4gNNiXiKW8n51dUZAQIzvsl3FGI2DhGQpXEK/5KxswGf
T2exitiNMoOMQ2dcvzBwZyOBVBN71InBiHJhhgKV7pvhKXWzZ7A6J2NYZe0UCEEztf4QfUIH
FdL+qdQkB9b1FkDs7Si0jgYJqWN44bCrHYBSWCLTCchqiqjC9UpAl/Mx5qtdm0JqbcuM2CgJ
kzSkta+Ao3vX2ebY6mcoEGAa1toCSkExTJzWDjg6xFfQ9Dxpf54Gzz+PH29vH9+mp9tYRsf8
QUPGc/T7ljNnFhKeBo0IU8rKXaN3rMbza2Bw6qGLzkIl5yS4kEIEI+sKuKicMepRrEnWNCdm
EZExLi38+pDWEdkmJ1CShYHBouBse9m2JCav99m0F/uE3J2BoX9xAB3MBoIeUmVbYws3sbz1
64pWJkvkDadOERiDDEVF5/EWeMMlUlkp/nOpUufldFyZvhicCVFWQmCCA6sh3yFRt4pWKb+s
EjGAPWK0DQOCDOK09KFZgWTiSW19VYu2FXnjjFT9DnIxvA4Z5WQ5EByilsypoTlpS/jtITr2
KycQNYfIE6Kp7UVGYTs7J6hNMESxmK2md5r/r5en1/ePH8fn7tuHHd2xJ80jj1Z2oHBv8ikF
IS+THxJ9nAZaasX1Kd8Vom9FqcNDEigphwSSHZxqeMZGZHk047c40ImGeTU64xw3M1+CzFSf
+FAaCPEZuoqgcmmaMJs8p6AemeekVqd0PRuPgdzOAat+mjlQUaD+tbHY7fgmJc9WEAWukamr
hpiQqN4SOjbqtJivt5ylMeZH0niWuLfPekHAnbDcc3hUJcYLa6zXwCDQkWRJ/FM0EMJ55ROJ
+77F9ht+DEqqbSqleQwsMFNnQB3cKB4DON4lhIdPcbz/sYifjs+QdOXl5edr/+jxiyzxq2Ec
3vHDBofkjnTLpaRTue2SoC5d0dcO4KviYr2epRCN6twcSdFWQOOvYh0f6uLCrcNQVIJJuR6/
X0v2Hgd/OGijZ0rnAekYTTwdA9pCcMcoc/UJcpGZa3nYe3d6UbgIHdTdSOCDGtsV38bkuE8P
BrwoXYeKnU7f4kY/RGCIlZJYebZke5q8ip1kOxomJfldQYZdbFgRsqzEoV/l5lAfitM6lze+
zqZCyUzxQcXsttsIYcLYUNJq30CrE1W4fSPRXcyyLEAR4FUKPXBWsZxoeo4oy8qDB+dArRFS
Qk+d0lt7kInqSEyLKd5el+28wbkUEVMRhw2pzuE6Ko/HuKbK5dCT4hXQ+10GmawDySk2qf1I
JFkpFPRG/4a9M4GJKrfkQQM8LCd0eY483UyFdrJXcBdSObdDSJ0Y4zCicg1EBY+GtGeDE+p4
QPVHbSk3KddvT+MV2dDvxiX1iO0G4ag4RLZ1+T4Dog4T2wtGucAYVkXxNoN0Vk0VXJIYhwwx
odUngK7YZRn8QIKDg+tM7O4+9Q8lTpgiSBsR1nYIpJ4ElBZChHIo02q9Ut54w5e/1oy6D/qi
IePXl2fTKnc6cOCkA1lZkgJuX10dWM2FX25PyVEJ6CXQ48XNCXy7mWlTbevuLKAJ0DrmL7Vx
isOyI8upoQcFKg/3dshdG2w2h5V8A6MPk8BukEEMYq/AixPRBc17qcVkq9EHqMoeMNd1ezYG
oFDSrmYx9nlkeQP3t6GEOgnIhqna59imFki1ZSIju6AIYhbUyMVOQXESUE2IEwwDSL/BT5ij
/On9YXrCsPBidSGZ3wpFBR2B+JyUV0R+p0668TUnyOURbu2xKpHXUGmtILEF725uKUSaNM47
E57WBl217dKqmYvr9Uqcn1kHsDw3s1JA4HcIrZBylJJFnsFZiRZLFYprKQ0w0mMyFdnq+sx+
q9OQlaW4FFEhylp0jcRcXBCIIFkiVWwPV5++PrOzy+X8cn2xsja7WF5uVvbakDy6eVrpYsGu
zzd0hDNBn1C2g7i6Wi3GDJyw60YgL1O+cs987TIcyVs2twzL+qFXcLkBV8gOx4C976kGLyWs
y82V9eJh4Ndr3l5a86uhadh0m+ukioQ1gDy4Wp51blRjDfXKQyNWrlIhORw4Uodrqzn+ff++
SEFf8PNFJWw0ASxGw7vnp9fj4lHunafv8F87j3Yn0GtrP/VZKiYSwMCGNZJHAdayQg6NOpCe
xXsMoA6fHiO8aWk3hb1mS/c5IR+lrx/H50We8sV/L34cn+8/ZE+d4AcjCTAkmglH1h+6AZLp
cgJVKCLB0xgX7MdGIkz0UkW4l5ciRSfhNtnYmgSCKQzUDpLf/3h0kKol0+YrsH9Y+Nv3IVWF
+JDjs8jHYHG/8FLkv7ryCvSE6IX1pp9ANm9slSwZ18MtZmTl7zHJg85zWEccrrq7f1lREyKe
UKqFYYPjYCU6Y5cd5Qp+9DHFn4/370dZi5TB3h7U+lfS8u9Pj0f488+Pvz8gYIAyGfz96fXP
t4UUpWUFWvVup3IJo66V93iH84QAWD+aCQyUl3iVUnwNIAXzuAACcjvP10gSTgljFl5+Gu0o
C6UiARL3BHQD0i7KS8zObayiv0HM6vGRAgbn4dvTd1m631i///Hz338+/e0OlxFdpszGkAF4
guF5eHl+RrVdY+Thn0w8gql+Ss58foyU9BLHA3MvjxKrZ+/Tu8Gu3E0SBPAyjoOS1eEU4x0H
yDZ9uVoS3NhX/LbotJv8Pov4pcPmD6gsXV6065kBYXl4de4p3KRpOzeYambIok2dxlnUzs5V
UjXry8tZki8q+j0d2GxYUrKRcxPebJZXK2JAm81quSb3CmDmqizE5up8eUGVrUK+OpNz0ZWk
2mRCVkQHqhqxP9yQb5U9Pk1zhizNBoS4uKC7JTJ+fRZdUh7u46zlkkOc1rpP2WbFW3qVNHxz
yc/Olic3Xb/hlJBinjkne03lP4OQW6MCgqWhih1nmR4LbseDUmWQ8KAgo8+6dUFC7UPcNdJW
UqTuuacabFqqczz9Ilmmv/6x+Lj/fvzHgoe/Sa7uV/siHsactDdIao20Q7gYWClsxnaopiYn
tO72kiMu6afw4Ssk49gjeTIZnkEI8dieChVOEPSHHsstRZKV2y39LKTQAuwOlG4MDXLTM6bv
zooQEENRrQE8xzGnloYUdeBvCiMgTqYHnqWB/Ics4K4tgCrOR9i6Ro2qq+EL7pgcfGk49BJO
3DWdSKHY9hPsoSqA/JQ4yvlkOiWYZTvKmV6hSxGqaOwpc7LhDtgdeZIN6LCqQSID8SAaQ3qP
aPx+xRrLPsDkS1dvfIonRHR9SN6xRQD8WpUh2R5AVvnghsOtCGj/+/TxTdK//iZv/cWr5AL/
c1w8QdL6P+8fjoh/Vp+ln/MHHMHDKJwcRb6U97ADZirFBBRE6wFQIs1WtNWmwsa0L3JOxkQx
nvlISdNwKWs6mS0ABmHAbRMEgFX4SAUQqOMtP0BQ9YFG3nzLkubUZBuoNV/xTjiqTM1FRlG0
WK6vzxe/xE8/jgf551fK0StO6wgsGqjXB4PqilKgEEw5vEU3JcQjVxp3T1ATY+qE33scBVdZ
hMhsVCmHLAH/did5q69OtBatsLJ+NxFDetMeZmLv1CULvUGeMG1d7oqwLoOU5oYcYhUc/xOE
OrkOTKvPl90ihmeagGUq6ugLGnQw36ZkiwoQlkxR7aWAgnSXLV1yaiy8bagGym+LCPkbyCbD
9VRm9P1Vp2CuTe2gnWX/57RS4rq9WiO1vKA7T9X7WaVtgTdHkeW+gL01LwgFJzxzW4qbiX2Y
egZvGmuJKohQscAZHssRIy9gj82kpEhIZbJCmcSoRtYOn94/fjz98RM0LiZwIPsh5amP4wOk
waRMdYOLtXd5Kg8G+mGhR+fN1cUaSYs6T1aSVt2N+DpXcr/ZRJetHaNwguq2WSkX+grvZUxS
NW6kBUVwy9mGjDdk8CIXfHCjIDw3bLxHzUaS5sioTJk3I/9hjIcqNO/YrXmJTqh9WTcewa25
q5KSfJyy6mMhq3TszXFFa5BKBhHTJ7pdwTbCSXiiZrkm5TG7UMZ4ncqPYH42S3npi2w1Fm2i
0gktH8m7nN6cWsXZiFOdyNlXXGlUsGFaTpVFUZflz81yuXSfhMbXTTgu1nROTQhx2m7JpGT2
B+VdVkgOEH311vMOaZernduuh0M3S/RszprM08Imo53cAEGfs4DxzQ69cO227SSfSYaWguOd
hVGBveDlBUN5/Vg16kscb6LgnObrgqKlh4H7FlyTbsuCPiqhMo+GpSDtG3GjuZMDICh8w2LK
cLZPd6ibTSJ5EgjBlvLOEznHJtmfJgm2nqPHoqm31GGgW+cey1l6u0tDjwdOj+xIB3m750mU
iRQ9vhlQ19Crd0DTUzeg6WUyok+2TDLfJT5mUt+d0ReBEBcF2uy87SLOaC40PHlehfi0Vzzj
LiODdNilXN1MmK1oM3Ahp96N6z+tDyLoRugFMIhWJ9sefQWWgTzFopZhgXjlWUb7lkz4ZlWV
4ERQFZ0Hyi6wY4cICb9JenJie0v3cS3Q34mUhvn/0E9Llah/d8nBDnCebi37SvlDonMnf+k2
8OzvVN5AlHAAF5NVKfwkqlXgkNOuwwrr++z5GX1/AMJXxpM9Is6XZz6urh/9zeqiRevvS35i
WeSs3kcZmrJ8n/tOK3Gz9ajkbu5WJz4kv8KKErUuz9rzLqJFEIm7UPKwDysOs+j4cKI9klfH
S/VGbDYXYM9Ne8JKln6zOW89flB2zXc12jbwe3nmGbg4YllxgrEsmOT1cEIXA6I5DbFZb1Yn
drfyeizKHF2/RXziwCxS8pjarK/P8PG78vmL2ZXt5cWH7oC4rHkU0iKsVbC8QWMBiXR8x5IJ
Bq7D2aOzTHLH8tglB/AuAlvOOD3Bet5m5RZnBrrN2FrKZWSlt5mXv7rNPItDfqyNis5bjvSo
tlu4Y5nyirPbCM6kkS9IVJ2fvK4gQlkToWtzs1xfc9rjDVBNSZ8m9WZ5eX3qY0UE+nBq1dUh
Gvz68uz8xKKvwdcbXagaMl9KsFxe/8glQ6gb4eRCFZGdiMhGpBnOJCb49epsTb1foVJInpE/
rz0ZGiVqeX1iMCCvcB3LP2hfiJheGAIs82E1ndgUoBBAm7NK+dLXSkl7vVzS+0Uhz08dY6Lk
oExrG3qYG6WRQf1rcogvcnrqdgU+LqrqLo88QRJgeUQ+x18hJNtEb+90N9+IJkp2DTrrNORE
KVwC0hHJu5J5NIYNrfy06tvjQ1r+7OrElzAasOCvx+lAQ1a1h/Sro4/UkO5w4VswA8H6FPMq
7oqyEti3Lzzwrs22dOy7OAzRsIVR3FLXsriJ7eTeaWXbX4MUXoPXh+XWP8K6DJ4nlJ3SJGmA
CDwZVXOdbGWP0vYqIBhx2bpHBUubgNGOcCrRiZaeXxDQiLUjtErutONS3+WDhFhvMFEIphWQ
JLLTCG38mqYL+dPrOwxqICAfX96MxsdALdXK5mzdApToRsDzK6X5xGUkeHPVzhTSzEDfsbGc
0Zt4CvKUs5DhZhvRFQNDObCmGgtYAR+2IoDnGwJ4eYWBcdpGzpClvMp2wu28NhhsD+zO7cao
ZYA39WZ5tlxyT1eztsHfMoIBDZTsrINQ3LTbslEfTn9U4YGPdQsWKg8Nyzzlbq0y/TbTXIkL
VNyDA5RXft8m9BwKqmzfAIpGiqSkHRLoYuXiSvlkXvZpEwkRefrQgsN1223lvlnV8LddtKqo
T4kMp5CG3yrsPKROIHlBRSFyhn1RFFS9psH/kDGO2spgCfrb+9PjcbETwWB0AlTH4+PxUVks
AqaP68Ie779DpDfiAfXg3C4Kd3jKWbuAR9fn4/v7Ivjxdv/4ByQKHm3ntZ30q0qrZDfi420B
1pS6BkBMzpkDZqySkAxeKaHWuQ2/VDDZwUlCBAV+K5e/tU9BRufFsuIkmWdfyz41b0E9btcX
776kjdh1ZKwLcyIHZdZ0Trwp/XDs+FOOJ4EIPS+z+3wyC+nr958fXhuotKh2OB8QAHwhWDQy
jiGnKvb+1xgIG4QckzQYUrKL6AY5j2lMzuQV0xqMau7u/fjjGRbJYDWB3vJMsXInNwKZH0ET
fCnviHZEe+TN2wPBauTFHixfOBxd4Ca6600wR6WBgXXymiEaZaGri4uVpRHDmM3GUyngKBFq
JGluArpFt/I+uKJYDotitbyk2hSaqFj15cbyNxjQ2c2N7eQzwLeV/f6HwGqFRHRDG84uz5eU
zaBNsjlfboim6oVE1pvlm/Xq/ym7kua4cWT9V3SciZgOc18OfWCRrCq2iCKbQC3SpUJta9qK
kSWH7J6x//1DAlywJKh+B1tSfknsSGy5YGqpGkcYoqle0jDOMaTUdmULvR/8ADvfzRyH+gxB
qLGPwYUZ3HXhum4z23hQfYeJdeeC7xXe4ToebjfYirI0OQmurDuWexmBzIQvTI4BO2lY8q+1
w0f1MovXpjA4K9cuICbateCbBjSmxcIRKnqdC7VqEGrZbYYCoe+2gWb9tgAD+uSg4VfS498e
Gz4FiCO49cwGu72hQB3Kzjy0qepzc9BMo2eQkapEC9CI67f13M/FMDQObc+ZCdSCW/xYuRQR
4v52wwYpoIA2hepobsHAd5R6WFmqdW4q/gfyzf2+PuyPBT5eaMw3xevVgTXjSPDrrZnp0jvC
wM8c/WXA4+7BoBYOa7X1VlKEwRpvjtKRusrV9HwD/B7XvjicC4eMUNhuwYXue0x9vSsoGkx3
ZKL10PBN/Lngm9TIXHSF8KD82KB6/1OIoAHd14Nuaq7iRZVmaa4oTFmYMK3EcUbAyOrC3oGv
LEwduR/5otVcymbA8c0x4OetEAfLu6xkZOf7ngtnjPamKqXN4KyfxCPTBBThkEks3auwVEXu
hZjrb43p7lDwnsIz2Rekp/tGv2JUGeqa4XdjGtOuaMHDjBhN7xSnvpSh9rSoguOu21XfXddV
qB2HViUuW1WncSrGDwe80y84SBN6lyY+Du6Oh3tHR9W3bBv4gWMY1q3qM1BHHJ0ipuP1nHmq
2a/N4BxbfPPj+5nrY74BijXrIQ0k1Pcj12Dgc27LT+uk6d8bdET84epHfkK7oO6BtCRuUz/A
S8l3W8JliXPQVvysw+KLh+1JVUbx+wCuIVxJid/PDn1ajbG5FiQM48uVoVF9tfJLsYR3fsXE
TdnKtAfRDrcKHW0Y6lPELH/DpBUThtNSzNvO2QC0DDwPV0Gx+dJ3igOxTKkrK9q0NRodVWei
ukG+BjI/CB2DhjKyZdTVpvSSJQ7vyFote5rEXvqeDLqvWRIEjrXlXmzj8EIO3Z7IlUn9etx1
N7Q0aVnWk8y7XLsD7PKNAzJfY/3oYn4iqXobSmRDCl818B+P2eHF40ViTA2BOd4alLS/HcwP
COFnvVjTux1z7gvD35LBsOsDTL1sAuH+nIt2/YFQAau67CpXrAhZAtZy+bVhB/ygNjE1wl8P
q3E1vPkyge+DDyOns9S3F/ZbbrabII4n6slg2Ei+7871QFwRoiXPXV3AOX+FoyS+h90+SHSo
2fHan4exc83Rc+kDPrL6+tbuyaP4sZJxX25jLwnDa0+wJ7SZKYvTyNGbQ8eK4Q4szcxO1Xhh
DxTH+AQALAldk+PShrpdqgY49Kqndi30TYxGHueWkS5YV/MzCFzpVvz0tDZMaVeOM+7Kj3MF
GhBEVnA4BQnvpH3R6+HIFTiJ1+F0hlUP26SJLO0deff88Pbpfw9vjzfNh+7GtMIbF5LxT8Tx
ksEh/rw2mRcFJpH/P8bgWu54BVCyLChT3/FiLVj6sukppu4k4bbZcNjMEBxy/zRTGlW5jdTM
7GhADENRM5mhNNPQcHnDppbpaLTUriC1HpprolwPNI4zhN5qM2sm1+Toe7f4kXpm2vJVxbf6
vvz88PbwEV4SLCc6YFQyF+GkGq1KOxsZjLwtJt8jM+fEgNH4XIGt/PKae0a5F/J10xgWWcdD
c8mza8/0p2bpq0WQnd3GD8YHacNaFQOqyNPdd0R323jdUcwvjXBzNgahUBZ+QaWam8CqPhle
tDjlltT28wB9fHt6eLbfV8ai18XQ3pXqmj0CWRB75kAfyTyvfgAl37oSzge6A3Z3oH6g+UZT
gS1cg93imNWHWopl4yodKNuu9ZZgIuKIg+mSqlyHQbjWpL9GGDrws0VD6jWW+sLqQ6XGWtcK
URzuRJhCiuPCL57uLk/vBiYibLnwgRbOHsQDTGlfsyDLHDo9Clvbo0YxWjWbypTPM9RdCmvI
Hl5ffgGUU8TYFS+GyKPkmBA0f4sfcUYO/f5FISpjzEz1N4q/zY0wLcsD+o48437S0FR3c2Bi
TtemI+O4rPzGip3p4RVl1N2v2xgc+eVwMweryrQpjhXEOv3V92N+VjM5hxJpLVi5SttU0mbi
M0qWwDfAoQ+sLuK0ZQqGgYFuactH39F8FDfB98sFsuDeD2Or6cCtgfSxZCYvPJawoYUFzeEP
cn+afHUqq5C037QkW9OTBq50q1aPzUbAF0Uznli0vSJAwrWEeEeAeJv4RlHwFWDqIryxYltE
kYvQTFoSMwqhR6SRJNo49N4BPUO0vQp9wZFFgnNLJxznLIu2tDReemEmiSizfJ8DSx6CGrEM
FgCs3xDySQ0soJJHO9RplT4NusH1EOYJdqNV9D0YB6oKWWctNA3fM05DQVHBuUh6faIi+O2i
6tCjqrt8eOzKfQ1PJNAaqsk9/9crfgUFoaHmpbGkajcbIyMXQ/KqHNuTKDwNpxxq/XFTxQ/H
U8ccpsjAd8CvvMqdzF278Cl3c3bO9MrB8bZRwoavJ1dX0Pmp0JSF4X0fRFYrzYh1wVa3JXhB
QPPlfekQBpembe+kpp9BER5WZ/UEvh7YKhzqFQw4shBt3fEt2K7RLls4VTzN8nbT7ukAgItA
h1WWgPlOw6FvwVFyvEwlJH89f3/6+vz4g+/uobTl56evaJHhI0NTYKK2rIxCL7GBvizyOPJd
wA8b4G2gHc1HMmkvZd86gsZyntExNDhKdlSZEtW5Hq9o8fzn69vT989fvunVLNpdt2mY3g1A
7Mut2QmSbG94IP35wAzO/gxXg315w8vD6Z/Bt9/H2R0JZgwv82n8OIwdVRNoEpolFs69DCKp
0jixaiGoVxplGXZUHVnAzlhPrZFvDVpaDS0xBW4JEWayg38uTAIL4SPuSwM9z5HIC5tnsTlS
hIOr3NVMHE10twAjNU+we10ApYa1TpBvajL0GHjNc3QZLQnihRLEwc9v3x+/3PwBTq/lpzf/
+MKHwfPPm8cvfzx+AkW+DyPXL3zjDK7n/qkP0RLEjJiKRnNWNcRZEV4wV6NembwOh/vAVpP6
5BoVozTQ+MWVhurHuUPv8EDgCc0Za0SUxVowLNllhNWlLjuk1uY0v+sf3x/fXvhJg0Mf5Ex7
GHUhrXOzyFQ6Ab+245OQArECtGJOZOrz7vtnKSnHdJV+NMSlFFl6aqOOzVWGINCrQNlxY1DG
gHj6wGpFRAHpqtbdueD21WmGt7CABHuHxfB2uuycUZeRwpG8queJ+gnpe63jeyzkyXK7wnrg
sGYT0D4+P0nntfZpEhIt2wZCFtyKHRaauMLVVg26n1FYxhE/Z/8nhGx4+P76Zot41vPCvX78
D1o0XiM/zrKre+vRNwc4jyDFgTKAuvxPlXDVHc6PPHCVoNswyy4dZYf6Pb2jarwkQZs8VOpU
oWPnzXONPH55fft58+Xh61cuuYADE4myjKTqsc2UfMU5F70WclQtwro4E5xNibvAEGB7xw/3
4B3azUI2WUJT/H5EMtSHez/AXjol3IGfJKsCp0sWx/bQ5QPil7HJ4ELdaDY1gW3qZ5miuiAr
y7JUlbyyC9Gld4JC378YPXluDuDKyirzmfpJGWXo8iVK+vjj68PLJ7SLpVass5HE2PGwERVc
rAqJXWK40iXyJWmFgfVNGWT6o4Ectdvqb1UFtXOT8NDcd4fCKvSmyuPUJ+eTu1Ty7cqVcNuH
eRQaHd72WRraLTSUMYszTFd2rD48W2eJ9Z0AMnTfs+C5b3bUSA6s9M4kC2NnU3E0z6NZbvLd
htX0hpgQm02rZVnmsOGVo6i9Np1zBoCLeOHPw7dbA05sEnS43JNtXZUh7vv1rG2Dzz7cB1kj
zv/lf0/jaYA88M2dPuL4R2P8YFCM7vBc5hDDNIiywMhzxvwzLiUXHtH6jvLR54f/PppFk3sO
8NzjTFqyUOIwt5w5oOweNvZ1DuVhywDAoqgyov+oHLqDW/1jTC9I4xDaF+jHmYdH/tY+D/Hn
NZ0H9/qi82Tv8qQJNt00jkzR6dABH2+7rPYiZ/1rH1v6xL3ftTgpWwdJ4lt7XW9WIcP/DL//
llwQn7G9M5OUVDsOXw+mgMCBzf1x/1BUJYQoZ+BTXh0eQm7ZXyvXQ5Q5Ex8TtBpboyttrdE1
ITohdIOGtdyDgeoAqHrfeCgs4pTO5vcgNV0y65BDz8Hk2le/I/UC/VOlvpPKCDSTmiXQ+SZ3
e6zb6644op5wpjRBeTH1Iu2J0sCwY6jGEqg7nKnRJpWUpbgTwr/Jck+b8RMEy62+1UNZ0I3O
xKBvsufPWBkmsba4KeXxozjFppnCkqZJHtrp8g6L/PiCVUZAOa44ofIE8VrWwJGGMVZwDsUZ
6tZgHrlkE0Yp1rdiXECrBHmEmeFMKQwsj+JYfV4g6l2p+PN6aiqTNJ6E5SFIvkZKJ7/IA/oY
v2bTsOPuOCgBSS1IW2NmtEojH99AaCzYoFkYiO+pvv91IHYBCVJYAeSOL0Jtz6JAeRC5dGwm
HsYrgfW2zuFjReJAEuA5cwg1e9M5sBagZQrxEqzsbjNWay64J7rvjYBVjG1B/HjvlPhLjKO+
rSkpkSoKjwFYIftaVxsY6ezSo11R0QQ9fCy4L4NE2F+CJTgl2PXZzCJOIFi2TXzLN+C4HsXY
RPxA6sVbu4ripBpsd2i7pnGYxrhiwcjBz6gEaaBdG/uZGmVLAQKPEiy3Hd8doV7NFzywE9w3
+8QPPRtoNqSo0Yw40teoO4qJgR8cpKhCOqqJY5cHlpEDbvBgqK7lIK8CDOpvZYTUkA/rwQ+w
KF9gPQ1BI5A6StmMbdk1jhxpOHgY8mN0eAMU+PieWuMJcPU5hSNCB7KAkvXmlTz4pn3igVU5
8ZK1+gsWP8e6WEDJmsQHjjx1fJskwbulS5Iwf58H3T1pHKZ6mALl+FZI4Qn91LHDmJnKPvRQ
S9s50lyZxJE9NEl92Ab+hpTuidSSBD9VLQwpdkmiwPgYIul6zTkDflRbGLI1IQ6GzHiFstUJ
R7IUmW0EnYN8Rcfrlq83SR4HIdIdAoiQ1VYCyPrcl1kaJujoAihC71QnjgMr5cVDQ41gsDNH
yfgMW6sLcKTYzoED/OCGCEoAci9CJCjcOOaaROvJBrW1nD6he+bHdkqcjO1ZODn8gZJLdLF3
v3nOaz3hR/cQlTA1Kf3IW2s6zhH4+hlJgZJzgMb2mQtHaBmlBKvmiORI40tsE+JSkTJG03g9
V8KlGbb7LP0gqzI/w/bE1Pd8dHtN+Vkd+4JXP8N6sDkUgYdsu4GuepZX6GGA7+RYmWKv4zO8
JyUutRnp+d5/VTIJlnWpKVjW1i7OoMUoVel4jcANWdkf39nTcK4kSwq7rU7MD7CDxYllQYic
ms5ZmKbhzv4AgMyvsLYDKPdxXRONJ0A9+6gcIZ5xji42EuEnENfDn8LYplmsG7XpYOKwJFe4
kiDdYw6kdZZ6v0Vzse77VxUi5jkDyk7uy7blTHTr+egJU6wEha5YJkkQQIA1YNGPe+6RTDWp
h119ABOAUWERTkvF3ZXQXz2T2fI3PAHnoRGG9OBurV/Lbgwldt11ENGr7q/nhtZYiirjtmgG
qSmO30gin4DViHTP8Lc/GS9u27YrC+ZwHDF95y4VwrhaT2AAR3hX0xseyvk3q/X/rQ54Ay/M
CAaL4oPw2ibSK9vC4V5CMoG9VsXolDA+HThrGHmXG9Ab+aIZbqipAQuWjlmscr/KpV53r/Gt
qPNScCDRUdpsDDV6il0KbEoIPLmwK2Tl3hiYREQ0eIXDuWdcuyScAYp6Eha4VMRFPx0hcC15
LYkjVKTK2KPm6ZJlfHZYtCb//dfLR4ga63StSLaVYaoAlIKGqbqG9UR02ORnai6Y4C1YkKXe
ikNtzsSLF+ce6hVTwNODtFEMcWmvvCfMNN3DgKiEVFtCiU7uSQd1AUVNxePBxayouJAKHI8S
M0OMfZZgJ9sZ1I5XI9WP8aMqwHxHHCLPIzMP34df+4I2Jb51Aph/2qNx8SB9OY9/PxbDLapD
1/alU5UFMOrAFokErfw3WHj3sPPfZQRxgulxLTUCsyGzdxbk6ggwbHAZcxjQ34rDPZ+7ncvz
PfDc8t2ks8GlqbxnDgNJxu+fZjzxXJNqeqvRR779PDNTsyg0qybfn/ALhhkPsKPdjOYpmmiO
X0oInCVhjh24BThdtegVAINxvaL2o9ps+V1UJUI1h7lI1lao0HEWeyF2OBWg1Hwxq09B7nTo
JkXATZQmF8OQQgAkVg8yM8lSsxXI7V3Ge98ld0xX28XmEnu2DFe/uKOl+poFNM2xiNaogI5K
Qj91GrxIWqm05GhWoC9aUuBanaDi43uxI9KO0Cdy2GCv+MgQJZl0kYyySLrj8nBiyPCnoamG
k3KUmWyWXIzmsPSaFGqApMCppsXIiHGZ4lD3YOc28sKVRZszgE/8tRFxbv0gDZGB2pIwDo2O
FzqGxko+aqf9RIhYhUoapa6Ao6I8JHZdKEwwemCT4CioTFpmjgVOjRwvIiMc+i7NhYkh9qyc
QMVDM7qZSxBpzg+EBlPv7reh3sHJAdVoL0fBoyXolkV11RRCoUX6Olg2lV8ePz093Hx8fUN8
v8qvyoKAaef08U8dlY4Wr+ykMCyNKFiqZsfPr63Cg7e4YB4K0ItD+PSaVIM7P2ia9xLgf7AB
HKNoxpVVLXysL0Nbkk5RG/AUNyIOvar2vMBqN0hqUZ1sHXONQzr2Js0BIlLw86nq305ywPGF
3tZtrflNkRg7au7lRRm3bUH3wjE7P0pSaqLnA1iB6ulsjls4xSHUih9C6Oz4lohxYh85RGuK
cs7dofB/fPgqgm5aQ2usw5mLzMhuO3ZGn7AkeN8NhdUagnjlC7yHI/dDmHiJA9wc7+0yTCmi
YkZlaUmrbkwsaPAd2RYnmtR3NdWbeGyyDw8vD8+vf96wk6vx9vUFgsztaj6CGrv8I9wNeOhE
yUQuG7NsFQt9Id2dZfrw+ecfb0+fVopWXoI4U7VKJJkWReqHSH83/ZGvPU2HC3w+eGd9fCyW
ssZIahLwfysxl4FLqNlN/rnN6dyQ0pIAzampUCJIGzsFAMBAVxjnJpFZX55F4PAOwAXbWl2l
Sw7Z6o+fbggpP1A4qozmRt+sGXaSljv2/A6MxX6hj/LMovNm7XqKISAqQKI2OzQ9Iu7JXB9S
8yM5TqLEQb6ecAHNekNYPbx8fHp+fnj7uRi+ff/rhf/8F2/Kl2+v8MtT8JH/9fXpXzf/fnt9
+f748unbP9Wrsmnh3FTDSZh7Ui6NUae743LIWCHivs4GDPXLx9dPItNPj9NvY/Y34Mb8VRh4
fX58/sp/gPHd7Pa++OvT06vy1de314+P3+YPvzz9QDu8OGrhdUdyVaRRiCxTHMgzNF7SiNfg
dDu2ZoSgB5ZkI7QPI88ilzQMvczOvaRxiKp6LHAbBoWVeXsKA69oyiC05NexKriMMQcwbL/k
k6xRAqCHmO+ycWT1QUpJf7HGYne4u27Y9iox0V9DRefeUsfQPHoTw1JFMJ2ePj2+rnzH9xGg
AOUsocRDu2YAJB72nrfgmd1QIxmTaxuW6VonMznGNN1nNEnsj26phxs3jeOozRJe/CS1i8dX
Fmt8VeeciwZUYNirryRfkLlQhnHGpwm+uIzTq4/9CDtzKnhsZcnJqedh0+8cZCt9xM557iF9
K+jJWjk5w8rO5dRfQqmXpYxBECoPmsxBR3HqOyyglLU/st/qZB6PL3PKdrqB1duCrMYWUMZ8
arWyJCOTHIBwtV8FB6qgsuCxb+1oRjI2WYoqD7PcEk/FbZahY29P+bi2m618+PL49jCuGLY/
tDHRXoYialtkb0UuAfqqL+HuFCSR1ZJAjXOMandGd4qTKLUz7k6g47WScZzYXQjUHMkiTQNL
BnOqLLqVcZqk+Kl+SW5lyetOeRKj6fphFrsPJnw7nwSWECIsJ15oiVkg+/aA4uTeCzEyAzfN
CNn3sbRPnm7QpgAhdo84TrfBC70eOUQduu7g+ShEYtK15q7wSuPbpLDWbUFFxBmnR3WJhtKe
GeJNsUW+JE2BxkiScM2y+jabxNz2+eHbZ+ccqno/ia2DHNx/2edGTv0/xp6kuXGc17/i40zV
m/dsyethDtRim21tESXH7osqk3anXZPEqSzfdL5f/wBSC0lB7jn0YgDcIC4giGUuBVRtazs/
gYD2n9PT6fm9leNMySQLYL66E9YfhkKZRmWdDPh/qoH7C7QAAiA+AZINoIixmDnb9kYJt4mR
FHlbeuOiATcUB/bLXqPx+e3+BJLz8+mCMUNM0dTetRYudUDFM8cy0KyDCSrB9+MNLi8wjLfL
fXWvdjglozeyLzr70w0rObvRfqghfby9X57O/z3hlVSJ+CQ9RnLIIl3BqeFAEJ7ImIW6ptLE
Lx3S6aRHtThca2IxGcSulqabtYEO2Wwxp+zQ+lQLuoW4cMaHgb4hTp/nPZw71DHAOnNK/rOI
Ju7AwDEB0WSg6YPvjHVrOBNXB5gnu3XwpwOZFPVuHSKoYyYGxybxi2sKy5rQn07FcsC+zSDE
NUdad/dnymRg4Gt/PJ4MMFPinKHxSCz5xNVvfLCS8F8wdu2DFDg0nZbLXMyhjmJwrpdsNR7T
rx3menYmpBOZTsSL1cQdmPU5yFzFQC8PkTue5OuhPt7Ek2AC7DQN3fX96O00CvbeaN0oFpq9
rbhcHt8wgx2cRKfHy8vo+fRPp35oqDavdy8/zvdkqBG2IY+8DauYnkmnBkhN1CYrxZ8TLUoc
IsUtL/xtmKeUFUqQm/FhUSGVVaw8XAn2JYmkB1ysedDo0EqE0RrVbx3XEb2LRR1UyyyG8LVH
otZSH98aV1HIdB/mSvc0GY/NoUQpCyr4nEG15nl8S9uZIWFRWCPZhHEl7YQGujuE28e6Wqi+
CI0uPd2PVkRFVoOb49ysSkUliibzaR+eHDJ5lKyWxi0D0TkLhqLhIZrFAcwSyqps9JvSRfmX
rNFB/Q4/nr+fHz5e79AmqdVZxcEoOv/1ilq318vH+/nZdO7HdpK03IesHOwHX02o/VHycKNH
cFRcvd2seyNVUJgFPqn8lp8xZjM9MkgNm4/H9qwHqDsfeCZEfBlQ1rOSo/Y0jzds4+jqMQT6
PM9LUd2EcWl25+YQmQAv9bfC7l4dE9T6dBpBhukQmrkXnN9eHu8+RxlId4/WdPNyHmxCs0lZ
uMMYdfAmA+PIez1/ezhZ1amnQX6A/xwWy0PvI2254PCXF5OJOXHp8eSIu5DBLRVS22ZCEayp
24Oc9RNdgKi/gjWJzMzWCBJsz0gH8o4paY4xmuTmU92UPN8Jk3UYEKkOSVozbv0Ksu7or4/v
32G9B/Y9ZK1t3c2mJLcoDezB9oJZF0MDlqQFXx8NUBD4xm8vTTEptiAecrFS+LPmUZSHfh/h
p9kRusJ6CI4J3ryIm0XEUdB1IYKsCxF0Xes0D/kmqcIEDt7EGlCx7eDtt0MM/KMQ5JIFCmim
iEKCyBpFmgmTqeE6zPMwqHRPe3k8+aWnzSksD+erETULO8b8nRXyDaAyAa86MMzWCh5JjhQq
0nx/Bv1oQj72nmXxA8ldxagwiw2ZTkHgW63TCkORpUlCP21gbUcvzB1L3NbhOOHoohjwWecM
g5ML2G4ygceiKKzvCBwks30CqsSZbNQqAcaamOoiMn6kDbM6T6bT1D4hCHhom2l1K4EbLqe8
fQGX8z2zyBE0YELSYHsRRhpEO2GGJjKn9Vg4xcPleLZY2p+L5bAyMQlFQgbvwuko4wGZM1SC
qhjzUiaYOJ5CYnbDmzKkcBsKaCUv0Wpi+3BgUSoBxuaUBA4a0HYUv+RmTTdktYFztzjiafLZ
AxlrW68T0AOzy7W+jXCH15A6jcwNRoIINtYI5vtkPGak4MKsiovKNeWeBjrgMY0LzlwDxgoJ
U9jN+cBYdsc8tZpy6dMbW0nTIE3NhbwvlnPH5l4BEgodn1xuQTtrI3TNw4zlMZ6pvcWCUDjL
WVyFezLloEHjl6JIzdWh7Dz13oO8U20OxXTW20tRkCvJVnBxhLA4kjS2FpgHrNBVOh1MGuVs
LCmgwRnWaXgy5XAdEtswNHdlzG25m6zGB6unDXxg72nQE3uGS/XbwJyMMQ2fFrqoXk5V5AeU
qReCpZFTHXqeqLWrQyek2mgCTz4RzVv2jx2m71jQ4WS8jqtdyuLlajqpbjHZNdGsYHDHZhSm
8dx4ItsNsuWSjNRl0SzGdMcbA+qrNaD2210N9EB6m1wtbgb11qrdw7gWUUbhvGA+GS8Gmsz9
g5+QRk4bhm562jffBjJcrLqSXp7fLo8gPdXXGSVFETZNG0bkA4JbCJwVIl3Dx/LRlNCMEUfj
YQl8DdEg6DoVioJcFBgBNkyk5593bLzptDtGGcfHfs8MMPwblXEi/lyOaXye3mL6gHYlwj4G
x98a5Nx+zQSyySGT5SDA58frtJhqrVbVdOs43VDKJ5GWiZn0JTEcLlSOMB70v9aWG1628LOL
dlbkYbIpaIcWIMwZndWmxIb6fcSqu51DPVu8nO4x4wwWIBzvsASbAsMo2Usi/bzUdvMWVBmZ
LhCaGQ8ZEiRKQ48tYSXctWiXPMmYMNpxauEgEhWD+dHmpb/l8IuSaSRWakh7ZY4ZCNm0zR7i
gfGbNMm5oM2gkSREPSDlPiyRUWhkz5Cwr0YyPvWtYo/ngQVc57HJWijXyyor4UdqR0fMLYuK
NLPpN8d82OsTCbgP8uZAlbywvu4XplLQGzUUtzzZkjdYNZBEwNXRSKiJ8MhvIufpwDCwAUm6
Ty1YuuE4e+2hNnD8Qb7GtgT6PEZgXsawvWUscBRK3xf4ZjUd018dsbcgrkSitzKk5BmnpQjt
XsbsKA2kB9gVc3QkhJ3YHHOcYk6b8Gi1Ajsxb6aJBk8KbgJAbDEzWyIwg+svrK4oJfO9SYqw
YBhE2mw1g7UHgo/ZQg001Ec6nNA66Gj48MKeV1nE0Dw+oZ3bJQXu91bvBONGLjYFi0WpJ8qT
QAxNhilF7XbhyINPChtqOLxZQHVZNBAiHvF5TCcXkEsSk98yQd7eZd1whhVf0iM2oPdNh1sT
0lyPfE8dZhKVZiK011ixhfUZ27AcrhEqcm6H0aG9KY/ptm6rTLgm+JZzzBlrVn/gSZyadF/D
PK1HXEMbSK+lr8cAziPdGUGyTcZRqLalNQNruLoW1b/sT84iItK+zGdCHe4y94o84BXd8/vp
ccRhSZvUbQvK1xMIKvoIxxTX6RYuSoZGsBsF4nv6UgTKnKNbJqqtb4gbJem1jiWUr6nsHBLJ
nHSdiNDCsx+fb+d7ECGiu086QUuSZrLCgx9yOug3YlUw+KFcCgXb7lO7s2Z5FmxCWlNSHLOQ
1rVgQfQ+gcs4HW0BCcoo44NJHspbin+xbpEPPyoP8xgQIOVNA9KubugCjLCz33UvulASXyP7
NjDSsl4Z128xa47fZc0J+h8F6xnSGyFOBDDLjKfkBjiYDaWjGHJm7qqIinVM177Gf13yuR5o
bj0RmGws+BqWqgX0vYVhoBHLzDRA1vswJbTG53CRGdvdQUEUjgd7uHorNwSPilRsuceuciku
6JwWHRcOIMxQYlIMcmXBfeOAbmD976nlnxDv5/u/KXeoumyZCLYOMfB0qatsYpHlaTt7uyaF
gl1tbHgW2o3LbxgLclBfpJiTVO6SdJxtyPLZSndPbcHdR+ywSXjbSBGNeAa/ahc0Aqbc1CyM
l6OIksA1QebZxWR1YbvPA0Wf17IYy0qrIibc+XSmqU4kVKpxjDnZgWmjnQZvRTI08SpjBGVQ
KdGmpkPViI7UUwI4c3rA2eyAvuOxEXm4xemxwDqg4aHegsmYFTV2OTMVdQ3YijZt4v0o3GMi
DU5fLjvmDHh2twRzl5qHEm1710pgrXWz++sFznLAX1ji6xATYuoMPOSrURfujDQCVzOrjZmi
QwufoRt6j+1F5M9WEzJKisQ38RT683T2sze8NlBCb4folsbo++V19Nfj+fnv3ya/S1ki33gS
D2U+MPEFpZ4Y/dYJoobnk2IrSum0p5rq15U8eQ1BHlKHosRiwKXeWOHWsVh6B3Kkxev54aG/
C6C8sTGeT3Wwne/SwKWw5WzTov/5anzAxW6o+w3NNgTxwgtZ0RtLQ0E+PVGEfm8/azDMh9sF
19OfG+heXBdjEHUgLiJNyPnl/e6vx9Pb6F2xtpssyen9+/kRc5jdS0uf0W/4Bd7vXh9O7/2Z
0vIa869z6yWGJlWO5b/iSIbJZwcGnYSF4a6Nb14Y7IlHBqPYZHKEA4bh+yWROxf+TkDESDSh
p4OpoGAxu4JUrerM1yjCQ9Zkgd+HuSfkaVkyUqDrtRrGVDcr+UYZ4/8ytjHS0GtELAjqr/EL
dKWQa5ouLrY+I8cuMf23a43ihtP3C9gUphrddU4k4RBrAXMli5vOLz8PYvq1UqPaK4ObbG8T
90l5lnKPZIrEVD793RSy4dhVPJxzBSOJRJ4N8AMwZH5mrQFrv7VQvyidZqzaJ/ozmYZEpu2N
DRAhVX4YyAjYldyuOW3pq9F4yQGzuBD9CwOGuYdTDBwl/FxXQUhU7/aOUIumXp9NSrq2AxI5
dKurkZhYu4r1Z0XVozjQjTM7WBXmeZrXuSoNs1VJEy5mzsGC8aWzWpipNhTcpe2wa6RhZ6hg
oTtxzHd+CT+4lFOTKjKb6kaSNWzcr3o26dPJ1GstXV74lWERhQAMCDxfTpZ9THN96OYTALc+
3AePtOoA8YAr0i2tnED88HaB2GRvpZNSbr0F1NdYOhqXfiwDguVazZzBaiUJ5lonmNzi8Rz7
JMqhGXPJQ2nnPFAeXdNri+pWe4ad7t2YGmIVi8wQohsU87zZ11BQMnBHcljqgfwaeCAmrvlE
a2JUfNMrFddkPggPpf6UqOMX0yF4dRsUJG6+cPqdrWNXEZ3FAPSrgUuCRoOy+5Wx5GLmuwuH
aoCLCFYhteJMCocsfQAMbZPTUMiQ4c61LygpxnoGZwPjzt0+wyRm7tpztEWRAdFbfk0nxXJM
clti8NtdKe7duM6u39k25Favs23YLaLF4RSGDYVwZ+5qzKihrmN34l6fGzmsDtLzWiOY6Vm6
9ILOjOpyGLtj0le+LbpfLqUXXus7N7j+ZXZtFBayVh2N9Oj7/ct9IxCu4xKLScHtFEna9HCU
a3efV3sY2Mrve9Bkj3fvcJ19svrTq8CPU+qFSlv9znJOblUz0z9Wx8yuTQ7cUJYYNTvm0XGg
hvny+gqVJFTMCY1g4Sxn1AxE1PTX9cPmdoVGjQGPJIwxNnxy1YTyeOtRUh1zqB3YmY6nJKeG
0pLqBNReJIrdZFGwZR8TT5fFct7vBMLdGQ2frciNScRzh0xi0u1KU5XLoT+ts5lP5iloCHDa
j/u9qRVeRG+umGW1S6GNmSsXyuX5Dz8rr6/ndQH/U66XrT2N8tAdWncg0isruv6bHaC8cj26
vKA7kJ7m7Jj46A+gScjiVkK1C3p5CLjIIqad+uhkZr51B9PpwjxFeLzBbFycozkg9e5mxtKE
n5XP6edbxGXIlE2Y8PyGrgxzW8Q1hV0xG3oTw3B2Ye6npFBV1qlie6mvEZGExcFuJstLQS1D
xMVrjD+gFUCL0muRsKTnkF1ApZ7u+4HF5/vXy9vl+/to+/lyev1jP3r4OL29U8+u22MW5pR/
oChshUVmjBB+SlVtTsmJiZ9VupYCfsO2lDF/FxaV4JtE1dw9lEo8T/0iqvB1hSfUPU5RCTR3
2Nh1J/in12IqHAW1WhIY5yogD6S6uogoFR6KnFFl/BSNqfTpriCDN9IWrZR9GMMPzQ2rnfen
M54ur5CBPKtTjntNxlz4V0Ov1XRcsH9DhjP+X5AtnRkcPpQupibYqX8jqYzpNs3l0nG8gZCa
hZjRwve+mM+7uHecp6O397uH8/OD/UrP7u9Pj6fXy9PpXYeqcH3o1Xt+OL/fPaLWFIqZQdlY
sJiPjWhIClLxNfNDmMvorhoSkf1V7U3Vf53/+HZ+Palo8HQ7xcKdWA1JkO0nUQeZebm7h5qf
70+DI9B7PCHjukiEJh7C70UXJCOQHYZ/VN3i8/n9x+nt3DKwQTx8wi5zf3k5jeooaQ1Bcnr/
5/L6t+TF539Pr/8z4k8vp2+y0z7Jg9nKbYXi6Pzw412rsiYqROT8XPxsqNi9zNV5ej69PnyO
5BfGGcB9vdpwsZxNTdZKEMna/PR2ecTXmV/MDGUCrz93AeSw4Zpl6d3fHy9YVhotv72cTvc/
tGM2C9muNFSDNQjP2mJbMT8pyLVkkWVpFKVXqimDrBhIp2IQegmZpMqgCULYmzU7jh4WNsfh
rkRQ9pdNmAZ9Fi7bpeUgtjhk+ZXWpRn18BFXNZaw9fr99no5f9OerRLd1QJ/SS/9jB3RMf3P
CezCs4XmrS8pGtd56skE8djhStejRSWaPFemVrMGKjVzeMjQSnQformvT5tRBJuEUl1tRLXO
NgwdS/Xq/fyYFSmGreW06WuZcLhQCNjriEpveeRPDPViA5GGPAR4e1ulqYdSg2FbBhdD+glq
Jxb0/XyTh0dPt4KrAZUVULEB48Bz3d2nQWx1j90GqCwwtdnUIsisKB02zWrHgl7JwRzkNT5n
t/1+7LmXM5XZzh6P9PEOqmx7pPo5kKukQRtZORqgIBmHxljNtiZN3i7/SHfoRzxmP6UqogAJ
8w/6BoLu2l56kGGG6NelYoeWP0RfD8u5FlxV3WN0xsIRnMPEysNoyFodKbYBfYNA+/sqYjD5
KQvoOkmux1PjOUsDD6TQlRSqWqJgulwO6CrX5RdeiJLoUY9EJpeiV8smgwmRSgl7PeBPvc36
voY68ipDM5YwgYbG1/qJ1gm7jAVDhnBtQt2AZdZjIVp9wG0mSmnPDvnNfvHFMw4Xc9r4DI16
C5Zf7Xttv+YVVb7e8YhmU0O1ZdmVbvhxdi2BCvwNG6JT7e2latFJ94j90BO9otl7xbV0VXQa
sjpnVOxboYXR5TEvjCxqtV34Nc41JDcD+R+kC0y1iUvawkh1Jh84BWp7ILTr9vt+79303Evz
gytV4Gj5wGcRZa7E+jx14Z5VFAPOIA0dRWQ2Bmdngc0Zpn3Rod3ViJLYQWa4pfpbOLbCtoyx
BSpcSm1kfZoMU6RSj7JtRqbCCEjZgKOM2p0bLHCrSE2JAhA7T7oqXLWkiWFPZEnasUMzvJR2
SNU2LbKo1AJO+9EOX9jgmEXhubNex9QMgIPOhCCoaLorZY6HuD9bN8KnJ7iG+Y+X+79VfAa8
pnSiXlcCruMzdzahKkOUbhaoYfzADxfjOY0TMvaCr3f9VmQ8kRamTQdlz8Tl45VKGgbVhPsC
H5ln2oOQ/FnVtXSUXhS0lN0EZDyCE5matdDT0s4MsMHb1fl+JJGj7O7hJC2QmqjmxlUzDlQd
17aiYXx+U+VhzIxZXF/Kni7vJ4ynTShHQ3SaQN14I6PkL09vDwRhFgtD3yQBUm9JqWklstW4
NSsf3Rzx/GnfYi4fz99u4aqshYfp9omGWg29NyxMWveb+Hx7Pz2NUpiRP84vv+NF8f78Hfgd
WGqMp8fLA4DFxbc1HN7r5e7b/eWJwp3/Nz5Q8JuPu0coYpfR+m6n9JLYw/nx/PzTKtSIazzi
yaHa+6W+iWRSdFvnIaWjhfuiL71TZOXhz3e4Ltec7NtLK2KZu/ALMw2yG9Qhc5akbYTC20Z3
Nbg9jt3pigpgUpNpOb3sGjDDuUu+jXQEKvMXWVam/7pa2DQ9reF5sVwtXNaDi3g2Gzs9cONm
QvQBUH6zodNCOqyynLo+c/3GAD8q5UOs7UwtrPINtZ+GQAvyNEHTe2opIuFORr0BcrOx2rAQ
zxnVrIFV/10LsozZw6Z5gb7cLYmjk4jbJiKBNQhA1AX6ekBb99gW9GJGR4n3Yn8yGysRveu4
DjXvbgFzzEeWgLmkQ38AwlOgJ56WAPPRXfMCU025pLUfMqw+/RVZHeTLZkzR1MIOnBJAdwcR
GK95EjAQfWd38L/sJuOJ9sAY+67jGo4ubDE1Ul0pQC+jFYDnc1pMBdxyIHdbjPbxEzvploLa
AL2XMrTpzADMHb2botgtXT0uNAI8Nmtf+n6hrdZ1vc6K+viAWK0MC6I6lycL6AWvttJB9PZA
R41QSczNJH/KdseCFb4z1SPrSsDSMKeQoNVA/kPYi905GRmVHVZzI9qqn7lTx/COSaqvE7tH
CSsXS33XvAG5rdrjaVO7dJgYkcW84v/f2JMtN47r+iuueTqn6s4ZW14SP/QDLcm2Otpai+3k
RZVJe7pd01lu4tRJ36+/AKkFJEH3VM1U2gDEnSAAgoBWxADfaXBM1Rf44+uJCTNyyg8p/dTn
7bn/8gPkAXJ0+9+Pj/LJYdlbx4dpq2IBPGzb7mJeH/DLa37yxBcjx8zd9ZK469B93+nwhuZo
U/SX1aev3WU1XtYoKVwLA9FxHsWP9SE30B2D1ipOyr5Var8rIavMu3rNOlsepX/E49putgrE
+xO9SupuQs6YkkHuU/6KZz5eEI0Bfk9pxF34PaM5dOD3fOnhU4QyNKBTzSk4KGczj0sYkCy8
qZ5CBvbGfOLYUH4+u/Ls2OI4V1/fHx9/DgG/6QjJCEHKtm5xf4JT9gveVGLRqqPcasn69fi/
78enh5/9XdT/4XuYICj/yOO43xxSeZI6y/35+fWP4PR2fj39+U6Dnubf79+Ov8dAePw6ip+f
X0b/ghL+Pfqrr+GN1PBPLrzIsb6ZsPF8yALe3BYZHKzaxOT1dKyyEDrOW1iL6js8Sq1lKlHo
Kmaiq03rV6z24PH+x/k74Rsd9PU8Ku7Px1Hy/HQ6axduYh3ODH8gFHbHEz6ktEJ5fYXvj6ev
p/NPbqhE4rnClQXbasL7mG8xwRubdVd72J5EAb4ooZJNVXqeo8yq9jh2WEZX6tgelCKAeHaU
/AgW2xnfaT0e79/eX1VKgXcYSWNpRLA0XMJNclhoDm5RusNVsfjlqojLZBGUB2tJtHDKCs07
Vd1aKWJORBPBZxjXKT1QRTzFbE4EkAflcqrHR5OwJR/aaju50t2mEMIKw34y9SbXpG4EUJdG
+D31ptrvxWI+MXlRb8lSQbOKjLdBbnJP5DDDYjzmopj0B0UZe8sxjfauY2j8WgmZeOSUpzI2
TcRB4NhA2oXPpZh4E9a5LS/Gc5q5r2tJGweNyFeFFtku3sE+nfmlsbFnZqz4Hpnl1XTMesnl
0DhvPB3rz1LLaDJhU4WBbDud0ufpsFjrXVR6cwakH8qVX05nNG+UBOhu290AoKfAnJUQJeaa
jA0AZnOa7aAu55NrjyYQ9NN4pl1z7sIkXoy1hDjxYqJrYncwZjAyE4thJPffno5npRXaPg7i
BtR6MhjiZrxc0g3YKoOJ2KQsUB80gEy1rFpkoSF1WGVJiGFKpnoUgenco4mGWrYiy+cPoa5q
E91f9yT+HNOcuxCUVclcty8/jh/kAI6eHn6cnqxR45TXKPXjKO37dfm4UFr9EO2sbUL3dnX0
O3oWPX0Fye7pSOvDbkvnt6LOK84EQIdHuuQOYqsmUbw8n+HEODFWAhD3vCtu34PqcK3ncUEB
DniSU7ibu7JR5/HYSN3MNg7GQD/P4iRfTsZMCqwck97ILLLWyl7l48U42dBVm3tUCla/TX2d
svCVKFwxe3ruGdJcutt8TJXxPJ5QnUv9tgwEeQx7hs36Uc517VL+NnYcwKZX1v4w2kWhZv3V
fDbmWNcWdPYFqekuF3AcLiyAdeo/oVuU4aCVvz5/nB5ROsMr/K+nN+VQZs1aHAV4ZxpVYbOj
rwnW6C9GNeayWI8Jcy4PyzllmYjucztVx8cXFNH1dcLt5SpMuAv6JD4sxwt6GCiIrvFUST4e
czZdiSBzVMEOpeej/O1pQnpa8c9jd0nojI+T7+0HauiujMkj7HBJArMXRL50LUqLT5N+qaDT
LNZBNkomCswz70fau0EMxiXwvjfzK0Hsh7DIworNoq0wVYQsyqcq95rGioEfzVrchOr59uCR
gBFfimgX8WFwMWJNgeumT2qrfcnkJVELc3s7Kt//fJM3I8PotD7X0uFliO/qJ80NJq2vy5Wn
o+BHkx9E412nSbMtI22HaUj8lp8+oPJzX+TO2EvSqccX7Ar1iWsX/NCjsCAgzv3uIik/vuID
GrkDH5UWZq+PQugvLEWJmQy51b2t0yAsVlncX+MNLm3D6ZIGRcbG2YqjVboLooTEOlvFN/Jx
Y57QlB741jfWrmJWFXfVG2ByZelBPAxJQAPSybecXVu3+9H59f5B8ixzDEqa3wV+2MYHBJZZ
Xfh98AD+Fn8g6wNCsOJqT7auCiFfDhtXmhUbmj3fkAfhGIanEMDsYWsqYxKNqA2kTbIpOip/
5/D/QTrl9sXiladeA4JzVhgMqRfKM6Ip4q+m8xXTRjCOEqMAZYI5vT7KBAb23VyghVWDn03G
RoLsE2XAdCcipx9JFyloOLd8/GAlCPcLkog67cHP9jX4owbyBV6e+VuM+J1maROuI+Bifejf
YRpLv4yaaLWuoH1sgIP1vvHXG/vJOYV3qT6YzzdZtonDvvOad6BC4ZqQOT+kc5flOWWSw+i1
a1t6yan7F2u+quO31/vRX92s6Sn71id0S5Y8liaC8WG8wmafFUEXKGPwcMbXGWrSunk+VF6z
1pTIFtQcRFVx0jDgp/YnCAJeWmL2GZ/3ueqoytCv4VDhLiOBZNbQVdAChpK1ps9ocdryRVyY
StdYV0RYSeN62vF5FRC5CH+ZYSSg5mQlx5oe0hjVATD68PRgt8tvTyLfCEbpmvcnIxU45+ez
qv8n/c0M32fH0CHcOSry4Q4oWRicjFRx6KrsS0HIlxoUMqaUg9Eg7SM2JgYishS3phlyAjGw
IVOzGHfcgc26xOXNm0h8G9mfioUxrh2E70uPlXMuz5mNueht4qJOm1KkQCcDDLgbYixGBRQl
xhRhWliEawyGo6UsSqNYdZYsac9auhKEU86PSvuFWotWQdyy61Bk6VGMGi2DRbef8PuZEsmL
JUFjg6hv5bsrGgFkKBsDnLGpMBw8Bx2rjKAlLawNiJmxnpr4HrN7E0dkShDg0Df81sTT9l3u
dtmnohqOYQViL3clRoUBo7UI5ydyE1NaCcCXkhipTJlP0JeSMysWgG3pcY9qXVdgYxkrYFWE
ZAa/rJOq2U1MgGd85VexDcFbyFxoryVEXWXrcubiAGsYGn6pY2rDWNwa+2OAwiYLIkzB1cCf
i98PlCLeC5n2Ko4z8nSAkIIwE2oPNgkulY8ZcfHxzGygPMDEy55bAoZ///Bd93lbl/JQsymD
30ED/CPYBVLwsOQOkFmXi8VYO70/Z3FEn93cARFlOHWwbszf6s2msmBl5R9rUf2RVnyVa8mW
NLNPCd/w87frqcnX3ZtMDCqUY8Kf2fSKw0cZqrqgZ3/67fT2fH09X/4++Y0jrKs1yVaUVtbB
KEHu00mii701+vnb8f3rM0iCzDBIkYEOowTctEoKhe0SBohmA7p5JBAHAyOxR5UeQVoiQR6P
g4LNGXUTFiltSidvtz+rJNeHQwJ+ITcqGpe4s603wItWtJYWJDtBNLgugvQm2oi0inwDr/5Y
EyZf4iJ7xlBHYcKzDWCHIHDfuOg6qpg+bY7LPsMIXVRDmXHZr8sG1iVfMSW6+kdEV5xVVCO5
nhODlIHx9B4QzNz5zZXrm4WznsXEiXG2gMbXMTAzJ8bZ6sXCiVk6MMvpwlHP0jmiy6mrP8uZ
5lmnt+Fq5pxp4LG4lhrOjVYrZOLR168maqJxrbhUcR8cZXZ1GrPWgT2zIx2CM5FTvDFvHXjO
gxc8+MpV+/KXY6in7uZJOM8djWBujuRNFl03HC/rkbU+jonwGzh8RWr2BBF+GAMzc5SmCEBI
q4vMLtMvMlDmRMpgbjFvIY2P0WE2Iox1S2yPAbmN1247igjaysef7CnSOqq4wmX3XRlGO6Kq
Lm6ikk83hDR4OvP+KrFt5b85vj4df4y+3z/8fXr6Rl6wo4aBbx3WsdiU5mOLl9fT0/lvdSHz
eHz7ZsdnkWLxjYyRqx0+0hYUo3FoF8b90dCLI0lYlrg1LYoZ0SPR/tSWH8BQ89pmcJsKjN7I
h1v3nx9fQMr4/Xx6PI5AOHz4+0325kHBX+0OqYfNaLMgBr0ehtJu7YeadZFgyzyOePmVEAWg
Pqx5jrcJVmgTiHJWWW6TeaH2AeXlIHSLSm9KS5HUZWWbZzoBD1NrKTPD9WTpUQs0VAyMMQE5
hz3xi1AEyhxYEqN3nYKWEeA3q0yPUCKZb7ZP2WtoNSCaoAPFo8u7bLg9wKXSd1GESUTF5sAy
SdRQZWlsZhYDGU3qetR0j3daO4G3i6Za3TY1Q6P7PhQywRqGWmY9zvDCDIQmGeHHBvaitZqp
T+OPCRHOCJ26OXOOG0qmQ1ZuFed/FBz/fP/2TW1vfRLCQ4Xv9F3Z22WRSCiz3fMXS1gMjBq+
tmUD4QyFoIHGHr4iw5i0VrYMgypboVmDF0vbZRALLseHfHLXjk0SJjFMk92GDuNsvloFdamJ
0gq1S2wI/CeU0dRGFSu7fgDnG8loOde2TqJvaVU6T6YQZ55PhVdvY4DVRJqpoAVL00gE65cG
kr08nnJQUP9ea3r9RaT8XPboRpQ0JU73s2+XBKgwRuysK3xWV467DIWPUj2rOS6ztq5Ha4BB
mdSipeJv95LYqmhdSofHHTZCV933F3WQbO+fvlHnhMzHGB8qrWFG+Uu2rmykdtZh+J6EEubm
4+FfEiMDq4GrDNNQBC1e2SLxnIYpS7SbLkLVtc2xAWWyxi0+q65EyUtH+y/AdYH3BhlvE1Dt
BCad8bZFDW/2RyGxExh5pQeX0LnANL8poH6QSxgagPX8XJJS7f0wDZwnp1oQWPtNGOaGbbPl
fyA1JrmdDwiXzMCfR/96ezk9oWv42/+MHt/Px48j/ON4fvjPf/7zb30xqXJlSBgrFnVewMaz
7bDyM+ykuVeLCiSDKjyEpbWLhze/Oi/hyfd7hQFmnO1zUW1NAtkEeZjozQKphSNlwF1M7jjk
P8EBEXnUB7Upjf7DGgb5OVSRjck0DU13R8PRZWJDRrAu3aWMAX3FpD1hGMBKKkAryPi0F+05
pI455xKD/zHaf1ZaB0sc6d1pV10kEZdOTX4zKmR3JnDbUVH4IPaC3hWJwZxZ+LUmcGhrEpCE
F+tT0QmTfo1y1NqaIUTQTzhBFEhA/sIJgXHv2IE3MQopeEs+4sIvw62TMRrAwJSoV1hCnkGp
rkjg6EJPFK6d7GGrRW3PE56I6LAyScWvqOxLoQ5Rp0omtptALkyi2BSrNKQS69zCoaRJxA2K
fl9ql4QnqfBSS82Xm2aNG9SB1rrZKxGczxDoRql/i3FvBlUF02IMu9jmqJgcT6LIyS1FmX4Y
L2M3hci3PE2np66NOz0G2eyjaisD5pr1KHTiZ3WKCQ38rAgMErR/y02BlFLLsQqBjUzjo6tg
FW1pqmiyd2WFvn42FMh8zYfV8kmVpNcOI/hT4Q4poU++PTSkKLm+9kBIPTqs8jqvO7OgltCe
UnO87Zkk12XMNLLrEM4GEL3Wl0haSeASiZI7bIJuYvawhrlmtotXzbQjQ6P8qilTkWN+Iuch
t4KzCqYFuPYawyVo7FDDSY8l/l5UoUWaosc6vn2X3+mxsdqynH1Vwpfd187Nr7sL5xQAaMEq
bJ/0kb3Og3moa3P+el/2a6Ydh8JcedZuteaxEnDY5W7NOEmizNX5btlrblBbkAWYpFYDS2hW
wBq3iSj4TU3Q1O+HEPyyzaprIYjv2DR5k3Sh9Wo6lN+fJt1GQSgTrE6myxkGCLC0WoShGHgh
MwcMPhw4sqkqsGLKn+mgIDvEDWmYSGVOHXSMw/cVxglaCnwwymY7HhThTaCZBPD3JTNAvULF
VvrPYHBd2Opkca8MLdomZvuoyEQcbdLEiOClUaQ1rU0q06pKW5mG3YlRraNS8W/dHokmRb9q
aTiLpiji287GW5fUFep60bQysNR3aXgl+hUPbYLVxvGBSn4brHy9rrwK6sT2hR1QTtl4T9yG
g6xexa0l25Dc8VY3rmniSrk0+s1NTi6tdpUjqLikr2BkcbSPy9S6zfhwPR5UYxMH8zPhcbX8
NwkyomGR+3+aWjhZGXVdHRAhn9evp6jdNv2exnHmDI4MpIlDn1vpXF4foJlED1GWiwvcIoOt
neAOkgalS5ZOQ4pqNalk0Ej19dVKqjI/3yAjyIBsqOpeaFKd7tFvpmhAKeE2bIc2Ddsq3MDx
4f0V39RY9xw34S05G/AX418ECloJhwlKdkCBJwAvbqzaIlgeX5coFcj6Bk9Y5QY2wAe2GN42
wRYmIiykIZ71G2/d7TCgfinfjEg+QzR1yx+vg2juHF0xrcODdXehnJ+jMouFw2OtL4KkAXSW
3xzWMqjcwB47ArShuA4P+SolDVVSPz/Lb5UiJjTzokVk2vf0Ejqvc+56CHgQetWpRwY6Mxfo
Z4KFJMCStmGcuwTbrl+wF6K05jwSB5LE8H7XMfjAIN3UHPs1CGGQQczQL3V0CpHnaN7DWP9C
v6nqCWErZre8t3JPA8UIGIFfdB0DMeeOGMY90a1wJhZkPGwN7uceQosiEBzrMMk+/fb2eP/w
d+8KdsgKZeMge0bFZ+7Yi//68+X8PHp4fj2Onl9H348/XmhMjjaYs4g3QuYL4sCeDQ9FwAJt
UlAP/Cjf0jk3MfZHWy19NAHapIWmyvYwlrC/wraa7myJcLX+Js9tagDaJSDPZppTCgsW2J0O
fQA+GsBEpGLDtKmF25W1/rcsNSbAlUzUsNG2VJv1xLtO6thC6AIoAdrVI2f9Uod1aGHkH3sp
JQ64qKttSPPKtPA2OZ4OLKPELmET1/h6C/kiHvr2eKcbdUulnsC9n7/jW+aH+/Px6yh8esDN
hCkZ/ns6fx+Jt7fnh5NEBffne2tT+TRLaFc/A/O3Av7zxnkW306mNO5X15PwS7RjlsZWwIG2
6x7IrmQgm8fnr8c3uylSmB4krBa65tSbDlnZS8ZnFkhIHy22sLjYW53I/ZU9cQemQBAv9oXI
u25t79++u3qVCLvIrQKafT1A9e7O7tRH3Tv249vZrqzwp55dnQKrd308kofCeMTctgJkNRkH
0dqN6T41R3jDss1+VbkQUvilHovdJgxmNucJ7HKSCBYiRuGmiWM7LpcEwD5s5gfgxZgDe3N7
TwJ46o3tXbEVE4sWgU1ZluGUo4fS3cj5xGuRbKHJillVbZnJhX3UlpysHA3iaoMPODDTssTu
SrUpJkuGCedzGjCQrplGrqcmjfplrESH08t3PZJwd9DbmxZgTRVZxSO4X17m4CGyq5MVsTq6
tF6x0SA7fOFzxYNctF8b3nk8RRc8zpZQWrxjh2B+8ziOhNXtDvGrD3EIYATE7vDPKT03KbqU
8T1BnH2uSCitnSOwF6iEXmp0wCwQgE2bMAhdVa3lXwt8sxV3NDV7t+5BOxAcT1BwZ3/ak9aJ
GD60dnoYcn6kPbYAxcUWLFs48JXQczWqo7kwoITEOf1lwsByw0+vl5fYnFstcp/horf5ioK7
lliHdjRPRzfTvbh11qCtyN5JFIPEnGg0xn5lrfEm0RZC7jILdj3zmLmN7zif6gG57WWD4v7p
6/PjKH1//PP42gUN5Bol0jJq/By1E7OXQbFSNm57jyBmywk1CqOOd7P1Euezb1UIhVXk56gC
TRxtZMoWYWsMDacSdgheR+uxZac3mb3vKbih6ZGsgimPKt1bqMPsGX6za3IhnabsGRhw8jCz
VwSlgIP30umEpL7PWT8IwRdh84YWDlrf9XL+4TOT3hL408PhwHZCYheeG9mVvbPFSa30S3go
f7dma0ijqsj4yhWq8dN0Pnc03gyVL8rbJAnRTCgtjNJgzCHzehW3NGW90skO8/Gy8UO0j0Xo
eo3WZU33zW/88qr3beexyjMx1EOERBs0z+WhejkrHzdjDYbNUTErDO74l1Qa30Z/YViW07cn
FbhI+rdr3jjq9Ra1wRbabbqNLz/99puBlb6ZtN/W9xaFzBz5aTZeLnrKEP4RiOKWacwwDqq4
VSyzdJS90dllGr3ZaebU1jM2unNZa1dRii2QF0HrjuvGpz9f719/jl6f38+nJ6oIFiIKFk1O
PLlXsPBCzDtJxkCZqQVRtjofhbIqUh+trUWWGFYSShKHqQOLWdnqKqIP7ToUBgbBAB4wSKuo
svGYI9OIjtGhDLC8ycOHwn6SH/yt8p9TLtyUAu/61igEgjBfRXkc6UYfH9gU8HwNNFnoFLbq
CY2p6kb/StdpUZntb1QeDTjs1HB1e60fWwTDP7JoSUSxh5V6gWLleMoBWP5E98nTwDha2Tq9
T5TVw0E/45TTIO1tjwK5Qt7N6AHbEIqXgyb8DqrGg0wXWyTUEmZAihlK1qCkZAIHYYWln7H0
d2UVMOQSzNEf7hA89ET91i1pLUzGucp9Cx4JKh22QEFT+QywalsnKwuBmQXtclf+ZwumL8mh
Q83mLtJ8VnuEJjRq8Jm9TZlbHvSkKkPcjhysuUlyEjFugK8SFrwuCVyUZeZHwMqku0IhNAcx
GWgnTEwQXlcbnifoEJAQ23O5iU0/YHTZaCMGZHmpw2XGaQ2q3NbllQ16hBLyL5TjxtlK/8Vs
ozTW43rERd0YIW/8+A4v/Uj1WRFQy1MQ0EwdxRe0c5F2JLnMJtz/zqIA/YXgKKN3xesMlTbL
US1Ldbd0SXb9wb18bVGSwer0iw9HqGqJvfqY8DxRYnP0kzBr1EkEDEh6mSSJ0qiZfXBRDrsW
jo2xmIw/JtfW+KRtBw3oxPvwPLrCYA4yMgf9aaWyKUUpg8KocboCMrjdqDBTjXTWMB73SC+1
IMwzetUMx4S2B0C6SMImBd4SFjTsbCUdqMhZ9v8Yt8iT1dcBAA==

--yrj/dFKFPuw6o+aM--
