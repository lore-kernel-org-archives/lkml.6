Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62454C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E51D2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZuVkyCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E51D2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIAAch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:32:37 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36669 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeIAAcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:32:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id w202-v6so5504365yww.3;
        Fri, 31 Aug 2018 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4ycn/g7fw8SqfXjt7f6eHXQQdDKhRrTOaowx1xDnWeg=;
        b=bZuVkyCU1I70NNU/Nt6qA+o76T3OmFM2XGSQlTC/lPJT7C5jA/ts+UF53fAXi4g3tG
         0Q2vQwCwAOE53QDwEOSFpaV0duuAdctBWbjH9Z+cZK5/PkbO2nqkAnO2Zz5Hj6REO2B2
         Q771+5202p1QLs/shU8sZyELGxXPSy33lvsMWYvYk9LLDCwyJdcJDjgR432TelMGTm4n
         2wcf8pmAJUalwtdh61M77DtcLaXCGL0/saDQ++CaWXD67LXH+uu58ycs24LQgz+/5fEy
         1D3UR5eGeoKR8zwFnozt+gSTc0I6HMXMVho2482Fx0l6F8WBILRUmnmUpUJUODnwdPfn
         pG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4ycn/g7fw8SqfXjt7f6eHXQQdDKhRrTOaowx1xDnWeg=;
        b=BoA2xCGsil8YwmvnYgetz0IuLSFxemh0G2J+nYQDjVLeSCaGVBdraI39HmC/a79wwb
         2FnYd6hEZBHSHTo24vdixwmFYib5cY+GQReA8qGA0/nQ+KUFhXhd9EP2jNoClKoZ+MlZ
         +vitm/qRKJOGgWKIaq+r737VIv1WXsei0VkPsCGUmkWAoGzMB0vwEB4Fk693PrFASH0d
         Eykly9EfTnXMxPMWcKgzuu7C1GyOwJY0jSPGv/KOSLWGZBl58cx4BTYb5jadw+KK/VRq
         2HmAhTF2WNkXMJi8Mtxtizp8AGG9MRQpYaG9B4iQQOynJW17fhMWYji8uVJiUt/UAGhy
         UAgA==
X-Gm-Message-State: APzg51BEhgsOZJl9rHEurOGNfBd9NF/zGq2oyOjmBnAq0S1NUzf88XXF
        cF+Ojogbk36jBQ3MyLHba5o=
X-Google-Smtp-Source: ANB0VdY+INE7johEGMkgFOBITRvMMUq2y/hHmr0PxjzoXJtN4liPNWMZ/bvDc1K2PXwkRFnyuvGaFw==
X-Received: by 2002:a81:1151:: with SMTP id 78-v6mr9772760ywr.138.1535747009349;
        Fri, 31 Aug 2018 13:23:29 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u8-v6sm3978961ywl.59.2018.08.31.13.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:23:28 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 3/3] blkcg: use tryget logic when associating a blkg with a bio
Date:   Fri, 31 Aug 2018 16:22:44 -0400
Message-Id: <20180831202244.21678-4-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831202244.21678-1-dennisszhou@gmail.com>
References: <20180831202244.21678-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

There is a very small change a bio gets caught up in a really
unfortunate race between a task migration, cgroup exiting, and itself
trying to associate with a blkg. This is due to css offlining being
performed after the css->refcnt is killed which triggers removal of
blkgs that reach their blkg->refcnt of 0.

To avoid this, association with a blkg should use tryget and fallback to
using the root_blkg.

v2:
 - In blk-throttle, be explicit that we only associate with the
   root_blkg if tryget failed.

Fixes: 08e18eab0c579 ("block: add bi_blkg to the bio for cgroups")
Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c          | 3 ++-
 block/blk-throttle.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 04969b392c72..4473ccd22987 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1987,7 +1987,8 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
 	if (unlikely(bio->bi_blkg))
 		return -EBUSY;
-	blkg_get(blkg);
+	if (!blkg_try_get(blkg))
+		return -ENODEV;
 	bio->bi_blkg = blkg;
 	return 0;
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a3eede00d302..01d0620a4e4a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2129,8 +2129,9 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	if (bio->bi_css)
-		bio_associate_blkg(bio, tg_to_blkg(tg));
+	/* fallback to root_blkg if we fail to get a blkg ref */
+	if (bio->bi_css && (bio_associate_blkg(bio, tg_to_blkg(tg)) == -ENODEV))
+		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 #endif
 }
-- 
2.17.1

