Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80732ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F10020893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/u+KH5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F10020893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeG0E1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37923 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbeG0E1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:53 -0400
Received: by mail-pl0-f68.google.com with SMTP id b1-v6so1683847pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhsouOTSZpwNMHL+XGnko9gGj/9LkFMIrmqbsvi7R5I=;
        b=E/u+KH5rk4mortJ6467u6+1afh2EgNSRYSR0LZg8VvS0IttR2CYCNh3v/RGiQ5NmUK
         1arLtPMjZpkDTeHfbEcZonhkEpDy9jP8KvJN0sBOFjtZeVsOC5w7X8bpyBRbJUDRwq0Y
         E7Tli0ItE/AOUu/ALONFCDwBLpi7G9jY10tyjN3Rs0FWo8aPne/ddRgvo219MIMiR4UN
         j+4Cajfq5k10txVq3ml2lOT340jMW9xwHB8kAt8cIuRpFYQ0XOg9fkNhwKZ3RZLh1ESt
         8mjuQjDoFw1gX3hJxZ9KwzsNdXW7/fw3G/Dgq2FT5s++LxrOCojxZ1UpzUcChB06tdhT
         ECiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhsouOTSZpwNMHL+XGnko9gGj/9LkFMIrmqbsvi7R5I=;
        b=G12oqenYNl3pxrEmqHsAb+/gux4ehSI/cAAd2Rh/ylm6/nBvvWMEufNbZEEG3FmtS+
         FOt7iT1cKBK5bG6n70dOFgSNJELiNOPWwDoAIYlF2Vf7a3ZnXcCHQEKyyM1DNJjeSLN5
         bsj7QbbvSzrcmbOOgbJeys/6Nm8m78fyPQCdiSyif4hK+J0tiXEqFUuCJhfp08fiGmpo
         y3iGdMIP10Zd8f7ppaNCp7E50URZ9qdNppZntNB0Adxje4UkvMT9vNL0gE498Ud1K0N5
         hT90audAQ8zaRXACqOlsnrafnMmrEmk0aqXHcwy5YCW2d99PhQGCIPSQTToY/auzx6Uo
         fZeg==
X-Gm-Message-State: AOUpUlEnH8UC18ysn1bow5twU2SHG2jg7V+YvY2SAM8H6RO+Wxpg6oCm
        POvg8MtgM4YCA1CSyPanPH0=
X-Google-Smtp-Source: AAOMgpd6B+OOREB2W0W4qeXCt0fgu16nj1ieQECB/FOt6P1XUZ0xcq/4YGMSchKeOqhdajrTWCg3Mw==
X-Received: by 2002:a17:902:6f02:: with SMTP id w2-v6mr4231334plk.216.1532660889558;
        Thu, 26 Jul 2018 20:08:09 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:09 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/10] staging: gasket: apex: convert to standard logging
Date:   Thu, 26 Jul 2018 20:07:34 -0700
Message-Id: <20180727030737.231268-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727030737.231268-1-toddpoynor@gmail.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Drop gasket logging calls in favor of standard logging.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 61 ++++++++++++----------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 6396b18b246a5..73fc2683a834d 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -7,11 +7,13 @@
 
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/printk.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 
@@ -19,7 +21,6 @@
 
 #include "gasket_core.h"
 #include "gasket_interrupt.h"
-#include "gasket_logging.h"
 #include "gasket_page_table.h"
 #include "gasket_sysfs.h"
 
@@ -362,11 +363,9 @@ static int apex_add_dev_cb(struct gasket_dev *gasket_dev)
 
 	if (retries == APEX_RESET_RETRY) {
 		if (!page_table_ready)
-			gasket_log_error(
-				gasket_dev, "Page table init timed out.");
+			dev_err(gasket_dev->dev, "Page table init timed out\n");
 		if (!msix_table_ready)
-			gasket_log_error(
-				gasket_dev, "MSI-X table init timed out.");
+			dev_err(gasket_dev->dev, "MSI-X table init timed out\n");
 		return -ETIMEDOUT;
 	}
 
@@ -420,12 +419,9 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 		gasket_dev, APEX_BAR_INDEX,
 		APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
 
-	gasket_log_debug(
-		gasket_dev,
-		"%s 0x%p hib_error 0x%llx scalar_error "
-		"0x%llx.",
-		__func__,
-		gasket_dev, hib_error, scalar_error);
+	dev_dbg(gasket_dev->dev,
+		"%s 0x%p hib_error 0x%llx scalar_error 0x%llx\n",
+		__func__, gasket_dev, hib_error, scalar_error);
 
 	if (allow_power_save)
 		ret = apex_enter_reset(gasket_dev, APEX_CHIP_REINIT_RESET);
@@ -452,7 +448,7 @@ static int apex_reset(struct gasket_dev *gasket_dev, uint type)
 		/* We are not in reset - toggle the reset bit so as to force
 		 * re-init of custom block
 		 */
-		gasket_log_debug(gasket_dev, "%s: toggle reset.", __func__);
+		dev_dbg(gasket_dev->dev, "%s: toggle reset\n", __func__);
 
 		ret = apex_enter_reset(gasket_dev, type);
 		if (ret)
@@ -489,9 +485,9 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 	if (gasket_wait_with_reschedule(gasket_dev, APEX_BAR_INDEX,
 					APEX_BAR2_REG_USER_HIB_DMA_PAUSED, 1, 1,
 					APEX_RESET_DELAY, APEX_RESET_RETRY)) {
-		gasket_log_error(gasket_dev,
-				 "DMAs did not quiesce within timeout (%d ms)",
-				 APEX_RESET_RETRY * APEX_RESET_DELAY);
+		dev_err(gasket_dev->dev,
+			"DMAs did not quiesce within timeout (%d ms)\n",
+			APEX_RESET_RETRY * APEX_RESET_DELAY);
 		return -ETIMEDOUT;
 	}
 
@@ -511,9 +507,8 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 	if (gasket_wait_with_reschedule(gasket_dev, APEX_BAR_INDEX,
 					APEX_BAR2_REG_SCU_3, 1 << 6, 1 << 6,
 					APEX_RESET_DELAY, APEX_RESET_RETRY)) {
-		gasket_log_error(
-			gasket_dev,
-			"RAM did not shut down within timeout (%d ms)",
+		dev_err(gasket_dev->dev,
+			"RAM did not shut down within timeout (%d ms)\n",
 			APEX_RESET_RETRY * APEX_RESET_DELAY);
 		return -ETIMEDOUT;
 	}
@@ -560,9 +555,8 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 	if (gasket_wait_with_reschedule(gasket_dev, APEX_BAR_INDEX,
 					APEX_BAR2_REG_SCU_3, 1 << 6, 0,
 					APEX_RESET_DELAY, APEX_RESET_RETRY)) {
-		gasket_log_error(
-			gasket_dev,
-			"RAM did not enable within timeout (%d ms)",
+		dev_err(gasket_dev->dev,
+			"RAM did not enable within timeout (%d ms)\n",
 			APEX_RESET_RETRY * APEX_RESET_DELAY);
 		return -ETIMEDOUT;
 	}
@@ -572,9 +566,8 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 					APEX_BAR2_REG_SCU_3,
 					SCU3_CUR_RST_GCB_BIT_MASK, 0,
 					APEX_RESET_DELAY, APEX_RESET_RETRY)) {
-		gasket_log_error(
-			gasket_dev,
-			"GCB did not leave reset within timeout (%d ms)",
+		dev_err(gasket_dev->dev,
+			"GCB did not leave reset within timeout (%d ms)\n",
 			APEX_RESET_RETRY * APEX_RESET_DELAY);
 		return -ETIMEDOUT;
 	}
@@ -589,9 +582,8 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
 		val1 = gasket_dev_read_32(
 			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
-		gasket_log_debug(
-			gasket_dev, "Disallow HW clock gating 0x%x -> 0x%x",
-			val0, val1);
+		dev_dbg(gasket_dev->dev,
+			"Disallow HW clock gating 0x%x -> 0x%x\n", val0, val1);
 	} else {
 		val0 = gasket_dev_read_32(
 			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
@@ -602,9 +594,8 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
 		val1 = gasket_dev_read_32(
 			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
-		gasket_log_debug(
-			gasket_dev, "Allow HW clock gating 0x%x -> 0x%x", val0,
-			val1);
+		dev_dbg(gasket_dev->dev, "Allow HW clock gating 0x%x -> 0x%x\n",
+			val0, val1);
 	}
 
 	return 0;
@@ -668,7 +659,7 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev,
 	if (copy_from_user(&ibuf, argp, sizeof(ibuf)))
 		return -EFAULT;
 
-	gasket_log_debug(gasket_dev, "%s %llu", __func__, ibuf.enable);
+	dev_dbg(gasket_dev->dev, "%s %llu\n", __func__, ibuf.enable);
 
 	if (ibuf.enable) {
 		/* Quiesce AXI, gate GCB clock. */
@@ -709,13 +700,13 @@ static ssize_t sysfs_show(
 
 	gasket_dev = gasket_sysfs_get_device_data(device);
 	if (!gasket_dev) {
-		gasket_nodev_error("No Apex device sysfs mapping found");
+		dev_err(device, "No Apex device sysfs mapping found\n");
 		return -ENODEV;
 	}
 
 	gasket_attr = gasket_sysfs_get_attr(device, attr);
 	if (!gasket_attr) {
-		gasket_nodev_error("No Apex device sysfs attr data found");
+		dev_err(device, "No Apex device sysfs attr data found\n");
 		gasket_sysfs_put_device_data(device, gasket_dev);
 		return -ENODEV;
 	}
@@ -738,8 +729,8 @@ static ssize_t sysfs_show(
 					gasket_dev->page_table[0]));
 		break;
 	default:
-		gasket_log_debug(
-			gasket_dev, "Unknown attribute: %s", attr->attr.name);
+		dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
+			attr->attr.name);
 		ret = 0;
 		break;
 	}
-- 
2.18.0.345.g5c9ce644c3-goog

