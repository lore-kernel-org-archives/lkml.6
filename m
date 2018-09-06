Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CFDC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0220659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLqHcHrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB0220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeIGBs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:48:29 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43937 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbeIGBs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:48:27 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so4629093ywb.10;
        Thu, 06 Sep 2018 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XW4vNaFCwmCNZ3mlNtC+z7gUlG1ZEWN8xOgaeWA3Wtw=;
        b=gLqHcHrk2pSq4TPjIHiQDL0xuVr8CrcOdMI1lx424OacZ7BG09ALACoa/b+BVpS2mR
         iw4yQZMRkN209wAssPYEdP9ZpyuzIjLRID2suqzjyqbWRfIDtIWcs+JoKd1rOAyOQjH/
         8uBlsK2+IbuaXL9LTRDC2l1GFV28vprFekVhOO5e/kJkgjUyeBeqQw1cxhSjdqxG4zfy
         7Byi4ZwUI4sIn5B8J6tTwf8r14DeQdrOeSahcXKmkstEpZkNQn2FCbAGPbuOeQAWthIC
         uzerxjqSMU2SnPAroov58fHn6LG0Y9q4WpNS8ensu1qELlPlo4lDz1N/48ykNn9zQIlB
         cYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XW4vNaFCwmCNZ3mlNtC+z7gUlG1ZEWN8xOgaeWA3Wtw=;
        b=KBhP+IUrwdneO9yBoSI3aj8MQ+TvxXyZE0+DK1ev/IZVxRFmigJUFy7Clfv076K90X
         Ynbncy9U2HXfXfrCUbAJ6cxsZur03AoOpV8vDiyovI4FnyNV+sqdBpkDF0xow7PYCsMh
         NUyQC/IEE1GWvuTwFq5O3bv/QafR/1STz550PPHgpYzhnh1/YltEZ7SD3vOAOfFOyWOK
         qrUMFqThOShqAy4ODRKmSGbMVtReLX7j+Ph8iA+NwP4I5nXRvCEz37EDUbvU0mtvrT9X
         9gVZ5fj6jPnP1Aa2K1SvIpo+hlymyptaCX6FQxkBT4mmieX6ZvB2Qn737c+MpQQsricc
         5epg==
X-Gm-Message-State: APzg51BkcAJF7sCkiFb2w1aYOfbpp02r7/wRSR83lcAhoBo4PUWGyZzs
        2UI1fgwG+l0XzdXvudXGrZc=
X-Google-Smtp-Source: ANB0VdbzxK9CViD+aXKx7iCKX4jZD5nHcNOLPmIt2OM56jl2ftRrLQtIrwTsOqohA6MSINImKIrEIw==
X-Received: by 2002:a81:af05:: with SMTP id n5-v6mr2575849ywh.481.1536268269504;
        Thu, 06 Sep 2018 14:11:09 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u67-v6sm2032802ywa.56.2018.09.06.14.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:11:08 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 10/12] blkcg: cleanup and make blk_get_rl use blkg_lookup_create
Date:   Thu,  6 Sep 2018 17:10:43 -0400
Message-Id: <20180906211045.29055-11-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180906211045.29055-1-dennisszhou@gmail.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

blk_get_rl is responsible for identifying which request_list a request
should be allocated to. Try get logic was added earlier, but
semantically the logic was not changed.

This patch makes better use of the bio already having a reference to the
blkg in the hot path. The cold path uses a better fallback of
blkg_lookup_create rather than just blkg_lookup and then falling back to
the q->root_rl. If lookup_create fails with anything but -ENODEV, it
falls back to q->root_rl.

A clarifying comment is added to explain why q->root_rl is used rather
than the root blkg's rl.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/blk-cgroup.h | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 2951ea3541b1..7964e7fc6521 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -586,28 +586,36 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 
 	rcu_read_lock();
 
-	blkcg = bio_blkcg(bio);
-	if (!blkcg)
-		blkcg = css_to_blkcg(blkcg_css());
+	if (bio && bio->bi_blkg) {
+		blkcg = bio->bi_blkg->blkcg;
+		if (blkcg == &blkcg_root)
+			goto rl_use_root;
+
+		blkg_get(bio->bi_blkg);
+		rcu_read_unlock();
+		return &bio->bi_blkg->rl;
+	}
 
-	/* bypass blkg lookup and use @q->root_rl directly for root */
-	if (blkcg == &blkcg_root)
-		goto root_rl;
+	blkcg = css_to_blkcg(blkcg_css());
+	if (blkg->blkcg == &blkcg_root)
+		goto rl_use_root;
 
-	/*
-	 * Try to use blkg->rl.  blkg lookup may fail under memory pressure
-	 * or if either the blkcg or queue is going away.  Fall back to
-	 * root_rl in such cases.
-	 */
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg))
-		goto root_rl;
+		blkg = __blkg_lookup_create(blkcg, q);
 
 	if (!blkg_try_get(blkg))
-		goto root_rl;
+		goto rl_use_root;
+
 	rcu_read_unlock();
 	return &blkg->rl;
-root_rl:
+
+	/*
+	 * Each blkg has its own request_list, however, the root blkcg
+	 * uses the request_queue's root_rl.  This is to avoid most
+	 * overhead for the root blkcg.
+	 */
+rl_use_root:
 	rcu_read_unlock();
 	return &q->root_rl;
 }
-- 
2.17.1

