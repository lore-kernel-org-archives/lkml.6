Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE142C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679FF20846
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUDpTMZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679FF20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeHaF72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:59:28 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41188 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeHaF71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:27 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so4522263ywg.8;
        Thu, 30 Aug 2018 18:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C768bFizqKMqaoT2KhKg9lvapJ3iYCGQF+XLB4jeNa8=;
        b=jUDpTMZ5F3Q1BXk+UsR72TiydHElvQ8EBVpo36nFUp1dbtCB+iAyYr4X0dzAL0MBDR
         YiUx96+5AwiWZN8XkWt2jt5QKI2HTN9aSONFuxOvC2Vo5Vt7vjM75jJd8B9n8DE5VpCB
         O7qxjv9fs2fVXLsMvubZvSymtSo1SWkbUrjSZAOqLdJi7TUbElciFyPvcnnRzu7AKtxd
         2HmMcgXFCNnQSO+qbhDQaP+rdg6K+8E3uRnT4T+QOwgJFSmhxmauNzuOKb3nmOBBVY/s
         S+4QU6i0r2ptIKfKn2Jk7oauFjfuAOUXiF2FyoU9skuipOG2njg7z/vrKL6xR0acrIn+
         Celg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C768bFizqKMqaoT2KhKg9lvapJ3iYCGQF+XLB4jeNa8=;
        b=VFpkOCNVgbFRKKTcaj1haIKRgbYdnLQfxibWZJx8KcwMXMNxpOLvVDK2mj0IiNAIx2
         LLZbITx1EqZVg+Z5QrqyyibLV8Yk/3MsBHJ8sgWINHuWpqQN4nZfXnYvDgCmKarU2JoB
         qp61svQxDF+bPw08PmY623ugf4kV6vWCHKDHpMtfqx7t4QsvUhqlGwYe6+WmBNu7RAB/
         Yml0XsuV5RtI5Zn+OgYGuqHSH8VwJNIExuab5vNYUKiyU9HJGR8oxF/MNz+uLBTaXFBv
         h0IUn9SfPV/MwnsDm1xayLwvice4ABLyjUotu4jiKloqg7bcSQ8B3tRQAXEgB1HrE02m
         aBmw==
X-Gm-Message-State: APzg51AhsvAJHbaKdQPwts4HnF5NRsv7mOBqQSgyr922xmnYLkIQ7Nbi
        MJZUYHKwYzcMiDTEzURKUuY=
X-Google-Smtp-Source: ANB0VdbdrWLbWdzTmaoG1REspK0g/n0zjtggCno6e/mjSKO31RuXgTufChQ/uuExaQsMPQAMW6mhZg==
X-Received: by 2002:a81:5b8b:: with SMTP id p133-v6mr7518686ywb.356.1535680465400;
        Thu, 30 Aug 2018 18:54:25 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:24 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 11/15] blkcg: remove additional reference to the css
Date:   Thu, 30 Aug 2018 21:53:52 -0400
Message-Id: <20180831015356.69796-12-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

The previous patch in this series removed carrying around a pointer to
the css in blkg. However, the blkg association logic still relied on
taking a reference on the css to ensure we wouldn't fail in getting a
reference for the blkg.

Here we remove the implicit dependency on the css and utilize tryget and
retry logic during association. This streamlines the three ways that
association can happen: generic, swap, writeback. They now share common
association logic with separate retry mechanisms for obtaining a copy of
the css.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 block/bio.c                | 89 +++++++++++++++++++++++++++-----------
 include/linux/blk-cgroup.h | 35 ++++-----------
 include/linux/cgroup.h     |  2 +
 kernel/cgroup/cgroup.c     |  4 +-
 4 files changed, 77 insertions(+), 53 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ec55ee810503..b792bffecce1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1949,18 +1949,42 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 	return 0;
 }
 
+/**
+ * __bio_associate_blkg_from_css - internal blkg association function
+ *
+ * This in the core association function that all association paths rely on.
+ * This handles -ENOMEM, but propagates -ENODEV to allow for separate retry
+ * scenarios.  This takes a reference on the blkg, which is released upon
+ * freeing of the bio.
+ */
 static int __bio_associate_blkg_from_css(struct bio *bio,
 					 struct cgroup_subsys_state *css)
 {
+	struct request_queue *q = bio->bi_disk->queue;
 	struct blkcg_gq *blkg;
+	int ret;
 
 	rcu_read_lock();
 
-	blkg = blkg_lookup_create(css_to_blkcg(css), bio->bi_disk->queue);
+	if (!css || !css->parent) {
+		blkg = q->root_blkg;
+	} else {
+		blkg = blkg_lookup_create(css_to_blkcg(css), q);
+
+		if (IS_ERR(blkg)) {
+			ret = PTR_ERR(blkg);
+			if (ret != -ENOMEM)
+				blkg = q->root_blkg;
+			else
+				goto afc_out;
+		}
+	}
 
-	rcu_read_unlock();
+	ret = bio_associate_blkg(bio, blkg);
 
-	return bio_associate_blkg(bio, blkg);
+afc_out:
+	rcu_read_unlock();
+	return ret;
 }
 
 /**
@@ -1969,14 +1993,18 @@ static int __bio_associate_blkg_from_css(struct bio *bio,
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
-	return __bio_associate_blkg_from_css(bio, css);
+	if (unlikely(bio->bi_blkg))
+		return -EBUSY;
+	/* there is no retry to get another css so fallback to the root_blkg */
+	if (__bio_associate_blkg_from_css(bio, css))
+		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
 
@@ -1987,22 +2015,35 @@ EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
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
+	while (true) {
+		css = cgroup_e_css(page->mem_cgroup->css.cgroup,
+				   &io_cgrp_subsys);
+
+		ret = __bio_associate_blkg_from_css(bio, css);
+		if (ret != -ENODEV)
+			break;
+		cpu_relax();
+	}
+
+	rcu_read_unlock();
+	return ret;
 }
 #endif /* CONFIG_MEMCG */
 
@@ -2012,12 +2053,12 @@ int bio_associate_blkg_from_page(struct bio *bio, struct page *page)
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
@@ -2026,19 +2067,19 @@ int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
 
 	rcu_read_lock();
 
-	blkcg = css_to_blkcg(blkcg_get_css());
+	while (true) {
+		css = blkcg_css();
 
-	if (!blkcg->css.parent) {
-		ret = bio_associate_blkg(bio, q->root_blkg);
-		goto assoc_out;
+		ret = __bio_associate_blkg_from_css(bio, css);
+		if (ret != -ENODEV)
+			break;
+		cpu_relax();
 	}
 
-	blkg = blkg_lookup_create(blkcg, q);
-	if (IS_ERR(blkg))
-		blkg = q->root_blkg;
+	/* explicitly fall back to root */
+	if (unlikely(!bio->bi_blkg))
+		bio_associate_blkg(bio, q->root_blkg);
 
-	ret = bio_associate_blkg(bio, blkg);
-assoc_out:
 	rcu_read_unlock();
 	return ret;
 }
@@ -2054,8 +2095,6 @@ void bio_disassociate_task(struct bio *bio)
 		bio->bi_ioc = NULL;
 	}
 	if (bio->bi_blkg) {
-		/* a ref is always taken on css */
-		css_put(&bio_blkcg(bio)->css);
 		blkg_put(bio->bi_blkg);
 		bio->bi_blkg = NULL;
 	}
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 3c66154709ed..3eed491e4daa 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -233,31 +233,18 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
 
 /**
- * blkcg_get_css - find and get a reference to the css
+ * blk_css - find the current css
  *
  * Find the css associated with either the kthread or the current task.
  */
-static inline struct cgroup_subsys_state *blkcg_get_css(void)
+static inline struct cgroup_subsys_state *blkcg_css(void)
 {
 	struct cgroup_subsys_state *css;
 
-	rcu_read_lock();
-
 	css = kthread_blkcg();
-	if (css) {
-		css_get(css);
-	} else {
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
+	if (css)
+		return css;
+	return task_css(current, io_cgrp_id);
 }
 
 static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
@@ -551,11 +538,8 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 	rcu_read_lock();
 
 	blkcg = bio_blkcg(bio);
-	if (blkcg) {
-		css_get(&blkcg->css);
-	} else {
-		blkcg = css_to_blkcg(blkcg_get_css());
-	}
+	if (!blkcg)
+		blkcg = css_to_blkcg(blkcg_css());
 
 	/* bypass blkg lookup and use @q->root_rl directly for root */
 	if (blkcg == &blkcg_root)
@@ -570,7 +554,8 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 	if (unlikely(!blkg))
 		goto root_rl;
 
-	blkg_get(blkg);
+	if (!blkg_try_get(blkg))
+		goto root_rl;
 	rcu_read_unlock();
 	return &blkg->rl;
 root_rl:
@@ -587,8 +572,6 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
  */
 static inline void blk_put_rl(struct request_list *rl)
 {
-	/* an additional ref is always taken for rl */
-	css_put(&rl->blkg->blkcg->css);
 	if (rl->blkg->blkcg != &blkcg_root)
 		blkg_put(rl->blkg);
 }
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c9fdf6f57913..0c4d56acfdca 100644
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
index 077370bf8964..d3fa4bdd7407 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -498,8 +498,8 @@ static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
  * enabled.  If @ss is associated with the hierarchy @cgrp is on, this
  * function is guaranteed to return non-NULL css.
  */
-static struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
-						struct cgroup_subsys *ss)
+struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
+					 struct cgroup_subsys *ss)
 {
 	lockdep_assert_held(&cgroup_mutex);
 
-- 
2.17.1

