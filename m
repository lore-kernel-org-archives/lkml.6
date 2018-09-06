Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57D4C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A352083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvd4+FQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A352083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeIGBsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:48:22 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40091 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbeIGBsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:48:21 -0400
Received: by mail-yb1-f196.google.com with SMTP id t71-v6so4690976ybi.7;
        Thu, 06 Sep 2018 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A7oknpfBCZ28ZYcXI/hUlO4PlTV81jtdGOJ56zQQbeI=;
        b=lvd4+FQjMCmbE7A5/M7KBBrTkwC+8uf25hiBfpmG52KlvVc7vfdNjZiv0ORNVzgJTx
         O1y8nGlb2qTnIqODoFFTBWnFowhiKmJobZIdHLm1hO8tJTNX/0UzA/fVi3K+njyANc0W
         3pnWMCO44Rqn0XDkYv0rcg3VmfSMVYiV0O+U2xE8texSTwoKg2l2vlxeb2K2VfpFlR50
         0arrhbosssQMXfyxzQcw8459IqitgNb3qg+oHOtLI1OVD54/Mk2CslgWidaZMLPpEF8p
         GBf00srxk8jBTty0o48Mh3J6NGbzdrqXOdTJm+0F9EZJY6JyeLwn+/OAcAuy9PkfSe7C
         qyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A7oknpfBCZ28ZYcXI/hUlO4PlTV81jtdGOJ56zQQbeI=;
        b=NhkjLrhpyvGTq8H+ZofANyyXLm1ADq4fwIBv1tNyINz2qavGE4fqKjTtNliw8cmim3
         +9vuGjzovkwbT9gbcr60gfaCq9ZgSwZXQfh/56RSMUK1HZ9OusgFM3hzfeiyOVhb6zqM
         S3UPf/Ga4UUj38tSz8G9qXor22iiNFCBajcBNRelV+izgyBGeUwL7zWEbYqB9yqY6uO6
         iS2ghUG5WSt5JJfJ1YcUu/lGylDnXbv7d7ZlSZWMU50PSSwKB7FSXPRj/3tt0albdWvp
         4UevEyLJM8t7X2Se9MLlM7mEo2q1zT6MCD+hFS1tVEBT7eiXEyfcPQN+wbecyYylMUQl
         EOxw==
X-Gm-Message-State: APzg51DSdcuN+cTI0XAxzxcyY3AiA/5zM1KAlXQV9i4fx7Z0R+TL8DTI
        M73yGqQehk8fplpMW3cLl7M=
X-Google-Smtp-Source: ANB0VdYXlm/L+NPU6WmfgmYMwIIkjnS7XuXqZknvYg7gtFaiiUCpv2giMVPii7jyeNJkIFNydR7DtQ==
X-Received: by 2002:a25:8403:: with SMTP id u3-v6mr2554107ybk.296.1536268263041;
        Thu, 06 Sep 2018 14:11:03 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u67-v6sm2032802ywa.56.2018.09.06.14.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:11:02 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 05/12] blkcg: consolidate bio_issue_init to be a part of core
Date:   Thu,  6 Sep 2018 17:10:38 -0400
Message-Id: <20180906211045.29055-6-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180906211045.29055-1-dennisszhou@gmail.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

bio_issue_init among other things initializes the timestamp for an IO.
Rather than have this logic handled by policies, this consolidates it to
be on the init paths (normal, clone, bounce clone).

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
v2: Association path consolidation was moved to the prior patch.

 block/bio.c                | 2 ++
 block/blk-iolatency.c      | 2 --
 block/blk-throttle.c       | 8 --------
 block/bounce.c             | 2 ++
 include/linux/blk-cgroup.h | 9 +++++++++
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b2b3fddfcd6f..a05997bdb967 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -610,6 +610,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	bio_clone_blkcg_association(bio, bio_src);
+
+	blkcg_bio_issue_init(bio);
 }
 EXPORT_SYMBOL(__bio_clone_fast);
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 79a7549e2062..9d7052bad6f7 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -401,8 +401,6 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
 	if (!blk_iolatency_enabled(blkiolat))
 		return;
 
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-
 	while (blkg && blkg->parent) {
 		struct iolatency_grp *iolat = blkg_to_lat(blkg);
 		if (!iolat) {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b7b5cc4defc2..f2b355338894 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2126,13 +2126,6 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
-static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
-{
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-#endif
-}
-
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -2156,7 +2149,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
-	blk_throtl_assoc_bio(tg, bio);
 	blk_throtl_update_idletime(tg);
 
 	sq = &tg->service_queue;
diff --git a/block/bounce.c b/block/bounce.c
index bc63b3a2d18c..7a08703b1204 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -259,6 +259,8 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 
 	bio_clone_blkcg_association(bio, bio_src);
 
+	blkcg_bio_issue_init(bio);
+
 	return bio;
 }
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6e33ad1d92b4..a6b6e741a75e 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -897,6 +897,12 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
 				  struct bio *bio) { return false; }
 #endif
 
+
+static inline void blkcg_bio_issue_init(struct bio *bio)
+{
+	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
+}
+
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio)
 {
@@ -922,6 +928,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
 	}
 
+	blkcg_bio_issue_init(bio);
+
 	rcu_read_unlock();
 	return !throtl;
 }
@@ -1034,6 +1042,7 @@ static inline void blk_put_rl(struct request_list *rl) { }
 static inline void blk_rq_set_rl(struct request *rq, struct request_list *rl) { }
 static inline struct request_list *blk_rq_rl(struct request *rq) { return &rq->q->root_rl; }
 
+static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
 
-- 
2.17.1

