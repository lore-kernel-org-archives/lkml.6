Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CADAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAD52084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uLye05mH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBKKhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:37:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55456 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfBKKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:37:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so16680331wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORsjA8hmqOYVa1A6z58C/tpqF85yI2kmPo177hZON40=;
        b=uLye05mHf5U4mdu8gXtjfTR+N3aOWDgsG2T1ERC4B3Socyqgmm/3fxEawS5ubPSdFG
         B/ugTQ69/ccJCN00HR4Lcd5V4LlAZZKtW1s8Og3uVxvxvXrVJyE11GUsT9OsoPTGzUHM
         KuzWsf48SBy2Y5Bus0/mXAoubrViDagkXNF2DHWvAg8468CqDAeNXfahxXHfjuX+acWV
         v+sU48xODUB6NESxzJW5iJF4xcMRX9IPNV7u8mxCsTi/tTgI90a5scml1fnBDrVw1L4i
         fdXYERqFuxqjpOg1epP/K3xE6iVPojWA+jj910LrTB/6BG8TRWFPJwSHGeuqSaBOuHeZ
         Djyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORsjA8hmqOYVa1A6z58C/tpqF85yI2kmPo177hZON40=;
        b=gtYCHU7K2OjbOg3kLEwgkSkMvKlpKaRpg1VlX+7NDp+XsSp2X9aO6BzCg+E+3h/wTP
         CZvjYZad3XiSUpz6Xz22eMVu45s889tuawjdug3/GclNDyfTTmt8jhqHqfLxg8/lLWaW
         0EvoWMxmMjI8hLghHnrV9+zhMvonsluMrGy8EBi3xltUMvNsgVlEZ9mLbOo93JsJgPK9
         CR7RrYmEgiHBlUSLrbTXwL2T2A/qmLV/6AP2ZX6xSfGzCt/6/64dbjKwsz5ti/JB6dYI
         gGVolvIXaMnwH/yWurVothX3wHGlegeKmUoOYUubjnEhmlrOF1aq439UPNW9/lf5GTt3
         ebjg==
X-Gm-Message-State: AHQUAuay1iYqowo/temOw/nUfg4BhOy3YkZTvLfQpqmMobMgFgLIvWB0
        Z1Q8Vxc0bNN4pEkCQYsiiPp6Pw==
X-Google-Smtp-Source: AHgI3Ib/RRpS7Aag0oclwa7+AqIq9+WfvoGs3rvHUtSqAKvhDoU0qM6dtbyLVU0XyAbi8y51UGZqXw==
X-Received: by 2002:a1c:2408:: with SMTP id k8mr8550037wmk.110.1549881428735;
        Mon, 11 Feb 2019 02:37:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:37:08 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/8] usb: ohci-da8xx: add a helper pointer to &pdev->dev
Date:   Mon, 11 Feb 2019 11:36:56 +0100
Message-Id: <20190211103702.4277-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a helper pointer to &pdev->dev. This improves readability by
removing all the &pdev->dev dereferencing.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
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

