Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D053C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B6D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g8udK3zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B6D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJ3B1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36062 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeJ3B1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:31 -0400
Received: by mail-io1-f68.google.com with SMTP id o19-v6so5379630iod.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BdwO0LohnhfWerZuHJKSr7FFsXgq9TwdYLAuiZgg/AU=;
        b=g8udK3zQPJXvHAuqmR0bLnaG09AbP1RMdB43PoUGlGEDRFBC+4NG0+datDoeJH7dUC
         s9T9up2g22UgUZSIUE+ax/93Qa1HuM7HS9iZvMVjvMoWVX8FQLKg4PVsC9Hp6VvuKbRH
         dn7/+MsAdXRIKvt5K8MSAsk3+JjQ506wkpE0hVa9jgOWXOS/YfN/UwErMFp0G1nPQqrj
         2rGoyxuMpAD0QmOjZw6hwC5f49m8M8JxHn1HasI8j8D6k6Aqp/gLRr6bDNLGZLAEL9Cz
         1L6KmEyrJyiAdt6wP5OrSFAFGhzlfYBbWRF7iYha/fPjJdbU5R7RwhYzWMKJXn6qjD/K
         Dk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BdwO0LohnhfWerZuHJKSr7FFsXgq9TwdYLAuiZgg/AU=;
        b=gr0kMLnk0Ppfjp8AO/OLkxYf9DjgAwKqarlHBxcI9/q3jgyUV//OD1r4SeXEKCJMUW
         uMSgAzBxkaQnzveTsVoKuQONRxyKwWHFKWDoobGNzW4sbATk65TBmEmtYeLLmr2+LHk2
         xJJGdhzXMZkgNnZ/uKphfCmYf9PkkUqmHVgpFkd/7/sub6+32DnjRnxmiRYFdL3U27bW
         9kolXQ8/IYXQxnuk+alYgPKbzgrwTIfkiKdHXFdY4Zk88zA+jvqEyaCWmlGN+EwtzDTV
         89bJY4s6r/oF07vsyEyMjJshnSORYTVDYAy2RM3ZxIfWYMkqAeEivQxAhVYGMW6FNm6I
         PO8w==
X-Gm-Message-State: AGRZ1gIJ259xi4iv8u0c5x6Sc4rw4I5HeWDVk9w5EpGtu4WhTT005HS/
        0B2LTeAjLm+dRVZFRmZz09BZBQ==
X-Google-Smtp-Source: AJdET5drGBSDuDIaaFxhXsP+Ty4iMHQ0CMn/dMlbYERKCnS819QI4BiLzuU1VcvMAKZpmM5evweLnA==
X-Received: by 2002:a6b:9286:: with SMTP id u128-v6mr8236839iod.264.1540831089328;
        Mon, 29 Oct 2018 09:38:09 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:38:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/14] nvme: utilize two queue maps, one for reads and one for writes
Date:   Mon, 29 Oct 2018 10:37:36 -0600
Message-Id: <20181029163738.10172-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe does round-robin between queues by default, which means that
sharing a queue map for both reads and writes can be problematic
in terms of read servicing. It's much easier to flood the queue
with writes and reduce the read servicing.

Implement two queue maps, one for reads and one for writes. The
write queue count is configurable through the 'write_queues'
parameter.

By default, we retain the previous behavior of having a single
queue set, shared between reads and writes. Setting 'write_queues'
to a non-zero value will create two queue sets, one for reads and
one for writes, the latter using the configurable number of
queues (hardware queue counts permitting).

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 139 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 131 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5d783cb6937..658c9a2f4114 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -74,11 +74,29 @@ static int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 
+static int queue_count_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops queue_count_ops = {
+	.set = queue_count_set,
+	.get = param_get_int,
+};
+
+static int write_queues;
+module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);
+MODULE_PARM_DESC(write_queues,
+	"Number of queues to use for writes. If not set, reads and writes "
+	"will share a queue set.");
+
 struct nvme_dev;
 struct nvme_queue;
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
+enum {
+	NVMEQ_TYPE_READ,
+	NVMEQ_TYPE_WRITE,
+	NVMEQ_TYPE_NR,
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -92,6 +110,7 @@ struct nvme_dev {
 	struct dma_pool *prp_small_pool;
 	unsigned online_queues;
 	unsigned max_qid;
+	unsigned io_queues[NVMEQ_TYPE_NR];
 	unsigned int num_vecs;
 	int q_depth;
 	u32 db_stride;
@@ -134,6 +153,17 @@ static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 	return param_set_int(val, kp);
 }
 
+static int queue_count_set(const char *val, const struct kernel_param *kp)
+{
+	int n = 0, ret;
+
+	ret = kstrtoint(val, 10, &n);
+	if (n > num_possible_cpus())
+		n = num_possible_cpus();
+
+	return param_set_int(val, kp);
+}
+
 static inline unsigned int sq_idx(unsigned int qid, u32 stride)
 {
 	return qid * 2 * stride;
@@ -218,9 +248,20 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 }
 
+static unsigned int max_io_queues(void)
+{
+	return num_possible_cpus() + write_queues;
+}
+
+static unsigned int max_queue_count(void)
+{
+	/* IO queues + admin queue */
+	return 1 + max_io_queues();
+}
+
 static inline unsigned int nvme_dbbuf_size(u32 stride)
 {
-	return ((num_possible_cpus() + 1) * 8 * stride);
+	return (max_queue_count() * 8 * stride);
 }
 
 static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
@@ -431,12 +472,41 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 	return 0;
 }
 
+static int queue_irq_offset(struct nvme_dev *dev)
+{
+	/* if we have more than 1 vec, admin queue offsets us 1 */
+	if (dev->num_vecs > 1)
+		return 1;
+
+	return 0;
+}
+
 static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_dev *dev = set->driver_data;
+	int i, qoff, offset;
+
+	offset = queue_irq_offset(dev);
+	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
+		struct blk_mq_queue_map *map = &set->map[i];
+
+		map->nr_queues = dev->io_queues[i];
+		if (!map->nr_queues) {
+			BUG_ON(i == NVMEQ_TYPE_READ);
 
-	return blk_mq_pci_map_queues(&set->map[0], to_pci_dev(dev->dev),
-			dev->num_vecs > 1 ? 1 /* admin queue */ : 0);
+			/* shared set, resuse read set parameters */
+			map->nr_queues = dev->io_queues[NVMEQ_TYPE_READ];
+			qoff = 0;
+			offset = queue_irq_offset(dev);
+		}
+
+		map->queue_offset = qoff;
+		blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+		qoff += map->nr_queues;
+		offset += map->nr_queues;
+	}
+
+	return 0;
 }
 
 /**
@@ -849,6 +919,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+static int nvme_flags_to_type(struct request_queue *q, unsigned int flags)
+{
+	if ((flags & REQ_OP_MASK) == REQ_OP_READ)
+		return NVMEQ_TYPE_READ;
+
+	return NVMEQ_TYPE_WRITE;
+}
+
 static void nvme_pci_complete_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1476,6 +1554,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.flags_to_type	= nvme_flags_to_type,
 	.complete	= nvme_pci_complete_rq,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
@@ -1888,18 +1967,53 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	return ret;
 }
 
+static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
+{
+	unsigned int this_w_queues = write_queues;
+
+	/*
+	 * Setup read/write queue split
+	 */
+	if (nr_io_queues == 1) {
+		dev->io_queues[NVMEQ_TYPE_READ] = 1;
+		dev->io_queues[NVMEQ_TYPE_WRITE] = 0;
+		return;
+	}
+
+	/*
+	 * If 'write_queues' is set, ensure it leaves room for at least
+	 * one read queue
+	 */
+	if (this_w_queues >= nr_io_queues)
+		this_w_queues = nr_io_queues - 1;
+
+	/*
+	 * If 'write_queues' is set to zero, reads and writes will share
+	 * a queue set.
+	 */
+	if (!this_w_queues) {
+		dev->io_queues[NVMEQ_TYPE_WRITE] = 0;
+		dev->io_queues[NVMEQ_TYPE_READ] = nr_io_queues;
+	} else {
+		dev->io_queues[NVMEQ_TYPE_WRITE] = this_w_queues;
+		dev->io_queues[NVMEQ_TYPE_READ] = nr_io_queues - this_w_queues;
+	}
+}
+
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = &dev->queues[0];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues;
 	unsigned long size;
-
+	int irq_sets[2];
 	struct irq_affinity affd = {
-		.pre_vectors = 1
+		.pre_vectors = 1,
+		.nr_sets = ARRAY_SIZE(irq_sets),
+		.sets = irq_sets,
 	};
 
-	nr_io_queues = num_possible_cpus();
+	nr_io_queues = max_io_queues();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
@@ -1929,6 +2043,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	/* Deregister the admin queue's interrupt */
 	pci_free_irq(pdev, 0, adminq);
 
+	nvme_calc_io_queues(dev, nr_io_queues);
+	irq_sets[0] = dev->io_queues[NVMEQ_TYPE_READ];
+	irq_sets[1] = dev->io_queues[NVMEQ_TYPE_WRITE];
+	if (!irq_sets[1])
+		affd.nr_sets = 1;
+
 	/*
 	 * If we enable msix early due to not intx, disable it again before
 	 * setting up the full range we need.
@@ -1941,6 +2061,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	dev->num_vecs = result;
 	dev->max_qid = max(result - 1, 1);
 
+	nvme_calc_io_queues(dev, dev->max_qid);
+
 	/*
 	 * Should investigate if there's a performance win from allocating
 	 * more queues than interrupt vectors; it might allow the submission
@@ -2042,6 +2164,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (!dev->ctrl.tagset) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
+		dev->tagset.nr_maps = NVMEQ_TYPE_NR;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
@@ -2489,8 +2612,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->queues = kcalloc_node(num_possible_cpus() + 1,
-			sizeof(struct nvme_queue), GFP_KERNEL, node);
+	dev->queues = kcalloc_node(max_queue_count(), sizeof(struct nvme_queue),
+					GFP_KERNEL, node);
 	if (!dev->queues)
 		goto free;
 
-- 
2.17.1

