Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2539887-1528205644-2-6369385752163268818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528205643; b=D+Av45j3uHTWZZvVtCfBki3EsX+MrvcAV08kY3s4sNoz32oogL
    XfgzcvXelO8ysYeI3IAxw6pKGqZvnWVByknDchJulLfGyZWfsKNwYjPzi6xkxvOt
    CTmqlpW122tg9AXkE+NWenriXI5D+B1J8Xo+TGqT0oHKA43ZpLFLB2M7W9yrR/Hw
    4bOIfDA1p8HeBQ2/4VDP8LZzjNt2bhlga2RCs/mYR/s8XuadTyZ/Ag+SG1yMBKZq
    UxzRq13xOGvoKEurd/+rOB5Wd/tmsPYtaV4GEK0RkXMH13TzRFpZcQllY0vhQ2Er
    ftAuTY5m5g7XHs98xZlRL3SMv9Ey26wD5O2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1528205643; bh=
    DYjnlTNA/693YUK2Gqhsje8xLxjoBdeV8D140ceewns=; b=kD6BD/7zRyT6YFPR
    m39xeKM2uf9gnVKUR1wcT4QZ2GACzPoPM3YzZGAmZzb1A4Ewzxavmg+jPewj/j2t
    zTVnSEjj/LTBJ4aU94fD9Uz/IbYdEm6kX1ZxSVn5s7RHD7zzyZUBC4Yo7RM3EF8n
    UjsS/IYKhI4pHfruJNSYHrgtAwV2rNkaCkeerZm/XxAC7fL2LmdMgptzpCk4EbdC
    M6pOE9rSGZfFiC7ms7SJb9ZWqIHbf1wQgbPUoku2sywiPoHdC7YdL1wiAjOJnUwN
    ccE5WxVJBUg13xKSKDGa+nxM3/BTrYmYqGKtDexI37TwBPK+u/Op9u4hC+8shWyT
    zJ8NBg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=toxicpanda-com.20150623.gappssmtp.com
    header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=XAM1eudY
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=CXE47TkI;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=toxicpanda.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=toxicpanda-com.20150623.gappssmtp.com
      header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=XAM1eudY
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=CXE47TkI;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=toxicpanda.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHUZ5jBCmbImdSrTmDBnkCAlW14X45Tvu5YM4Na04BSc+8DluMLXOA7o59lb46C8BG8VXYdiBVjyyAjowUQFYpBcLURa79sfU6iYboQeb7Buq9qEHhUf
    hNGxV78yWnZunjpvEojuMiUhitmHgke/lnZoCqtlXWGGc/BLPGUhn1ymb5u/o0jEc3wHjoAiW55fuxRAQWgvwErDwmctG5mS4f0bMUJCk80+gV/CM4p+6YOp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=FOH2dFAWAAAA:8
    a=VwQbUJbxAAAA:8 a=tccTKXtuD1MeSDQK7NkA:9 a=i3VuKzQdj-NEYjvDI-p3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeFENd7 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 09:33:59 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:39538 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeFEN3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:29:53 -0400
X-Google-Smtp-Source: ADUXVKJYb6IyerVFzhwJNi4RRPe9XHMinowk2ma9Z1UREnguPUAsw+T/Whe/eUGEwl2CCJB6HTzK8g==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 01/13] block: add bi_blkg to the bio for cgroups
Date: Tue,  5 Jun 2018 09:29:36 -0400
Message-Id: <20180605132948.1664-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605132948.1664-1-josef@toxicpanda.com>
References: <20180605132948.1664-1-josef@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
