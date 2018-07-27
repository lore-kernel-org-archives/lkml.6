Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE7BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9780620671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkssfN9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9780620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbeG0KeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:34:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41471 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeG0KeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:34:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so2880222pgu.8;
        Fri, 27 Jul 2018 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uvTHbGutzAZckRt+6qi7Iz8OaqAPur9V4Cn4afpXUVY=;
        b=AkssfN9dyA3um/2+9+ODrauLL0F5lFgNcm3n1jT0nGUv+MRU8jJDK87xHRCuwvezAf
         RvRzznBpnU8OHAuPqn9DwMHKfPYDtfDRoTptgRWMYJgBDHoGWp2zF4X0d14ctyetAwMr
         rYvq9GDEYG1H8/cmTzT1lT+UTIc5ZYUcCqB16dSCjXQlLBqBRoJlLdb4tbuvzj0IIBpX
         qVJkzlLKYarxLKXW3SgKO4T/KNZM56JwKF8VuoF9pkD6eav65dtkyJgtEUUfGbKCBZ9I
         1vFUvStHE17XCDs6ciw/MkhUxq11x5zVDU4fsfiA1Tu4xsWnwXvsf9ECwTyttCFg60j7
         Z8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uvTHbGutzAZckRt+6qi7Iz8OaqAPur9V4Cn4afpXUVY=;
        b=rGfzH5rXIICvar+KF3RMIxpCB3sBlgaN6qrpS8ugBCMD1gCOGDvledieWuZCWnBzW2
         SPZf1cYs5xr/POHceMJe77+42jZhCkET58Xdc0boa9pygG6T5TY33sjonNkWmIknz6w/
         /L0rRhqFT4911T1S/Nsna2DyONzr2YN81mEbC4kSszVOWxPN7jprN77gZ4eRt/g9vQR6
         NsRJ8O21O/iNsqLmIenbk9mHdnBgkpYu8sv+q1mJ9ibGGW8BgQHv4oF32VmFBpTLAGQ/
         nnwXIf4b4OjthE7FEhpUg1LqzPtd/eFJiSoio56V2vX1aJSVM/c4XzmXuCPMdKhogGsb
         Xapw==
X-Gm-Message-State: AOUpUlFNYZYLN2C1S/nUAkLUkYxTcSFrx/1vqq0s1O6WTohR7XEqc9+7
        Zd3+955koO6nepDhV1V2yuU=
X-Google-Smtp-Source: AAOMgpf1NLykPeLVVajz7JxoDax44b8LprFuoVh3w8LGK2qG+dZAJ0NOmjCQsYaQfJt/9PuZqzX47Q==
X-Received: by 2002:a63:4a61:: with SMTP id j33-v6mr5305289pgl.436.1532682802910;
        Fri, 27 Jul 2018 02:13:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id 64-v6sm6474685pfi.89.2018.07.27.02.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 02:13:22 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: atp870u: Replace mdelay() with msleep()
Date:   Fri, 27 Jul 2018 17:13:17 +0800
Message-Id: <20180727091317.6976-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tscam(), atp870_init(), atp880_init() and atp885_init() are never 
called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/atp870u.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
index b46997cf77e2..8996d2329e11 100644
--- a/drivers/scsi/atp870u.c
+++ b/drivers/scsi/atp870u.c
@@ -1055,7 +1055,7 @@ static void tscam(struct Scsi_Host *host, bool wide_chip, u8 scam_on)
 	udelay(2);		/* 2 deskew delay(45ns*2=90ns) */
 	val &= 0x007f;		/* no bsy  */
 	atp_writew_io(dev, 0, 0x1c, val);
-	mdelay(128);
+	msleep(128);
 	val &= 0x00fb;		/* after 1ms no msg */
 	atp_writew_io(dev, 0, 0x1c, val);
 	while ((atp_readb_io(dev, 0, 0x1c) & 0x04) != 0)
@@ -1286,9 +1286,9 @@ static void atp870_init(struct Scsi_Host *shpnt)
 	k = (atp_readb_base(atpdev, 0x3a) & 0xf3) | 0x10;
 	atp_writeb_base(atpdev, 0x3a, k);
 	atp_writeb_base(atpdev, 0x3a, k & 0xdf);
-	mdelay(32);
+	msleep(32);
 	atp_writeb_base(atpdev, 0x3a, k);
-	mdelay(32);
+	msleep(32);
 	atp_set_host_id(atpdev, 0, host_id);
 
 	tscam(shpnt, wide_chip, scam_on);
@@ -1370,9 +1370,9 @@ static void atp880_init(struct Scsi_Host *shpnt)
 	k = atp_readb_base(atpdev, 0x38) & 0x80;
 	atp_writeb_base(atpdev, 0x38, k);
 	atp_writeb_base(atpdev, 0x3b, 0x20);
-	mdelay(32);
+	msleep(32);
 	atp_writeb_base(atpdev, 0x3b, 0);
-	mdelay(32);
+	msleep(32);
 	atp_readb_io(atpdev, 0, 0x1b);
 	atp_readb_io(atpdev, 0, 0x17);
 
@@ -1454,10 +1454,10 @@ static void atp885_init(struct Scsi_Host *shpnt)
 	atp_writeb_base(atpdev, 0x28, k);
 	atp_writeb_pci(atpdev, 0, 1, 0x80);
 	atp_writeb_pci(atpdev, 1, 1, 0x80);
-	mdelay(100);
+	msleep(100);
 	atp_writeb_pci(atpdev, 0, 1, 0);
 	atp_writeb_pci(atpdev, 1, 1, 0);
-	mdelay(1000);
+	msleep(1000);
 	atp_readb_io(atpdev, 0, 0x1b);
 	atp_readb_io(atpdev, 0, 0x17);
 	atp_readb_io(atpdev, 1, 0x1b);
@@ -1473,7 +1473,7 @@ static void atp885_init(struct Scsi_Host *shpnt)
 		k = (k & 0x07) | 0x40;
 	atp_set_host_id(atpdev, 1, k);
 
-	mdelay(600); /* this delay used to be called tscam_885() */
+	msleep(600); /* this delay used to be called tscam_885() */
 	dev_info(&pdev->dev, "Scanning Channel A SCSI Device ...\n");
 	atp_is(atpdev, 0, true, atp_readb_io(atpdev, 0, 0x1b) >> 7);
 	atp_writeb_io(atpdev, 0, 0x16, 0x80);
-- 
2.17.0

