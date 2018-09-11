Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CF1C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A1820865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW6b1MZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A1820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeIKXnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:43:09 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39458 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKXm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:28 -0400
Received: by mail-yb1-f193.google.com with SMTP id c4-v6so9730870ybl.6;
        Tue, 11 Sep 2018 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YMAVRklk/4sYhDVPwGuayrITVLMrMHDpd9GIsM9ItTE=;
        b=KW6b1MZPVu3BJezWeGzrg04KX0BrEsLMLcJQzw118+EBaStzNH2pgzEl9xxdNRsROI
         ovPQKk0QyEqRc2IqufjFJvrBXFYWJHqYHKZXxkkjGPVMBd8XuX62VgkKgmAAuH1FpLlx
         G4GsuDik2yynehzTyMqS9Mukx+0Nf8Vrw9kIKPuFB9ZBeQiCXeFhks+WPq1D9dQ+VJ75
         0KESbPjR5MtOZqbJvln3nXke9PXrIO/HjJU2my6pe2gnvzJH3LHkKa3D22w5KOHIZFgF
         aC7ubJK0+vaQFHFrWd13QVq3xEyf3Ln3wZR2HHYcXKp0PGF73miF51aMmv8lOvtf3cGo
         RoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YMAVRklk/4sYhDVPwGuayrITVLMrMHDpd9GIsM9ItTE=;
        b=U/kHAph4wDrPNODETx+7Ymg6gH9Fgg7p18hgqbzwyxO+QojS7+UpEk/OM3SpumNTkt
         q279hxUw2/qjIQX0lUAmsbrLSNQ/cbHfiJEEUd9DvQV1r2ch9H/twMrHioVc//ATkDvb
         SBREG5wQSFeRspO4b0j16zdCOAAsnnkBgsb3Rj/PmnL3tgWUS7LAYIeGjQ9I2+2Z4MKH
         o4cKxTF4L/aKyF8kTQgI1EXzybmzwQtg2VU81WlSxn5VdIFdSpsae5++Y/yZWqKjxFfL
         +EBoFGZek+JX1VYnzsV/4VGTsYfQNQ6cm2thwpkLaOxU9beAOW80PAxWiKIQhL2D4wa6
         Zx0g==
X-Gm-Message-State: APzg51Bj7PtTssmgO40vXq4/x1F80gSiQtgzhQJPAkkX13ShIbPGCrD3
        yPkMcGonoq6eP5fc9Y3WiNMBPgPDoow=
X-Google-Smtp-Source: ANB0VdYZVxbVYPIMO9J9pstUNhaIDMlNHRocUJE7UpVFaFMR1C97xTaaM/6zON2q9/AKjcLz3WGNLw==
X-Received: by 2002:a25:5bc3:: with SMTP id p186-v6mr12388257ybb.439.1536691312419;
        Tue, 11 Sep 2018 11:41:52 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:51 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 08/12] blkcg: remove bio->bi_css and instead use bio->bi_blkg
Date:   Tue, 11 Sep 2018 14:41:33 -0400
Message-Id: <20180911184137.35897-9-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180911184137.35897-1-dennisszhou@gmail.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Prior patches ensured that all bios are now associated with some blkg.
This now makes bio->bi_css unnecessary as blkg maintains a reference to
the blkcg already.

This patch removes the field bi_css and transfers corresponding uses to
access via bi_blkg.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c                | 56 ++++++++------------------------------
 block/bounce.c             |  2 +-
 drivers/block/loop.c       |  5 ++--
 drivers/md/raid0.c         |  2 +-
 include/linux/bio.h        |  9 ++----
 include/linux/blk-cgroup.h |  8 +++---
 include/linux/blk_types.h  |  1 -
 kernel/trace/blktrace.c    |  4 +--
 8 files changed, 25 insertions(+), 62 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 897c8ed9e572..f32b4757a232 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -609,7 +609,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
-	bio_clone_blkcg_association(bio, bio_src);
+	bio_clone_blkg_association(bio, bio_src);
 
 	blkcg_bio_issue_init(bio);
 }
@@ -1957,34 +1957,6 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
 #ifdef CONFIG_BLK_CGROUP
 
-/**
- * bio_associate_blkcg - associate a bio with the specified blkcg
- * @bio: target bio
- * @blkcg_css: css of the blkcg to associate
- *
- * Associate @bio with the blkcg specified by @blkcg_css.  Block layer will
- * treat @bio as if it were issued by a task which belongs to the blkcg.
- *
- * This function takes an extra reference of @blkcg_css which will be put
- * when @bio is released.  The caller must own @bio and is responsible for
- * synchronizing calls to this function.  If @blkcg_css is NULL, a call to
- * blkcg_get_css finds the current css from the kthread or task.
- */
-int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css)
-{
-	if (unlikely(bio->bi_css))
-		return -EBUSY;
-
-	if (blkcg_css)
-		css_get(blkcg_css);
-	else
-		blkcg_css = blkcg_get_css();
-
-	bio->bi_css = blkcg_css;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bio_associate_blkcg);
-
 /**
  * bio_associate_blkg - associate a bio with the a blkg
  * @bio: target bio
@@ -2034,7 +2006,6 @@ int bio_associate_blkg_from_css(struct bio *bio,
 				struct cgroup_subsys_state *css)
 {
 	css_get(css);
-	bio->bi_css = css;
 	return __bio_associate_blkg_from_css(bio, css);
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
@@ -2055,12 +2026,11 @@ int bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 {
 	struct cgroup_subsys_state *css;
 
-	if (unlikely(bio->bi_css))
+	if (unlikely(bio->bi_blkg))
 		return -EBUSY;
 	if (!page->mem_cgroup)
 		return 0;
 	css = cgroup_get_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
-	bio->bi_css = css;
 
 	return __bio_associate_blkg_from_css(bio, css);
 }
@@ -2086,8 +2056,7 @@ int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
 
 	rcu_read_lock();
 
-	bio_associate_blkcg(bio, NULL);
-	blkcg = bio_blkcg(bio);
+	blkcg = css_to_blkcg(blkcg_get_css());
 
 	if (!blkcg->css.parent) {
 		ret = bio_associate_blkg(bio, q->root_blkg);
@@ -2111,30 +2080,27 @@ void bio_disassociate_task(struct bio *bio)
 		put_io_context(bio->bi_ioc);
 		bio->bi_ioc = NULL;
 	}
-	if (bio->bi_css) {
-		css_put(bio->bi_css);
-		bio->bi_css = NULL;
-	}
 	if (bio->bi_blkg) {
+		/* a ref is always taken on css */
+		css_put(&bio_blkcg(bio)->css);
 		blkg_put(bio->bi_blkg);
 		bio->bi_blkg = NULL;
 	}
 }
 
 /**
- * bio_clone_blkcg_association - clone blkcg association from src to dst bio
+ * bio_clone_blkg_association - clone blkg association from src to dst bio
  * @dst: destination bio
  * @src: source bio
  */
-void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
+void bio_clone_blkg_association(struct bio *dst, struct bio *src)
 {
-	if (src->bi_css)
-		WARN_ON(bio_associate_blkcg(dst, src->bi_css));
-
-	if (src->bi_blkg)
+	if (src->bi_blkg) {
+		css_get(&bio_blkcg(src)->css);
 		bio_associate_blkg(dst, src->bi_blkg);
+	}
 }
-EXPORT_SYMBOL_GPL(bio_clone_blkcg_association);
+EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
 #endif /* CONFIG_BLK_CGROUP */
 
 static void __init biovec_init_slabs(void)
diff --git a/block/bounce.c b/block/bounce.c
index 7a08703b1204..b30071ac4ec6 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -257,7 +257,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		}
 	}
 
-	bio_clone_blkcg_association(bio, bio_src);
+	bio_clone_blkg_association(bio, bio_src);
 
 	blkcg_bio_issue_init(bio);
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ea9debf59b22..abad6d15f956 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -77,6 +77,7 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/ioprio.h>
+#include <linux/blk-cgroup.h>
 
 #include "loop.h"
 
@@ -1760,8 +1761,8 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	/* always use the first bio's css */
 #ifdef CONFIG_BLK_CGROUP
-	if (cmd->use_aio && rq->bio && rq->bio->bi_css) {
-		cmd->css = rq->bio->bi_css;
+	if (cmd->use_aio && rq->bio && rq->bio->bi_blkg) {
+		cmd->css = &bio_blkcg(rq->bio)->css;
 		css_get(cmd->css);
 	} else
 #endif
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index ac1cffd2a09b..f3fb5bb8c82a 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -542,7 +542,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 		    !discard_bio)
 			continue;
 		bio_chain(discard_bio, bio);
-		bio_clone_blkcg_association(discard_bio, bio);
+		bio_clone_blkg_association(discard_bio, bio);
 		if (mddev->gendisk)
 			trace_block_bio_remap(bdev_get_queue(rdev->bdev),
 				discard_bio, disk_devt(mddev->gendisk),
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c73a870ebc0e..e973876625a8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -540,24 +540,21 @@ static inline int bio_associate_blkg_from_page(struct bio *bio,
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
-int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
 int bio_associate_blkg_from_css(struct bio *bio,
 				struct cgroup_subsys_state *css);
 int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
-void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
+void bio_clone_blkg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
-static inline int bio_associate_blkcg(struct bio *bio,
-			struct cgroup_subsys_state *blkcg_css) { return 0; }
 static inline int bio_associate_blkg_from_css(struct bio *bio,
 					      struct cgroup_subsys_state *css)
 { return 0; }
 static inline int bio_associate_create_blkg(struct request_queue *q,
 					    struct bio *bio) { return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
-static inline void bio_clone_blkcg_association(struct bio *dst,
-			struct bio *src) { }
+static inline void bio_clone_blkg_association(struct bio *dst,
+					      struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
 
 #ifdef CONFIG_HIGHMEM
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index a6b6e741a75e..c41cfcc2b4d8 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -308,8 +308,8 @@ static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
  */
 static inline struct blkcg *__bio_blkcg(struct bio *bio)
 {
-	if (bio && bio->bi_css)
-		return css_to_blkcg(bio->bi_css);
+	if (bio && bio->bi_blkg)
+		return bio->bi_blkg->blkcg;
 	return css_to_blkcg(blkcg_css());
 }
 
@@ -323,8 +323,8 @@ static inline struct blkcg *__bio_blkcg(struct bio *bio)
  */
 static inline struct blkcg *bio_blkcg(struct bio *bio)
 {
-	if (bio && bio->bi_css)
-		return css_to_blkcg(bio->bi_css);
+	if (bio && bio->bi_blkg)
+		return bio->bi_blkg->blkcg;
 	return NULL;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index f6dfb30737d8..9578c7ab1eb6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -178,7 +178,6 @@ struct bio {
 	 * release.  Read comment on top of bio_associate_current().
 	 */
 	struct io_context	*bi_ioc;
-	struct cgroup_subsys_state *bi_css;
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
 #endif
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 2868d85f1fb1..fac0ddf8a8e2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -764,9 +764,9 @@ blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 	if (!bt || !(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
 		return NULL;
 
-	if (!bio->bi_css)
+	if (!bio->bi_blkg)
 		return NULL;
-	return cgroup_get_kernfs_id(bio->bi_css->cgroup);
+	return cgroup_get_kernfs_id(bio_blkcg(bio)->css.cgroup);
 }
 #else
 static union kernfs_node_id *
-- 
2.17.1

