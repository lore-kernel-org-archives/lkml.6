Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B83CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE5F2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq9DXu6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfAWWzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:55:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37603 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfAWWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:55:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so1933745pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4WZVbXflNyi2B86ocdbFcoByaoSrHI2wAdzhIiL6Trs=;
        b=eq9DXu6PQ6cdcasDYU0RhzADNFKg5SED5+iK6A/1Sxru1Z7sNBDsvDfSeTf1pdC7k4
         CWUV2pXivwblZxew+d4C+N171XMkJzPXw7zV/69dvMLZZFEAC5KhCCyR520UICewQ8vj
         UFWeg6NtSnl0VJBEiZfcbj1zIdcOo+C1k/tT7viywBLrlqd3Pqz3VCYi02BddhHlk7XJ
         XdiM/5ue/5Tqi8wkgIroRIu8/02UTBuRc4jz+ydAJoF1uRzhjbbmue/Zf9oTIVg3I3tW
         N/2jejYJWJNvdmXLSz6Bax7cWSkbDDwLsJCDYXGbVp9HvC9fNNYEOgz+7OG2iV9Txg8T
         BivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4WZVbXflNyi2B86ocdbFcoByaoSrHI2wAdzhIiL6Trs=;
        b=As4PGAghbz8fC6x/DQLQhJctuvPadtztXkm2PkJ23iwNkxCurjhCJp6K5Kc/IRmcjx
         r9Pw5AMB36+wWJQpKMq9ZXE9TGVVKLIMLFB1eKFmPmnOIpvjKo347DoHcgfhF2w8a2KU
         jWKt0wDBRPXrT5PiVxCk2LHyx5Y6Z1NwKWIbGqVLpP5K/Zkhs6o4w9T35x7JsQMmripg
         kzlbnQlWyIDwwyp6WSJVNQZ+nM6U+XI6AsrjYRsya9n/mJBd8wwsI3vJAR88qqgmM38M
         MvoABoGYoHnQRj9Px1E8P4WxODKGROmel98oEkHsktVc30+DSZ+Pc+ycxlEafiY0nVGr
         T8xA==
X-Gm-Message-State: AJcUukfG8jQqvd7MXEj8Wb/bYAzVMoNrLww2AUeneaqL4MrBsgyhgEru
        lBEBGcVWbLux9ssZZkgBP53vCF+J
X-Google-Smtp-Source: ALg8bN5hY2fK9oq8SC/eikWU201RUpdua4mcjuvtZAdD/Iq2k0r84OWaerkZFp66Xkg36Nw+JXP/fw==
X-Received: by 2002:a63:9501:: with SMTP id p1mr3731484pgd.149.1548284102276;
        Wed, 23 Jan 2019 14:55:02 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b9sm23532435pfi.118.2019.01.23.14.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 14:55:01 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, paul.gortmaker@windriver.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH reset/next] reset: Add Broadcom STB SW_INIT reset controller driver
Date:   Wed, 23 Jan 2019 14:54:36 -0800
Message-Id: <20190123225439.32622-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for resetting blocks through the Linux reset controller
subsystem when reset lines are provided through a SW_INIT-style reset
controller on Broadcom STB SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Philipp,

This is a replacement patch for what is currently in your reset/next
branch.

Thank you!

 drivers/reset/Kconfig         |   8 +++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-brcmstb.c | 132 ++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/reset/reset-brcmstb.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2e01bd833ffd..d9a02b7f90cf 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -40,6 +40,14 @@ config RESET_BERLIN
 	help
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
+config RESET_BRCMSTB
+	tristate "Broadcom STB reset controller"
+	depends on ARCH_BRCMSTB || COMPILE_TEST
+	default ARCH_BRCMSTB
+	help
+	  This enables the reset controller driver for Broadcom STB SoCs using
+	  a SUN_TOP_CTRL_SW_INIT style controller.
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index dc7874df78d9..7395db2cb1dd 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
+obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
new file mode 100644
index 000000000000..a608f445dad6
--- /dev/null
+++ b/drivers/reset/reset-brcmstb.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Broadcom STB generic reset controller for SW_INIT style reset controller
+ *
+ * Author: Florian Fainelli <f.fainelli@gmail.com>
+ * Copyright (C) 2018 Broadcom
+ */
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/types.h>
+
+struct brcmstb_reset {
+	void __iomem *base;
+	struct reset_controller_dev rcdev;
+};
+
+#define SW_INIT_SET		0x00
+#define SW_INIT_CLEAR		0x04
+#define SW_INIT_STATUS		0x08
+
+#define SW_INIT_BIT(id)		BIT((id) & 0x1f)
+#define SW_INIT_BANK(id)	((id) >> 5)
+
+/* A full bank contains extra registers that we are not utilizing but still
+ * qualify as a single bank.
+ */
+#define SW_INIT_BANK_SIZE	0x18
+
+static inline
+struct brcmstb_reset *to_brcmstb(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct brcmstb_reset, rcdev);
+}
+
+static int brcmstb_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv = to_brcmstb(rcdev);
+
+	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_SET);
+
+	return 0;
+}
+
+static int brcmstb_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv = to_brcmstb(rcdev);
+
+	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_CLEAR);
+	/* Maximum reset delay after de-asserting a line and seeing block
+	 * operation is typically 14us for the worst case, build some slack
+	 * here.
+	 */
+	usleep_range(100, 200);
+
+	return 0;
+}
+
+static int brcmstb_reset_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv = to_brcmstb(rcdev);
+
+	return readl_relaxed(priv->base + off + SW_INIT_STATUS) &
+			     SW_INIT_BIT(id);
+}
+
+static const struct reset_control_ops brcmstb_reset_ops = {
+	.assert	= brcmstb_reset_assert,
+	.deassert = brcmstb_reset_deassert,
+	.status = brcmstb_reset_status,
+};
+
+static int brcmstb_reset_probe(struct platform_device *pdev)
+{
+	struct device *kdev = &pdev->dev;
+	struct brcmstb_reset *priv;
+	struct resource *res;
+
+	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
+	    !IS_ALIGNED(resource_size(res), SW_INIT_BANK_SIZE)) {
+		dev_err(kdev, "incorrect register range\n");
+		return -EINVAL;
+	}
+
+	priv->base = devm_ioremap_resource(kdev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	dev_set_drvdata(kdev, priv);
+
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.nr_resets = DIV_ROUND_DOWN_ULL(resource_size(res),
+						   SW_INIT_BANK_SIZE) * 32;
+	priv->rcdev.ops = &brcmstb_reset_ops;
+	priv->rcdev.of_node = kdev->of_node;
+	/* Use defaults: 1 cell and simple xlate function */
+
+	return devm_reset_controller_register(kdev, &priv->rcdev);
+}
+
+static const struct of_device_id brcmstb_reset_of_match[] = {
+	{ .compatible = "brcm,brcmstb-reset" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver brcmstb_reset_driver = {
+	.probe	= brcmstb_reset_probe,
+	.driver	= {
+		.name = "brcmstb-reset",
+		.of_match_table = brcmstb_reset_of_match,
+	},
+};
+module_platform_driver(brcmstb_reset_driver);
+
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("Broadcom STB reset controller");
+MODULE_LICENSE("GPL");
-- 
2.17.1

