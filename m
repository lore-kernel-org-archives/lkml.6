Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69CEC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710892086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIYBLZ/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710892086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeIKXm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:42:26 -0400
Received: from mail-yw1-f42.google.com ([209.85.161.42]:35705 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:24 -0400
Received: by mail-yw1-f42.google.com with SMTP id 14-v6so9624477ywe.2;
        Tue, 11 Sep 2018 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N0pKhA7/QEQ1I21aBpLNJq0PPd2R4B39KJXaiCvhNQI=;
        b=qIYBLZ/1tuspipkuIJwiZ2whRfmILbilgJgMRE/IeOEZe1gQMLHiI2NpNYG9c4uv8H
         FAehYBc9zluSa2+oVQMunhC0bsVfe1EjHfm7ZqZnFxIdMj3aZ7IENB6dLrncEOlMTLlV
         +wzg29W8vQ9c9m17wyUD2hKpbnwixCOcPf0JrGQsNxsHsZJCEcydW+tvsbrP413+fPFY
         RVuoZFIcf3bFA+5ohomdSUH1SIa4HbsQIwmMdqF6rSSSGELbI76TQmsoFS2ibTnCK6B6
         dyZ/UjCUhTT/FDuqrmRWRAVc5LY20fFF+x5N9JI6E4JKi99garHHlAcDN+QqDSskW+gC
         Dvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N0pKhA7/QEQ1I21aBpLNJq0PPd2R4B39KJXaiCvhNQI=;
        b=GRk6ms8jnaPxRZUZGqXrIZq8PcLcYtslSXrfLxHm8mGrQf8zhEMW+wZOZPZ87l/nCk
         7emr/J9qgikRSxFtRS8ETU6zufEhKPXMyrYtjQUYmPpDjIO/Mjx6gjulC6KgKfKvIyTY
         R5qed0nbGqXIHuXx2/CMePRF3EvAjQm4iLXSoNQ4iIy2Y539EgV2PXj6Lq46T8sOUXJr
         qcmDek1Wrl2UGKfPv8EDDKaBvCF5HWo3ur5HCrDSqLrbXGWBHovkb3wpbV/5r/iPB1wG
         VWlutkwwmYBuKgmM8GLDpFP1HQVUxbvZURg9ycDnPWf2W7mBM+rgPIsM/hasY1ltYwnW
         lAEA==
X-Gm-Message-State: APzg51CHixJ08xZqd7zixw1qbsgHiuu7oTg/Hi5rsK/k/COzSUCtwB2I
        myuWRly6lxF82U5WnwfGTI8cB9gLPMI=
X-Google-Smtp-Source: ANB0Vda8WzUYE15kA4EBL+XLgME903zeTOvtntg31pkePgblKXcwOBrU5qVLWOZZVP8gLdtxJqj3XQ==
X-Received: by 2002:a81:c85:: with SMTP id 127-v6mr13278991ywm.364.1536691307359;
        Tue, 11 Sep 2018 11:41:47 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:46 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 04/12] blkcg: always associate a bio with a blkg
Date:   Tue, 11 Sep 2018 14:41:29 -0400
Message-Id: <20180911184137.35897-5-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180911184137.35897-1-dennisszhou@gmail.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Previously, blkg's were only assigned as needed by blk-iolatency and
blk-throttle. bio->css was also always being associated while blkg was
being looked up and then thrown away in blkcg_bio_issue_check.

This patch begins the cleanup of bio->css and bio->bi_blkg by always
associating a blkg in blkcg_bio_issue_check. This tries to create the
blkg, but if it is not possible, falls back to using the root_blkg of
the request_queue. Therefore, a bio will always be associated with a
blkg. The duplicate association logic is removed from blk-throttle and
blk-iolatency.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c                | 38 ++++++++++++++++++++++++++++++++++++++
 block/blk-iolatency.c      | 24 ++----------------------
 block/blk-throttle.c       |  5 +----
 include/linux/bio.h        |  3 +++
 include/linux/blk-cgroup.h | 16 ++--------------
 5 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 49a28abd9772..97c1c4bf8df6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2029,6 +2029,41 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 	return 0;
 }
 
+/**
+ * bio_associate_create_blkg - associate a bio with a blkg from q
+ * @q: request_queue where bio is going
+ * @bio: target bio
+ *
+ * Associate @bio with the blkg found from the bio's css and the request_queue.
+ * If one is not found, bio_lookup_blkg creates the blkg.
+ */
+int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
+{
+	struct blkcg *blkcg;
+	struct blkcg_gq *blkg;
+	int ret = 0;
+
+	/* someone has already associated this bio with a blkg */
+	if (bio->bi_blkg)
+		return ret;
+
+	rcu_read_lock();
+
+	bio_associate_blkcg(bio, NULL);
+	blkcg = bio_blkcg(bio);
+
+	if (!blkcg->css.parent) {
+		ret = bio_associate_blkg(bio, q->root_blkg);
+	} else {
+		blkg = blkg_lookup_create(blkcg, q);
+
+		ret = bio_associate_blkg(bio, blkg);
+	}
+
+	rcu_read_unlock();
+	return ret;
+}
+
 /**
  * bio_disassociate_task - undo bio_associate_current()
  * @bio: target bio
@@ -2058,6 +2093,9 @@ void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
 {
 	if (src->bi_css)
 		WARN_ON(bio_associate_blkcg(dst, src->bi_css));
+
+	if (src->bi_blkg)
+		bio_associate_blkg(dst, src->bi_blkg);
 }
 EXPORT_SYMBOL_GPL(bio_clone_blkcg_association);
 #endif /* CONFIG_BLK_CGROUP */
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 22b2ff0440cc..79a7549e2062 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -395,34 +395,14 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
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
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-	bio_associate_blkg(bio, blkg);
-out:
-	rcu_read_unlock();
+
 	while (blkg && blkg->parent) {
 		struct iolatency_grp *iolat = blkg_to_lat(blkg);
 		if (!iolat) {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 01d0620a4e4a..b7b5cc4defc2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2129,9 +2129,6 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	/* fallback to root_blkg if we fail to get a blkg ref */
-	if (bio->bi_css && (bio_associate_blkg(bio, tg_to_blkg(tg)) == -ENODEV))
-		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 #endif
 }
@@ -2140,7 +2137,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
 	struct throtl_qnode *qn = NULL;
-	struct throtl_grp *tg = blkg_to_tg(blkg ?: q->root_blkg);
+	struct throtl_grp *tg = blkg_to_tg(blkg);
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 14b4fa266357..829cd0bb407d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -542,11 +542,14 @@ static inline int bio_associate_blkcg_from_page(struct bio *bio,
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
+int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
 static inline int bio_associate_blkcg(struct bio *bio,
 			struct cgroup_subsys_state *blkcg_css) { return 0; }
+static inline int bio_associate_create_blkg(struct request_queue *q,
+					    struct bio *bio) { return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkcg_association(struct bio *dst,
 			struct bio *src) { }
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 1fbff1bbb651..6e33ad1d92b4 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -900,29 +900,17 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio)
 {
-	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
 	bool throtl = false;
 
 	rcu_read_lock();
 
-	/* associate blkcg if bio hasn't attached one */
-	bio_associate_blkcg(bio, NULL);
-	blkcg = bio_blkcg(bio);
-
-	blkg = blkg_lookup(blkcg, q);
-	if (unlikely(!blkg)) {
-		spin_lock_irq(q->queue_lock);
-		blkg = __blkg_lookup_create(blkcg, q);
-		if (IS_ERR(blkg))
-			blkg = NULL;
-		spin_unlock_irq(q->queue_lock);
-	}
+	bio_associate_create_blkg(q, bio);
+	blkg = bio->bi_blkg;
 
 	throtl = blk_throtl_bio(q, blkg, bio);
 
 	if (!throtl) {
-		blkg = blkg ?: q->root_blkg;
 		/*
 		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
 		 * is a split bio and we would have already accounted for the
-- 
2.17.1

