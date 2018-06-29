Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91992C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D56523DEF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Yf/kNSfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D56523DEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936996AbeF2T3q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:29:46 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:42346 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934192AbeF2TZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:25:47 -0400
Received: by mail-qt0-f176.google.com with SMTP id y31-v6so8829691qty.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DYjnlTNA/693YUK2Gqhsje8xLxjoBdeV8D140ceewns=;
        b=Yf/kNSfbc7Ptv4KC/BLPcbVPXoFvdk6HCpcvgKFp1EFYowGlBH41I+Rcz5WHFUaQCO
         9c33RCBxYiugcfnhKT/t1pmrcmvOoaRP1n7j6B6ZKoA0KScQWhBmetKhSKuWpv7aZ3Zo
         ADR3f96n9KOmQo1xibPi58oA21deuBsVTuCjpLfy0+/CYo6rsBHRx4B6tJdv7hp7CqCi
         +jV6SXIf2sZRGi/pwMQCC2JASJMRxRHyF+FnSnT0E3dPagVRvY2uTZzij6qqvvFQIEFn
         odQxy+BRt6iuwv6PgI2E1cVwfkUQ5K6ene2Nwf1QYqaThcYZ0lkEDP3sanvEiatj2f+5
         u7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DYjnlTNA/693YUK2Gqhsje8xLxjoBdeV8D140ceewns=;
        b=F3NBrAOHJJqSXczlObOe3vNqP6ZnJsu8J7Pryy6QsSrB5LIeYNHbSYEEpGxiZrZRmb
         MUZTeELvcU8UA7zypbo73+LEXEYW8/gcV7wGoA3tTxkQdAZUxE5KItwo+qmN8EYUeAQK
         8CjrsiApR1Kol4Bbs153+g4gv8/RRZ0IlCSvDHpiOiQSbXcvtHgDwX9koLwQSQv/WyEh
         Eji6Pe3alCua6YIMgC9fQnYG5t6kffjY74UJKmv1wzPuLXKIbsA533be3t/hH0PhIfTw
         kndRxxlyrbpy7dDNm9FaQC/hJgjPUp01Qv+4zsx3Df3v4SAL3x1YsgSCaLSd5icFdkAt
         +uTw==
X-Gm-Message-State: APt69E1t8ybik4Rs9hMg0DFGe3LAmxg2kmZYm5qTxA/qqEKxgYTqxS2k
        3cuqgOtUruraQAl0XrJ1BcVplA==
X-Google-Smtp-Source: AAOMgpchYBlenBCitOml/JFKH9G2gSZsOdVXR91UoE+Uk0M66OMY0t93KPK7OQLaTsN60p3ZvuvWsQ==
X-Received: by 2002:aed:36e4:: with SMTP id f91-v6mr11537510qtb.268.1530300346566;
        Fri, 29 Jun 2018 12:25:46 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j20-v6sm8212577qtc.71.2018.06.29.12.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:25:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 01/14] block: add bi_blkg to the bio for cgroups
Date:   Fri, 29 Jun 2018 15:25:29 -0400
Message-Id: <20180629192542.26649-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180629192542.26649-1-josef@toxicpanda.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

Currently io.low uses a bi_cg_private to stash its private data for the
blkg, however other blkcg policies may want to use this as well.  Since
we can get the private data out of the blkg, move this to bi_blkg in the
bio and make it generic, then we can use bio_associate_blkg() to attach
the blkg to the bio.

Theoretically we could simply replace the bi_css with this since we can
get to all the same information from the blkg, however you have to
lookup the blkg, so for example wbc_init_bio() would have to lookup and
possibly allocate the blkg for the css it was trying to attach to the
bio.  This could be problematic and result in us either not attaching
the css at all to the bio, or falling back to the root blkcg if we are
unable to allocate the corresponding blkg.

So for now do this, and in the future if possible we could just replace
the bi_css with bi_blkg and update the helpers to do the correct
translation.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c               | 23 +++++++++++++++++++++++
 block/blk-throttle.c      | 21 +++++++--------------
 include/linux/bio.h       |  1 +
 include/linux/blk_types.h |  2 +-
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0a4df92cd689..57c4b1986e76 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -28,6 +28,7 @@
 #include <linux/mempool.h>
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
+#include <linux/blk-cgroup.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -2026,6 +2027,24 @@ int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css)
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkcg);
 
+/**
+ * bio_associate_blkg - associate a bio with the specified blkg
+ * @bio: target bio
+ * @blkg: the blkg to associate
+ *
+ * Associate @bio with the blkg specified by @blkg.  This is the queue specific
+ * blkcg information associated with the @bio, a reference will be taken on the
+ * @blkg and will be freed when the bio is freed.
+ */
+int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
+{
+	if (unlikely(bio->bi_blkg))
+		return -EBUSY;
+	blkg_get(blkg);
+	bio->bi_blkg = blkg;
+	return 0;
+}
+
 /**
  * bio_disassociate_task - undo bio_associate_current()
  * @bio: target bio
@@ -2040,6 +2059,10 @@ void bio_disassociate_task(struct bio *bio)
 		css_put(bio->bi_css);
 		bio->bi_css = NULL;
 	}
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
 }
 
 /**
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f63d88c92c3a..5112cef3166b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2131,12 +2131,8 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	if (bio->bi_css) {
-		if (bio->bi_cg_private)
-			blkg_put(tg_to_blkg(bio->bi_cg_private));
-		bio->bi_cg_private = tg;
-		blkg_get(tg_to_blkg(tg));
-	}
+	if (bio->bi_css)
+		bio_associate_blkg(bio, tg_to_blkg(tg));
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 #endif
 }
@@ -2284,6 +2280,7 @@ void blk_throtl_stat_add(struct request *rq, u64 time_ns)
 
 void blk_throtl_bio_endio(struct bio *bio)
 {
+	struct blkcg_gq *blkg;
 	struct throtl_grp *tg;
 	u64 finish_time_ns;
 	unsigned long finish_time;
@@ -2291,20 +2288,18 @@ void blk_throtl_bio_endio(struct bio *bio)
 	unsigned long lat;
 	int rw = bio_data_dir(bio);
 
-	tg = bio->bi_cg_private;
-	if (!tg)
+	blkg = bio->bi_blkg;
+	if (!blkg)
 		return;
-	bio->bi_cg_private = NULL;
+	tg = blkg_to_tg(blkg);
 
 	finish_time_ns = ktime_get_ns();
 	tg->last_finish_time = finish_time_ns >> 10;
 
 	start_time = bio_issue_time(&bio->bi_issue) >> 10;
 	finish_time = __bio_issue_time(finish_time_ns) >> 10;
-	if (!start_time || finish_time <= start_time) {
-		blkg_put(tg_to_blkg(tg));
+	if (!start_time || finish_time <= start_time)
 		return;
-	}
 
 	lat = finish_time - start_time;
 	/* this is only for bio based driver */
@@ -2333,8 +2328,6 @@ void blk_throtl_bio_endio(struct bio *bio)
 		tg->bio_cnt /= 2;
 		tg->bad_bio_cnt /= 2;
 	}
-
-	blkg_put(tg_to_blkg(tg));
 }
 #endif
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 98b175cc00d5..f2f3f1428e81 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -547,6 +547,7 @@ do {						\
 
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
+int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4cb970cdcd11..ff181df8c195 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -179,8 +179,8 @@ struct bio {
 	 */
 	struct io_context	*bi_ioc;
 	struct cgroup_subsys_state *bi_css;
+	struct blkcg_gq		*bi_blkg;
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	void			*bi_cg_private;
 	struct bio_issue	bi_issue;
 #endif
 #endif
-- 
2.14.3

