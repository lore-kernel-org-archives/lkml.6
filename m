Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B14C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4892083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvuaj3y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4892083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeHaF7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:59:48 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44502 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeHaF7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:30 -0400
Received: by mail-yw1-f67.google.com with SMTP id l9-v6so4508239ywc.11;
        Thu, 30 Aug 2018 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jit6SOP1wxl/niVnzyIL+oa21o0jJ66/5PbbODOSPhw=;
        b=jvuaj3y63F1UhmCB4n3qpwUWx85ghl8Qp3rHbvaiZhV2MoaZ3n59hWfHxTPvMLBk2T
         Xs6Mctg8koET+QLUfFJvO0LH0y+wh8UYIkhMX4+0Zc8Flk9bnjsm0UadHWDZYLgl26Sh
         OybWJoB6WwH6HyZIjwtZn0S6zkrNZP5sV6bff655gS+Hr7ylwkp7lc9EziCXybz2LTEs
         JVX+Ay0IX0fK/3CBQt+1ayRKLkqCLO5zTV+V3QyOduPWW/4spBVC5xrCUvHs94hC6Dja
         9Si00l79UGljdNgtxy5dAf9+hU13qo49ofhj+CaDtNVu+lvwbl5nUnAkJ3skVVewI8CM
         TI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jit6SOP1wxl/niVnzyIL+oa21o0jJ66/5PbbODOSPhw=;
        b=crwzDpJpQa77gBcN/4w+RZYSTTRJIK1WVeGO3Ql1OdHvkMy0JB9vPwYSbMxFZu0rYo
         T+0AUlxex/SWOrIUijCA2QJCoBmimBTH2w7yfioUfxn4LZVfeEfrGwxqRVPu4tlqn3XP
         KeWRbrpnMQFUVeUpojSWDILgmnjCzg/PmHOd51Ut6YyG3KcMlsuIixr9yptN+qfFH5fP
         V1j7WtL8/scresQzw/uF8+xjq4rDHsuaGKixyHVmpB1vcDruaauwR/NpGjIC4UJlXbxB
         kLEDD7kWDFBWQkFb2hsonrtHVbZmW8LoZY9IbV+QdK/82Gwyw2xDb0boEpyMwejiG+T8
         bVyQ==
X-Gm-Message-State: APzg51Dh2HhZ1DqPZHFa7eqTdMAbnAxHB2ikfamqJ1+pjZKr1Ad7kp8W
        03UtiC8EuyfAHqa1QHEOKk0=
X-Google-Smtp-Source: ANB0VdagxC4XlnhQyJQXuwY6EVtHiAovMjmraJnIISv4asPJHOTmQ7DEUeubjoMC1SAd+yAcAWX6Iw==
X-Received: by 2002:a81:8402:: with SMTP id u2-v6mr7216607ywf.99.1535680468069;
        Thu, 30 Aug 2018 18:54:28 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:27 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 14/15] blkcg: rename blkg_try_get to blkg_tryget
Date:   Thu, 30 Aug 2018 21:53:55 -0400
Message-Id: <20180831015356.69796-15-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

blkg reference counting now uses percpu_ref rather than atomic_t. Let's
make this consistent with css_tryget. This renames blkg_try_get to
blkg_tryget and now returns a bool rather than the blkg or NULL.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 block/bio.c                |  2 +-
 block/blk-cgroup.c         |  3 +--
 block/blk-iolatency.c      |  2 +-
 include/linux/blk-cgroup.h | 10 ++++------
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b792bffecce1..a0b816811e7d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1943,7 +1943,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
 	if (unlikely(bio->bi_blkg))
 		return -EBUSY;
-	if (!blkg_try_get(blkg))
+	if (!blkg_tryget(blkg))
 		return -ENODEV;
 	bio->bi_blkg = blkg;
 	return 0;
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bbea4b44bd8f..1eaf097e38b0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1777,8 +1777,7 @@ void blkcg_maybe_throttle_current(void)
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
index b60d063fb0d7..0134cdd270b8 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -459,17 +459,15 @@ static inline void blkg_get(struct blkcg_gq *blkg)
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
@@ -560,7 +558,7 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 			}
 		}
 
-		if (blkg_try_get(blkg))
+		if (blkg_tryget(blkg))
 			break;
 		cpu_relax();
 	}
-- 
2.17.1

