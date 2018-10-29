Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B707C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0E420657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Se1GMmG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0E420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeJ3B1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:15 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34818 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeJ3B1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:14 -0400
Received: by mail-it1-f195.google.com with SMTP id p64-v6so10180639itp.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YdW9jHQFmkDw/Bx6HtFcVTIU0iWJR3rZpnd+EOU2uNE=;
        b=Se1GMmG2yUzRhbD6TQn47Wm6Mee88P1kJovqFVWM7pKN2lcYE4ysLQlWzeR/jEwJQ0
         BRcOgm+2E5PxTpm+rsRhwKfhtYu7Bqhl/+FMIrYs+aRF90qGsN1Sl30uEvOZYLswyPN8
         vno2j1NzUIwYCx6r1z/jQw8sCJmbJ0IpbbPLbIaLSB9ZkagDLQYJ8LOAdzBlF+l7tLdQ
         0uaC6kVqYQVk1MIcMI4kbPJgAsDewrGbNol9L1negqXeNU4t2XIfcNIMktWxGw9v0zOV
         d5tgOURAnl2PNR+AM47T/PwDqTksT12A8MrMN2I1/Aux8JBxja+TstFqNB+2PfZmXm5+
         EFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YdW9jHQFmkDw/Bx6HtFcVTIU0iWJR3rZpnd+EOU2uNE=;
        b=I7akmQ/9ZyvK6StYh9gPuaq0HNL/eg5p+/ve29szo6ZCfd1jv1p12yF3ZTHe//Vemj
         lqg/q+9V6ElQ9YKzQjtNeHGJiSh2mSirdgMz0Kih7O+wYMr6jbwuEtIKR0u6N2XSUeoU
         0aPodjODCVxLaNXKSaXQ2zuiY1XGFfQZ+r4s6gBI7aMmXXvd8UDCa3ayRdhtEyHvkImQ
         N/Ldpv+FP4FadRTRrG2HM0gO/n73fV5o7sY+VKKeImXetETjaH9wdiWHveNA7P995F+7
         et5mwE4cMnyPFDIKVNz4Noi6I0V/RtmqI4uX1MMgLoRaxjNfFsRot+C74/5XFBI1u5LB
         t7fA==
X-Gm-Message-State: AGRZ1gLqTpDtjmpWb48oEt2RewZJ+kj1xG+CNMFZuRE6VyE0ZdmEn4Ub
        UBCTcoQVXHmA1sFSF2//m9YSBQ==
X-Google-Smtp-Source: AJdET5dtYFrGLX0W5FVQua2DTuWr3i7tr8VKZFl8/0RjGUECTIzyNRmXNZ+nKoAqcc1bD0B6cDpkoA==
X-Received: by 2002:a05:660c:441:: with SMTP id d1mr10654181itl.22.1540831072079;
        Mon, 29 Oct 2018 09:37:52 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:37:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/14] blk-mq: allow software queue to map to multiple hardware queues
Date:   Mon, 29 Oct 2018 10:37:29 -0600
Message-Id: <20181029163738.10172-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mapping used to be dependent on just the CPU location, but
now it's a tuple of { type, cpu} instead. This is a prep patch
for allowing a single software queue to map to multiple hardware
queues. No functional changes in this patch.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sched.c   |  2 +-
 block/blk-mq.c         | 18 ++++++++++++------
 block/blk-mq.h         |  2 +-
 block/kyber-iosched.c  |  6 +++---
 include/linux/blk-mq.h |  3 ++-
 5 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 8125e9393ec2..d232ecf3290c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -110,7 +110,7 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
 					  struct blk_mq_ctx *ctx)
 {
-	unsigned idx = ctx->index_hw;
+	unsigned short idx = ctx->index_hw[hctx->type];
 
 	if (++idx == hctx->nr_ctx)
 		idx = 0;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e6ea7da99125..fab84c6bda18 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -75,14 +75,18 @@ static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 static void blk_mq_hctx_mark_pending(struct blk_mq_hw_ctx *hctx,
 				     struct blk_mq_ctx *ctx)
 {
-	if (!sbitmap_test_bit(&hctx->ctx_map, ctx->index_hw))
-		sbitmap_set_bit(&hctx->ctx_map, ctx->index_hw);
+	const int bit = ctx->index_hw[hctx->type];
+
+	if (!sbitmap_test_bit(&hctx->ctx_map, bit))
+		sbitmap_set_bit(&hctx->ctx_map, bit);
 }
 
 static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 				      struct blk_mq_ctx *ctx)
 {
-	sbitmap_clear_bit(&hctx->ctx_map, ctx->index_hw);
+	const int bit = ctx->index_hw[hctx->type];
+
+	sbitmap_clear_bit(&hctx->ctx_map, bit);
 }
 
 struct mq_inflight {
@@ -954,7 +958,7 @@ static bool dispatch_rq_from_ctx(struct sbitmap *sb, unsigned int bitnr,
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start)
 {
-	unsigned off = start ? start->index_hw : 0;
+	unsigned off = start ? start->index_hw[hctx->type] : 0;
 	struct dispatch_rq_data data = {
 		.hctx = hctx,
 		.rq   = NULL,
@@ -2342,10 +2346,12 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
 		hctx = blk_mq_map_queue_type(q, 0, i);
-
+		hctx->type = 0;
 		cpumask_set_cpu(i, hctx->cpumask);
-		ctx->index_hw = hctx->nr_ctx;
+		ctx->index_hw[hctx->type] = hctx->nr_ctx;
 		hctx->ctxs[hctx->nr_ctx++] = ctx;
+		/* wrap */
+		BUG_ON(!hctx->nr_ctx);
 	}
 
 	mutex_unlock(&q->sysfs_lock);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 55428b92c019..7b5a790acdbf 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -17,7 +17,7 @@ struct blk_mq_ctx {
 	}  ____cacheline_aligned_in_smp;
 
 	unsigned int		cpu;
-	unsigned int		index_hw;
+	unsigned short		index_hw[HCTX_MAX_TYPES];
 
 	/* incremented at dispatch time */
 	unsigned long		rq_dispatched[2];
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 728757a34fa0..b824a639d5d4 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -576,7 +576,7 @@ static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
 {
 	struct kyber_hctx_data *khd = hctx->sched_data;
 	struct blk_mq_ctx *ctx = blk_mq_get_ctx(hctx->queue);
-	struct kyber_ctx_queue *kcq = &khd->kcqs[ctx->index_hw];
+	struct kyber_ctx_queue *kcq = &khd->kcqs[ctx->index_hw[hctx->type]];
 	unsigned int sched_domain = kyber_sched_domain(bio->bi_opf);
 	struct list_head *rq_list = &kcq->rq_list[sched_domain];
 	bool merged;
@@ -602,7 +602,7 @@ static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 	list_for_each_entry_safe(rq, next, rq_list, queuelist) {
 		unsigned int sched_domain = kyber_sched_domain(rq->cmd_flags);
-		struct kyber_ctx_queue *kcq = &khd->kcqs[rq->mq_ctx->index_hw];
+		struct kyber_ctx_queue *kcq = &khd->kcqs[rq->mq_ctx->index_hw[hctx->type]];
 		struct list_head *head = &kcq->rq_list[sched_domain];
 
 		spin_lock(&kcq->lock);
@@ -611,7 +611,7 @@ static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,
 		else
 			list_move_tail(&rq->queuelist, head);
 		sbitmap_set_bit(&khd->kcq_map[sched_domain],
-				rq->mq_ctx->index_hw);
+				rq->mq_ctx->index_hw[hctx->type]);
 		blk_mq_sched_request_inserted(rq);
 		spin_unlock(&kcq->lock);
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 71fd205b4213..f9e19962a22f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -37,7 +37,8 @@ struct blk_mq_hw_ctx {
 	struct blk_mq_ctx	*dispatch_from;
 	unsigned int		dispatch_busy;
 
-	unsigned int		nr_ctx;
+	unsigned short		type;
+	unsigned short		nr_ctx;
 	struct blk_mq_ctx	**ctxs;
 
 	spinlock_t		dispatch_wait_lock;
-- 
2.17.1

