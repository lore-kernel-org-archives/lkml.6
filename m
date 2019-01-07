Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6588C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFE220989
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0JNb+9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfAGI0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:26:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43999 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:26:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so29472101lff.10;
        Mon, 07 Jan 2019 00:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObUIOmdOpVO5dWT+zxTi2qqvEuqO4GIPUo/3Daru638=;
        b=q0JNb+9zZ8uNq6UPhoswGBLW50PVnk93tTeFVmZrPz+Ue009VJZnSFi4Ge+WgD7jbU
         tVZtapM5tXlrLlNR68+SHROJPcligIjp2WWbWiO5hlYJ/odyjWogIH71YjiGkPExqSZ3
         m8AqvJCmj4IVg6Kw+golZY2xT+78Tp0dMJf3jSvyf2FlZPgjGlkXZcestyNi7zmMMA1l
         nQDOet1aqqNU9QMXzvrampX911dj6sWOZPAgBBEqNrPEg8etn8a/Wr1hDfcrKIE87ns9
         IWY+0W9RV857t9/p27XilJwWXIdE7c4IHBSUi+efiIsaa48+7aVoRuQtWDyeEEbKWCpD
         6Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObUIOmdOpVO5dWT+zxTi2qqvEuqO4GIPUo/3Daru638=;
        b=M6x2q2sJ7Atfokfg9QMgUrmjGN1Jhqe2ojWvL4u+LPocF8UksrFZp1eXAjivXDwv9P
         KQZNrXCkNL/R9Mf3/TjqqYhnAUzj1w2XdENG+gRBFScuixgLixWiSPUMw9TZz8xU9HBE
         YgK1aj4JKLDm1nWPCEYYdJ3Jq221SbVu3z8dkwCpzQNR0hF5hZ3YTzGdgb+SaWuFCGcC
         i+VMb44CLRu8ZMzhWVUewbKJ8q6JiE1GxBRXjsKx59ZtjRRMPL8dRY8pqbarlgHBoB3q
         ra+44PO67S9S1AG3t+r/xCoyuoIIg5/Q8V2SWRWsPmXaX3u9VHs0BsWLJesUGwjMvfqI
         UZxQ==
X-Gm-Message-State: AA+aEWYGiZafl0JIu0kDn2MLStpXAcjQTA+tV0JXNMifv/PGMEglAz8X
        v5MTbI2uPT4M7fm+jcJBU3o=
X-Google-Smtp-Source: AFSGD/VM7neB5HaWVflhS0NiJyO1evm05R+mDp4/iIk+H2UaJ89zT2qWXeqX2Tn/WAMuTc+tI48kyA==
X-Received: by 2002:a19:6806:: with SMTP id d6mr28828122lfc.48.1546849568183;
        Mon, 07 Jan 2019 00:26:08 -0800 (PST)
Received: from linux-veee.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 6sm13692196lfa.27.2019.01.07.00.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jan 2019 00:26:07 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] phy: bcm-ns-usb2: support updated DT binding with the CRU syscon
Date:   Mon,  7 Jan 2019 09:25:45 +0100
Message-Id: <20190107082545.5529-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190107082545.5529-1-zajec5@gmail.com>
References: <20190107082545.5529-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This adds support for the "syscon-cru" DT property which simply requires
using regmap to access CRU registers.

The old binding has been deprecated and stays as a fallback method.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/phy/broadcom/phy-bcm-ns-usb2.c | 44 +++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
index 58dff80e9386..8dc6835b941c 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
@@ -13,17 +13,23 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/regmap.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define CRU_USB2_CONTROL			0x64
+#define CRU_CLKSET_KEY				0x80
+
 struct bcm_ns_usb2 {
 	struct device *dev;
 	struct clk *ref_clk;
 	struct phy *phy;
+	struct regmap *cru;
 	void __iomem *dmu;
 };
 
@@ -31,6 +37,7 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 {
 	struct bcm_ns_usb2 *usb2 = phy_get_drvdata(phy);
 	struct device *dev = usb2->dev;
+	struct regmap *cru = usb2->cru;
 	void __iomem *dmu = usb2->dmu;
 	u32 ref_clk_rate, usb2ctl, usb_pll_ndiv, usb_pll_pdiv;
 	int err = 0;
@@ -48,7 +55,10 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 		goto err_clk_off;
 	}
 
-	usb2ctl = readl(dmu + BCMA_DMU_CRU_USB2_CONTROL);
+	if (cru)
+		regmap_read(cru, CRU_USB2_CONTROL, &usb2ctl);
+	else
+		usb2ctl = readl(dmu + BCMA_DMU_CRU_USB2_CONTROL);
 
 	if (usb2ctl & BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_PDIV_MASK) {
 		usb_pll_pdiv = usb2ctl;
@@ -62,15 +72,24 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 	usb_pll_ndiv = (1920000000 * usb_pll_pdiv) / ref_clk_rate;
 
 	/* Unlock DMU PLL settings with some magic value */
-	writel(0x0000ea68, dmu + BCMA_DMU_CRU_CLKSET_KEY);
+	if (cru)
+		regmap_write(cru, CRU_CLKSET_KEY, 0x0000ea68);
+	else
+		writel(0x0000ea68, dmu + BCMA_DMU_CRU_CLKSET_KEY);
 
 	/* Write USB 2.0 PLL control setting */
 	usb2ctl &= ~BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_MASK;
 	usb2ctl |= usb_pll_ndiv << BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_SHIFT;
-	writel(usb2ctl, dmu + BCMA_DMU_CRU_USB2_CONTROL);
+	if (cru)
+		regmap_write(cru, CRU_USB2_CONTROL, usb2ctl);
+	else
+		writel(usb2ctl, dmu + BCMA_DMU_CRU_USB2_CONTROL);
 
 	/* Lock DMU PLL settings */
-	writel(0x00000000, dmu + BCMA_DMU_CRU_CLKSET_KEY);
+	if (cru)
+		regmap_write(cru, CRU_CLKSET_KEY, 0x00000000);
+	else
+		writel(0x00000000, dmu + BCMA_DMU_CRU_CLKSET_KEY);
 
 err_clk_off:
 	clk_disable_unprepare(usb2->ref_clk);
@@ -86,6 +105,7 @@ static const struct phy_ops ops = {
 static int bcm_ns_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *cru_np;
 	struct bcm_ns_usb2 *usb2;
 	struct resource *res;
 	struct phy_provider *phy_provider;
@@ -95,11 +115,17 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	usb2->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmu");
-	usb2->dmu = devm_ioremap_resource(dev, res);
-	if (IS_ERR(usb2->dmu)) {
-		dev_err(dev, "Failed to map DMU regs\n");
-		return PTR_ERR(usb2->dmu);
+	cru_np = of_parse_phandle(dev->of_node, "syscon-cru", 0);
+	usb2->cru = syscon_node_to_regmap(cru_np);
+	if (IS_ERR(usb2->cru)) {
+		usb2->cru = NULL;
+
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmu");
+		usb2->dmu = devm_ioremap_resource(dev, res);
+		if (IS_ERR(usb2->dmu)) {
+			dev_err(dev, "Failed to map DMU regs\n");
+			return PTR_ERR(usb2->dmu);
+		}
 	}
 
 	usb2->ref_clk = devm_clk_get(dev, "phy-ref-clk");
-- 
2.13.7

