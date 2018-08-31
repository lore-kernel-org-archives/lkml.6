Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBFAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B19B2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4pGlUrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B19B2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeHaF7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:59:31 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:47055 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeHaF7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:30 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so4510424ywc.13;
        Thu, 30 Aug 2018 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tu/AriW7HdBy3hcsN7f/g+VUfGV9GCz/UgAHKU8KDmw=;
        b=L4pGlUrxrEzZMR8p1KPpJpEOBv6PlROFKL19Z+Co1NyRMzzYpT36JXKdJyhaLS6bO3
         GjOcIAShcjSmBMHCgcDOSkMrpO62nQJMShLwmrHQ7ouXVbbw6l0oIJzvPAE+gHQq/wkM
         Dn99dyAfJduPXusYjkX1zeusfVZNzAJcvK0t7a+35zhE6Iuo5/HbQvfkdtVeftf0N1ZW
         gWxWHleWSoXoyJuOxZf52ULtbNJmt+Mw+PqleW6lwhcVPszJwSjX/eBdythvLZkwFtsM
         Vo1jzvg3TjmGI6JgfmER06xvh8Z6BDFY2cVoK0WO0ehRxQYSILfhN0FzHvF139fmZXup
         eI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tu/AriW7HdBy3hcsN7f/g+VUfGV9GCz/UgAHKU8KDmw=;
        b=CG/tQIUNdo/1vbRW6takbqz3Z4pzjNKDmCsBtBsfjuBVwSrE5iUL0AmHvbp/hksYpH
         J0jO/HM3HTAxNWbx0r9VDreK1ak2GJu/uCemlEsBiynSacwca1iP6L/yrqpx1kNcOck5
         NHF2td0ugEX49IaHr9qpC2XY4n2NyKNz+djo5GiUlZUQFWIPPhiyPJzGDVvV4J1F4h+J
         fJSE68MEkZ3/UG0cyvomUoOU/8ODu0s8kLhvIANXX84uABIjCBrllTUp0UAg38G14vvw
         FoURL+u6rZbkuGxxTny7KV8nErU2C3cpimTk8ttvPP1HEWsvwTa40QJ40T+XUlgolBAF
         eIwQ==
X-Gm-Message-State: APzg51BQgQLOZcUkeXDmDqhjYe69via8kZo2vZCLMrTLbJJrxN2Bkf6A
        cxEoDs8uEvPwDJGV5d3df4uddj8mAw8=
X-Google-Smtp-Source: ANB0VdZ7bUqWT+6ztM8v88xQtbpUyudcSJ1Wfs5NqK55EvOnKSrxzSSEg79wfC3FVOyaV4z1G0ge0A==
X-Received: by 2002:a0d:d48b:: with SMTP id w133-v6mr7595156ywd.374.1535680467225;
        Thu, 30 Aug 2018 18:54:27 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:26 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 13/15] blkcg: change blkg reference counting to use percpu_ref
Date:   Thu, 30 Aug 2018 21:53:54 -0400
Message-Id: <20180831015356.69796-14-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Now that every bio is associated with a blkg, this puts the use of
blkg_get, blkg_try_get, and blkg_put on the hot path. This switches over
the refcnt in blkg to use percpu_ref.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 block/blk-cgroup.c         | 56 +++++++++++++++++++++-----------------
 include/linux/blk-cgroup.h | 14 +++-------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index f678cd555814..bbea4b44bd8f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -84,6 +84,30 @@ static void blkg_free(struct blkcg_gq *blkg)
 	kfree(blkg);
 }
 
+/*
+ * A group is RCU protected, but having an rcu lock does not mean that one
+ * can access all the fields of blkg and assume these are valid.  For
+ * example, don't try to follow throtl_data and request queue links.
+ *
+ * Having a reference to blkg under an rcu allows accesses to only values
+ * local to groups like group stats and group rate limits.
+ */
+static void __blkg_release(struct percpu_ref *ref)
+{
+	struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
+
+	percpu_ref_exit(&blkg->refcnt);
+
+	/* release the blkcg and parent blkg refs this blkg has been holding */
+	css_put(&blkg->blkcg->css);
+	if (blkg->parent)
+		blkg_put(blkg->parent);
+
+	wb_congested_put(blkg->wb_congested);
+
+	blkg_free(blkg);
+}
+
 /**
  * blkg_alloc - allocate a blkg
  * @blkcg: block cgroup the new blkg is associated with
@@ -110,7 +134,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
-	atomic_set(&blkg->refcnt, 1);
 
 	/* root blkg uses @q->root_rl, init rl only for !root blkgs */
 	if (blkcg != &blkcg_root) {
@@ -217,6 +240,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		blkg_get(blkg->parent);
 	}
 
+	ret = percpu_ref_init(&blkg->refcnt, __blkg_release, 0, GFP_KERNEL);
+	if (ret)
+		goto err_cancel_ref;
+
 	/* invoke per-policy init */
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -249,6 +276,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
+err_cancel_ref:
+	percpu_ref_exit(&blkg->refcnt);
 err_put_congested:
 	wb_congested_put(wb_congested);
 err_put_css:
@@ -378,7 +407,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	 * Put the reference taken at the time of creation so that when all
 	 * queues are gone, group can be destroyed.
 	 */
-	blkg_put(blkg);
+	percpu_ref_kill(&blkg->refcnt);
 }
 
 /**
@@ -405,29 +434,6 @@ static void blkg_destroy_all(struct request_queue *q)
 	q->root_rl.blkg = NULL;
 }
 
-/*
- * A group is RCU protected, but having an rcu lock does not mean that one
- * can access all the fields of blkg and assume these are valid.  For
- * example, don't try to follow throtl_data and request queue links.
- *
- * Having a reference to blkg under an rcu allows accesses to only values
- * local to groups like group stats and group rate limits.
- */
-void __blkg_release_rcu(struct rcu_head *rcu_head)
-{
-	struct blkcg_gq *blkg = container_of(rcu_head, struct blkcg_gq, rcu_head);
-
-	/* release the blkcg and parent blkg refs this blkg has been holding */
-	css_put(&blkg->blkcg->css);
-	if (blkg->parent)
-		blkg_put(blkg->parent);
-
-	wb_congested_put(blkg->wb_congested);
-
-	blkg_free(blkg);
-}
-EXPORT_SYMBOL_GPL(__blkg_release_rcu);
-
 /*
  * The next function used by blk_queue_for_each_rl().  It's a bit tricky
  * because the root blkg uses @q->root_rl instead of its own rl.
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 97cb82029b18..b60d063fb0d7 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -126,7 +126,7 @@ struct blkcg_gq {
 	struct request_list		rl;
 
 	/* reference count */
-	atomic_t			refcnt;
+	struct percpu_ref		refcnt;
 
 	/* is this blkg online? protected by both blkcg and q locks */
 	bool				online;
@@ -455,8 +455,7 @@ static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
  */
 static inline void blkg_get(struct blkcg_gq *blkg)
 {
-	WARN_ON_ONCE(atomic_read(&blkg->refcnt) <= 0);
-	atomic_inc(&blkg->refcnt);
+	percpu_ref_get(&blkg->refcnt);
 }
 
 /**
@@ -468,23 +467,18 @@ static inline void blkg_get(struct blkcg_gq *blkg)
  */
 static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
 {
-	if (atomic_inc_not_zero(&blkg->refcnt))
+	if (percpu_ref_tryget(&blkg->refcnt))
 		return blkg;
 	return NULL;
 }
 
-
-void __blkg_release_rcu(struct rcu_head *rcu);
-
 /**
  * blkg_put - put a blkg reference
  * @blkg: blkg to put
  */
 static inline void blkg_put(struct blkcg_gq *blkg)
 {
-	WARN_ON_ONCE(atomic_read(&blkg->refcnt) <= 0);
-	if (atomic_dec_and_test(&blkg->refcnt))
-		call_rcu(&blkg->rcu_head, __blkg_release_rcu);
+	percpu_ref_put(&blkg->refcnt);
 }
 
 /**
-- 
2.17.1

