Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EDFC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FF62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rvJN3FEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FF62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeJaD2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:28:52 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50837 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeJaD1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:47 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so14965073ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YaNlZPxgZjMsE6yDVY2FyfjFvXinmFQDne8Zv8Bpjm0=;
        b=rvJN3FEpSNBj12cWkHpNYG7i5NmARKfJSGWGLfZWELhd2ghH2qATNNTI3NmE9wB6de
         LvZOmj22JPpd8H4nShUmkioSmKplguqzr/kxV4D2wF5GA7EIjYBx3sIYHadXPUlpodaK
         aTk9KYY0EJsFCicSrCPQjTc+SJXkJWz5SIOmiiA6dx62gfeuiakNh6IgTtKsM7vjYQBJ
         9/f6GzuJo8mNiAs+s45s5lJHYxmHUPkyZJKhSFRNSFrSJ/CKf7+TtsrNFBh5i11x52CP
         Cy745LEdaBZVaS2/t09CxGR+9OKdh2YkJUh/ZkCMO5Sr8dmh1JSOKXZyNxnUZxKueWev
         GxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YaNlZPxgZjMsE6yDVY2FyfjFvXinmFQDne8Zv8Bpjm0=;
        b=oLF5qwwrjLfPrwlKuU/nUMiKdFl1hMvj+mQmXgYOxADhvVE78YYGSfnQw9IdLS+gj9
         0ZcvNqZ9Y6UWIoj+6UNYMUnuB7La86U5RMHVkBzrjnSLsibVsah5DTnsuFPLv2jtbIi3
         zGE7yMLqrB/cQKsuL94L8oZnPuKsqrapGwz7SYop7iwAUUlVYKAhPR0lzzYm9lh73Qv3
         BLHAcShq0LwxsNEZbhO4fOIoiJPFsc4FNUihU7g6yNKGVYJjgJWmWKSvNd6Mirrw+X2f
         AwlKPAKqNSwLCnYhLGhNCnsrtXO6ZDltS3xp3ke/naeui9wk8YZx1iC/UhQ9STsOc37A
         4HvQ==
X-Gm-Message-State: AGRZ1gIzFVUVeC0YjOpsPicGaEhCvrnhXks3VWPBu/c/7RPW/9GhpyH9
        0Hmbvv+VwLtAkbsBhUMPfCfJWg==
X-Google-Smtp-Source: AJdET5c8lhycrzLUP6kjXFFrkwzLDmmX+RTAN+tgh/t7zJztE849d8dlf2ZIv1LnyNCbA7+t6iUeYA==
X-Received: by 2002:a24:b303:: with SMTP id e3-v6mr19471itf.82.1540924392117;
        Tue, 30 Oct 2018 11:33:12 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/16] blk-mq: separate number of hardware queues from nr_cpu_ids
Date:   Tue, 30 Oct 2018 12:32:44 -0600
Message-Id: <20181030183252.17857-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With multiple maps, nr_cpu_ids is no longer the maximum number of
hardware queues we support on a given devices. The initializer of
the tag_set can have set ->nr_hw_queues larger than the available
number of CPUs, since we can exceed that with multiple queue maps.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9d6e2f6f8ee9..1ca48cf3bbc7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2668,6 +2668,19 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	mutex_unlock(&q->sysfs_lock);
 }
 
+/*
+ * Maximum number of hardware queues we support. For single sets, we'll never
+ * have more than the CPUs (software queues). For multiple sets, the tag_set
+ * user may have set ->nr_hw_queues larger.
+ */
+static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
+{
+	if (set->nr_maps == 1)
+		return nr_cpu_ids;
+
+	return max(set->nr_hw_queues, nr_cpu_ids);
+}
+
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
@@ -2687,7 +2700,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
 
-	q->queue_hw_ctx = kcalloc_node(nr_cpu_ids, sizeof(*(q->queue_hw_ctx)),
+	q->nr_queues = nr_hw_queues(set);
+	q->queue_hw_ctx = kcalloc_node(q->nr_queues, sizeof(*(q->queue_hw_ctx)),
 						GFP_KERNEL, set->numa_node);
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
@@ -2699,7 +2713,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
-	q->nr_queues = nr_cpu_ids;
 	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
@@ -2889,12 +2902,13 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		set->queue_depth = min(64U, set->queue_depth);
 	}
 	/*
-	 * There is no use for more h/w queues than cpus.
+	 * There is no use for more h/w queues than cpus if we just have
+	 * a single map
 	 */
-	if (set->nr_hw_queues > nr_cpu_ids)
+	if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
 		set->nr_hw_queues = nr_cpu_ids;
 
-	set->tags = kcalloc_node(nr_cpu_ids, sizeof(struct blk_mq_tags *),
+	set->tags = kcalloc_node(nr_hw_queues(set), sizeof(struct blk_mq_tags *),
 				 GFP_KERNEL, set->numa_node);
 	if (!set->tags)
 		return -ENOMEM;
@@ -2937,7 +2951,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i, j;
 
-	for (i = 0; i < nr_cpu_ids; i++)
+	for (i = 0; i < nr_hw_queues(set); i++)
 		blk_mq_free_map_and_requests(set, i);
 
 	for (j = 0; j < set->nr_maps; j++) {
@@ -3069,7 +3083,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	lockdep_assert_held(&set->tag_list_lock);
 
-	if (nr_hw_queues > nr_cpu_ids)
+	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
 	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
 		return;
-- 
2.17.1

