Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129AAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F932208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="njjgSn4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F932208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934135AbeGCPPg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:15:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43055 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934089AbeGCPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:23 -0400
Received: by mail-qt0-f193.google.com with SMTP id f18-v6so1857473qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L/dl89vNmHD1a2CLlRckLkBTArA4CRmiS5qracWKLSk=;
        b=njjgSn4qiibUC613AfAar09guLz3tRohKhC1tyAKGdyzm6Ga0dyjyum6Z4f/UTz9Ho
         zU+pLL8zJD5YgE2JZN1UZs7B5GT02iNqd3LbsmrBK9xpvBJggbcQgbe7MeYnTKcpjU/r
         n0F7+o15x/GnKNm0bPLAU1bcUtdPVnp3sPGR4hrnVqkGkpiduwYYQtvukG547mhqrl5r
         isq5o/OIi/h9Dr2bV4Cr+UkrZDIwEPJLDbmXl39T8IXB8l9XZzQdXYTHKRdXxbB+RoJL
         KXSxhmoNs/OkXMqf09HB2yZj2unYTQdYSJ110O3VvluncEgGTz6EeZ6KWn/6rAVJ8HTa
         AgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L/dl89vNmHD1a2CLlRckLkBTArA4CRmiS5qracWKLSk=;
        b=dYoDLXq23trfzYc0XH3wEtJPrhfOAL40KY5DkOWtcutVQjC9IYwxqnr8cS6tPjpA+5
         mG+jwZAtnQ+XFomMjWwKdFO5Nqh0HM9olFT6aZFTBi+iTgv9UJvjdD/vvUEBpZIGAJCh
         QXm43FqbRi5DwOeEBHdQ1I1aaqcPtFs+YnXx+/2k5sf30A9G1/VRNU1Gi6Scz6F/0xC6
         3O/Mi769zuP9pbezlpcDAlD3LUaAMlLmxdWioRG8DJrz4BxQNaYliAqhSFhc8pkOyCNk
         wlNZYhfqBq/BjZDXY2FObZz7exKeteYED1xNPKAlX6il1RJqMiabX7UAKndWkdyiBXxS
         YEpA==
X-Gm-Message-State: APt69E3Sp0ANKnAMDXtS8+vlpP2owE8Lx+Btd1ePbMEOe4F7WC17PCHX
        Plsm35YZgUHSXbElHu71riWmtw==
X-Google-Smtp-Source: AAOMgpfp91jEn8OTFDRO3pH/YzvL7YipXYJUBs05VKtoOkrlVVmi3JZWaGLwomC2Arhy+xFkSg07pQ==
X-Received: by 2002:a0c:9e5d:: with SMTP id z29-v6mr26768461qve.15.1530630922425;
        Tue, 03 Jul 2018 08:15:22 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p189-v6sm796887qkf.70.2018.07.03.08.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 10/14] block: remove external dependency on wbt_flags
Date:   Tue,  3 Jul 2018 11:14:59 -0400
Message-Id: <20180703151503.2549-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

We don't really need to save this stuff in the core block code, we can
just pass the bio back into the helpers later on to derive the same
flags and update the rq->wbt_flags appropriately.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/blk-core.c   |  9 ++++-----
 block/blk-mq.c     |  9 ++++-----
 block/blk-rq-qos.c | 24 +++++++++++++++---------
 block/blk-rq-qos.h | 11 ++++++-----
 block/blk-wbt.c    | 52 +++++++++++++++++++++++++++++++++++++++-------------
 block/blk-wbt.h    |  5 -----
 6 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7eaa2999f849..21f0e2e4c4c3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -42,7 +42,7 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
-#include "blk-wbt.h"
+#include "blk-rq-qos.h"
 
 #ifdef CONFIG_DEBUG_FS
 struct dentry *blk_debugfs_root;
@@ -1982,7 +1982,6 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	int where = ELEVATOR_INSERT_SORT;
 	struct request *req, *free;
 	unsigned int request_count = 0;
-	unsigned int wb_acct;
 
 	/*
 	 * low level driver can indicate that it wants pages above a
@@ -2040,7 +2039,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	}
 
 get_rq:
-	wb_acct = rq_qos_throttle(q, bio, q->queue_lock);
+	rq_qos_throttle(q, bio, q->queue_lock);
 
 	/*
 	 * Grab a free request. This is might sleep but can not fail.
@@ -2050,7 +2049,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	req = get_request(q, bio->bi_opf, bio, 0, GFP_NOIO);
 	if (IS_ERR(req)) {
 		blk_queue_exit(q);
-		rq_qos_cleanup(q, wb_acct);
+		rq_qos_cleanup(q, bio);
 		if (PTR_ERR(req) == -ENOMEM)
 			bio->bi_status = BLK_STS_RESOURCE;
 		else
@@ -2059,7 +2058,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 		goto out_unlock;
 	}
 
-	wbt_track(req, wb_acct);
+	rq_qos_track(q, req, bio);
 
 	/*
 	 * After dropping the lock and possibly sleeping here, our request
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8356ae6dcb00..9d6020b70fbb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -34,8 +34,8 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 #include "blk-stat.h"
-#include "blk-wbt.h"
 #include "blk-mq-sched.h"
+#include "blk-rq-qos.h"
 
 static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
 static void blk_mq_poll_stats_start(struct request_queue *q);
@@ -1758,7 +1758,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
 	blk_qc_t cookie;
-	unsigned int wb_acct;
 
 	blk_queue_bounce(q, &bio);
 
@@ -1774,19 +1773,19 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	if (blk_mq_sched_bio_merge(q, bio))
 		return BLK_QC_T_NONE;
 
-	wb_acct = rq_qos_throttle(q, bio, NULL);
+	rq_qos_throttle(q, bio, NULL);
 
 	trace_block_getrq(q, bio, bio->bi_opf);
 
 	rq = blk_mq_get_request(q, bio, bio->bi_opf, &data);
 	if (unlikely(!rq)) {
-		rq_qos_cleanup(q, wb_acct);
+		rq_qos_cleanup(q, bio);
 		if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
 		return BLK_QC_T_NONE;
 	}
 
-	wbt_track(rq, wb_acct);
+	rq_qos_track(q, rq, bio);
 
 	cookie = request_to_qc_t(data.hctx, rq);
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index d2f2af8aa10c..b7b02e04f64f 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -1,7 +1,5 @@
 #include "blk-rq-qos.h"
 
-#include "blk-wbt.h"
-
 /*
  * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
  * false if 'v' + 1 would be bigger than 'below'.
@@ -29,13 +27,13 @@ bool rq_wait_inc_below(struct rq_wait *rq_wait, int limit)
 	return atomic_inc_below(&rq_wait->inflight, limit);
 }
 
-void rq_qos_cleanup(struct request_queue *q, enum wbt_flags wb_acct)
+void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
 {
 	struct rq_qos *rqos;
 
 	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
 		if (rqos->ops->cleanup)
-			rqos->ops->cleanup(rqos, wb_acct);
+			rqos->ops->cleanup(rqos, bio);
 	}
 }
 
@@ -69,17 +67,25 @@ void rq_qos_requeue(struct request_queue *q, struct request *rq)
 	}
 }
 
-enum wbt_flags rq_qos_throttle(struct request_queue *q, struct bio *bio,
-			       spinlock_t *lock)
+void rq_qos_throttle(struct request_queue *q, struct bio *bio,
+		     spinlock_t *lock)
 {
 	struct rq_qos *rqos;
-	enum wbt_flags flags = 0;
 
 	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
 		if (rqos->ops->throttle)
-			flags |= rqos->ops->throttle(rqos, bio, lock);
+			rqos->ops->throttle(rqos, bio, lock);
+	}
+}
+
+void rq_qos_track(struct request_queue *q, struct request *rq, struct bio *bio)
+{
+	struct rq_qos *rqos;
+
+	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
+		if (rqos->ops->track)
+			rqos->ops->track(rqos, rq, bio);
 	}
-	return flags;
 }
 
 /*
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index f9a39bd6ece3..a6d13b8ce0dc 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -25,12 +25,12 @@ struct rq_qos {
 };
 
 struct rq_qos_ops {
-	enum wbt_flags (*throttle)(struct rq_qos *, struct bio *,
-				   spinlock_t *);
+	void (*throttle)(struct rq_qos *, struct bio *, spinlock_t *);
+	void (*track)(struct rq_qos *, struct request *, struct bio *);
 	void (*issue)(struct rq_qos *, struct request *);
 	void (*requeue)(struct rq_qos *, struct request *);
 	void (*done)(struct rq_qos *, struct request *);
-	void (*cleanup)(struct rq_qos *, enum wbt_flags);
+	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*exit)(struct rq_qos *);
 };
 
@@ -97,10 +97,11 @@ void rq_depth_scale_up(struct rq_depth *rqd);
 void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
 bool rq_depth_calc_max_depth(struct rq_depth *rqd);
 
-void rq_qos_cleanup(struct request_queue *, enum wbt_flags);
+void rq_qos_cleanup(struct request_queue *, struct bio *);
 void rq_qos_done(struct request_queue *, struct request *);
 void rq_qos_issue(struct request_queue *, struct request *);
 void rq_qos_requeue(struct request_queue *, struct request *);
-enum wbt_flags rq_qos_throttle(struct request_queue *, struct bio *, spinlock_t *);
+void rq_qos_throttle(struct request_queue *, struct bio *, spinlock_t *);
+void rq_qos_track(struct request_queue *q, struct request *, struct bio *);
 void rq_qos_exit(struct request_queue *);
 #endif
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 6fe20fb823e4..461a9af11efe 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -549,41 +549,66 @@ static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
 	}
 }
 
+static enum wbt_flags bio_to_wbt_flags(struct rq_wb *rwb, struct bio *bio)
+{
+	enum wbt_flags flags = 0;
+
+	if (bio_op(bio) == REQ_OP_READ) {
+		flags = WBT_READ;
+	} else if (wbt_should_throttle(rwb, bio)) {
+		if (current_is_kswapd())
+			flags |= WBT_KSWAPD;
+		if (bio_op(bio) == REQ_OP_DISCARD)
+			flags |= WBT_DISCARD;
+		flags |= WBT_TRACKED;
+	}
+	return flags;
+}
+
+static void wbt_cleanup(struct rq_qos *rqos, struct bio *bio)
+{
+	struct rq_wb *rwb = RQWB(rqos);
+	enum wbt_flags flags = bio_to_wbt_flags(rwb, bio);
+	__wbt_done(rqos, flags);
+}
+
 /*
  * Returns true if the IO request should be accounted, false if not.
  * May sleep, if we have exceeded the writeback limits. Caller can pass
  * in an irq held spinlock, if it holds one when calling this function.
  * If we do sleep, we'll release and re-grab it.
  */
-static enum wbt_flags wbt_wait(struct rq_qos *rqos, struct bio *bio,
-			       spinlock_t *lock)
+static void wbt_wait(struct rq_qos *rqos, struct bio *bio, spinlock_t *lock)
 {
 	struct rq_wb *rwb = RQWB(rqos);
-	enum wbt_flags ret = 0;
+	enum wbt_flags flags;
 
 	if (!rwb_enabled(rwb))
-		return 0;
+		return;
 
-	if (bio_op(bio) == REQ_OP_READ)
-		ret = WBT_READ;
+	flags = bio_to_wbt_flags(rwb, bio);
 
 	if (!wbt_should_throttle(rwb, bio)) {
-		if (ret & WBT_READ)
+		if (flags & WBT_READ)
 			wb_timestamp(rwb, &rwb->last_issue);
-		return ret;
+		return;
 	}
 
 	if (current_is_kswapd())
-		ret |= WBT_KSWAPD;
+		flags |= WBT_KSWAPD;
 	if (bio_op(bio) == REQ_OP_DISCARD)
-		ret |= WBT_DISCARD;
+		flags |= WBT_DISCARD;
 
-	__wbt_wait(rwb, ret, bio->bi_opf, lock);
+	__wbt_wait(rwb, flags, bio->bi_opf, lock);
 
 	if (!blk_stat_is_active(rwb->cb))
 		rwb_arm_timer(rwb);
+}
 
-	return ret | WBT_TRACKED;
+static void wbt_track(struct rq_qos *rqos, struct request *rq, struct bio *bio)
+{
+	struct rq_wb *rwb = RQWB(rqos);
+	rq->wbt_flags |= bio_to_wbt_flags(rwb, bio);
 }
 
 void wbt_issue(struct rq_qos *rqos, struct request *rq)
@@ -707,9 +732,10 @@ EXPORT_SYMBOL_GPL(wbt_disable_default);
 static struct rq_qos_ops wbt_rqos_ops = {
 	.throttle = wbt_wait,
 	.issue = wbt_issue,
+	.track = wbt_track,
 	.requeue = wbt_requeue,
 	.done = wbt_done,
-	.cleanup = __wbt_done,
+	.cleanup = wbt_cleanup,
 	.exit = wbt_exit,
 };
 
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 53b20a58c0a2..f47218d5b3b2 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -87,11 +87,6 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 #ifdef CONFIG_BLK_WBT
 
-static inline void wbt_track(struct request *rq, enum wbt_flags flags)
-{
-	rq->wbt_flags |= flags;
-}
-
 int wbt_init(struct request_queue *);
 void wbt_update_limits(struct request_queue *);
 void wbt_disable_default(struct request_queue *);
-- 
2.14.3

