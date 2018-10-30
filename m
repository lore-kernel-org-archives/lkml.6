Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD121C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBDC2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1qhl4csY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBDC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeJaD1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:27:51 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50845 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeJaD1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:50 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so14965201ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UQiEEY9NMcTCEmprz5TQOWS0p7/1mWG9RdC0JOyu6aY=;
        b=1qhl4csYHjkqmdwTYPZNkKwdlfHdKdX1wk3lz8Rc/n7h0Gthk3YlWXYkcOLL+gEiLF
         iDTBShjNC8DbXvUS7vqXpCI4BPYmyTWFoNTqa3nfhYYoG1n2WiJo5pxEUBpV74HsmmKh
         Rihxm3/iy0jro0hP5SnyvYIW+4+pvgR0c3mn8qik/LITLoitXb9NnepqdJA12yhkyp+r
         HISAf9PHE9LsFr1CK+y1unqpowo3qSuv/4eDa/MndUG8/8hp4KT5StqH7E5NLFIYWzwb
         k3xGTCtQUBsaElrdqyeMhwQp7Yp9gMO8PioldRSkq09/LLdgdSutHlf1ohpAnkUE7E7e
         rcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UQiEEY9NMcTCEmprz5TQOWS0p7/1mWG9RdC0JOyu6aY=;
        b=Of97xmXZaSLZcuzGDPlmva9RS0lVSwdovGARmVdSB1K/Br7/QbXnCYLKtughh/L/JX
         Nc8lF3JYYfjVt7Pzqu6ZyiFdu8QC143K1H0TcsQAxXxV5F7Vpo/ZLKgstNm55yfLpLkK
         d8P2KuafuJdR3noEHqmP3+MwwuCzCQfpHvQsQqGScSXZq1992BkOkZ4d+2oR5yrPQUqy
         pBMqC0ADUftXdeOVAKBgk2P5OyltTqLu68EcTn2/bZ4k8AuUiVI0to90vupL/qBQShl0
         oOaJJ4w/7jwCoiSZlkjkdBLNMYeEWEOIZjVuF1XVwpUPgKmf7um4x56wQIxCxxtLEBoc
         fIyw==
X-Gm-Message-State: AGRZ1gKQOUGDKjFQa6pq/8Q7GZUTgQTDUj4Rl3CRYic94vr1PFEJ4JAe
        LS79GaKPi3VooTZDYDY3kcz7Ng==
X-Google-Smtp-Source: AJdET5ccjFh3e9qP38/MTNN/1Nt5ynjAi8TFrdMikZAjRf6YzSgvdneZkX8f8xE4+ggqqbV10qCmeA==
X-Received: by 2002:a24:2914:: with SMTP id p20-v6mr2162992itp.171.1540924394036;
        Tue, 30 Oct 2018 11:33:14 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:33:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/16] blk-mq: cache request hardware queue mapping
Date:   Tue, 30 Oct 2018 12:32:45 -0600
Message-Id: <20181030183252.17857-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call blk_mq_map_queue() a lot, at least two times for each
request per IO, sometimes more. Since we now have an indirect
call as well in that function. cache the mapping so we don't
have to re-call blk_mq_map_queue() for the same request
multiple times.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-flush.c      | 12 ++++--------
 block/blk-mq-debugfs.c |  4 +---
 block/blk-mq-sched.c   |  6 ++----
 block/blk-mq-tag.c     |  9 +--------
 block/blk-mq.c         | 22 +++++++++-------------
 block/blk-mq.h         |  5 +----
 include/linux/blkdev.h |  1 +
 7 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 7922dba81497..2ff590b31a9d 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -219,7 +219,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
-	hctx = blk_mq_map_queue(q, flush_rq->cmd_flags, flush_rq->mq_ctx->cpu);
+	hctx = flush_rq->mq_hctx;
 	if (!q->elevator) {
 		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
 		flush_rq->tag = -1;
@@ -268,7 +268,6 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	struct request *first_rq =
 		list_first_entry(pending, struct request, flush.list);
 	struct request *flush_rq = fq->flush_rq;
-	struct blk_mq_hw_ctx *hctx;
 
 	/* C1 described at the top of this file */
 	if (fq->flush_pending_idx != fq->flush_running_idx || list_empty(pending))
@@ -303,13 +302,12 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	 * just for cheating put/get driver tag.
 	 */
 	flush_rq->mq_ctx = first_rq->mq_ctx;
+	flush_rq->mq_hctx = first_rq->mq_hctx;
 
 	if (!q->elevator) {
 		fq->orig_rq = first_rq;
 		flush_rq->tag = first_rq->tag;
-		hctx = blk_mq_map_queue(q, first_rq->cmd_flags,
-					first_rq->mq_ctx->cpu);
-		blk_mq_tag_set_rq(hctx, first_rq->tag, flush_rq);
+		blk_mq_tag_set_rq(flush_rq->mq_hctx, first_rq->tag, flush_rq);
 	} else {
 		flush_rq->internal_tag = first_rq->internal_tag;
 	}
@@ -326,13 +324,11 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 {
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	unsigned long flags;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, ctx);
 
-	hctx = blk_mq_map_queue(q, rq->cmd_flags, ctx->cpu);
-
 	if (q->elevator) {
 		WARN_ON(rq->tag < 0);
 		blk_mq_put_driver_tag_hctx(hctx, rq);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index fac70c81b7de..cde19be36135 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -427,10 +427,8 @@ struct show_busy_params {
 static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
 {
 	const struct show_busy_params *params = data;
-	struct blk_mq_hw_ctx *hctx;
 
-	hctx = blk_mq_map_queue(rq->q, rq->cmd_flags, rq->mq_ctx->cpu);
-	if (hctx == params->hctx)
+	if (rq->mq_hctx == params->hctx)
 		__blk_mq_debugfs_rq_show(params->m,
 					 list_entry_rq(&rq->queuelist));
 }
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index d232ecf3290c..8bc1f37acca2 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -367,9 +367,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 	struct request_queue *q = rq->q;
 	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct blk_mq_hw_ctx *hctx;
-
-	hctx = blk_mq_map_queue(q, rq->cmd_flags, ctx->cpu);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	/* flush rq in flush machinery need to be dispatched directly */
 	if (!(rq->rq_flags & RQF_FLUSH_SEQ) && op_is_flush(rq->cmd_flags)) {
@@ -408,7 +406,7 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 
 	/* For list inserts, requests better be on the same hw queue */
 	rq = list_first_entry(list, struct request, queuelist);
-	hctx = blk_mq_map_queue(q, rq->cmd_flags, ctx->cpu);
+	hctx = rq->mq_hctx;
 
 	e = hctx->queue->elevator;
 	if (e && e->type->ops.mq.insert_requests)
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 478a959357f5..fb836d818b80 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -527,14 +527,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
  */
 u32 blk_mq_unique_tag(struct request *rq)
 {
-	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx;
-	int hwq = 0;
-
-	hctx = blk_mq_map_queue(q, rq->cmd_flags, rq->mq_ctx->cpu);
-	hwq = hctx->queue_num;
-
-	return (hwq << BLK_MQ_UNIQUE_TAG_BITS) |
+	return (rq->mq_hctx->queue_num << BLK_MQ_UNIQUE_TAG_BITS) |
 		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
 }
 EXPORT_SYMBOL(blk_mq_unique_tag);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1ca48cf3bbc7..b86d725958d3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -300,6 +300,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	/* csd/requeue_work/fifo_time is initialized before use */
 	rq->q = data->q;
 	rq->mq_ctx = data->ctx;
+	rq->mq_hctx = data->hctx;
 	rq->rq_flags = rq_flags;
 	rq->cpu = -1;
 	rq->cmd_flags = op;
@@ -473,10 +474,11 @@ static void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->cmd_flags, ctx->cpu);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	const int sched_tag = rq->internal_tag;
 
 	blk_pm_mark_last_busy(rq);
+	rq->mq_hctx = NULL;
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
@@ -490,7 +492,7 @@ void blk_mq_free_request(struct request *rq)
 	struct request_queue *q = rq->q;
 	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->cmd_flags, ctx->cpu);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	if (rq->rq_flags & RQF_ELVPRIV) {
 		if (e && e->type->ops.mq.finish_request)
@@ -982,7 +984,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_alloc_data data = {
 		.q = rq->q,
-		.hctx = blk_mq_map_queue(rq->q, rq->cmd_flags, rq->mq_ctx->cpu),
+		.hctx = rq->mq_hctx,
 		.flags = BLK_MQ_REQ_NOWAIT,
 		.cmd_flags = rq->cmd_flags,
 	};
@@ -1148,7 +1150,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 
 		rq = list_first_entry(list, struct request, queuelist);
 
-		hctx = blk_mq_map_queue(rq->q, rq->cmd_flags, rq->mq_ctx->cpu);
+		hctx = rq->mq_hctx;
 		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
 			break;
 
@@ -1578,9 +1580,7 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
  */
 void blk_mq_request_bypass_insert(struct request *rq, bool run_queue)
 {
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, rq->cmd_flags,
-							ctx->cpu);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	spin_lock(&hctx->lock);
 	list_add_tail(&rq->queuelist, &hctx->dispatch);
@@ -1789,9 +1789,7 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 	blk_status_t ret;
 	int srcu_idx;
 	blk_qc_t unused_cookie;
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, rq->cmd_flags,
-							ctx->cpu);
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	hctx_lock(hctx, &srcu_idx);
 	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
@@ -1916,9 +1914,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		blk_mq_put_ctx(data.ctx);
 
 		if (same_queue_rq) {
-			data.hctx = blk_mq_map_queue(q,
-					same_queue_rq->cmd_flags,
-					same_queue_rq->mq_ctx->cpu);
+			data.hctx = same_queue_rq->mq_hctx;
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
 		}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8329017badc8..74cb2f524824 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -223,13 +223,10 @@ static inline void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
 
 static inline void blk_mq_put_driver_tag(struct request *rq)
 {
-	struct blk_mq_hw_ctx *hctx;
-
 	if (rq->tag == -1 || rq->internal_tag == -1)
 		return;
 
-	hctx = blk_mq_map_queue(rq->q, rq->cmd_flags, rq->mq_ctx->cpu);
-	__blk_mq_put_driver_tag(hctx, rq);
+	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
 }
 
 static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4223ae2d2198..7b351210ebcd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -129,6 +129,7 @@ enum mq_rq_state {
 struct request {
 	struct request_queue *q;
 	struct blk_mq_ctx *mq_ctx;
+	struct blk_mq_hw_ctx *mq_hctx;
 
 	int cpu;
 	unsigned int cmd_flags;		/* op and common flags */
-- 
2.17.1

