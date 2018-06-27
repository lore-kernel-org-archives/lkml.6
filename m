Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7CFC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFF625DBF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="vMVZc84A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFF625DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966356AbeF0TME (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:12:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46385 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966189AbeF0TJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:09:59 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so2611726qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wKru50GXpawbcdIy/JAmL8ctpAjcdHrI6DqT69SaPGM=;
        b=vMVZc84A9obU2Uhn9oWFWFLliVAJmxY6xuazofW1c2XrCt5TRMW6VKh1RbwK+QMhrH
         8uHWu6MFWo/m8G++W6EuVRhmAa4IliHzvx83/iCn3U2/Iw9H+YCZ72L+Btf3Xm9TLGR9
         RmFyoCnDzmBSvc2Tke66LiyBwo3hoDJVegfAbGW3Uf9nCzhLdX+k8l263L04qkztVfOu
         B5zyUCdudLmkAdK09Mg/wUMh/nR5qn4GQlTpDoDM9IxSlp7SykpLk+42Pqyb7GuytjV6
         3p+xCIHwhuNEVV5LsOMPQGlHRdT/XQUKZA9uyC+dlYk0LnWDS3tOCaI5qHrO4pFwwmvo
         CYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wKru50GXpawbcdIy/JAmL8ctpAjcdHrI6DqT69SaPGM=;
        b=gnQ0Np6QsqwNqU1kVZj+k/U+4jrzq6tvV0AH5+mk/NOVrGWQ3xOZssSrW7X6kV5cZo
         JSeNsbRUBWM/BwMJQ7q3NKg6CUxquwLal5NBVKQMRcpHyt2yUrG2sh5L0E5zQMaD9PYu
         3lyECku1BA+n3/48Zb1gwUk+z2U9VhoT69LVE5xyTPsTIQ46sclqmzgA6MA2B1kZ/nEJ
         2/H8x0MQ9Cxi4TDI55CKQo74ALgmtSJjOZV8AdDN+eXHLzLTKBvwTOEVd42m4IcYkGvO
         +X3fpCpkICqpjZtzyFH2TqhghcxsSoGTOgN428fdQGhgovZYMfOhnT/m/Eavlidvl1cy
         mW7A==
X-Gm-Message-State: APt69E213MEicqET74eHJjg47+W0LfMkdogpRTRqsEeyd5RH46J4lMM1
        5bSZDJCD1FaxGwCEBQBZdpR9Uw==
X-Google-Smtp-Source: AAOMgpf6gnzKXJPuHtM/FF0hZiIW0HUkLrxHq2dLhwqoyScOnJyZKKCOPxLb0qEJdHedmHv00KCAhw==
X-Received: by 2002:a0c:fa89:: with SMTP id o9-v6mr6616480qvn.160.1530126598311;
        Wed, 27 Jun 2018 12:09:58 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m14-v6sm2814530qkk.88.2018.06.27.12.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:09:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 10/14] block: remove external dependency on wbt_flags
Date:   Wed, 27 Jun 2018 15:09:36 -0400
Message-Id: <20180627190940.4696-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180627190940.4696-1-josef@toxicpanda.com>
References: <20180627190940.4696-1-josef@toxicpanda.com>
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
index 07594fb34c0f..af67fa68f635 100644
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
@@ -1994,7 +1994,6 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	int where = ELEVATOR_INSERT_SORT;
 	struct request *req, *free;
 	unsigned int request_count = 0;
-	unsigned int wb_acct;
 
 	/*
 	 * low level driver can indicate that it wants pages above a
@@ -2052,7 +2051,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	}
 
 get_rq:
-	wb_acct = rq_qos_throttle(q, bio, q->queue_lock);
+	rq_qos_throttle(q, bio, q->queue_lock);
 
 	/*
 	 * Grab a free request. This is might sleep but can not fail.
@@ -2062,7 +2061,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 	req = get_request(q, bio->bi_opf, bio, 0, GFP_NOIO);
 	if (IS_ERR(req)) {
 		blk_queue_exit(q);
-		rq_qos_cleanup(q, wb_acct);
+		rq_qos_cleanup(q, bio);
 		if (PTR_ERR(req) == -ENOMEM)
 			bio->bi_status = BLK_STS_RESOURCE;
 		else
@@ -2071,7 +2070,7 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 		goto out_unlock;
 	}
 
-	wbt_track(req, wb_acct);
+	rq_qos_track(q, req, bio);
 
 	/*
 	 * After dropping the lock and possibly sleeping here, our request
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5308396ee22a..7c55c9d35492 100644
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
@@ -1852,7 +1852,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
 	blk_qc_t cookie;
-	unsigned int wb_acct;
 
 	blk_queue_bounce(q, &bio);
 
@@ -1868,19 +1867,19 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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

