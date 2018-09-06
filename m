Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEDCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C32120659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tisRTJJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C32120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbeIGBth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:49:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38690 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeIGBsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:48:17 -0400
Received: by mail-yb1-f193.google.com with SMTP id e18-v6so4694777ybq.5;
        Thu, 06 Sep 2018 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ElWDl0f7yaVkieg8dsiiyfInoiRyXp3U8BvsQtSTbKs=;
        b=tisRTJJs/93AbzNxeq7Ak2SO6dKqyeOAdLDj4iU1p+9jLS6w40xlWxCzOeu+QQOjP+
         bk/nCf5vIK//2ynQAG0WtMJyTYA02u7Tv6jp3F8vJGz+SLo3Ojpju8jRDvxB+htuMIdd
         VYKiMWFX6cZfOwYLrrs/zokOqWAljBWvstbrHYgYGGN0qZwGmIv26/v2eSi9u4+LZhz7
         JMT1ChKynlzNRFcNeKsdrqL8Xtg3iw1wbA94d23JFr+zpNhAqYCnnsuoXjxHYaVztLRW
         mL0jb7P6hC7gybZsxhag1f2B+fWMOMEkUVU0vngSlTlS4OzqrOXCdcBXgcjilqJNIl4W
         blBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ElWDl0f7yaVkieg8dsiiyfInoiRyXp3U8BvsQtSTbKs=;
        b=ckCrunPxh1GBloavMA3Y/8GVIAVwx8eWhNQuhCvXZd3i4zs+tV54/oPFlmyrZyrqU7
         /Q5kgieE1hGvbvy/yNDkan3KOj+s5wJC0tYO1LpAv3Ewa8sh6lsWrSOtuuC21G+5LbT9
         oi2AmF8JLapZeRsSJ3yU6oJOvGpQ1Rtz2mtuKq0ESPSyfuepryog6CEcOR7U/gB4Q9JC
         6BB4Hj0sJIN1yiE4s/A7zrG3Br3C79y4lKlpzo+zs/gHwO14T+T0OCc6+PE4ZfjOTUuK
         tx7WrbcLHD+4lTnQ/TBTd72aJVX+n09JXjaJWvJALQfXZ8n/olqN3Mggjc1AY1smeIwi
         pnsg==
X-Gm-Message-State: APzg51BJA3VeAQL1k5c0wmW7JhxeE2FOhjGUzMeWxSz2lzX4PtmauNQX
        iPttjdbYLcHZ4jU4tO66sKI=
X-Google-Smtp-Source: ANB0VdY8pMj4N5nma2VtCcIuMIcfXpTpMdxT0K94n39gO8i0HrVBmFMcXbzZsAqALhMBsyA7dsPo1g==
X-Received: by 2002:a25:3b96:: with SMTP id i144-v6mr2564653yba.366.1536268259560;
        Thu, 06 Sep 2018 14:10:59 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u67-v6sm2032802ywa.56.2018.09.06.14.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:10:58 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 02/12] blkcg: update blkg_lookup_create to do locking
Date:   Thu,  6 Sep 2018 17:10:35 -0400
Message-Id: <20180906211045.29055-3-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180906211045.29055-1-dennisszhou@gmail.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
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
queue lock, they can use __blkg_lookup_create. This will be used in
upcoming patches.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c         | 31 ++++++++++++++++++++++++++++---
 block/blk-iolatency.c      |  2 +-
 include/linux/blk-cgroup.h |  4 +++-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c19f9078da1e..cd0d97bed83d 100644
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
index 24067a1f8b36..cc0f238530f6 100644
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
@@ -897,7 +899,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
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

