Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211FAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69E020841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtudko1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69E020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeIAAce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:32:34 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37683 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeIAAce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:32:34 -0400
Received: by mail-yw1-f66.google.com with SMTP id x83-v6so5500335ywd.4;
        Fri, 31 Aug 2018 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TO0jmspUoRjVVfIoVYshEwAx1ch9EaHAEw+E1Q58OTI=;
        b=dtudko1Nmh2H2c1PM8ht7LcHMmOxHgOtoWZA9s3pa8NiAK17tl61OBtVD8JeG2xxXv
         r4OYLKTby9VlyfiJMSnpA1M5V2vpYdaZJ7BPhAN7dvOgi17ow3RrMhnhnrjMWIUsjI/+
         94vxNB3HL6HMP508xnTTLBKF/45Yk7/v8iaurUpR0gqwJRZ3qypQjRrajZhKz13hyMAn
         hvSz/ymXZvZ4S4MYPs4U5KVfx3LhsnrDsNXGvFp5FYaC72UFARdErT5I0SmSbGUchmwU
         TeVHLYYYJD3eyp4eg0S7vB8XhSWJiGw7FyNVydKfrmFbtq8V9l85XEOGPKPV5PRzGuzN
         iPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TO0jmspUoRjVVfIoVYshEwAx1ch9EaHAEw+E1Q58OTI=;
        b=HpxMF/FJytXdoNwfQamsPkxmqCvSolspzerSyh9K1RI39Cj3+DS1VSC0tWHsQgJNgb
         TnjI5DMbBqvB+FloCAL6xhM+jJ19Qq9F68Me8NZqk89YjReZqevk8RhJV7dDHcuWT1iM
         sfzbogim75jBQHalI+3OKgVlOKf9Q+a6VD+rFr9zDCYYnkRWAi0FRLiqLkjhVasWtXH/
         h98n8Q6ADgOEvpAVE5k20toFsYg9wcE+4KC4cEXXsQgOJ91Q/XtYt0lwZbN8Du+CMQfN
         yRpToGwgqB1H2+C68H2XOAYthThp/akydbi/TxW/EEcB1fSN3HEOq2esB6wGVEi5gLyC
         ql3g==
X-Gm-Message-State: APzg51BpWZDojDcog0ZBy72vpB4C1+YY9Fcl4L1SEsiJUWPn6QFPjjYR
        IPBsqCl4TLHC1bdkcDCZFg0=
X-Google-Smtp-Source: ANB0VdbI2Dfh767lXZZZ9vXbTBIEqEyx/B+j8rjnLcOvUI3lM/g5fq6YlktUiXZ4RQE1MgAuiUfr9Q==
X-Received: by 2002:a0d:ea0a:: with SMTP id t10-v6mr9701201ywe.60.1535747007381;
        Fri, 31 Aug 2018 13:23:27 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u8-v6sm3978961ywl.59.2018.08.31.13.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:23:26 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 1/3] Revert "blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()"
Date:   Fri, 31 Aug 2018 16:22:42 -0400
Message-Id: <20180831202244.21678-2-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831202244.21678-1-dennisszhou@gmail.com>
References: <20180831202244.21678-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

This reverts commit 4c6994806f708559c2812b73501406e21ae5dcd0.

Destroying blkgs is tricky because of the nature of the relationship. A
blkg should go away when either a blkcg or a request_queue goes away.
However, blkg's pin the blkcg to ensure they remain valid. To break this
cycle, when a blkcg is offlined, blkgs put back their css ref. This
eventually lets css_free() get called which frees the blkcg.

The above commit (4c6994806f70) breaks this order of events by trying to
destroy blkgs in css_free(). As the blkgs still hold references to the
blkcg, css_free() is never called.

The race between blkcg_bio_issue_check() and cgroup_rmdir() will be
addressed in the following patch by delaying destruction of a blkg until
all writeback associated with the blkcg has been finished.

Fixes: 4c6994806f70 ("blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()")
Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c         | 78 ++++++++------------------------------
 include/linux/blk-cgroup.h |  1 -
 2 files changed, 16 insertions(+), 63 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 694595b29b8f..2998e4f095d1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -310,28 +310,11 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	}
 }
 
-static void blkg_pd_offline(struct blkcg_gq *blkg)
-{
-	int i;
-
-	lockdep_assert_held(blkg->q->queue_lock);
-	lockdep_assert_held(&blkg->blkcg->lock);
-
-	for (i = 0; i < BLKCG_MAX_POLS; i++) {
-		struct blkcg_policy *pol = blkcg_policy[i];
-
-		if (blkg->pd[i] && !blkg->pd[i]->offline &&
-		    pol->pd_offline_fn) {
-			pol->pd_offline_fn(blkg->pd[i]);
-			blkg->pd[i]->offline = true;
-		}
-	}
-}
-
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg = blkg->blkcg;
 	struct blkcg_gq *parent = blkg->parent;
+	int i;
 
 	lockdep_assert_held(blkg->q->queue_lock);
 	lockdep_assert_held(&blkcg->lock);
@@ -340,6 +323,13 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	WARN_ON_ONCE(list_empty(&blkg->q_node));
 	WARN_ON_ONCE(hlist_unhashed(&blkg->blkcg_node));
 
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+
+		if (blkg->pd[i] && pol->pd_offline_fn)
+			pol->pd_offline_fn(blkg->pd[i]);
+	}
+
 	if (parent) {
 		blkg_rwstat_add_aux(&parent->stat_bytes, &blkg->stat_bytes);
 		blkg_rwstat_add_aux(&parent->stat_ios, &blkg->stat_ios);
@@ -382,7 +372,6 @@ static void blkg_destroy_all(struct request_queue *q)
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
-		blkg_pd_offline(blkg);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
 	}
@@ -1058,54 +1047,21 @@ static struct cftype blkcg_legacy_files[] = {
  * @css: css of interest
  *
  * This function is called when @css is about to go away and responsible
- * for offlining all blkgs pd and killing all wbs associated with @css.
- * blkgs pd offline should be done while holding both q and blkcg locks.
- * As blkcg lock is nested inside q lock, this function performs reverse
- * double lock dancing.
+ * for shooting down all blkgs associated with @css.  blkgs should be
+ * removed while holding both q and blkcg locks.  As blkcg lock is nested
+ * inside q lock, this function performs reverse double lock dancing.
  *
  * This is the blkcg counterpart of ioc_release_fn().
  */
 static void blkcg_css_offline(struct cgroup_subsys_state *css)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
-	struct blkcg_gq *blkg;
 
 	spin_lock_irq(&blkcg->lock);
 
-	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		struct request_queue *q = blkg->q;
-
-		if (spin_trylock(q->queue_lock)) {
-			blkg_pd_offline(blkg);
-			spin_unlock(q->queue_lock);
-		} else {
-			spin_unlock_irq(&blkcg->lock);
-			cpu_relax();
-			spin_lock_irq(&blkcg->lock);
-		}
-	}
-
-	spin_unlock_irq(&blkcg->lock);
-
-	wb_blkcg_offline(blkcg);
-}
-
-/**
- * blkcg_destroy_all_blkgs - destroy all blkgs associated with a blkcg
- * @blkcg: blkcg of interest
- *
- * This function is called when blkcg css is about to free and responsible for
- * destroying all blkgs associated with @blkcg.
- * blkgs should be removed while holding both q and blkcg locks. As blkcg lock
- * is nested inside q lock, this function performs reverse double lock dancing.
- */
-static void blkcg_destroy_all_blkgs(struct blkcg *blkcg)
-{
-	spin_lock_irq(&blkcg->lock);
 	while (!hlist_empty(&blkcg->blkg_list)) {
 		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
-						    struct blkcg_gq,
-						    blkcg_node);
+						struct blkcg_gq, blkcg_node);
 		struct request_queue *q = blkg->q;
 
 		if (spin_trylock(q->queue_lock)) {
@@ -1117,7 +1073,10 @@ static void blkcg_destroy_all_blkgs(struct blkcg *blkcg)
 			spin_lock_irq(&blkcg->lock);
 		}
 	}
+
 	spin_unlock_irq(&blkcg->lock);
+
+	wb_blkcg_offline(blkcg);
 }
 
 static void blkcg_css_free(struct cgroup_subsys_state *css)
@@ -1125,8 +1084,6 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
 	struct blkcg *blkcg = css_to_blkcg(css);
 	int i;
 
-	blkcg_destroy_all_blkgs(blkcg);
-
 	mutex_lock(&blkcg_pol_mutex);
 
 	list_del(&blkcg->all_blkcgs_node);
@@ -1480,11 +1437,8 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		if (blkg->pd[pol->plid]) {
-			if (!blkg->pd[pol->plid]->offline &&
-			    pol->pd_offline_fn) {
+			if (pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
-				blkg->pd[pol->plid]->offline = true;
-			}
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
 		}
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 34aec30e06c7..1615cdd4c797 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -89,7 +89,6 @@ struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
-	bool				offline;
 };
 
 /*
-- 
2.17.1

