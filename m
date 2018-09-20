Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A77921534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItIQdkYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A77921534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeIUEji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:39:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33514 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeIUEji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:39:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so10996219wrc.0;
        Thu, 20 Sep 2018 15:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mq90HwvCcR9EVjXZXa7ItQrOkCJ+edai/jAxJZm1SJs=;
        b=ItIQdkYI52ag7DyEE0/c9WeqQ7edUY/mHfYZMk+cd/kECU/fxNtUBlZAKjL0Pn0P6a
         3fquE/VaT3OxVw1JAPlt8OJQqDwg/ZaCGEJ5+JomdKfTAZWT3GMDrlUEmcYjGXmZcs0s
         lrAbrKO5KtX4ke9m+jKsGKeDnaHZvujy1zY6af7p12nwHqBLL1yMZUsmBNMfPePKiIz+
         9bE1iwcLhuMrKx5AZdR5j8ToyHsNu2AOHctiAaGMkd5Z24L/UTR+0c5vSgMRsaqAEPyI
         TT5MeEUQmsqme5loS2s5FMi9b9BzXn8e7TQXMvXbCXN3Q1prAfVlJsH9YeK3Ajaj0L/8
         FAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mq90HwvCcR9EVjXZXa7ItQrOkCJ+edai/jAxJZm1SJs=;
        b=SRF8k4J3jx4eIpa4r2+iGWk55KOZuv0zgb2Bo0Gl2b7ZAQGwshrk76pUbF1UCB1Fmp
         qNfqKs4auWn46ggBFrbtRYRbEHqzTjBHglVKPRcov8lf1ZEPKDah1aSBe9p9CYDco/dc
         MSFtN9LdPhgM+CvY34IMqeZOx2/7U5VXt7cHv2ARGnxxFwf9OOX0AusXkSR9tDHdiz98
         UXlqNQtEQRuWK9TGCpQSxpuQe0G71lEKxE93ix8RqIe8IDo+kpunxaA4+nnLgUWxJh+P
         YjvQSFsKVn8Gc5mtlr/WUvspaXdvo6H/WVGRG6asCqJG9HxFaVU2p6QkF5thyQQ/62nP
         Qvwg==
X-Gm-Message-State: APzg51AWFvpQiYQrYXp3pqVgYIO5rTJhew9TFjHa86kW4DsM9mb/n1Kl
        EDvazxQ/e9+qyY183FJ+mTkruASnv+nRQQ==
X-Google-Smtp-Source: ANB0VdbhBLIGJrBFKfHGLOFx6Ow50HTTv/Pe135IAJFOFhC7IsD60QGIHWIS2Ioxau6ofvS6+WD6lg==
X-Received: by 2002:adf:a35e:: with SMTP id d30-v6mr9155005wrb.31.1537484028452;
        Thu, 20 Sep 2018 15:53:48 -0700 (PDT)
Received: from AQ-THINKPAD.home ([2a00:23c5:c200:5b00:5de9:20bb:eecf:e05c])
        by smtp.gmail.com with ESMTPSA id a9-v6sm3949602wmf.28.2018.09.20.15.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 15:53:47 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Fix typo frambuffer->framebuffer
Date:   Thu, 20 Sep 2018 23:53:21 +0100
Message-Id: <20180920225321.18180-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects a typo (frambuffer->framebuffer) in the
sm750fb_fram(e)buffer_release and sm750fb_fram(e)buffer_alloc function
names.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 846d7d243994..e9f10c2669ea 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1007,7 +1007,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	}
 }
 
-static void sm750fb_frambuffer_release(struct sm750_dev *sm750_dev)
+static void sm750fb_framebuffer_release(struct sm750_dev *sm750_dev)
 {
 	struct fb_info *fb_info;
 
@@ -1019,7 +1019,7 @@ static void sm750fb_frambuffer_release(struct sm750_dev *sm750_dev)
 	}
 }
 
-static int sm750fb_frambuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
+static int sm750fb_framebuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
 {
 	struct fb_info *fb_info;
 	struct lynxfb_par *par;
@@ -1137,7 +1137,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	/* allocate frame buffer info structures according to g_dualview */
 	max_fb = g_dualview ? 2 : 1;
 	for (fbidx = 0; fbidx < max_fb; fbidx++) {
-		err = sm750fb_frambuffer_alloc(sm750_dev, fbidx);
+		err = sm750fb_framebuffer_alloc(sm750_dev, fbidx);
 		if (err)
 			goto release_fb;
 	}
@@ -1145,7 +1145,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 release_fb:
-	sm750fb_frambuffer_release(sm750_dev);
+	sm750fb_framebuffer_release(sm750_dev);
 	return err;
 }
 
@@ -1155,7 +1155,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 
 	sm750_dev = pci_get_drvdata(pdev);
 
-	sm750fb_frambuffer_release(sm750_dev);
+	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
 	iounmap(sm750_dev->pvReg);
-- 
2.17.1

