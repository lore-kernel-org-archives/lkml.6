Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB2AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2646D2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ekRvCqVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfBEKZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:25:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52847 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfBEKZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:25:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so2984525wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K28XEDucrkZ5vgvjZiASy101nZ1AxRRv73xLLYx8KTo=;
        b=ekRvCqVm+xtU74RrKwAd41IXAQxFSUFWlIaLg+6J5y6MeIV8O0g8TlaAW2Eov0XQQm
         y/HjVMN0gITr/hb4ExYPvvq1spFo7qSblVl89fVAdjiaXYZOHZ2biaQ2mCmHDlUCJMKO
         ziNuBragCMqI+Ly6/ni8rdUm3AUkiSm2YaHwJGzSrzyaoI1yqR1mAalt0oQH36iIXWz1
         5t4awRrARZsiUJLbULx47sKoVI+hwQMwH0+C+BtKRaLfhP8auKY0BWqv9Y8UgKlcnSGT
         hgAwAzx4ES6MbvLyHyYJuYlXIHWEuqfWdOvWUuzE+ZFVFUiYX/U58UGXWV5pjxwNZk1r
         5Bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K28XEDucrkZ5vgvjZiASy101nZ1AxRRv73xLLYx8KTo=;
        b=UH1L6nIf7b0ZxszA8TfBjWaVos9TaNOQFotIDe/k25CdKbTsKLkHN7SXm2n997Cep4
         TN0lZBSS/kymq38SfXt96Tfmu2GeZyszX6ta1h3FmFtNi61jPj1C2nrSHei8ebw53tmz
         sP11mzo1fsPptqiwNryVmUFoa6A3J/I3C6k0zhzbIpmz22o6YEcOFAzzMwnw14aPJ4n5
         tDVrc41qA2DQ+IEidBk9Z0IwA/EzkKL62kzcqzltjByrU2++5ypjN1Sf8St/BlWYWips
         nkqWxXymANNVceMnqq2D1Y2ntP4jRie+UP+695G7jCtBGKUm3UrQiNADgPTmpcaTvyIK
         TYUw==
X-Gm-Message-State: AHQUAuYMKCo46o9CCVUukJr7fpZj+mHUK6eXjsorutgo+JcO9wdUMjM5
        rx1Ud5nXJTyPxsqt+FITcIkMMg==
X-Google-Smtp-Source: AHgI3Ib4vgR76sqHah7iOtB1dwjhpJLu9RRaSYtef1Gl8/yjMFKLzYEFWOGmumqju+OJB5OeNt9X9A==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr3113741wmk.152.1549362352910;
        Tue, 05 Feb 2019 02:25:52 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:25:52 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/8] usb: ohci-da8xx: add a helper pointer to &pdev->dev
Date:   Tue,  5 Feb 2019 11:25:40 +0100
Message-Id: <20190205102546.29457-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This improves readability by removing all the &pdev->dev dereferencing.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index c492c7e6f746..e8ede0b5e3f0 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -402,35 +402,35 @@ MODULE_DEVICE_TABLE(of, da8xx_ohci_ids);
 static int ohci_da8xx_probe(struct platform_device *pdev)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci;
+	struct device *dev = &pdev->dev;
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
 
-	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, &pdev->dev,
-				dev_name(&pdev->dev));
+	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, dev, dev_name(dev));
 	if (!hcd)
 		return -ENOMEM;
 
 	da8xx_ohci = to_da8xx_ohci(hcd);
 	da8xx_ohci->hcd = hcd;
 
-	da8xx_ohci->usb11_clk = devm_clk_get(&pdev->dev, NULL);
+	da8xx_ohci->usb11_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(da8xx_ohci->usb11_clk)) {
 		error = PTR_ERR(da8xx_ohci->usb11_clk);
 		if (error != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get clock.\n");
+			dev_err(dev, "Failed to get clock.\n");
 		goto err;
 	}
 
-	da8xx_ohci->usb11_phy = devm_phy_get(&pdev->dev, "usb-phy");
+	da8xx_ohci->usb11_phy = devm_phy_get(dev, "usb-phy");
 	if (IS_ERR(da8xx_ohci->usb11_phy)) {
 		error = PTR_ERR(da8xx_ohci->usb11_phy);
 		if (error != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get phy.\n");
+			dev_err(dev, "Failed to get phy.\n");
 		goto err;
 	}
 
-	da8xx_ohci->vbus_reg = devm_regulator_get_optional(&pdev->dev, "vbus");
+	da8xx_ohci->vbus_reg = devm_regulator_get_optional(dev, "vbus");
 	if (IS_ERR(da8xx_ohci->vbus_reg)) {
 		error = PTR_ERR(da8xx_ohci->vbus_reg);
 		if (error == -ENODEV) {
@@ -438,13 +438,13 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		} else if (error == -EPROBE_DEFER) {
 			goto err;
 		} else {
-			dev_err(&pdev->dev, "Failed to get regulator\n");
+			dev_err(dev, "Failed to get regulator\n");
 			goto err;
 		}
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, mem);
+	hcd->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(hcd->regs)) {
 		error = PTR_ERR(hcd->regs);
 		goto err;
-- 
2.20.1

