Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A3C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0692A2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/nroMDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0692A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeIKXme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:42:34 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42509 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbeIKXmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:32 -0400
Received: by mail-yw1-f66.google.com with SMTP id n207-v6so9606480ywn.9;
        Tue, 11 Sep 2018 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t00huGWlCQMYRW7qCaQabcFxN7tdJkCV+CAUTXuBTX8=;
        b=a/nroMDzIaeWZrVAWHgkzg/D4eri6/NtzkrEjTak/uFrZpTKBXscexN5rewvhhabUs
         yLWEyQwZNQlTsoqlHPYqTzCdRftTp3MxZyPpu5T2nVcw8uVWvyBkV0vhMg06dGJGVkng
         oWazU7eAy37gNHFVFRQn2usO/kNxmK07tyurKxxvxBjDZHg90GhKhoon3Re+dTnjigk4
         70dbUwXNdjV+/YfwbMZHs23ami0vb72NL7sAFiUyaE3pUEFdoVGDinB/faSFi97zMav6
         NI44hUsrLdS+FACYwn76Nf0klus7P/8+Sohb9XaTkci0mmDSPkH2Wu2oDR456Qa6uwNh
         i66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t00huGWlCQMYRW7qCaQabcFxN7tdJkCV+CAUTXuBTX8=;
        b=ejXpcCyWK0SOiv20zK4Fl+rPQ4na/CkppKpuSa5B7cyRjooKEu6m0FLOzwWY6ol+lL
         14o0uTVCPvldyEDqF6fliasE+DNK4QAY+PdMpiDUL7ANEikYhHG91Ar1+/DyRLgsXCdq
         bCLdjIxDj2uGQ08LEnjeBAUWyrRzWPuO05scvAfLrCCkEWBsGKIrpHCAK0jqhl516gKM
         KW5eSrTabNu5bFVNshKdFJf6ncaJd3PCampgtHugG0M7S15FBcuDUi9yRhA4goRByBCO
         DfIgqzxyJphoCJurtwtiWBLxPPa28okFHSm/MmAswkCHVCYqFaSjBDyhY64P8HkU9X+Z
         W9CQ==
X-Gm-Message-State: APzg51CUDcShE8oG+phJBwHKwuW3jTBDFAkWYusia0m8pH717i2rY4Gg
        O7S374+g891QCL9RiCuZQEGW0yaEe+4=
X-Google-Smtp-Source: ANB0VdYhRWOAgvBQco6mE+/yPdP+qlqR6yZgfHqMfPwg0pprC8RYc47hWIH79IFrdZHHY+fbCC5+Qw==
X-Received: by 2002:a0d:d945:: with SMTP id b66-v6mr13123868ywe.493.1536691316507;
        Tue, 11 Sep 2018 11:41:56 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:55 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 11/12] blkcg: change blkg reference counting to use percpu_ref
Date:   Tue, 11 Sep 2018 14:41:36 -0400
Message-Id: <20180911184137.35897-12-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180911184137.35897-1-dennisszhou@gmail.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Now that every bio is associated with a blkg, this puts the use of
blkg_get, blkg_try_get, and blkg_put on the hot path. This switches over
the refcnt in blkg to use percpu_ref.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c         | 64 +++++++++++++++++++++++---------------
 include/linux/blk-cgroup.h | 15 +++------
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e9e3a955f61a..ab3676e1e15e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -84,6 +84,37 @@ static void blkg_free(struct blkcg_gq *blkg)
 	kfree(blkg);
 }
 
+static void __blkg_release(struct rcu_head *rcu)
+{
+	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
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
+/*
+ * A group is RCU protected, but having an rcu lock does not mean that one
+ * can access all the fields of blkg and assume these are valid.  For
+ * example, don't try to follow throtl_data and request queue links.
+ *
+ * Having a reference to blkg under an rcu allows accesses to only values
+ * local to groups like group stats and group rate limits.
+ */
+static void blkg_release(struct percpu_ref *ref)
+{
+	struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
+
+	call_rcu(&blkg->rcu_head, __blkg_release);
+}
+
 /**
  * blkg_alloc - allocate a blkg
  * @blkcg: block cgroup the new blkg is associated with
@@ -110,7 +141,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
-	atomic_set(&blkg->refcnt, 1);
 
 	/* root blkg uses @q->root_rl, init rl only for !root blkgs */
 	if (blkcg != &blkcg_root) {
@@ -217,6 +247,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		blkg_get(blkg->parent);
 	}
 
+	ret = percpu_ref_init(&blkg->refcnt, blkg_release, 0,
+			      GFP_NOWAIT | __GFP_NOWARN);
+	if (ret)
+		goto err_cancel_ref;
+
 	/* invoke per-policy init */
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -249,6 +284,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
+err_cancel_ref:
+	percpu_ref_exit(&blkg->refcnt);
 err_put_congested:
 	wb_congested_put(wb_congested);
 err_put_css:
@@ -387,7 +424,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	 * Put the reference taken at the time of creation so that when all
 	 * queues are gone, group can be destroyed.
 	 */
-	blkg_put(blkg);
+	percpu_ref_kill(&blkg->refcnt);
 }
 
 /**
@@ -414,29 +451,6 @@ static void blkg_destroy_all(struct request_queue *q)
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
index d2f7f1b00fcf..7ff5d8ba8c7a 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -126,7 +126,7 @@ struct blkcg_gq {
 	struct request_list		rl;
 
 	/* reference count */
-	atomic_t			refcnt;
+	struct percpu_ref		refcnt;
 
 	/* is this blkg online? protected by both blkcg and q locks */
 	bool				online;
@@ -490,8 +490,7 @@ static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
  */
 static inline void blkg_get(struct blkcg_gq *blkg)
 {
-	WARN_ON_ONCE(atomic_read(&blkg->refcnt) <= 0);
-	atomic_inc(&blkg->refcnt);
+	percpu_ref_get(&blkg->refcnt);
 }
 
 /**
@@ -503,7 +502,7 @@ static inline void blkg_get(struct blkcg_gq *blkg)
  */
 static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
 {
-	if (atomic_inc_not_zero(&blkg->refcnt))
+	if (percpu_ref_tryget(&blkg->refcnt))
 		return blkg;
 	return NULL;
 }
@@ -517,23 +516,19 @@ static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
  */
 static inline struct blkcg_gq *blkg_try_get_closest(struct blkcg_gq *blkg)
 {
-	while (!atomic_inc_not_zero(&blkg->refcnt))
+	while (!percpu_ref_tryget(&blkg->refcnt))
 		blkg = blkg->parent;
 
 	return blkg;
 }
 
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

