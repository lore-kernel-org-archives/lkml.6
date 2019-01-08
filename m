Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB1BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CBD206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTXB/OCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfAHMjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:39:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38523 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:39:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so2794347lfk.5;
        Tue, 08 Jan 2019 04:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8FOgRfMKbfzT3tBdIx3TKHsJ3k6/UdHZxOnEPkAZcw=;
        b=PTXB/OCx6POxkif7rLf0ZlgNqICerHQjnGiPEYMeg/ZA2Px2/L71QUce+hKgPCw3G6
         4fBpQUL/5TpjFUjXQ4MfA98k/DCdON9rMy5EIwVtjyBajpxK51J5A1g51JsDG41zgR7f
         bAP4yOIlVXWPHxLOoGMDNBtSoG69ppz6l28g/6SgRxBJ6lsbVNfeNUWCa3+bDNh2Loq3
         XciZo61BcZ7ukE4DCibpPwB+MIzXQJXmPMgNqYXPYqz6TDu+3hlvcBtjASK5lMZoz4Mz
         yiS/hNtpuTgs2xy/vjMRT9G8ibtF4e86R0LyowCSjOyNXTJz7t8K1r/GMCAnFIVdHK9E
         99HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8FOgRfMKbfzT3tBdIx3TKHsJ3k6/UdHZxOnEPkAZcw=;
        b=Qcgk78xt1DcVP7n7YpP0Iud94DFApeQEammnIKiMkZxQoh8Ym5UW1EXNks035eE4Ga
         zJNWn6txqDhWvBxfSSiGhUx+SyIhGOQCeQ1zTbsC8mY+X0D7Lx8uUVby0qWwVXfxoUpz
         Eoq9WcJ0jFIa9SBtD4sAiJsaPHsUWHSQP5LbGebO9v6FSS9zZWOI5YStyw1QhqCa4lVg
         Sev3hIeMuqZKonApTESzj9SKMr35mZARR+B7N5sPLxSxL1VsYmn1lwFAz7UPgQx2S80o
         7oXAXC4/EipE/mSCgScQocoAQe5d8qTNebbEkfZhbJJd828ULk+vNfTrWlkggGwGSztI
         Vi8A==
X-Gm-Message-State: AJcUukdz4/yXcM9UWJ/8b41s4Phwyg2tV9tM/xqLRpw0RP/hy/Dy6Lb4
        zTyncMMLv3MjXwbWv+TJvms=
X-Google-Smtp-Source: ALg8bN6KJwSdgaKAx8Q3pEgXBLTZJffCilHfUqSg27KHHOPG9Fo+yI3l8yJu7/DrVl87AG+/n7v8gw==
X-Received: by 2002:a19:2906:: with SMTP id p6mr922090lfp.17.1546951159463;
        Tue, 08 Jan 2019 04:39:19 -0800 (PST)
Received: from samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y24sm12829527lfj.17.2019.01.08.04.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Jan 2019 04:39:18 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/2] phy: bcm-ns-usb2: support updated DT binding with the CRU syscon
Date:   Tue,  8 Jan 2019 13:39:07 +0100
Message-Id: <20190108123907.19816-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190108123907.19816-1-zajec5@gmail.com>
References: <20190107082545.5529-1-zajec5@gmail.com>
 <20190108123907.19816-1-zajec5@gmail.com>
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
V2: Add bcm_ns_usb2_(read|write) & use syscon_regmap_lookup_by_phandle
---
 drivers/phy/broadcom/phy-bcm-ns-usb2.c | 50 +++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
index 58dff80e9386..b9d3ba6f9609 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
@@ -13,25 +13,50 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
+#define CRU_USB2_CONTROL			0x64
+#define CRU_CLKSET_KEY				0x80
+
+#define DMU_CRU_OFFSET				0x100
+
 struct bcm_ns_usb2 {
 	struct device *dev;
 	struct clk *ref_clk;
 	struct phy *phy;
+	struct regmap *cru;
 	void __iomem *dmu;
 };
 
+static void bcm_ns_usb2_read(struct bcm_ns_usb2 *usb2, unsigned int reg,
+			     unsigned int *val)
+{
+	if (usb2->cru)
+		regmap_read(usb2->cru, reg, val);
+	else
+		*val = readl(usb2->dmu + DMU_CRU_OFFSET + reg);
+}
+
+static void bcm_ns_usb2_write(struct bcm_ns_usb2 *usb2, unsigned int reg,
+			      unsigned int val)
+{
+	if (usb2->cru)
+		regmap_write(usb2->cru, reg, val);
+	else
+		writel(val, usb2->dmu + DMU_CRU_OFFSET + reg);
+}
+
 static int bcm_ns_usb2_phy_init(struct phy *phy)
 {
 	struct bcm_ns_usb2 *usb2 = phy_get_drvdata(phy);
 	struct device *dev = usb2->dev;
-	void __iomem *dmu = usb2->dmu;
 	u32 ref_clk_rate, usb2ctl, usb_pll_ndiv, usb_pll_pdiv;
 	int err = 0;
 
@@ -48,7 +73,7 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 		goto err_clk_off;
 	}
 
-	usb2ctl = readl(dmu + BCMA_DMU_CRU_USB2_CONTROL);
+	bcm_ns_usb2_read(usb2, CRU_USB2_CONTROL, &usb2ctl);
 
 	if (usb2ctl & BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_PDIV_MASK) {
 		usb_pll_pdiv = usb2ctl;
@@ -62,15 +87,15 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
 	usb_pll_ndiv = (1920000000 * usb_pll_pdiv) / ref_clk_rate;
 
 	/* Unlock DMU PLL settings with some magic value */
-	writel(0x0000ea68, dmu + BCMA_DMU_CRU_CLKSET_KEY);
+	bcm_ns_usb2_write(usb2, CRU_CLKSET_KEY, 0x0000ea68);
 
 	/* Write USB 2.0 PLL control setting */
 	usb2ctl &= ~BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_MASK;
 	usb2ctl |= usb_pll_ndiv << BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_SHIFT;
-	writel(usb2ctl, dmu + BCMA_DMU_CRU_USB2_CONTROL);
+	bcm_ns_usb2_write(usb2, CRU_USB2_CONTROL, usb2ctl);
 
 	/* Lock DMU PLL settings */
-	writel(0x00000000, dmu + BCMA_DMU_CRU_CLKSET_KEY);
+	bcm_ns_usb2_write(usb2, CRU_CLKSET_KEY, 0x00000000);
 
 err_clk_off:
 	clk_disable_unprepare(usb2->ref_clk);
@@ -95,11 +120,16 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	usb2->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmu");
-	usb2->dmu = devm_ioremap_resource(dev, res);
-	if (IS_ERR(usb2->dmu)) {
-		dev_err(dev, "Failed to map DMU regs\n");
-		return PTR_ERR(usb2->dmu);
+	usb2->cru = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon-cru");
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

