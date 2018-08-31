Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C49C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE982083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCr52TZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE982083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeHaGAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 02:00:18 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40741 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeHaF7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:24 -0400
Received: by mail-yb1-f193.google.com with SMTP id f4-v6so330906ybp.7;
        Thu, 30 Aug 2018 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4hs1gt3E+KmSCGAk5j+8gYSMsQ09LEqBMEiVFXkCT1w=;
        b=CCr52TZdXMKZ1fa39IxMiQlXIo9YKFhZARy8r1UF/SeOX0Gv0mTeXLjy79n/LOAZY2
         huDzYiFBzPtqLmJ+0tNxBqqVXtr+qPIOY+WJwUEbWmniNV6IdjQQkl7f4orQRx4Bnjq+
         sEBGqPoeNkYOKK50bdXfRKAGnIqiaqg5FuK/QdTgUQoXj7Krx/L3VVU+OweiUptI/9Ha
         FYxiDskNBzGYxZ/pVfd04X8ghjhQSl2eea2JCldTw/zvT93SCxTf3smeM0GExgBe+GT6
         rhj1lJ7A6aK1Z/CMh32a+QPoT4Ifc5enIVGNqJ0NTOsbF+Tp7nWeTHBn3nVrukPcSztH
         srkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4hs1gt3E+KmSCGAk5j+8gYSMsQ09LEqBMEiVFXkCT1w=;
        b=o2GTCk0c00f5gA2/jb4BInUC2YoLAyKg7yC2tHfdbl6cFs5kPMI11VyPeD6wYJUS76
         N1lIfpgrb5pDt/u6CkJx8UAsvkZZhLr2NRBH+LdLemY3Qkjn+SIs3uv+w62PvERvIGJ+
         2STKUc8e18BQan0o6vWVCGBGxO0S0fgGGtFtwyuAaLG06K7el1Zc4IbO59/buCTaN6Zm
         RM4BNNuTQQgbICAJhc0sqtkbF+uhTaHTcA3JS5o4TJtwPIEKNjt1UvX0NBuSTs8j9FwO
         DeR8StwL+jrLjO6rHJfy0z3/6/dXT4v2YVR6d9bnT/et0MmYSqVRT9ea3E2M+uer0STg
         W2OQ==
X-Gm-Message-State: APzg51A6MYUGyby6zz+Jpw67n5aa3Ls2pVzTvRQxI3vZIq66yjI8JQoe
        bsKZhmNrhe6vwhBcQE9FJGU=
X-Google-Smtp-Source: ANB0VdYP61pZSIzzSTx74PTZPt/juwaMyGnbkWUqzVdOjmBhE+d9kO9tDUjGUakeiqzddnYuqKB2vg==
X-Received: by 2002:a25:c9c3:: with SMTP id z186-v6mr7512020ybf.232.1535680461835;
        Thu, 30 Aug 2018 18:54:21 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:21 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 07/15] blkcg: consolidate bio_issue_init and blkg association
Date:   Thu, 30 Aug 2018 21:53:48 -0400
Message-Id: <20180831015356.69796-8-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

This removes the now duplicate association logic in blk-throttle and
blk-iolatency. bio_issue_init is moved into blkcg_bio_issue_check and
into the bio clone variants to allow for the future addition of a
latency moving average for IOs.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 block/bio.c                |  2 ++
 block/blk-iolatency.c      | 24 +-----------------------
 block/blk-throttle.c       | 13 +------------
 block/bounce.c             |  2 ++
 include/linux/blk-cgroup.h |  2 ++
 5 files changed, 8 insertions(+), 35 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e937f9681188..ab41f5b7eb1f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -610,6 +610,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	bio_clone_blkcg_association(bio, bio_src);
+
+	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 }
 EXPORT_SYMBOL(__bio_clone_fast);
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 22b2ff0440cc..9d7052bad6f7 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -395,34 +395,12 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
 				     spinlock_t *lock)
 {
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
-	struct blkcg *blkcg;
-	struct blkcg_gq *blkg;
-	struct request_queue *q = rqos->q;
+	struct blkcg_gq *blkg = bio->bi_blkg;
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
 
 	if (!blk_iolatency_enabled(blkiolat))
 		return;
 
-	rcu_read_lock();
-	bio_associate_blkcg(bio, NULL);
-	blkcg = bio_blkcg(bio);
-	blkg = blkg_lookup(blkcg, q);
-	if (unlikely(!blkg)) {
-		if (!lock)
-			spin_lock_irq(q->queue_lock);
-		blkg = __blkg_lookup_create(blkcg, q);
-		if (IS_ERR(blkg))
-			blkg = NULL;
-		if (!lock)
-			spin_unlock_irq(q->queue_lock);
-	}
-	if (!blkg)
-		goto out;
-
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-	bio_associate_blkg(bio, blkg);
-out:
-	rcu_read_unlock();
 	while (blkg && blkg->parent) {
 		struct iolatency_grp *iolat = blkg_to_lat(blkg);
 		if (!iolat) {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c626e1f7cdcd..f2b355338894 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2126,21 +2126,11 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
-static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
-{
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	/* fallback to root_blkg if we fail to get a blkg ref */
-	if (bio->bi_css && bio_associate_blkg(bio, tg_to_blkg(tg)))
-		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-#endif
-}
-
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
 	struct throtl_qnode *qn = NULL;
-	struct throtl_grp *tg = blkg_to_tg(blkg ?: q->root_blkg);
+	struct throtl_grp *tg = blkg_to_tg(blkg);
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
@@ -2159,7 +2149,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
-	blk_throtl_assoc_bio(tg, bio);
 	blk_throtl_update_idletime(tg);
 
 	sq = &tg->service_queue;
diff --git a/block/bounce.c b/block/bounce.c
index bc63b3a2d18c..bea3b0cbe4a7 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -259,6 +259,8 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 
 	bio_clone_blkcg_association(bio, bio_src);
 
+	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
+
 	return bio;
 }
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 9931ec2f4e9e..55c348d66372 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -844,6 +844,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
 	}
 
+	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
+
 	return !throtl;
 }
 
-- 
2.17.1

