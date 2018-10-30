Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F4C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2DC20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k/sJ8EZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2DC20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbeJaD2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:28:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46741 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeJaD2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:28:05 -0400
Received: by mail-io1-f67.google.com with SMTP id y22-v6so7900956ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w9pcIzKJWRe4jEUW8l7UAhqEstR0ah0VX1SydPsKIBM=;
        b=k/sJ8EZX/mPKGCUC+siRmJj0IMRcSadGCPo7yzNtdm/aU3gF/2QC706dEfe3lJjXvP
         kwjP/5haEQFE8L23uRScEgi8nhbk+b++O2Ja+dkEjH1a5DJLFnA12plFKmNSnIQDyQs4
         IFkxIwqOvS3lNNqxKcA+ZgEGy6t6vfVJBSWTyTk/ZkMPDRpq0HTPyLNtAPQkVCnL9Kv9
         TWf4B8hkTwVlhm9mzZHixXcUe+c1JvRnUD1qnY6iUjnbmJPlwPfriGOoQV3+2AN5gCpm
         nhic631b4SzogW4z8nGqTvzdUDUu+NklTmcOjf9m4YqrHALQKHg21hkHCmjYO8FQRMdU
         pW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w9pcIzKJWRe4jEUW8l7UAhqEstR0ah0VX1SydPsKIBM=;
        b=Ia0AHzjVjQ7WsU+pckvAK8bUbKfqD8A8eltUOBuxS3rFEKk9ZP9ScsPGY9moVmduz+
         2OtoP/FICwgLRgw+Jx4t8f/EI2RtHKbaa2rlnHp8ub5QXfSjJiMD0/6YgU+7B84FKaGT
         CtftGXfYd50+sgHYw605wjtEfYQaVRxWVuSV8pyT+EgZsdC95Da0/ljl03My9QVDVZfD
         k4cSrcjy22f4gKctRPwYt2nji/FCQ94j29e6k0KJOU0AaTy1sU9HyY+i+Siz3iby9DGS
         N4FGy86j9OEkATd+g8snsxRKeFNt4iin7eAH7uRdzcgT5HOTvw+syboGP0DLVEugY+Cb
         hX4g==
X-Gm-Message-State: AGRZ1gIX+e7GgDWJC2FRlksw8Onexyhh089CPGzGd8vwYsqoWylw6ISA
        oyzKcoe8++7Jaf5Kzsnxgkk30QvRKmY=
X-Google-Smtp-Source: AJdET5cRsn8cFeLIlhbzA/6Yn4l/my5K7FsIVbBGX0GaklA5Ln/rrS8ZFdZ/B9SYNvLIGFtx5fHu/g==
X-Received: by 2002:a6b:b48d:: with SMTP id d135-v6mr3972iof.61.1540924407842;
        Tue, 30 Oct 2018 11:33:27 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/16] nvme: add separate poll queue map
Date:   Tue, 30 Oct 2018 12:32:52 -0600
Message-Id: <20181030183252.17857-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for defining a variable number of poll queues, currently
configurable with the 'poll_queues' module parameter. Defaults to
a single poll queue.

And now we finally have poll support without triggering interrupts!

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 97 +++++++++++++++++++++++++++++++++--------
 include/linux/blk-mq.h  |  2 +-
 2 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17170686105f..305d8d3826d7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -86,6 +86,10 @@ MODULE_PARM_DESC(write_queues,
 	"Number of queues to use for writes. If not set, reads and writes "
 	"will share a queue set.");
 
+static int poll_queues = 1;
+module_param_cb(poll_queues, &queue_count_ops, &poll_queues, 0644);
+MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -94,6 +98,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 enum {
 	NVMEQ_TYPE_READ,
 	NVMEQ_TYPE_WRITE,
+	NVMEQ_TYPE_POLL,
 	NVMEQ_TYPE_NR,
 };
 
@@ -202,6 +207,7 @@ struct nvme_queue {
 	u16 last_cq_head;
 	u16 qid;
 	u8 cq_phase;
+	u8 polled;
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -250,7 +256,7 @@ static inline void _nvme_check_size(void)
 
 static unsigned int max_io_queues(void)
 {
-	return num_possible_cpus() + write_queues;
+	return num_possible_cpus() + write_queues + poll_queues;
 }
 
 static unsigned int max_queue_count(void)
@@ -500,8 +506,15 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 			offset = queue_irq_offset(dev);
 		}
 
+		/*
+		 * The poll queue(s) doesn't have an IRQ (and hence IRQ
+		 * affinity), so use the regular blk-mq cpu mapping
+		 */
 		map->queue_offset = qoff;
-		blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+		if (i != NVMEQ_TYPE_POLL)
+			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+		else
+			blk_mq_map_queues(map);
 		qoff += map->nr_queues;
 		offset += map->nr_queues;
 	}
@@ -892,7 +905,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * We should not need to do this, but we're still using this to
 	 * ensure we can drain requests on a dying queue.
 	 */
-	if (unlikely(nvmeq->cq_vector < 0))
+	if (unlikely(nvmeq->cq_vector < 0 && !nvmeq->polled))
 		return BLK_STS_IOERR;
 
 	ret = nvme_setup_cmd(ns, req, &cmnd);
@@ -921,6 +934,8 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static int nvme_flags_to_type(struct request_queue *q, unsigned int flags)
 {
+	if (flags & REQ_HIPRI)
+		return NVMEQ_TYPE_POLL;
 	if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		return NVMEQ_TYPE_READ;
 
@@ -1094,7 +1109,10 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 		struct nvme_queue *nvmeq, s16 vector)
 {
 	struct nvme_command c;
-	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED;
+	int flags = NVME_QUEUE_PHYS_CONTIG;
+
+	if (vector != -1)
+		flags |= NVME_CQ_IRQ_ENABLED;
 
 	/*
 	 * Note: we (ab)use the fact that the prp fields survive if no data
@@ -1106,7 +1124,10 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	c.create_cq.cqid = cpu_to_le16(qid);
 	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(flags);
-	c.create_cq.irq_vector = cpu_to_le16(vector);
+	if (vector != -1)
+		c.create_cq.irq_vector = cpu_to_le16(vector);
+	else
+		c.create_cq.irq_vector = 0;
 
 	return nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 }
@@ -1348,13 +1369,14 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	int vector;
 
 	spin_lock_irq(&nvmeq->cq_lock);
-	if (nvmeq->cq_vector == -1) {
+	if (nvmeq->cq_vector == -1 && !nvmeq->polled) {
 		spin_unlock_irq(&nvmeq->cq_lock);
 		return 1;
 	}
 	vector = nvmeq->cq_vector;
 	nvmeq->dev->online_queues--;
 	nvmeq->cq_vector = -1;
+	nvmeq->polled = false;
 	spin_unlock_irq(&nvmeq->cq_lock);
 
 	/*
@@ -1366,7 +1388,8 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
 
-	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
+	if (vector != -1)
+		pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
 
 	return 0;
 }
@@ -1500,7 +1523,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	spin_unlock_irq(&nvmeq->cq_lock);
 }
 
-static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
+static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
@@ -1510,7 +1533,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	 * A queue's vector matches the queue identifier unless the controller
 	 * has only one vector available.
 	 */
-	vector = dev->num_vecs == 1 ? 0 : qid;
+	if (!polled)
+		vector = dev->num_vecs == 1 ? 0 : qid;
+	else
+		vector = -1;
+
 	result = adapter_alloc_cq(dev, qid, nvmeq, vector);
 	if (result)
 		return result;
@@ -1527,15 +1554,20 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	 * xxx' warning if the create CQ/SQ command times out.
 	 */
 	nvmeq->cq_vector = vector;
+	nvmeq->polled = polled;
 	nvme_init_queue(nvmeq, qid);
-	result = queue_request_irq(nvmeq);
-	if (result < 0)
-		goto release_sq;
+
+	if (vector != -1) {
+		result = queue_request_irq(nvmeq);
+		if (result < 0)
+			goto release_sq;
+	}
 
 	return result;
 
 release_sq:
 	nvmeq->cq_vector = -1;
+	nvmeq->polled = false;
 	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
 release_cq:
@@ -1686,7 +1718,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 
 static int nvme_create_io_queues(struct nvme_dev *dev)
 {
-	unsigned i, max;
+	unsigned i, max, rw_queues;
 	int ret = 0;
 
 	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
@@ -1697,8 +1729,17 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	}
 
 	max = min(dev->max_qid, dev->ctrl.queue_count - 1);
+	if (max != 1 && dev->io_queues[NVMEQ_TYPE_POLL]) {
+		rw_queues = dev->io_queues[NVMEQ_TYPE_READ] +
+				dev->io_queues[NVMEQ_TYPE_WRITE];
+	} else {
+		rw_queues = max;
+	}
+
 	for (i = dev->online_queues; i <= max; i++) {
-		ret = nvme_create_queue(&dev->queues[i], i);
+		bool polled = i > rw_queues;
+
+		ret = nvme_create_queue(&dev->queues[i], i, polled);
 		if (ret)
 			break;
 	}
@@ -1970,6 +2011,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	unsigned int this_w_queues = write_queues;
+	unsigned int this_p_queues = poll_queues;
 
 	/*
 	 * Setup read/write queue split
@@ -1977,9 +2019,28 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
 	if (nr_io_queues == 1) {
 		dev->io_queues[NVMEQ_TYPE_READ] = 1;
 		dev->io_queues[NVMEQ_TYPE_WRITE] = 0;
+		dev->io_queues[NVMEQ_TYPE_POLL] = 0;
 		return;
 	}
 
+	/*
+	 * Configure number of poll queues, if set
+	 */
+	if (this_p_queues) {
+		/*
+		 * We need at least one queue left. With just one queue, we'll
+		 * have a single shared read/write set.
+		 */
+		if (this_p_queues >= nr_io_queues) {
+			this_w_queues = 0;
+			this_p_queues = nr_io_queues - 1;
+		}
+
+		dev->io_queues[NVMEQ_TYPE_POLL] = this_p_queues;
+		nr_io_queues -= this_p_queues;
+	} else
+		dev->io_queues[NVMEQ_TYPE_POLL] = 0;
+
 	/*
 	 * If 'write_queues' is set, ensure it leaves room for at least
 	 * one read queue
@@ -2084,11 +2145,13 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	} while (1);
 
 	dev->num_vecs = result;
-	dev->max_qid = max(result - 1, 1);
+	result = max(result - 1, 1);
+	dev->max_qid = result + dev->io_queues[NVMEQ_TYPE_POLL];
 
-	dev_info(dev->ctrl.device, "%d/%d/%d read/write queues\n",
+	dev_info(dev->ctrl.device, "%d/%d/%d read/write/poll queues\n",
 					dev->io_queues[NVMEQ_TYPE_READ],
-					dev->io_queues[NVMEQ_TYPE_WRITE]);
+					dev->io_queues[NVMEQ_TYPE_WRITE],
+					dev->io_queues[NVMEQ_TYPE_POLL]);
 
 	/*
 	 * Should investigate if there's a performance win from allocating
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8e80d5043079..b31f6f016621 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -82,7 +82,7 @@ struct blk_mq_queue_map {
 };
 
 enum {
-	HCTX_MAX_TYPES = 2,
+	HCTX_MAX_TYPES = 3,
 };
 
 struct blk_mq_tag_set {
-- 
2.17.1

