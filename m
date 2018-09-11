Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15309ECDFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84E42087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By7vpYN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84E42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeIKXmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:42:23 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46498 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIKXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:22 -0400
Received: by mail-yb1-f195.google.com with SMTP id y20-v6so9720807ybi.13;
        Tue, 11 Sep 2018 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0vFvSHzEg8C5aAk8MUn2HD/7B9Z1ZlOCDdmp1KeTvd0=;
        b=By7vpYN5SSFvh9S236XgvWLLPWN69zPWXl78tdPTVfQLdiOR8NXC1hauzGbN3WhaTG
         hM4ilN8GhwkkRSk10Lyf6XsJbs91J/BWivdQDesdPsEwS/xtvjHRDDenfGQJUlfefUWZ
         LGqDl2XlzQ/ZWZC/18n4QIZoAKPKCnWYGeO5fWps1ZYA2BnNFTAbZn0WiNGzxmPB7L0f
         8ra+5pBWbqB/oexvBStmAdOv3PeMsiKCD4vuFEofEe4sMB3o4QLWorFZomYZlyLftEZa
         MUrJArYE8XEjRpi5j9LlfspbFuXU4NdGghZUJZYhyIdcOazTTg8qqgmPa9utze8PYu51
         fQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0vFvSHzEg8C5aAk8MUn2HD/7B9Z1ZlOCDdmp1KeTvd0=;
        b=bF3cQcM2RvTtRB/yKTTq5wOVQ1KjjJv4YO1SWO7afnWL895/cZljwlWCRfQDXVAXaC
         UnKufudVtAsvJpSDlLLhWChJTtlenx1yLoru6Vwfvo1Rlf2XjifIRre9R/q062Oylb/p
         j6LzpocluESh1Ck615RuKvUngeVGhKQputjr2JwxpKmFMexmalGis73tS6/xMJXMTMsS
         tmDTjW2ya+diV+o3Ohp37FAPUE9Mnzsk9hzCPdYMMBwpfpE+w6eSlHu1k//eorr5a/Ql
         k9tNiKgRImk2M0YLwIqXkKWEuAxy6sHH8PTPpd9FBCinNk75vvLeZWwjkp6KOjAKzMPb
         Nang==
X-Gm-Message-State: APzg51DzjJ3vr+8DOQ9KdAqmSieGflTLWshsyHFAgGhuReRSxRw3a6VO
        q6iXGWTRgGMFMOiR02OHBS0=
X-Google-Smtp-Source: ANB0VdYjNjBI2TTPxYw4kaBfXxwBdTkhkYnhfOx7YmrBk+QULCyK4QOZ0z7G8/e+j+tJ0A1YEeNbSg==
X-Received: by 2002:a25:9cc1:: with SMTP id z1-v6mr12995474ybo.2.1536691306139;
        Tue, 11 Sep 2018 11:41:46 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:45 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 03/12] blkcg: convert blkg_lookup_create to find closest blkg
Date:   Tue, 11 Sep 2018 14:41:28 -0400
Message-Id: <20180911184137.35897-4-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180911184137.35897-1-dennisszhou@gmail.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

There are several scenarios where blkg_lookup_create can fail. Examples
include the blkcg dying, request_queue is dying, or simply being OOM. At
the end of the day, most handle this by simply falling back to the
q->root_blkg and calling it a day.

This patch implements the notion of closest blkg. During
blkg_lookup_create, if it fails to create, return the closest blkg
found or the q->root_blkg. blkg_try_get_closest is introduced and used
during association so a bio is always attached to a blkg.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 block/bio.c                | 17 ++++++++++-------
 block/blk-cgroup.c         | 25 +++++++++++++++++--------
 include/linux/blk-cgroup.h | 14 ++++++++++++++
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 6ca4dda481ca..49a28abd9772 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2008,21 +2008,24 @@ int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css)
 EXPORT_SYMBOL_GPL(bio_associate_blkcg);
 
 /**
- * bio_associate_blkg - associate a bio with the specified blkg
+ * bio_associate_blkg - associate a bio with the a blkg
  * @bio: target bio
  * @blkg: the blkg to associate
  *
- * Associate @bio with the blkg specified by @blkg.  This is the queue specific
- * blkcg information associated with the @bio, a reference will be taken on the
- * @blkg and will be freed when the bio is freed.
+ * This tries to associate @bio with the specified blkg.  Association failure
+ * is handled by walking up the blkg tree.  Therefore, the blkg associated can
+ * be anything between @blkg and the root_blkg.  This situation only happens
+ * when a cgroup is dying and then the remaining bios will spill to the closest
+ * alive blkg.
+ *
+ * A reference will be taken on the @blkg and will be released when @bio is
+ * freed.
  */
 int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
 	if (unlikely(bio->bi_blkg))
 		return -EBUSY;
-	if (!blkg_try_get(blkg))
-		return -ENODEV;
-	bio->bi_blkg = blkg;
+	bio->bi_blkg = blkg_try_get_closest(blkg);
 	return 0;
 }
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index cd0d97bed83d..e9e3a955f61a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -268,9 +268,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
  * that all non-root blkg's have access to the parent blkg.  This function
  * should be called under RCU read lock and @q->queue_lock.
  *
- * Returns pointer to the looked up or created blkg on success, ERR_PTR()
- * value on error.  If @q is dead, returns ERR_PTR(-EINVAL).  If @q is not
- * dead and bypassing, returns ERR_PTR(-EBUSY).
+ * Returns the blkg or the closest blkg if blkg_create fails as it walks
+ * down from root.
  */
 struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
 				      struct request_queue *q)
@@ -285,7 +284,7 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
 	 * we shouldn't allow anything to go through for a bypassing queue.
 	 */
 	if (unlikely(blk_queue_bypass(q)))
-		return ERR_PTR(blk_queue_dying(q) ? -ENODEV : -EBUSY);
+		return q->root_blkg;
 
 	blkg = __blkg_lookup(blkcg, q, true);
 	if (blkg)
@@ -293,19 +292,29 @@ struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
 
 	/*
 	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
-	 * non-root blkgs have access to their parents.
+	 * non-root blkgs have access to their parents.  Returns the closest
+	 * blkg to the intended blkg should blkg_create() fail.
 	 */
 	while (true) {
 		struct blkcg *pos = blkcg;
 		struct blkcg *parent = blkcg_parent(blkcg);
-
-		while (parent && !__blkg_lookup(parent, q, false)) {
+		struct blkcg_gq *ret_blkg = q->root_blkg;
+
+		while (parent) {
+			blkg = __blkg_lookup(parent, q, false);
+			if (blkg) {
+				/* remember closest blkg */
+				ret_blkg = blkg;
+				break;
+			}
 			pos = parent;
 			parent = blkcg_parent(parent);
 		}
 
 		blkg = blkg_create(pos, q, NULL);
-		if (pos == blkcg || IS_ERR(blkg))
+		if (IS_ERR(blkg))
+			return ret_blkg;
+		if (pos == blkcg)
 			return blkg;
 	}
 }
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index cc0f238530f6..1fbff1bbb651 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -549,6 +549,20 @@ static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
 	return NULL;
 }
 
+/**
+ * blkg_try_get_closest - try and get a blkg ref on the closet blkg
+ * @blkg: blkg to get
+ *
+ * This walks up the blkg tree to find the closest non-dying blkg and returns
+ * the blkg that it did association with as it may not be the passed in blkg.
+ */
+static inline struct blkcg_gq *blkg_try_get_closest(struct blkcg_gq *blkg)
+{
+	while (!atomic_inc_not_zero(&blkg->refcnt))
+		blkg = blkg->parent;
+
+	return blkg;
+}
 
 void __blkg_release_rcu(struct rcu_head *rcu);
 
-- 
2.17.1

