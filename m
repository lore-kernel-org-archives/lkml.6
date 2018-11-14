Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D776C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB482175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2RmRMN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB482175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbeKNKmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:42:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33923 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeKNKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:42:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so6884637plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 16:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7Qk2tX7Z34NB++z2RyQ6S4QoHFhg5PiJo0o9akZOKWE=;
        b=K2RmRMN4eOiwWcdUMe2uSGRiaaZEcfJvtbrwcYl086b71qofg7arh5Vt2c8+oF8giF
         aE+C6XK40Ww7pqYicpTYn65fH2pMsGX2cRJ2ehtCQa0I1dKh95B55/L4vgT95c1XqODa
         FN9Pku+Xo3pRVaROiZmdAZkzW4AEYKWINZl3VQKhgjOfI+n+ETGRdU/CQnxI1np1szL8
         PbWfZsVFLuSEoeLHo1tFjm7HHzbRCIe46r6UxVAmEdKYTD9Adb6Kp0PbwgVZma+jWJTH
         6w23lVTiifoXyn7g/RUmjorW1xUdlMH9qP5yjgHBKNCS77SbjQe1mTf9qqG8L/nQHSi9
         b0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7Qk2tX7Z34NB++z2RyQ6S4QoHFhg5PiJo0o9akZOKWE=;
        b=ojrKyp43ydhID9whQHQLYbKAGStZF8vxvQi68JY33FHa+Qs0Z4fCMSHG5cwayMja2P
         2RxYJzIJ2lVfti61jsDB+OXbc1UrsFBiRO2RkZK6G9Aih3UhEaN3ymh53v+AfFvTwxgC
         zhH9gdC0dpfn6u8aBzUoF/y8QW/jJ3n1F3uqOxB3POLMEQXibN4xLAQgB2RjLXPAvJl7
         PgisXF254BHdQ5UUo+gkQac0RMm2Oy1dba61YOKvYaYcBM+nfOXkfRsZkS3P2kO2DnDA
         FCII9C/13fth8ao6SNLi/N41gu1H6CT9Xbq20c7dMoNoyxd8VJ3jZXokjtbpTa0WO9KB
         rpqQ==
X-Gm-Message-State: AGRZ1gLj9G3a4uoPX3K33TsBC3cYzO8awOYiN48azyqgfnm7SOPuLedH
        nHQX9M8wl/9Kk9qwMhtqqeA=
X-Google-Smtp-Source: AJdET5f9KINOG+JtNm7jOtKY98HCzkYHXYLtOPQ8J1Ln6mnN4M4CHsa/0HUkBjagciILKByHTSeBNw==
X-Received: by 2002:a17:902:b03:: with SMTP id 3-v6mr7402060plq.233.1542156110878;
        Tue, 13 Nov 2018 16:41:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 134sm20385958pgb.78.2018.11.13.16.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 16:41:49 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:41:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
Message-ID: <20181114004148.GA29545@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 31, 2018 at 08:36:31AM -0600, Jens Axboe wrote:
> NVMe does round-robin between queues by default, which means that
> sharing a queue map for both reads and writes can be problematic
> in terms of read servicing. It's much easier to flood the queue
> with writes and reduce the read servicing.
> 
> Implement two queue maps, one for reads and one for writes. The
> write queue count is configurable through the 'write_queues'
> parameter.
> 
> By default, we retain the previous behavior of having a single
> queue set, shared between reads and writes. Setting 'write_queues'
> to a non-zero value will create two queue sets, one for reads and
> one for writes, the latter using the configurable number of
> queues (hardware queue counts permitting).
> 
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

This patch causes hangs when running recent versions of
-next with several architectures; see the -next column at
kerneltests.org/builders for details.  Bisect log below; this
was run with qemu on alpha. Reverting this patch as well as
"nvme: add separate poll queue map" fixes the problem.

Guenter

---
# bad: [220dcf1c6fc97f8873b6d9fe121b80decd4b71a8] Add linux-next specific files for 20181113
# good: [ccda4af0f4b92f7b4c308d3acc262f4a7e3affad] Linux 4.20-rc2
git bisect start 'HEAD' 'v4.20-rc2'
# good: [b5ae1d7e1bd7cf5dfdef977774da5cb69c60c911] Merge remote-tracking branch 'crypto/master'
git bisect good b5ae1d7e1bd7cf5dfdef977774da5cb69c60c911
# bad: [be877b847ffe96fb18e4925f05d5c2eb12b6b9f1] Merge remote-tracking branch 'block/for-next'
git bisect bad be877b847ffe96fb18e4925f05d5c2eb12b6b9f1
# good: [088122c5028636643d566c89cfdc621beed79974] Merge remote-tracking branch 'drm-intel/for-linux-next'
git bisect good 088122c5028636643d566c89cfdc621beed79974
# good: [3577f74d5ae898c34252c5cdc096a681910a919f] Merge remote-tracking branch 'drm-misc/for-linux-next'
git bisect good 3577f74d5ae898c34252c5cdc096a681910a919f
# good: [72008e28c7bf500a03f09929176bd025de94861b] Merge remote-tracking branch 'sound-asoc/for-next'
git bisect good 72008e28c7bf500a03f09929176bd025de94861b
# bad: [d1e36282b0bbd5de6a9c4d5275e94ef3b3438f48] block: add REQ_HIPRI and inherit it from IOCB_HIPRI
git bisect bad d1e36282b0bbd5de6a9c4d5275e94ef3b3438f48
# good: [4316b79e4321d4140164e42f228778e5bc66c84f] block: kill legacy parts of timeout handling
git bisect good 4316b79e4321d4140164e42f228778e5bc66c84f
# good: [a0fedc857dff457e123aeaa2039d28ac90e543df] Merge branch 'irq/for-block' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-4.21/block
git bisect good a0fedc857dff457e123aeaa2039d28ac90e543df
# good: [b3c661b15d5ab11d982e58bee23e05c1780528a1] blk-mq: support multiple hctx maps
git bisect good b3c661b15d5ab11d982e58bee23e05c1780528a1
# good: [67cae4c948a5311121905a2a8740c50daf7f6478] blk-mq: cleanup and improve list insertion
git bisect good 67cae4c948a5311121905a2a8740c50daf7f6478
# good: [843477d4cc5c4bb4e346c561ecd3b9d0bd67e8c8] blk-mq: initial support for multiple queue maps
git bisect good 843477d4cc5c4bb4e346c561ecd3b9d0bd67e8c8
# bad: [3b6592f70ad7b4c24dd3eb2ac9bbe3353d02c992] nvme: utilize two queue maps, one for reads and one for writes
git bisect bad 3b6592f70ad7b4c24dd3eb2ac9bbe3353d02c992
# first bad commit: [3b6592f70ad7b4c24dd3eb2ac9bbe3353d02c992] nvme: utilize two queue maps, one for reads and one for writes

> ---
>  drivers/nvme/host/pci.c | 200 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 181 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 49ad854d1b91..1987df13b73e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -74,11 +74,29 @@ static int io_queue_depth = 1024;
>  module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
>  MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
>  
> +static int queue_count_set(const char *val, const struct kernel_param *kp);
> +static const struct kernel_param_ops queue_count_ops = {
> +	.set = queue_count_set,
> +	.get = param_get_int,
> +};
> +
> +static int write_queues;
> +module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);
> +MODULE_PARM_DESC(write_queues,
> +	"Number of queues to use for writes. If not set, reads and writes "
> +	"will share a queue set.");
> +
>  struct nvme_dev;
>  struct nvme_queue;
>  
>  static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
>  
> +enum {
> +	NVMEQ_TYPE_READ,
> +	NVMEQ_TYPE_WRITE,
> +	NVMEQ_TYPE_NR,
> +};
> +
>  /*
>   * Represents an NVM Express device.  Each nvme_dev is a PCI function.
>   */
> @@ -92,6 +110,7 @@ struct nvme_dev {
>  	struct dma_pool *prp_small_pool;
>  	unsigned online_queues;
>  	unsigned max_qid;
> +	unsigned io_queues[NVMEQ_TYPE_NR];
>  	unsigned int num_vecs;
>  	int q_depth;
>  	u32 db_stride;
> @@ -134,6 +153,17 @@ static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
>  	return param_set_int(val, kp);
>  }
>  
> +static int queue_count_set(const char *val, const struct kernel_param *kp)
> +{
> +	int n = 0, ret;
> +
> +	ret = kstrtoint(val, 10, &n);
> +	if (n > num_possible_cpus())
> +		n = num_possible_cpus();
> +
> +	return param_set_int(val, kp);
> +}
> +
>  static inline unsigned int sq_idx(unsigned int qid, u32 stride)
>  {
>  	return qid * 2 * stride;
> @@ -218,9 +248,20 @@ static inline void _nvme_check_size(void)
>  	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
>  }
>  
> +static unsigned int max_io_queues(void)
> +{
> +	return num_possible_cpus() + write_queues;
> +}
> +
> +static unsigned int max_queue_count(void)
> +{
> +	/* IO queues + admin queue */
> +	return 1 + max_io_queues();
> +}
> +
>  static inline unsigned int nvme_dbbuf_size(u32 stride)
>  {
> -	return ((num_possible_cpus() + 1) * 8 * stride);
> +	return (max_queue_count() * 8 * stride);
>  }
>  
>  static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
> @@ -431,12 +472,41 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
>  	return 0;
>  }
>  
> +static int queue_irq_offset(struct nvme_dev *dev)
> +{
> +	/* if we have more than 1 vec, admin queue offsets us by 1 */
> +	if (dev->num_vecs > 1)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  {
>  	struct nvme_dev *dev = set->driver_data;
> +	int i, qoff, offset;
> +
> +	offset = queue_irq_offset(dev);
> +	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
> +		struct blk_mq_queue_map *map = &set->map[i];
> +
> +		map->nr_queues = dev->io_queues[i];
> +		if (!map->nr_queues) {
> +			BUG_ON(i == NVMEQ_TYPE_READ);
>  
> -	return blk_mq_pci_map_queues(&set->map[0], to_pci_dev(dev->dev),
> -			dev->num_vecs > 1 ? 1 /* admin queue */ : 0);
> +			/* shared set, resuse read set parameters */
> +			map->nr_queues = dev->io_queues[NVMEQ_TYPE_READ];
> +			qoff = 0;
> +			offset = queue_irq_offset(dev);
> +		}
> +
> +		map->queue_offset = qoff;
> +		blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
> +		qoff += map->nr_queues;
> +		offset += map->nr_queues;
> +	}
> +
> +	return 0;
>  }
>  
>  /**
> @@ -849,6 +919,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return ret;
>  }
>  
> +static int nvme_rq_flags_to_type(struct request_queue *q, unsigned int flags)
> +{
> +	if ((flags & REQ_OP_MASK) == REQ_OP_READ)
> +		return NVMEQ_TYPE_READ;
> +
> +	return NVMEQ_TYPE_WRITE;
> +}
> +
>  static void nvme_pci_complete_rq(struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> @@ -1475,13 +1553,14 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
>  };
>  
>  static const struct blk_mq_ops nvme_mq_ops = {
> -	.queue_rq	= nvme_queue_rq,
> -	.complete	= nvme_pci_complete_rq,
> -	.init_hctx	= nvme_init_hctx,
> -	.init_request	= nvme_init_request,
> -	.map_queues	= nvme_pci_map_queues,
> -	.timeout	= nvme_timeout,
> -	.poll		= nvme_poll,
> +	.queue_rq		= nvme_queue_rq,
> +	.rq_flags_to_type	= nvme_rq_flags_to_type,
> +	.complete		= nvme_pci_complete_rq,
> +	.init_hctx		= nvme_init_hctx,
> +	.init_request		= nvme_init_request,
> +	.map_queues		= nvme_pci_map_queues,
> +	.timeout		= nvme_timeout,
> +	.poll			= nvme_poll,
>  };
>  
>  static void nvme_dev_remove_admin(struct nvme_dev *dev)
> @@ -1891,6 +1970,87 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
>  	return ret;
>  }
>  
> +static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
> +{
> +	unsigned int this_w_queues = write_queues;
> +
> +	/*
> +	 * Setup read/write queue split
> +	 */
> +	if (nr_io_queues == 1) {
> +		dev->io_queues[NVMEQ_TYPE_READ] = 1;
> +		dev->io_queues[NVMEQ_TYPE_WRITE] = 0;
> +		return;
> +	}
> +
> +	/*
> +	 * If 'write_queues' is set, ensure it leaves room for at least
> +	 * one read queue
> +	 */
> +	if (this_w_queues >= nr_io_queues)
> +		this_w_queues = nr_io_queues - 1;
> +
> +	/*
> +	 * If 'write_queues' is set to zero, reads and writes will share
> +	 * a queue set.
> +	 */
> +	if (!this_w_queues) {
> +		dev->io_queues[NVMEQ_TYPE_WRITE] = 0;
> +		dev->io_queues[NVMEQ_TYPE_READ] = nr_io_queues;
> +	} else {
> +		dev->io_queues[NVMEQ_TYPE_WRITE] = this_w_queues;
> +		dev->io_queues[NVMEQ_TYPE_READ] = nr_io_queues - this_w_queues;
> +	}
> +}
> +
> +static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	int irq_sets[2];
> +	struct irq_affinity affd = {
> +		.pre_vectors = 1,
> +		.nr_sets = ARRAY_SIZE(irq_sets),
> +		.sets = irq_sets,
> +	};
> +	int result;
> +
> +	/*
> +	 * For irq sets, we have to ask for minvec == maxvec. This passes
> +	 * any reduction back to us, so we can adjust our queue counts and
> +	 * IRQ vector needs.
> +	 */
> +	do {
> +		nvme_calc_io_queues(dev, nr_io_queues);
> +		irq_sets[0] = dev->io_queues[NVMEQ_TYPE_READ];
> +		irq_sets[1] = dev->io_queues[NVMEQ_TYPE_WRITE];
> +		if (!irq_sets[1])
> +			affd.nr_sets = 1;
> +
> +		/*
> +		 * Need IRQs for read+write queues, and one for the admin queue
> +		 */
> +		nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
> +
> +		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
> +				nr_io_queues,
> +				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> +
> +		/*
> +		 * Need to reduce our vec counts
> +		 */
> +		if (result == -ENOSPC) {
> +			nr_io_queues--;
> +			if (!nr_io_queues)
> +				return result;
> +			continue;
> +		} else if (result <= 0)
> +			return -EIO;
> +		break;
> +	} while (1);
> +
> +	return result;
> +}
> +
>  static int nvme_setup_io_queues(struct nvme_dev *dev)
>  {
>  	struct nvme_queue *adminq = &dev->queues[0];
> @@ -1898,11 +2058,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	int result, nr_io_queues;
>  	unsigned long size;
>  
> -	struct irq_affinity affd = {
> -		.pre_vectors = 1
> -	};
> -
> -	nr_io_queues = num_possible_cpus();
> +	nr_io_queues = max_io_queues();
>  	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
>  	if (result < 0)
>  		return result;
> @@ -1937,13 +2093,18 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	 * setting up the full range we need.
>  	 */
>  	pci_free_irq_vectors(pdev);
> -	result = pci_alloc_irq_vectors_affinity(pdev, 1, nr_io_queues + 1,
> -			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> +
> +	result = nvme_setup_irqs(dev, nr_io_queues);
>  	if (result <= 0)
>  		return -EIO;
> +
>  	dev->num_vecs = result;
>  	dev->max_qid = max(result - 1, 1);
>  
> +	dev_info(dev->ctrl.device, "%d/%d read/write queues\n",
> +					dev->io_queues[NVMEQ_TYPE_READ],
> +					dev->io_queues[NVMEQ_TYPE_WRITE]);
> +
>  	/*
>  	 * Should investigate if there's a performance win from allocating
>  	 * more queues than interrupt vectors; it might allow the submission
> @@ -2045,6 +2206,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  	if (!dev->ctrl.tagset) {
>  		dev->tagset.ops = &nvme_mq_ops;
>  		dev->tagset.nr_hw_queues = dev->online_queues - 1;
> +		dev->tagset.nr_maps = NVMEQ_TYPE_NR;
>  		dev->tagset.timeout = NVME_IO_TIMEOUT;
>  		dev->tagset.numa_node = dev_to_node(dev->dev);
>  		dev->tagset.queue_depth =
> @@ -2491,8 +2653,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (!dev)
>  		return -ENOMEM;
>  
> -	dev->queues = kcalloc_node(num_possible_cpus() + 1,
> -			sizeof(struct nvme_queue), GFP_KERNEL, node);
> +	dev->queues = kcalloc_node(max_queue_count(), sizeof(struct nvme_queue),
> +					GFP_KERNEL, node);
>  	if (!dev->queues)
>  		goto free;
>  
> -- 
> 2.7.4
