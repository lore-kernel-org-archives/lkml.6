Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D99C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4600720857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+vLBFp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4600720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeG2VJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:09:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34726 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbeG2VIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so3560553pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VScNdHleqGz+aD0Z3qtBuMqwoURnosmtA+NDA8IXVKs=;
        b=g+vLBFp/yZq1oTLu8qjjSuV7uzqmOGX9ASRlKdmnejKT4crTrHp3KDmIkWVkWKyLOG
         LXyehdAXOhvPYu4fGk9CdJqU3P+B/jHhoXe6WL0GnbtWGXmTh/6ySEcQ9eWTlL5XRxU5
         USFffZDTpoPgWDYqtR7ylLM7jHBB7LVL4OICU/M9Z6pS3NAJKH97XRCT9auF/seWkuGd
         Q6//Ch4hGa2xGMzFpV/RYFNL5ddsVZQ3aM5N41eaKlC/Hiunpy9rycL40/r7/hQ70Q40
         shc0gM9/jXDxQdO+dnF5trfCjpRjVJ8ir0AJrX+bKImVw+aVk89X/8LMqav75Ny5vv4M
         TKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VScNdHleqGz+aD0Z3qtBuMqwoURnosmtA+NDA8IXVKs=;
        b=PZC2saQZMtFA6iukz9lkje1NYJNlvXpK/XF6oKSwCiVX2rg9riHJrqrO3ZfWzT24Ol
         BkdtN49DL1n38u/DV1jadmuqCZNpsNMm0fTTGF5hgCpWG2D9pTtVzWxJZdPjtEycwLbw
         tZK8mY+u+65vuqMh6fi02lhACRhaHtOXo7xNIfTfFkn593ADUaIJR3XotDTxN++srLyf
         Lue71s9mNbO5d9c/xRa4qlvPDyXF4u5vamBuWewxDy5zAY+HVC97ZsHxHbLERBfk3gz5
         Jjb3Qq5BS9WqkLFtsQ5snu2nYBEjG880YH+ivuMwZE/UAMiTHkP9SrCy8A+vMvKh9+bx
         h38g==
X-Gm-Message-State: AOUpUlHjp0K+X2xGppaSuvfIZVI+xHPLNsss8BXQs21FJTd336tJemyA
        9AOsEJCjH2GHw6szdZR6DNA=
X-Google-Smtp-Source: AAOMgpeBrStNIGpVgexuZ/QXi5VBuqjwa6WBFgIqeQhHgV2ehTaKRFt9Y8YzJPomsSwEq2h3sOXthw==
X-Received: by 2002:a63:4b5a:: with SMTP id k26-v6mr13309621pgl.384.1532893030246;
        Sun, 29 Jul 2018 12:37:10 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:09 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 13/13] staging: gasket: apex: fix function param line continuation style
Date:   Sun, 29 Jul 2018 12:36:46 -0700
Message-Id: <20180729193646.201721-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Fix multi-line alignment formatting to look like:
      int ret = long_function_name(device, VARIABLE1, VARIABLE2,
                                   VARIABLE3, VARIABLE4);

Many of these TODO items were previously cleaned up during the conversion
to standard logging functions.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 119 +++++++++++++--------------
 1 file changed, 58 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index f70fea0d80ecf..c0d3922e1d7c3 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -240,9 +240,9 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 	 *  - Software force GCB idle
 	 *    - Enable GCB idle
 	 */
-	gasket_read_modify_write_64(
-		gasket_dev, APEX_BAR_INDEX,
-		APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER, 0x0, 1, 32);
+	gasket_read_modify_write_64(gasket_dev, APEX_BAR_INDEX,
+				    APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER,
+				    0x0, 1, 32);
 
 	/*    - Initiate DMA pause */
 	gasket_dev_write_64(gasket_dev, 1, APEX_BAR_INDEX,
@@ -259,16 +259,16 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 	}
 
 	/*  - Enable GCB reset (0x1 to rg_rst_gcb) */
-	gasket_read_modify_write_32(
-		gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_2, 0x1, 2, 2);
+	gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+				    APEX_BAR2_REG_SCU_2, 0x1, 2, 2);
 
 	/*  - Enable GCB clock Gate (0x1 to rg_gated_gcb) */
-	gasket_read_modify_write_32(
-		gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_2, 0x1, 2, 18);
+	gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+				    APEX_BAR2_REG_SCU_2, 0x1, 2, 18);
 
 	/*  - Enable GCB memory shut down (0x3 to rg_force_ram_sd) */
-	gasket_read_modify_write_32(
-		gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3, 0x3, 2, 14);
+	gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+				    APEX_BAR2_REG_SCU_3, 0x3, 2, 14);
 
 	/*    - Wait for RAM shutdown. */
 	if (gasket_wait_with_reschedule(gasket_dev, APEX_BAR_INDEX,
@@ -297,24 +297,24 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 	 *    - b00: Not forced (HW controlled)
 	 *    - b1x: Force disable
 	 */
-	gasket_read_modify_write_32(
-		gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3, 0x0, 2, 14);
+	gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+				    APEX_BAR2_REG_SCU_3, 0x0, 2, 14);
 
 	/*
 	 *  - Disable software clock gate:
 	 *    - b00: Not forced (HW controlled)
 	 *    - b1x: Force disable
 	 */
-	gasket_read_modify_write_32(
-		gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_2, 0x0, 2, 18);
+	gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+				    APEX_BAR2_REG_SCU_2, 0x0, 2, 18);
 
 	/*
 	 *  - Disable GCB reset (rg_rst_gcb):
 	 *    - b00: Not forced (HW controlled)
 	 *    - b1x: Force disable = Force not Reset
 	 */
-	gasket_read_modify_write_32(
-		gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_2, 0x2, 2, 2);
+	gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+				    APEX_BAR2_REG_SCU_2, 0x2, 2, 2);
 
 	/*    - Wait for RAM enable. */
 	if (gasket_wait_with_reschedule(gasket_dev, APEX_BAR_INDEX,
@@ -338,27 +338,28 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 	}
 
 	if (!allow_hw_clock_gating) {
-		val0 = gasket_dev_read_32(
-			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
+		val0 = gasket_dev_read_32(gasket_dev, APEX_BAR_INDEX,
+					  APEX_BAR2_REG_SCU_3);
 		/* Inactive and Sleep mode are disabled. */
-		gasket_read_modify_write_32(
-			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3, 0x3,
-			SCU3_RG_PWR_STATE_OVR_MASK_WIDTH,
-			SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
-		val1 = gasket_dev_read_32(
-			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
+		gasket_read_modify_write_32(gasket_dev,
+					    APEX_BAR_INDEX,
+					    APEX_BAR2_REG_SCU_3, 0x3,
+					    SCU3_RG_PWR_STATE_OVR_MASK_WIDTH,
+					    SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
+		val1 = gasket_dev_read_32(gasket_dev, APEX_BAR_INDEX,
+					  APEX_BAR2_REG_SCU_3);
 		dev_dbg(gasket_dev->dev,
 			"Disallow HW clock gating 0x%x -> 0x%x\n", val0, val1);
 	} else {
-		val0 = gasket_dev_read_32(
-			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
+		val0 = gasket_dev_read_32(gasket_dev, APEX_BAR_INDEX,
+					  APEX_BAR2_REG_SCU_3);
 		/* Inactive mode enabled - Sleep mode disabled. */
-		gasket_read_modify_write_32(
-			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3, 2,
-			SCU3_RG_PWR_STATE_OVR_MASK_WIDTH,
-			SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
-		val1 = gasket_dev_read_32(
-			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
+		gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+					    APEX_BAR2_REG_SCU_3, 2,
+					    SCU3_RG_PWR_STATE_OVR_MASK_WIDTH,
+					    SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
+		val1 = gasket_dev_read_32(gasket_dev, APEX_BAR_INDEX,
+					  APEX_BAR2_REG_SCU_3);
 		dev_dbg(gasket_dev->dev, "Allow HW clock gating 0x%x -> 0x%x\n",
 			val0, val1);
 	}
@@ -373,12 +374,10 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 	u64 hib_error;
 	int ret = 0;
 
-	hib_error = gasket_dev_read_64(
-		gasket_dev, APEX_BAR_INDEX,
-		APEX_BAR2_REG_USER_HIB_ERROR_STATUS);
-	scalar_error = gasket_dev_read_64(
-		gasket_dev, APEX_BAR_INDEX,
-		APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
+	hib_error = gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
+				       APEX_BAR2_REG_USER_HIB_ERROR_STATUS);
+	scalar_error = gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
+					  APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
 
 	dev_dbg(gasket_dev->dev,
 		"%s 0x%p hib_error 0x%llx scalar_error 0x%llx\n",
@@ -393,8 +392,8 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 /* Determine if GCB is in reset state. */
 static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
 {
-	u32 val = gasket_dev_read_32(
-		gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
+	u32 val = gasket_dev_read_32(gasket_dev, APEX_BAR_INDEX,
+				     APEX_BAR2_REG_SCU_3);
 
 	/* Masks rg_rst_gcb bit of SCU_CTRL_2 */
 	return (val & SCU3_CUR_RST_GCB_BIT_MASK);
@@ -432,13 +431,11 @@ static int apex_add_dev_cb(struct gasket_dev *gasket_dev)
 
 	while (retries < APEX_RESET_RETRY) {
 		page_table_ready =
-			gasket_dev_read_64(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
+			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
+					   APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
 		msix_table_ready =
-			gasket_dev_read_64(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
+			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
+					   APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
 		if (page_table_ready && msix_table_ready)
 			break;
 		schedule_timeout(msecs_to_jiffies(APEX_RESET_DELAY));
@@ -481,20 +478,20 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev,
 
 	if (ibuf.enable) {
 		/* Quiesce AXI, gate GCB clock. */
-		gasket_read_modify_write_32(
-		    gasket_dev, APEX_BAR_INDEX,
-		    APEX_BAR2_REG_AXI_QUIESCE, 0x1, 1, 16);
-		gasket_read_modify_write_32(
-		    gasket_dev, APEX_BAR_INDEX,
-		    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x1, 2, 18);
+		gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+					    APEX_BAR2_REG_AXI_QUIESCE, 0x1, 1,
+					    16);
+		gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+					    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x1,
+					    2, 18);
 	} else {
 		/* Un-gate GCB clock, un-quiesce AXI. */
-		gasket_read_modify_write_32(
-		    gasket_dev, APEX_BAR_INDEX,
-		    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x0, 2, 18);
-		gasket_read_modify_write_32(
-		    gasket_dev, APEX_BAR_INDEX,
-		    APEX_BAR2_REG_AXI_QUIESCE, 0x0, 1, 16);
+		gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+					    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x0,
+					    2, 18);
+		gasket_read_modify_write_32(gasket_dev, APEX_BAR_INDEX,
+					    APEX_BAR2_REG_AXI_QUIESCE, 0x0, 1,
+					    16);
 	}
 	return 0;
 }
@@ -516,8 +513,8 @@ static long apex_ioctl(struct file *filp, uint cmd, void __user *argp)
 }
 
 /* Display driver sysfs entries. */
-static ssize_t sysfs_show(
-	struct device *device, struct device_attribute *attr, char *buf)
+static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
+			  char *buf)
 {
 	int ret;
 	struct gasket_dev *gasket_dev;
@@ -578,8 +575,8 @@ static struct gasket_sysfs_attribute apex_sysfs_attrs[] = {
 
 static int apex_sysfs_setup_cb(struct gasket_dev *gasket_dev)
 {
-	return gasket_sysfs_create_entries(
-		gasket_dev->dev_info.device, apex_sysfs_attrs);
+	return gasket_sysfs_create_entries(gasket_dev->dev_info.device,
+					   apex_sysfs_attrs);
 }
 
 /* On device open, perform a core reinit reset. */
-- 
2.18.0.345.g5c9ce644c3-goog

