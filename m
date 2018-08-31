Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE119C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988C12083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHIUDDO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988C12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeHaF7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:59:23 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44345 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeHaF7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:22 -0400
Received: by mail-yb1-f193.google.com with SMTP id l16-v6so330501ybk.11;
        Thu, 30 Aug 2018 18:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V/nPLJiLoMbwxwUN+SeDjrPjMrJFtIi3YKNpVCr/rfI=;
        b=cHIUDDO7zpJyjduUj1AwohQqhchaeZcF5rHzrvC830EPVE0vyg+4cTpVyh4a4QtOpU
         +G9wWJT7qq6cToApALaQAi5T6bf1NbGO24PCuieqXgOz2/YsonS49UPFUl1UdubPctmx
         F7rY9id1fp/KHKAJ8Tz8JTc+66obEHPfA0q+C6PiT0/7FlWtnXEtToIU4PCwJSkb4CLT
         JUd+dM0bMrpjsOxGVs3MmiX9hfP6yeltlF/Vs+//MI2Onv+Ly3QKp2V5Fy5v8ul5qVPM
         q4L4s3/h27gsLS0zx4y2ev2/+80AIbpNemaARAo3pBIWbTfe7+ABErERcJYDvMngGfrv
         ALOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V/nPLJiLoMbwxwUN+SeDjrPjMrJFtIi3YKNpVCr/rfI=;
        b=NiXroOqKkgMAbd0Wofn3BkGOQ0977VwIhJ6BLqXsbziVObMc1hm10zZZ12SqRofn5/
         6wHwQn6KBeg1vKmAGa09H+vDIN3xZgaQ7Wa6TdRnVIRp8rzpBdYId/DY+kIUs9nui2Ta
         iIXP2mYmscyZIMu2ek+wMoaWwXGkeh4d6L/D1Eb68/u+YLkDhSYlquf/BB6k8EVT9jFN
         cIHA0wajs+8RXtcoYpi9XjhQVWI4up3T9aMniV64SrahO/kccPF93c4B+9f5I2EVx2u6
         flSN2+OB1u6/pOSo+P/vshB76qMTJKc23pxql78HsWSz5oGtEQLvu+Z1rSYE5yZUne8V
         9HSQ==
X-Gm-Message-State: APzg51BQ3l3PNBctQglkFxhVJa4wJmgiLXCUDy/ipVvedhKZ8MTGXnXU
        GEx9jRolQ2x/EqdL5VKHuyg=
X-Google-Smtp-Source: ANB0Vda3dIa2nQlBs/oG8+sRC7aaZ2qqZNVrEidS0io+tqU3QGrL33K0QKG7fhBse0uwNvmKB+eqDw==
X-Received: by 2002:a25:23c3:: with SMTP id j186-v6mr832463ybj.259.1535680459994;
        Thu, 30 Aug 2018 18:54:19 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:19 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 05/15] blkcg: update blkg_lookup_create to do locking
Date:   Thu, 30 Aug 2018 21:53:46 -0400
Message-Id: <20180831015356.69796-6-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

To know when to create a blkg, the general pattern is to do a
blkg_lookup and if that fails, lock and then do a lookup again and if
that fails finally create. It doesn't make much sense for everyone who
wants to do creation to write this themselves.

This changes blkg_lookup_create to do locking and implement this
pattern. The old blkg_lookup_create is renamed to __blkg_lookup_create.
If a call site wants to do its own error handling or already owns the
queue lock, they can use __blkg_lookup_create.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 block/blk-cgroup.c         | 31 ++++++++++++++++++++++++++++---
 block/blk-iolatency.c      |  2 +-
 include/linux/blk-cgroup.h |  4 +++-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d7114308a480..f678cd555814 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -259,7 +259,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 }
 
 /**
- * blkg_lookup_create - lookup blkg, try to create one if not there
+ * __blkg_lookup_create - lookup blkg, try to create one if not there
  * @blkcg: blkcg of interest
  * @q: request_queue of interest
  *
@@ -272,8 +272,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
  * value on error.  If @q is dead, returns ERR_PTR(-EINVAL).  If @q is not
  * dead and bypassing, returns ERR_PTR(-EBUSY).
  */
-struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-				    struct request_queue *q)
+struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
+				      struct request_queue *q)
 {
 	struct blkcg_gq *blkg;
 
@@ -310,6 +310,31 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	}
 }
 
+/**
+ * blkg_lookup_create - find or create a blkg
+ * @blkcg: target block cgroup
+ * @q: target request_queue
+ *
+ * This looks up or creates the blkg representing the unique pair
+ * of the blkcg and the request_queue.
+ */
+struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
+				    struct request_queue *q)
+{
+	struct blkcg_gq *blkg = blkg_lookup(blkcg, q);
+	unsigned long flags;
+
+	if (unlikely(!blkg)) {
+		spin_lock_irqsave(q->queue_lock, flags);
+
+		blkg = __blkg_lookup_create(blkcg, q);
+
+		spin_unlock_irqrestore(q->queue_lock, flags);
+	}
+
+	return blkg;
+}
+
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg = blkg->blkcg;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 62fdd9002c29..22b2ff0440cc 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -410,7 +410,7 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
 	if (unlikely(!blkg)) {
 		if (!lock)
 			spin_lock_irq(q->queue_lock);
-		blkg = blkg_lookup_create(blkcg, q);
+		blkg = __blkg_lookup_create(blkcg, q);
 		if (IS_ERR(blkg))
 			blkg = NULL;
 		if (!lock)
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index d3cafb1eda48..ea2dd6e6baf2 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -184,6 +184,8 @@ extern struct cgroup_subsys_state * const blkcg_root_css;
 
 struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 				      struct request_queue *q, bool update_hint);
+struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
+				      struct request_queue *q);
 struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 				    struct request_queue *q);
 int blkcg_init_queue(struct request_queue *q);
@@ -835,7 +837,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
 		spin_lock_irq(q->queue_lock);
-		blkg = blkg_lookup_create(blkcg, q);
+		blkg = __blkg_lookup_create(blkcg, q);
 		if (IS_ERR(blkg))
 			blkg = NULL;
 		spin_unlock_irq(q->queue_lock);
-- 
2.17.1

