Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DDBC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E350020823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uXKPcN8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E350020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeJaD1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:27:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35217 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeJaD1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:42 -0400
Received: by mail-it1-f195.google.com with SMTP id p64-v6so14960547itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4MN7CxNF39hRfSgNb+oXevSm2RA1lQLKjJLPABnQJlg=;
        b=uXKPcN8YKbBxLsYmyZFRaHzHdS5sjoOx2mVFAI6TxbDct7Euo2hO6r/Q6ycdaLtFAT
         zxyUFc1axSnFTGeUepvQtmQbKixIHVDrigws7Rof+c5g+iCyGUHMXH7xqpGpLFfEOOSb
         orfCIap/pSnwww/ZTEGXIf1bR5V+xi2Cxh9l4vNz1ER8Aj40NcQDarZU0oMzVXhBWztj
         EEioG9IpRlGmri2+iA//OpYsow7zYEmuSO6y+k+q4jam3VxCgsB4LgR7ZtkdaGrYdd7q
         Z5nWVZ8Uwnd5WTCoMA7KubDzI5zF9nMLocnBKc6IUsGoy95+srg8JsUWmhx8WN/iJQMl
         61dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4MN7CxNF39hRfSgNb+oXevSm2RA1lQLKjJLPABnQJlg=;
        b=GM2xOJ8rluBrK9OdQstAiXV6YE/Ub4VYgiY/FE/UH01CH4qO24vogt3ZMA1kKyi2jt
         rZ2iM6GfQG28iiQA0daSmsk/ae8e1URDzbug9yO73690/EfIf0u8+yPb6t+NwOSl81D1
         dIBQ80Zuzqfb9zp8ev74Cap0RyDOX2yh7SFMQbpLvtyJtdyyAaFhyHPa+5d2wwFKNStu
         jyQR/4GdMhCSVkRSxczyjgQkCgjLjdzpfv5H65ATuyT/xvAiRgV2B52ldzcQIBt/ArxA
         7McLnKN8YuCAejEAmKox1O0TbEjErCOEchPcf7dO6Sy9jOm415TWFV6jUOxQl78Rluxs
         aWXA==
X-Gm-Message-State: AGRZ1gK2/aq6BoJqCAjSp5MPL+5ejiss0PreGM4fnmv0Tqzf/aR+tzGx
        kcWREhD4TiGpgtcHaOtAYiHRDw==
X-Google-Smtp-Source: AJdET5eHSIXdgvIc2upeAZJSde+rIJp1mm3cinoJete4zprpLtpSyruLzQe+b+dyDHygDJLWJnS8Zg==
X-Received: by 2002:a24:1b81:: with SMTP id 123-v6mr2165487its.163.1540924386174;
        Tue, 30 Oct 2018 11:33:06 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/16] blk-mq: allow software queue to map to multiple hardware queues
Date:   Tue, 30 Oct 2018 12:32:41 -0600
Message-Id: <20181030183252.17857-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mapping used to be dependent on just the CPU location, but
now it's a tuple of (type, cpu) instead. This is a prep patch
for allowing a single software queue to map to multiple hardware
queues. No functional changes in this patch.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sched.c   |  2 +-
 block/blk-mq.c         | 22 ++++++++++++++++------
 block/blk-mq.h         |  2 +-
 block/kyber-iosched.c  |  6 +++---
 include/linux/blk-mq.h |  3 ++-
 5 files changed, 23 insertions(+), 12 deletions(-)

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
index e3febb5691c4..34afbad0ebf6 100644
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
@@ -2342,10 +2346,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
 		hctx = blk_mq_map_queue_type(q, 0, i);
-
+		hctx->type = 0;
 		cpumask_set_cpu(i, hctx->cpumask);
-		ctx->index_hw = hctx->nr_ctx;
+		ctx->index_hw[hctx->type] = hctx->nr_ctx;
 		hctx->ctxs[hctx->nr_ctx++] = ctx;
+
+		/*
+		 * If the nr_ctx type overflows, we have exceeded the
+		 * amount of sw queues we can support.
+		 */
+		BUG_ON(!hctx->nr_ctx);
 	}
 
 	mutex_unlock(&q->sysfs_lock);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 6a8f8b60d8ba..1821f448f7c4 100644
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
index da88e539601b..466b9202b69c 100644
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

