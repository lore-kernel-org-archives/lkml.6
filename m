Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EEAC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF82720880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdwOfXpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF82720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeIKXmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:42:44 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:47093 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbeIKXmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:33 -0400
Received: by mail-yw1-f68.google.com with SMTP id j131-v6so9596783ywc.13;
        Tue, 11 Sep 2018 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zhl/2Dyq9QvCeiNHqKLR3IjW7/h51nLcSK+lBauCWR0=;
        b=gdwOfXpUVXotNnENEC5Plz4ZaeFlcFnbenVx5eLjQXQUnNbYlwV7N8Qpyz6GpF8h56
         /s1+KnWao0oPn02D0hq7deBhx2teTphXM4eOl/c0JEmcrZCl2ZV/fycMaEdZjQSWTkqW
         Gh2iRQvB6ez/gkVNU+TtgbjPuT9bPXjwkz5+PNQiZ4Q+z5sjfEGjbLX2+McLy3whXxWH
         l0dauewPyU+OcbMxjdL3acVpVhXqVrij9B5gHzEHa1EmLzEYRRfBcDUGmX2fteDAJfb9
         YkEXu+/WRZcLPCZ8B7cjwMiIQhem4MKSR4jGmNmDbEiWRLafPk6vysEsHCroD6QMgKhz
         oAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zhl/2Dyq9QvCeiNHqKLR3IjW7/h51nLcSK+lBauCWR0=;
        b=PMuq/SZGaHkkT9m9R+wUBriH2dMNx1TjfXG9R9+46WDG05M2dcj7fTsbqNrRDrgUru
         QbFhhXbTKuXF1Op6X1/YEBnZWwOA6cc0O9XS+qR/5Xn6Ux2az53GzWOrAWizkxIXpILv
         benQD8JZ1EZg+rvXszP4pSDT8T8A1JGfcAkIec/RY2ko5Fje0L8jWgqgUyls0mROchjw
         u0wUrlL1AowU+k802uf4cfvx44Qcqvwn9puznTdDLMe2GVbbW/4+sqPTEvCB82/ixkLE
         oEnOwfpJ5WiL63W2Jmmd4BXCOONydH0RIXxIQXisyUVnny0wxtu3Msq3gU/CdhOaj1ZI
         1Ciw==
X-Gm-Message-State: APzg51AwxUOsajgBpecDq2yr08gFehAYDuiDW9j40SnEEDQ9KosYU4VI
        k/lNKqm/F8tWQigEAmfyNKA=
X-Google-Smtp-Source: ANB0VdaKF2yAsoy5PZiVo8JgmBuuqnGfM6nULWyDOk0EkLPrk80xA5aw2nYUiKL72yPHcfnBi6R0/Q==
X-Received: by 2002:a81:812:: with SMTP id 18-v6mr13280788ywi.475.1536691317739;
        Tue, 11 Sep 2018 11:41:57 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:57 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 12/12] blkcg: rename blkg_try_get to blkg_tryget
Date:   Tue, 11 Sep 2018 14:41:37 -0400
Message-Id: <20180911184137.35897-13-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180911184137.35897-1-dennisszhou@gmail.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

blkg reference counting now uses percpu_ref rather than atomic_t. Let's
make this consistent with css_tryget. This renames blkg_try_get to
blkg_tryget and now returns a bool rather than the blkg or NULL.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c                |  2 +-
 block/blk-cgroup.c         |  3 +--
 block/blk-iolatency.c      |  2 +-
 include/linux/blk-cgroup.h | 14 ++++++--------
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a65ab3bacb4f..14351fac07cd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1975,7 +1975,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
 	if (unlikely(bio->bi_blkg))
 		return -EBUSY;
-	bio->bi_blkg = blkg_try_get_closest(blkg);
+	bio->bi_blkg = blkg_tryget_closest(blkg);
 	return 0;
 }
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ab3676e1e15e..76136bea7a7f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1794,8 +1794,7 @@ void blkcg_maybe_throttle_current(void)
 	blkg = blkg_lookup(blkcg, q);
 	if (!blkg)
 		goto out;
-	blkg = blkg_try_get(blkg);
-	if (!blkg)
+	if (!blkg_tryget(blkg))
 		goto out;
 	rcu_read_unlock();
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 9d7052bad6f7..5a4cec54c998 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -628,7 +628,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 		 * We could be exiting, don't access the pd unless we have a
 		 * ref on the blkg.
 		 */
-		if (!blkg_try_get(blkg))
+		if (!blkg_tryget(blkg))
 			continue;
 
 		iolat = blkg_to_lat(blkg);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 7ff5d8ba8c7a..b7fd08013de2 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -494,27 +494,25 @@ static inline void blkg_get(struct blkcg_gq *blkg)
 }
 
 /**
- * blkg_try_get - try and get a blkg reference
+ * blkg_tryget - try and get a blkg reference
  * @blkg: blkg to get
  *
  * This is for use when doing an RCU lookup of the blkg.  We may be in the midst
  * of freeing this blkg, so we can only use it if the refcnt is not zero.
  */
-static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
+static inline bool blkg_tryget(struct blkcg_gq *blkg)
 {
-	if (percpu_ref_tryget(&blkg->refcnt))
-		return blkg;
-	return NULL;
+	return percpu_ref_tryget(&blkg->refcnt);
 }
 
 /**
- * blkg_try_get_closest - try and get a blkg ref on the closet blkg
+ * blkg_tryget_closest - try and get a blkg ref on the closet blkg
  * @blkg: blkg to get
  *
  * This walks up the blkg tree to find the closest non-dying blkg and returns
  * the blkg that it did association with as it may not be the passed in blkg.
  */
-static inline struct blkcg_gq *blkg_try_get_closest(struct blkcg_gq *blkg)
+static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
 {
 	while (!percpu_ref_tryget(&blkg->refcnt))
 		blkg = blkg->parent;
@@ -599,7 +597,7 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 	if (unlikely(!blkg))
 		blkg = __blkg_lookup_create(blkcg, q);
 
-	if (!blkg_try_get(blkg))
+	if (!blkg_tryget(blkg))
 		goto rl_use_root;
 
 	rcu_read_unlock();
-- 
2.17.1

