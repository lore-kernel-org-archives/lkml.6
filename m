Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDBEECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5CC20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+zy5r7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5CC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbeGWPOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:14:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45719 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388162AbeGWPOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:14:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so473518pgq.12;
        Mon, 23 Jul 2018 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RkQAA3E/9j5+VGD84stNgIqiheckzY73SWOYx7+yMDw=;
        b=c+zy5r7lDrAqrXtJCr9tzH2MiE2x7QYKICUJrGKCNB7YNectiJXn26UGfLz6V0653g
         JZ7wOXYzIJ0I3pMJPIvEWRzk+y+ZWsoWKa5xGXAT15gjllMoNNm2fP9EnhyOXfm80Agr
         RIqSQPxTEfXuBVtW1m1pHBEPDaMw7phSsPfrSGLKejfUFWIHY5zGNgNF83P7MP343gCt
         l3Ev5W8AuH43a7wezhRAJzWas9fcfyNAar6dwanRJsee61pbM/DnU19+WmYPG3MMlzjY
         8ePMKxzFDVqq74iU7H/O+lGIk0ZCFE9KfXrI5TGYXXtO/+vozSYXxUbdmUJzHbUrxe2a
         wfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RkQAA3E/9j5+VGD84stNgIqiheckzY73SWOYx7+yMDw=;
        b=O2NK4HtKt92QGLV7ntVpzt1n5IeeZONjmlpl19ln9lf2eSKPGrouv0aew+My5Pr0qN
         rwhsYXPA7miTZQDsXvdFrEs5rK4h9sHgrkZ5MC8f+xwOTOalePiXApq4MHJVp4ldyA48
         lQAW3Ag1A2arPfBzm5XmSlTWqMsFg0uoxxi2oAAif1iGVKUIaRAdj+e3IEPpC1+w9vdW
         +Fw/Au9u/OrxaC13FEpn/GPMdAmpOiHA9FchRgltLMQVPj0B4Pu5gEmA3KwPDIdkqRK8
         +7AqTjVX+2ew8zCvdm/W1XdFwsPJqHQFI6Fecsri2NEB9bIa3fntnEmD74MbRuy25khr
         kGDg==
X-Gm-Message-State: AOUpUlEIxpx0O9eW0JsmlyDvs1j52cd7Md9HLtYzqvkio1aBJm/SmX3X
        wrBh3HNoEyo+7w2faV5N/4g=
X-Google-Smtp-Source: AAOMgpeJ6+nJ3tmlMugyK8iGUtpn2Z/Afsrk/B4f5odVr8rF0kRU3fuM8+i5mbTN6Bo8Az2efGSznw==
X-Received: by 2002:a63:c60:: with SMTP id 32-v6mr12493682pgm.155.1532355196825;
        Mon, 23 Jul 2018 07:13:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:e422:450a:e730:728b])
        by smtp.gmail.com with ESMTPSA id u185-v6sm13872075pfu.134.2018.07.23.07.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:13:16 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] block: zram: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Mon, 23 Jul 2018 22:13:04 +0800
Message-Id: <20180723141304.3300-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_from_bdev_async() and write_to_bdev() are never called in atomic
context. They call bio_alloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0f3fadd71230..b958ed0b8c35 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -450,7 +450,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_ATOMIC, 1);
+	bio = bio_alloc(GFP_KERNEL, 1);
 	if (!bio)
 		return -ENOMEM;
 
@@ -538,7 +538,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 	struct bio *bio;
 	unsigned long entry;
 
-	bio = bio_alloc(GFP_ATOMIC, 1);
+	bio = bio_alloc(GFP_KERNEL, 1);
 	if (!bio)
 		return -ENOMEM;
 
-- 
2.17.0

