Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBD9C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDDB20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxujb3Do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDDB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeIKXmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:42:31 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42394 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbeIKXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:30 -0400
Received: by mail-yb1-f195.google.com with SMTP id j8-v6so9713399ybg.9;
        Tue, 11 Sep 2018 11:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JpX7At2uP82AEiO2R0RYzwv6ZW2l9R3i4u2KsNZHRcA=;
        b=kxujb3Do87hbX/w8Y1S1FimQkbRIymufwe2VDd6yjnT3cR5knvrQvGY8804azM8nA1
         /EWOVvQhKB/nJAYcuawVL1VFeOoI0ZKKc7zQ+ghcX4YPGJIDAZDVKLRBJeIaVmGWbNpv
         IL2iM3ftlrJ2EmMFUV4/ycGV5cgMMRBxBkukNkFIsG4ThZUuwySE7x1U42zmgxdiqI35
         uoSlIw/l59yw5wVkvPNSD20cMT63Cjyi29RH3pTVJNqukmw8LCTICgC+kG6T611Dgqtt
         m8kGAXweJoa/ZNpuBK8y8QMLaR9K0jSq/CF9Qbv1PEQ8/JmW5Cu7RaLM7Bf5py0y/B47
         Egfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JpX7At2uP82AEiO2R0RYzwv6ZW2l9R3i4u2KsNZHRcA=;
        b=ZgnZfpXsBZKsl894mXyVAcSnkuQ/h8HgfXYFSmpfLk4nbRaSfP717fN/Tt23QrLC/f
         YFH/Xiz5rO9zWLRViIZWfkssAgT39w5RIA1fG677KnYzIOeo/MLGD4uighkXHS0zLXGM
         Ziwds0+AAs9QD/4DDQT3VYST0jPjunF9qM3lKeI33GIJYzU+f0zeQdkVgSndLbb5pCbq
         zO8eiYmM3iG1FfooRCVax4hGjdQzj7XdMhJmVDKFgSfdLkkkzny/7eA0IWNrn90jqV0n
         d8+rjPrvDYrgP03F5D8Ev1fnEPUjRUtP6s+E9CJmQvAB4vHx/hMlVr4SBsa8uEq1hnxw
         rKsA==
X-Gm-Message-State: APzg51CZKWfVIUpR6UNpiVsJaXeTHLphL21bQ9RNwu8zROUUofQwmLyx
        f8IUQdLgYcYtX87MSzpBvmEukZ2aoio=
X-Google-Smtp-Source: ANB0VdaUsAHSdnhhABHCgX+GqiHgJDIRUjTqxawPpCLeYkfPegAd9C30zQrpGDj1rCpe1nTZRXKoVQ==
X-Received: by 2002:a25:adc6:: with SMTP id d6-v6mr9839627ybe.342.1536691313567;
        Tue, 11 Sep 2018 11:41:53 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:52 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 09/12] blkcg: remove additional reference to the css
Date:   Tue, 11 Sep 2018 14:41:34 -0400
Message-Id: <20180911184137.35897-10-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180911184137.35897-1-dennisszhou@gmail.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

The previous patch in this series removed carrying around a pointer to
the css in blkg. However, the blkg association logic still relied on
taking a reference on the css to ensure we wouldn't fail in getting a
reference for the blkg.

Here the implicit dependency on the css is removed. The association
continues to rely on the tryget logic walking up the blkg tree. This
streamlines the three ways that association can happen: normal, swap,
and writeback.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 block/bio.c                | 62 ++++++++++++++++++++++----------------
 include/linux/blk-cgroup.h | 52 +++-----------------------------
 include/linux/cgroup.h     |  2 ++
 kernel/cgroup/cgroup.c     | 48 +++++++++++++++++++++++------
 4 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f32b4757a232..a65ab3bacb4f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1979,18 +1979,30 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 	return 0;
 }
 
+/**
+ * __bio_associate_blkg_from_css - internal blkg association function
+ *
+ * This in the core association function that all association paths rely on.
+ * A blkg reference is taken which is released upon freeing of the bio.
+ */
 static int __bio_associate_blkg_from_css(struct bio *bio,
 					 struct cgroup_subsys_state *css)
 {
+	struct request_queue *q = bio->bi_disk->queue;
 	struct blkcg_gq *blkg;
+	int ret;
 
 	rcu_read_lock();
 
-	blkg = blkg_lookup_create(css_to_blkcg(css), bio->bi_disk->queue);
+	if (!css || !css->parent)
+		blkg = q->root_blkg;
+	else
+		blkg = blkg_lookup_create(css_to_blkcg(css), q);
 
-	rcu_read_unlock();
+	ret = bio_associate_blkg(bio, blkg);
 
-	return bio_associate_blkg(bio, blkg);
+	rcu_read_unlock();
+	return ret;
 }
 
 /**
@@ -1999,13 +2011,14 @@ static int __bio_associate_blkg_from_css(struct bio *bio,
  * @css: target css
  *
  * Associate @bio with the blkg found by combining the css's blkg and the
- * request_queue of the @bio.  This takes a reference on the css that will
- * be put upon freeing of @bio.
+ * request_queue of the @bio.  This falls back to the queue's root_blkg if
+ * the association fails with the css.
  */
 int bio_associate_blkg_from_css(struct bio *bio,
 				struct cgroup_subsys_state *css)
 {
-	css_get(css);
+	if (unlikely(bio->bi_blkg))
+		return -EBUSY;
 	return __bio_associate_blkg_from_css(bio, css);
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
@@ -2017,22 +2030,29 @@ EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
  * @page: the page to lookup the blkcg from
  *
  * Associate @bio with the blkg from @page's owning memcg and the respective
- * request_queue.  This works like every other associate function wrt
- * references.
+ * request_queue.  If cgroup_e_css returns NULL, fall back to the queue's
+ * root_blkg.
  *
  * Note: this must be called after bio has an associated device.
  */
 int bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 {
 	struct cgroup_subsys_state *css;
+	int ret;
 
 	if (unlikely(bio->bi_blkg))
 		return -EBUSY;
 	if (!page->mem_cgroup)
 		return 0;
-	css = cgroup_get_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
 
-	return __bio_associate_blkg_from_css(bio, css);
+	rcu_read_lock();
+
+	css = cgroup_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
+
+	ret = __bio_associate_blkg_from_css(bio, css);
+
+	rcu_read_unlock();
+	return ret;
 }
 #endif /* CONFIG_MEMCG */
 
@@ -2042,12 +2062,12 @@ int bio_associate_blkg_from_page(struct bio *bio, struct page *page)
  * @bio: target bio
  *
  * Associate @bio with the blkg found from the bio's css and the request_queue.
- * If one is not found, bio_lookup_blkg creates the blkg.
+ * If one is not found, bio_lookup_blkg creates the blkg.  This falls back to
+ * the queue's root_blkg if association fails.
  */
 int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
 {
-	struct blkcg *blkcg;
-	struct blkcg_gq *blkg;
+	struct cgroup_subsys_state *css;
 	int ret = 0;
 
 	/* someone has already associated this bio with a blkg */
@@ -2056,15 +2076,9 @@ int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
 
 	rcu_read_lock();
 
-	blkcg = css_to_blkcg(blkcg_get_css());
+	css = blkcg_css();
 
-	if (!blkcg->css.parent) {
-		ret = bio_associate_blkg(bio, q->root_blkg);
-	} else {
-		blkg = blkg_lookup_create(blkcg, q);
-
-		ret = bio_associate_blkg(bio, blkg);
-	}
+	ret = __bio_associate_blkg_from_css(bio, css);
 
 	rcu_read_unlock();
 	return ret;
@@ -2081,8 +2095,6 @@ void bio_disassociate_task(struct bio *bio)
 		bio->bi_ioc = NULL;
 	}
 	if (bio->bi_blkg) {
-		/* a ref is always taken on css */
-		css_put(&bio_blkcg(bio)->css);
 		blkg_put(bio->bi_blkg);
 		bio->bi_blkg = NULL;
 	}
@@ -2095,10 +2107,8 @@ void bio_disassociate_task(struct bio *bio)
  */
 void bio_clone_blkg_association(struct bio *dst, struct bio *src)
 {
-	if (src->bi_blkg) {
-		css_get(&bio_blkcg(src)->css);
+	if (src->bi_blkg)
 		bio_associate_blkg(dst, src->bi_blkg);
-	}
 }
 EXPORT_SYMBOL_GPL(bio_clone_blkg_association);
 #endif /* CONFIG_BLK_CGROUP */
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index c41cfcc2b4d8..2951ea3541b1 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -249,47 +249,6 @@ static inline struct cgroup_subsys_state *blkcg_css(void)
 	return task_css(current, io_cgrp_id);
 }
 
-/**
- * blkcg_get_css - find and get a reference to the css
- *
- * Find the css associated with either the kthread or the current task.
- * This takes a reference on the blkcg which will need to be managed by the
- * caller.
- */
-static inline struct cgroup_subsys_state *blkcg_get_css(void)
-{
-	struct cgroup_subsys_state *css;
-
-	rcu_read_lock();
-
-	css = kthread_blkcg();
-	if (css) {
-		css_get(css);
-	} else {
-		/*
-		 * This is a bit complicated.  It is possible task_css is seeing
-		 * an old css pointer here.  This is caused by the current
-		 * thread migrating away from this cgroup and this cgroup dying.
-		 * css_tryget() will fail when trying to take a ref on a cgroup
-		 * that's ref count has hit 0.
-		 *
-		 * Therefore, if it does fail, this means current must have
-		 * been swapped away already and this is waiting for it to
-		 * propagate on the polling cpu.  Hence the use of cpu_relax().
-		 */
-		while (true) {
-			css = task_css(current, io_cgrp_id);
-			if (likely(css_tryget(css)))
-				break;
-			cpu_relax();
-		}
-	}
-
-	rcu_read_unlock();
-
-	return css;
-}
-
 static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
 {
 	return css ? container_of(css, struct blkcg, css) : NULL;
@@ -628,10 +587,8 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 	rcu_read_lock();
 
 	blkcg = bio_blkcg(bio);
-	if (blkcg)
-		css_get(&blkcg->css);
-	else
-		blkcg = css_to_blkcg(blkcg_get_css());
+	if (!blkcg)
+		blkcg = css_to_blkcg(blkcg_css());
 
 	/* bypass blkg lookup and use @q->root_rl directly for root */
 	if (blkcg == &blkcg_root)
@@ -646,7 +603,8 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 	if (unlikely(!blkg))
 		goto root_rl;
 
-	blkg_get(blkg);
+	if (!blkg_try_get(blkg))
+		goto root_rl;
 	rcu_read_unlock();
 	return &blkg->rl;
 root_rl:
@@ -663,8 +621,6 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
  */
 static inline void blk_put_rl(struct request_list *rl)
 {
-	/* an additional ref is always taken for rl */
-	css_put(&rl->blkg->blkcg->css);
 	if (rl->blkg->blkcg != &blkcg_root)
 		blkg_put(rl->blkg);
 }
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 32c553556bbd..b8bcbdeb2eac 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -93,6 +93,8 @@ extern struct css_set init_css_set;
 
 bool css_has_online_children(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *css_from_id(int id, struct cgroup_subsys *ss);
+struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgroup,
+					 struct cgroup_subsys *ss);
 struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgroup,
 					     struct cgroup_subsys *ss);
 struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index aae10baf1902..48fb22e49467 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -492,7 +492,7 @@ static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
 }
 
 /**
- * cgroup_e_css - obtain a cgroup's effective css for the specified subsystem
+ * cgroup_e_css_by_mask - obtain a cgroup's effective css for the specified ss
  * @cgrp: the cgroup of interest
  * @ss: the subsystem of interest (%NULL returns @cgrp->self)
  *
@@ -501,8 +501,8 @@ static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
  * enabled.  If @ss is associated with the hierarchy @cgrp is on, this
  * function is guaranteed to return non-NULL css.
  */
-static struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
-						struct cgroup_subsys *ss)
+static struct cgroup_subsys_state *cgroup_e_css_by_mask(struct cgroup *cgrp,
+							struct cgroup_subsys *ss)
 {
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -522,6 +522,35 @@ static struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 	return cgroup_css(cgrp, ss);
 }
 
+/**
+ * cgroup_e_css - obtain a cgroup's effective css for the specified subsystem
+ * @cgrp: the cgroup of interest
+ * @ss: the subsystem of interest
+ *
+ * Find and get the effective css of @cgrp for @ss.  The effective css is
+ * defined as the matching css of the nearest ancestor including self which
+ * has @ss enabled.  If @ss is not mounted on the hierarchy @cgrp is on,
+ * the root css is returned, so this function always returns a valid css.
+ *
+ * The returned css is not guaranteed to be online, and therefore it is the
+ * callers responsiblity to tryget a reference for it.
+ */
+struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
+					 struct cgroup_subsys *ss)
+{
+	struct cgroup_subsys_state *css;
+
+	do {
+		css = cgroup_css(cgrp, ss);
+
+		if (css)
+			return css;
+		cgrp = cgroup_parent(cgrp);
+	} while (cgrp);
+
+	return init_css_set.subsys[ss->id];
+}
+
 /**
  * cgroup_get_e_css - get a cgroup's effective css for the specified subsystem
  * @cgrp: the cgroup of interest
@@ -604,10 +633,11 @@ EXPORT_SYMBOL_GPL(of_css);
  *
  * Should be called under cgroup_[tree_]mutex.
  */
-#define for_each_e_css(css, ssid, cgrp)					\
-	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT; (ssid)++)	\
-		if (!((css) = cgroup_e_css(cgrp, cgroup_subsys[(ssid)]))) \
-			;						\
+#define for_each_e_css(css, ssid, cgrp)					    \
+	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT; (ssid)++)	    \
+		if (!((css) = cgroup_e_css_by_mask(cgrp,		    \
+						   cgroup_subsys[(ssid)]))) \
+			;						    \
 		else
 
 /**
@@ -1006,7 +1036,7 @@ static struct css_set *find_existing_css_set(struct css_set *old_cset,
 			 * @ss is in this hierarchy, so we want the
 			 * effective css from @cgrp.
 			 */
-			template[i] = cgroup_e_css(cgrp, ss);
+			template[i] = cgroup_e_css_by_mask(cgrp, ss);
 		} else {
 			/*
 			 * @ss is not in this hierarchy, so we don't want
@@ -3019,7 +3049,7 @@ static int cgroup_apply_control(struct cgroup *cgrp)
 		return ret;
 
 	/*
-	 * At this point, cgroup_e_css() results reflect the new csses
+	 * At this point, cgroup_e_css_by_mask() results reflect the new csses
 	 * making the following cgroup_update_dfl_csses() properly update
 	 * css associations of all tasks in the subtree.
 	 */
-- 
2.17.1

