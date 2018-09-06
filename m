Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E877C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD38C2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI7VscDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD38C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbeIGBse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:48:34 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46222 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbeIGBsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:48:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id j131-v6so4618221ywc.13;
        Thu, 06 Sep 2018 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=li/WLeyYZgAmqutk7Zj8a0MrbpRWnmiZIqWMYyLNvQQ=;
        b=UI7VscDH/l6E17im9zGgmArb8j5UUC4o+m3+ZQv3xoG0c7rEbszVyJ41fqVxka3KMX
         Xch9o3fraGfGWHwyK7GdoG/S+Xz7GO7zBXKaHkSMBMfTCHpT9JgHqDt8f8Uyxx5arMgc
         /6QoXUf85mdAZoHUHal2EujTMRnIlGvZ/ijuq+y2cC4HlbntxHaHLrypNboqo1Ihd8AY
         v0uUBOz0esO4SbinmSwNBYQ2dUUZhVGw7QMSrbrewiZ+BcaN6iduS34SdJ3TexSb+s8y
         nn77px8wIKgPxoiC3XQ5fubOMRS/Iz70Hvnw0LmRhRVjxu7T445IicGcWPQWenbMLhiS
         5Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=li/WLeyYZgAmqutk7Zj8a0MrbpRWnmiZIqWMYyLNvQQ=;
        b=o/VPtubKPwHgzUZ+PCf0JevMJk9M/yteEsVnUMW16hmHtFeA2mPUt4QUL5E9EbR96F
         IHQgUy5KVwaaUWBfE1Jf6t7V9DvrfszPh3jG8PTrRjvQqCo+0J291IiC7j1YynBvE1Zk
         uLfOL4Pi0FizmRY4DjxLFeRM8ty7xi1ScgemhzlvTVsME0UX1ralpFQvvr0KAHeUjIgs
         pP0CpS/WAAlRqVfzSfKjR2+TsCtBptPtGmOWD3RWatgztNret+4UqP7sYaLqV8gP7b24
         UUpfdhhzXDFORF8640BS6sJvtq8KNIPGZrNWlQ750jPGtauIigNHRTWbF3Kv/G72+gqj
         q3GQ==
X-Gm-Message-State: APzg51AYQRtOdf3pCyG+vorfJT5lAJlrwichQvolkvyjm52WGuMNrRQw
        fHOZWc4KRWhqQNbZjn0HAtU=
X-Google-Smtp-Source: ANB0VdapsMcKHyVWtfjMIHZOyL7lgjzsZKCo+1Z58Oe1hacA/ThbWkGBsL235IyMtfyIePaVzgNJow==
X-Received: by 2002:a81:26d5:: with SMTP id m204-v6mr2596985ywm.156.1536268272047;
        Thu, 06 Sep 2018 14:11:12 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u67-v6sm2032802ywa.56.2018.09.06.14.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:11:11 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 12/12] blkcg: rename blkg_try_get to blkg_tryget
Date:   Thu,  6 Sep 2018 17:10:45 -0400
Message-Id: <20180906211045.29055-13-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180906211045.29055-1-dennisszhou@gmail.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
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
index 3cc8fcd8b827..bed3328c92ff 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1971,7 +1971,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
 	if (unlikely(bio->bi_blkg))
 		return -EBUSY;
-	bio->bi_blkg = blkg_try_get_closest(blkg);
+	bio->bi_blkg = blkg_tryget_closest(blkg);
 	return 0;
 }
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1efd697c9019..0c9aeb30ba8e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1793,8 +1793,7 @@ void blkcg_maybe_throttle_current(void)
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
index f8edff271a17..b5bbd9bdf37e 100644
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

