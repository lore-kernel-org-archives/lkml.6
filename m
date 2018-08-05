Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B750C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BD121920
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV+22Z8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BD121920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeHEWOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41590 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeHEWOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:14 -0400
Received: by mail-pl0-f68.google.com with SMTP id w19-v6so3062145ply.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpbI7qWDO6JeCEEZnAVOq1IdQOaMkP3/ZpER6OY/0cw=;
        b=YV+22Z8zvN6TVaER+5Khk/La++24gSduH/Gh+GJePedy2MRiK9RITyRo1Sy7x0FikN
         Le8ky/YDJ54VXOxB/wAVP6edUKNWizvB8Zl15asT53m4g3BseucYXKwTBFlqgsHf+Kkm
         rL57csIMv94hCyqff4A8lFi0AUPBwdS+srKzKH4w02GvRpHoH1SQRg7paapjjHhZ28Ld
         A5En0fE+6XRCCRNVhFuE3+AMqjcAVMTSm51+LPgOKFwRQrnmDgU9tIf5zpI6o3wuV/CH
         r08HQnrivabxNocd1XF8G/GYCuMl+Vdm8oqDzA6MElkWfG6jOVXwb5y6TH2U1XOUAgK9
         wvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpbI7qWDO6JeCEEZnAVOq1IdQOaMkP3/ZpER6OY/0cw=;
        b=NoNmv+ktQcRuhRBb4XUWOE9e010ORfc5V2HkrCuyzZdjI1ye9yMAbO5fxDeOuyQmBn
         zgtDUgsQaBv1IZ8WB65lMWebzBJwt1XMaFy1vXFX3vPcyB853VIHx70ASogiF1yOOsWb
         InHPRHpF7MW5qDz3ASbRGRPw5G+24wL/2x2KI/LxyfnQ6MRmqy49P1PJGMphHDl77zYh
         wItzTUHADe6EV4aNjZk3kX4a/wfCAMB0Fbk745sgRWleuj+sC0rtzzRe4SVytNDIpNw0
         cEWQ/GrJBBfmKuvQqqdE3py/QTCEi2TXjpEI32Up0RrLyLVVvoM/GjiRFG59su6zov6W
         z4IQ==
X-Gm-Message-State: AOUpUlHWn49OQr/Lp0JBJEPt0iUzcngb0EpfoXfLv3n49BlT09sgQsr6
        vtkSq/gH+o9rYqSQv8XLqUM=
X-Google-Smtp-Source: AAOMgpdabr6Ky7xM/7/Jm1399QK/jOWMChwC3AXclg1NUwvumRK9PnVY9WZa18h6Audq585l+oxTXA==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3-v6mr11454411plp.75.1533499710319;
        Sun, 05 Aug 2018 13:08:30 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:29 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 10/15] staging: gasket: apex: fold device add/remove logic inline
Date:   Sun,  5 Aug 2018 13:07:44 -0700
Message-Id: <20180805200749.116693-11-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Gasket device drivers are now in charge of the device add and remove
sequences; the framework callbacks for these are deleted.  Move the
apex device add callback code to the probe function.  Apex did not
implement the removal callback.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 69 +++++++++++++---------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 1d8a100c52885..69ca7fb10eddc 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -448,37 +448,6 @@ static int apex_reset(struct gasket_dev *gasket_dev)
 	return ret;
 }
 
-static int apex_add_dev_cb(struct gasket_dev *gasket_dev)
-{
-	ulong page_table_ready, msix_table_ready;
-	int retries = 0;
-
-	apex_reset(gasket_dev);
-
-	while (retries < APEX_RESET_RETRY) {
-		page_table_ready =
-			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
-					   APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
-		msix_table_ready =
-			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
-					   APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
-		if (page_table_ready && msix_table_ready)
-			break;
-		schedule_timeout(msecs_to_jiffies(APEX_RESET_DELAY));
-		retries++;
-	}
-
-	if (retries == APEX_RESET_RETRY) {
-		if (!page_table_ready)
-			dev_err(gasket_dev->dev, "Page table init timed out\n");
-		if (!msix_table_ready)
-			dev_err(gasket_dev->dev, "MSI-X table init timed out\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
 /*
  * Check permissions for Apex ioctls.
  * Returns true if the current user may execute this ioctl, and false otherwise.
@@ -626,6 +595,8 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
 			  const struct pci_device_id *id)
 {
 	int ret;
+	ulong page_table_ready, msix_table_ready;
+	int retries = 0;
 	struct gasket_dev *gasket_dev;
 
 	ret = pci_enable_device(pci_dev);
@@ -644,15 +615,42 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
 	}
 
 	pci_set_drvdata(pci_dev, gasket_dev);
+	apex_reset(gasket_dev);
+
+	while (retries < APEX_RESET_RETRY) {
+		page_table_ready =
+			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
+					   APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
+		msix_table_ready =
+			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
+					   APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
+		if (page_table_ready && msix_table_ready)
+			break;
+		schedule_timeout(msecs_to_jiffies(APEX_RESET_DELAY));
+		retries++;
+	}
+
+	if (retries == APEX_RESET_RETRY) {
+		if (!page_table_ready)
+			dev_err(gasket_dev->dev, "Page table init timed out\n");
+		if (!msix_table_ready)
+			dev_err(gasket_dev->dev, "MSI-X table init timed out\n");
+		ret = -ETIMEDOUT;
+		goto remove_device;
+	}
+
 	ret = gasket_enable_device(gasket_dev);
 	if (ret) {
 		dev_err(&pci_dev->dev, "error enabling gasket device\n");
-		gasket_pci_remove_device(pci_dev);
-		pci_disable_device(pci_dev);
-		return ret;
+		goto remove_device;
 	}
 
 	return 0;
+
+remove_device:
+	gasket_pci_remove_device(pci_dev);
+	pci_disable_device(pci_dev);
+	return ret;
 }
 
 static void apex_pci_remove(struct pci_dev *pci_dev)
@@ -697,9 +695,6 @@ static struct gasket_driver_desc apex_desc = {
 	.interrupts = apex_interrupts,
 	.interrupt_pack_width = 7,
 
-	.add_dev_cb = apex_add_dev_cb,
-	.remove_dev_cb = NULL,
-
 	.sysfs_setup_cb = apex_sysfs_setup_cb,
 	.sysfs_cleanup_cb = NULL,
 
-- 
2.18.0.597.ga71716f1ad-goog

