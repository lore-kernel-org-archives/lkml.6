Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38696C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5BA2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABDCKk3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5BA2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHaGAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 02:00:03 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33517 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeHaF71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:27 -0400
Received: by mail-yw1-f68.google.com with SMTP id x67-v6so4532077ywg.0;
        Thu, 30 Aug 2018 18:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=awg10XvAuGSDbfNPOY1xU77kPIpO9M7BU2YpkvZIb1I=;
        b=ABDCKk3KPEOyY7fnDUJ4TNehKkZjwWWuY7X1ga/PVeoXas8D/M9Of/1o5DkLmwLsih
         /uDx6sE9of73cHAg0z2YcwWjQhKIfOQbzYGIxcqYCwOcG6Vjr3lromGFoH+rTugismLQ
         u//leieRWyi1ckLYlQXEDSIEHuBXL1r5gSvIPWH2i9Ysfmck30AARrky4qFREX8tXFig
         6skFshTEKSCqdIP4eWu/B6d65AdoXacINS6ch6fsrCmCOUtXQShVcNhNp2Lhzz+82uXZ
         silmA0NIrnKtIqHs6cdRGKAiuGr+a+/PmBAu/OEVZouv8lKUQpqSkmIz0USESlHF2s5k
         zVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=awg10XvAuGSDbfNPOY1xU77kPIpO9M7BU2YpkvZIb1I=;
        b=p1Coxh6lU+yynz7ICY96vBMWRsB4cd07LdxMhEIObYiexQP4M5TZCUqeg0mleQc8S9
         a+ogGm1vyhsVv3M58kctCmQewr9SmvnepiUcUi6M47VHK6YSlE3s7ATw3WvezOlLf3rg
         pQZqcSb9OxgSa2APn+7LA8CLe62fNJ442O6OcJpu4cgrz3WZ1Rq17fgSg+StL9JTYyJa
         2QfbFYLI1YHnqXBI1FKP0Z5xE2r6rzfboAPXdlAHjHSO7t/fbqjgQBcDmu1O+lb5lPy6
         hq0txyb0tVDwnPu1zlls/20KhDumuk84NzWDsvXXJsAJI4w4xBi6uPNKRD25UHFqFm0T
         5H4A==
X-Gm-Message-State: APzg51AhUQYgAnVtxGmn4ZpMGoxF/JlJmgmoDiG4pEVX74+9J+mRjVBW
        ZhZbxTySrkT60BRT+jewYRA=
X-Google-Smtp-Source: ANB0VdbUkrJX+p5b8v8S0IFJUmMzvTut169cwTCRxEcsOmGEgw9ZJi/cJLjLf8zKK8e7I/4ePY7LrA==
X-Received: by 2002:a81:5457:: with SMTP id i84-v6mr7369634ywb.365.1535680464472;
        Thu, 30 Aug 2018 18:54:24 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:24 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 10/15] blkcg: remove bio->bi_css and instead use bio->bi_blkg
Date:   Thu, 30 Aug 2018 21:53:51 -0400
Message-Id: <20180831015356.69796-11-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
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
---
 block/bio.c                | 56 ++++++++------------------------------
 block/bounce.c             |  2 +-
 drivers/block/loop.c       |  5 ++--
 drivers/md/raid0.c         |  2 +-
 include/linux/bio.h        |  7 ++---
 include/linux/blk-cgroup.h |  4 +--
 include/linux/blk_types.h  |  1 -
 kernel/trace/blktrace.c    |  4 +--
 8 files changed, 22 insertions(+), 59 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 97ef994a08b6..ec55ee810503 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -609,7 +609,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
-	bio_clone_blkcg_association(bio, bio_src);
+	bio_clone_blkg_association(bio, bio_src);
 
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 }
@@ -1930,34 +1930,6 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
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
  * bio_associate_blkg - associate a bio with the specified blkg
  * @bio: target bio
@@ -2004,7 +1976,6 @@ int bio_associate_blkg_from_css(struct bio *bio,
 				struct cgroup_subsys_state *css)
 {
 	css_get(css);
-	bio->bi_css = css;
 	return __bio_associate_blkg_from_css(bio, css);
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
@@ -2025,12 +1996,11 @@ int bio_associate_blkg_from_page(struct bio *bio, struct page *page)
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
@@ -2056,8 +2026,7 @@ int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
 
 	rcu_read_lock();
 
-	bio_associate_blkcg(bio, NULL);
-	blkcg = bio_blkcg(bio);
+	blkcg = css_to_blkcg(blkcg_get_css());
 
 	if (!blkcg->css.parent) {
 		ret = bio_associate_blkg(bio, q->root_blkg);
@@ -2084,30 +2053,27 @@ void bio_disassociate_task(struct bio *bio)
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
index bea3b0cbe4a7..9f7071e176a4 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -257,7 +257,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		}
 	}
 
-	bio_clone_blkcg_association(bio, bio_src);
+	bio_clone_blkg_association(bio, bio_src);
 
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 
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
index 81530d11d34d..175e5e349d30 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -554,16 +554,13 @@ static inline int bio_associate_blkg_from_page(struct bio *bio,
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
 static inline int bio_associate_blkg(struct bio *bio,
 				     struct blkcg_gq *blkg) { return 0; }
 static inline int bio_associate_blkg_from_css(struct bio *bio,
@@ -572,7 +569,7 @@ static inline int bio_associate_blkg_from_css(struct bio *bio,
 static inline int bio_associate_create_blkg(struct request_queue *q,
 					    struct bio *bio) { return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
-static inline void bio_clone_blkcg_association(struct bio *dst,
+static inline void bio_clone_blkg_association(struct bio *dst,
 			struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 55c348d66372..3c66154709ed 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -275,8 +275,8 @@ static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
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
index b951aa1fac61..cd90f653c804 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -776,9 +776,9 @@ blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
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

