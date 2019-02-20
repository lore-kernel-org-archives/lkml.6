Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD742183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br2Z+EZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBTFSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:14 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51840 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfBTFSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:12 -0500
Received: by mail-it1-f193.google.com with SMTP id y184so12455511itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dpQnCqYK8zQeRAaUTV8LjE1UVmbI8+tnujnQmz5gcr8=;
        b=Br2Z+EZjM1fBYP5AaRzSQRwuIiAYydfoVFnAOTyb0sZ3rnjLysp6rDBJp691H/cv/g
         7j3nHRyAO/h4P33RdOmJz+Um8NIj2Lon0S/YUcs6zuIetuIL8YXNatU2MgQoLGxFy8Fs
         HF3TreY9dSJeVcaR9b3VoBRWvTyII7Hp1PtrhhbLXXQXpTrlYh8I/ngXEs9c0StVwUH+
         fO2XkZS5SsB/AL+IJtlHZzFarjFKUhCwr3akIOFbDMuuFEwIntgxMhjHDGWDuNPtinAq
         5GhaCCZkziZgEfhlhXMGb5RMkJE9z7qTvPzG9N+dI+1enDxQNb11PDhMKRDaeBoRLg4k
         84+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dpQnCqYK8zQeRAaUTV8LjE1UVmbI8+tnujnQmz5gcr8=;
        b=cji7RNgjgDZ5YxXJSPrE64yzOb3JS0S7R0eumtitdgln2XciPMyeWLZhUR0lGoNDqA
         CcJavLNzU/WHkBezhosEXYxGBz5Z764Nwp7SBRLUjl2O5XsTfo0RQCUhAATOwO56pxL+
         0/jURiVY3ZF8c9cHxPxOuki5cXL4M3r9AYZdyule3y0ivEqmnkUIVtQLs4R8N2uncjjv
         htFiWonTLqVRSJClcewZa4wVnYnJ6/jPyJHOtZ/1TdN9gg3V/oBr7vxYPcOuQJvK+hTq
         HVEuY0NpFdt3UM5DXW/ydCzLHTP8ieGfd0EkgkuHfG7wGGR40sMFGK5D0SsH/4rh/Yav
         BIBA==
X-Gm-Message-State: AHQUAuamskgLiCYCiHxc97blmWx8jBBFglnabmFtIBsuNMGz62NBDCFR
        ol40RtRq6ifbdn7cFqmdHrc=
X-Google-Smtp-Source: AHgI3Ib5XAks5sISvEEY6kgz40go36c4VajsvKAn+/Qu+3OESh6uCG57Q6V8J5z62fboRr/lfR3eyw==
X-Received: by 2002:a6b:c544:: with SMTP id v65mr16636993iof.222.1550639891392;
        Tue, 19 Feb 2019 21:18:11 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:10 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 05/10] staging: mt7621-mmc: Use pinctrl subsystem to select SDXC pin mode
Date:   Tue, 19 Feb 2019 22:17:49 -0700
Message-Id: <20190220051754.12195-6-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver previously grabbed the SD pins for itself, ignoring the pin
controller.  Replace this direct register access with appropriate calls
to the pinctrl subsystem.

This also allows this driver to work on related devices that have a
different pin controller mapping, such as the MT7688.  The hardcoded
bit index was incorrect on that device.

This change could break SD controller functionality on existing devices
whose device trees do not specify a pin controller and state for the SD
node.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index a7c7ec0d7bbb..97ed7510e96d 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -38,6 +38,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/interrupt.h>
 
 #include <linux/mmc/host.h>
@@ -1599,6 +1600,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	struct msdc_host *host;
 	struct msdc_hw *hw;
 	int ret;
+	struct pinctrl *pctrl;
+	struct pinctrl_state *pins_default;
 
 	hw = &msdc0_hw;
 
@@ -1671,6 +1674,25 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->mrq = NULL;
 
+	/* Read pin control settings from device tree */
+	pctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(pctrl)) {
+		ret = PTR_ERR(pctrl);
+		dev_err(&pdev->dev, "Cannot find pinctrl in device tree\n");
+		goto host_free;
+	}
+
+	pins_default = pinctrl_lookup_state(pctrl, PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(pins_default)) {
+		ret = PTR_ERR(pins_default);
+		dev_err(&pdev->dev, "Cannot find pinctrl state default\n");
+		goto host_free;
+	}
+
+	ret = pinctrl_select_state(pctrl, pins_default);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "Cannot select pinctrl state\n");
+
 	dma_coerce_mask_and_coherent(mmc_dev(mmc), DMA_BIT_MASK(32));
 
 	/* using dma_alloc_coherent*/  /* todo: using 1, for all 4 slots */
@@ -1822,12 +1844,6 @@ static struct platform_driver mt_msdc_driver = {
 static int __init mt_msdc_init(void)
 {
 	int ret;
-	u32 reg;
-
-	// Set the pins for sdxc to sdxc mode
-	//FIXME: this should be done by pinctl and not by the sd driver
-	reg = readl((void __iomem *)(RALINK_SYSCTL_BASE + 0x60)) & ~(0x3 << 18);
-	writel(reg, (void __iomem *)(RALINK_SYSCTL_BASE + 0x60));
 
 	ret = platform_driver_register(&mt_msdc_driver);
 	if (ret) {
-- 
2.20.1

