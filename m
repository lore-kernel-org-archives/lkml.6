Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C09CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166D720855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166D720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeKILUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:20:43 -0500
Received: from mx.socionext.com ([202.248.49.38]:41467 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeKILUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:20:41 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Nov 2018 10:42:19 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 254FC180D4F;
        Fri,  9 Nov 2018 10:42:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Nov 2018 10:42:20 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B7D8A1A03A2;
        Fri,  9 Nov 2018 10:42:18 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/4] reset: uniphier-usb3: Rename to reset-uniphier-glue
Date:   Fri,  9 Nov 2018 10:42:05 +0900
Message-Id: <1541727727-10821-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver works for controlling the reset lines including USB3
glue layer, however, this can be applied to other glue layers.
Now this patch renames the driver from "reset-uniphier-usb3" to
"reset-uniphier-glue".

At the same time, this changes CONFIG_RESET_UNIPHIER_USB3 to
CONFIG_RESET_UNIPHIER_GLUE.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/reset/Kconfig               |  10 +--
 drivers/reset/Makefile              |   2 +-
 drivers/reset/reset-uniphier-glue.c | 171 ++++++++++++++++++++++++++++++++++++
 drivers/reset/reset-uniphier-usb3.c | 171 ------------------------------------
 4 files changed, 177 insertions(+), 177 deletions(-)
 create mode 100644 drivers/reset/reset-uniphier-glue.c
 delete mode 100644 drivers/reset/reset-uniphier-usb3.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c21da9f..ef7f468 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -163,15 +163,15 @@ config RESET_UNIPHIER
 	  Say Y if you want to control reset signals provided by System Control
 	  block, Media I/O block, Peripheral Block.
 
-config RESET_UNIPHIER_USB3
-	tristate "USB3 reset driver for UniPhier SoCs"
+config RESET_UNIPHIER_GLUE
+	tristate "Reset driver in glue layer for UniPhier SoCs"
 	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
 	default ARCH_UNIPHIER
 	select RESET_SIMPLE
 	help
-	  Support for the USB3 core reset on UniPhier SoCs.
-	  Say Y if you want to control reset signals provided by
-	  USB3 glue layer.
+	  Support for peripheral core reset included in its own glue layer
+	  on UniPhier SoCs. Say Y if you want to control reset signals
+	  provided by the glue layer.
 
 config RESET_ZYNQ
 	bool "ZYNQ Reset Driver" if COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index d08e8b9..4570ecf 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -23,6 +23,6 @@ obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
-obj-$(CONFIG_RESET_UNIPHIER_USB3) += reset-uniphier-usb3.o
+obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
 
diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
new file mode 100644
index 0000000..1b8ea03
--- /dev/null
+++ b/drivers/reset/reset-uniphier-glue.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// reset-uniphier-glue.c - Glue layer reset driver for UniPhier
+// Copyright 2018 Socionext Inc.
+// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "reset-simple.h"
+
+#define MAX_CLKS	2
+#define MAX_RSTS	2
+
+struct uniphier_glue_reset_soc_data {
+	int nclks;
+	const char * const *clock_names;
+	int nrsts;
+	const char * const *reset_names;
+};
+
+struct uniphier_glue_reset_priv {
+	struct clk_bulk_data clk[MAX_CLKS];
+	struct reset_control *rst[MAX_RSTS];
+	struct reset_simple_data rdata;
+	const struct uniphier_glue_reset_soc_data *data;
+};
+
+static int uniphier_glue_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_glue_reset_priv *priv;
+	struct resource *res;
+	resource_size_t size;
+	const char *name;
+	int i, ret, nr;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data = of_device_get_match_data(dev);
+	if (WARN_ON(!priv->data || priv->data->nclks > MAX_CLKS ||
+		    priv->data->nrsts > MAX_RSTS))
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	size = resource_size(res);
+	priv->rdata.membase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->rdata.membase))
+		return PTR_ERR(priv->rdata.membase);
+
+	for (i = 0; i < priv->data->nclks; i++)
+		priv->clk[i].id = priv->data->clock_names[i];
+	ret = devm_clk_bulk_get(dev, priv->data->nclks, priv->clk);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < priv->data->nrsts; i++) {
+		name = priv->data->reset_names[i];
+		priv->rst[i] = devm_reset_control_get_shared(dev, name);
+		if (IS_ERR(priv->rst[i]))
+			return PTR_ERR(priv->rst[i]);
+	}
+
+	ret = clk_bulk_prepare_enable(priv->data->nclks, priv->clk);
+	if (ret)
+		return ret;
+
+	for (nr = 0; nr < priv->data->nrsts; nr++) {
+		ret = reset_control_deassert(priv->rst[nr]);
+		if (ret)
+			goto out_rst_assert;
+	}
+
+	spin_lock_init(&priv->rdata.lock);
+	priv->rdata.rcdev.owner = THIS_MODULE;
+	priv->rdata.rcdev.nr_resets = size * BITS_PER_BYTE;
+	priv->rdata.rcdev.ops = &reset_simple_ops;
+	priv->rdata.rcdev.of_node = dev->of_node;
+	priv->rdata.active_low = true;
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = devm_reset_controller_register(dev, &priv->rdata.rcdev);
+	if (ret)
+		goto out_rst_assert;
+
+	return 0;
+
+out_rst_assert:
+	while (nr--)
+		reset_control_assert(priv->rst[nr]);
+
+	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
+
+	return ret;
+}
+
+static int uniphier_glue_reset_remove(struct platform_device *pdev)
+{
+	struct uniphier_glue_reset_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < priv->data->nrsts; i++)
+		reset_control_assert(priv->rst[i]);
+
+	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
+
+	return 0;
+}
+
+static const char * const uniphier_pro4_clock_reset_names[] = {
+	"gio", "link",
+};
+
+static const struct uniphier_glue_reset_soc_data uniphier_pro4_data = {
+	.nclks = ARRAY_SIZE(uniphier_pro4_clock_reset_names),
+	.clock_names = uniphier_pro4_clock_reset_names,
+	.nrsts = ARRAY_SIZE(uniphier_pro4_clock_reset_names),
+	.reset_names = uniphier_pro4_clock_reset_names,
+};
+
+static const char * const uniphier_pxs2_clock_reset_names[] = {
+	"link",
+};
+
+static const struct uniphier_glue_reset_soc_data uniphier_pxs2_data = {
+	.nclks = ARRAY_SIZE(uniphier_pxs2_clock_reset_names),
+	.clock_names = uniphier_pxs2_clock_reset_names,
+	.nrsts = ARRAY_SIZE(uniphier_pxs2_clock_reset_names),
+	.reset_names = uniphier_pxs2_clock_reset_names,
+};
+
+static const struct of_device_id uniphier_glue_reset_match[] = {
+	{
+		.compatible = "socionext,uniphier-pro4-usb3-reset",
+		.data = &uniphier_pro4_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-usb3-reset",
+		.data = &uniphier_pxs2_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-usb3-reset",
+		.data = &uniphier_pxs2_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs3-usb3-reset",
+		.data = &uniphier_pxs2_data,
+	},
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, uniphier_glue_reset_match);
+
+static struct platform_driver uniphier_glue_reset_driver = {
+	.probe = uniphier_glue_reset_probe,
+	.remove = uniphier_glue_reset_remove,
+	.driver = {
+		.name = "uniphier-glue-reset",
+		.of_match_table = uniphier_glue_reset_match,
+	},
+};
+module_platform_driver(uniphier_glue_reset_driver);
+
+MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
+MODULE_DESCRIPTION("UniPhier Glue layer reset driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/reset-uniphier-usb3.c b/drivers/reset/reset-uniphier-usb3.c
deleted file mode 100644
index ffa1b19..0000000
--- a/drivers/reset/reset-uniphier-usb3.c
+++ /dev/null
@@ -1,171 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// reset-uniphier-usb3.c - USB3 reset driver for UniPhier
-// Copyright 2018 Socionext Inc.
-// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
-
-#include <linux/clk.h>
-#include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
-#include <linux/reset.h>
-
-#include "reset-simple.h"
-
-#define MAX_CLKS	2
-#define MAX_RSTS	2
-
-struct uniphier_usb3_reset_soc_data {
-	int nclks;
-	const char * const *clock_names;
-	int nrsts;
-	const char * const *reset_names;
-};
-
-struct uniphier_usb3_reset_priv {
-	struct clk_bulk_data clk[MAX_CLKS];
-	struct reset_control *rst[MAX_RSTS];
-	struct reset_simple_data rdata;
-	const struct uniphier_usb3_reset_soc_data *data;
-};
-
-static int uniphier_usb3_reset_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct uniphier_usb3_reset_priv *priv;
-	struct resource *res;
-	resource_size_t size;
-	const char *name;
-	int i, ret, nr;
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->data = of_device_get_match_data(dev);
-	if (WARN_ON(!priv->data || priv->data->nclks > MAX_CLKS ||
-		    priv->data->nrsts > MAX_RSTS))
-		return -EINVAL;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	size = resource_size(res);
-	priv->rdata.membase = devm_ioremap_resource(dev, res);
-	if (IS_ERR(priv->rdata.membase))
-		return PTR_ERR(priv->rdata.membase);
-
-	for (i = 0; i < priv->data->nclks; i++)
-		priv->clk[i].id = priv->data->clock_names[i];
-	ret = devm_clk_bulk_get(dev, priv->data->nclks, priv->clk);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < priv->data->nrsts; i++) {
-		name = priv->data->reset_names[i];
-		priv->rst[i] = devm_reset_control_get_shared(dev, name);
-		if (IS_ERR(priv->rst[i]))
-			return PTR_ERR(priv->rst[i]);
-	}
-
-	ret = clk_bulk_prepare_enable(priv->data->nclks, priv->clk);
-	if (ret)
-		return ret;
-
-	for (nr = 0; nr < priv->data->nrsts; nr++) {
-		ret = reset_control_deassert(priv->rst[nr]);
-		if (ret)
-			goto out_rst_assert;
-	}
-
-	spin_lock_init(&priv->rdata.lock);
-	priv->rdata.rcdev.owner = THIS_MODULE;
-	priv->rdata.rcdev.nr_resets = size * BITS_PER_BYTE;
-	priv->rdata.rcdev.ops = &reset_simple_ops;
-	priv->rdata.rcdev.of_node = dev->of_node;
-	priv->rdata.active_low = true;
-
-	platform_set_drvdata(pdev, priv);
-
-	ret = devm_reset_controller_register(dev, &priv->rdata.rcdev);
-	if (ret)
-		goto out_rst_assert;
-
-	return 0;
-
-out_rst_assert:
-	while (nr--)
-		reset_control_assert(priv->rst[nr]);
-
-	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
-
-	return ret;
-}
-
-static int uniphier_usb3_reset_remove(struct platform_device *pdev)
-{
-	struct uniphier_usb3_reset_priv *priv = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < priv->data->nrsts; i++)
-		reset_control_assert(priv->rst[i]);
-
-	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
-
-	return 0;
-}
-
-static const char * const uniphier_pro4_clock_reset_names[] = {
-	"gio", "link",
-};
-
-static const struct uniphier_usb3_reset_soc_data uniphier_pro4_data = {
-	.nclks = ARRAY_SIZE(uniphier_pro4_clock_reset_names),
-	.clock_names = uniphier_pro4_clock_reset_names,
-	.nrsts = ARRAY_SIZE(uniphier_pro4_clock_reset_names),
-	.reset_names = uniphier_pro4_clock_reset_names,
-};
-
-static const char * const uniphier_pxs2_clock_reset_names[] = {
-	"link",
-};
-
-static const struct uniphier_usb3_reset_soc_data uniphier_pxs2_data = {
-	.nclks = ARRAY_SIZE(uniphier_pxs2_clock_reset_names),
-	.clock_names = uniphier_pxs2_clock_reset_names,
-	.nrsts = ARRAY_SIZE(uniphier_pxs2_clock_reset_names),
-	.reset_names = uniphier_pxs2_clock_reset_names,
-};
-
-static const struct of_device_id uniphier_usb3_reset_match[] = {
-	{
-		.compatible = "socionext,uniphier-pro4-usb3-reset",
-		.data = &uniphier_pro4_data,
-	},
-	{
-		.compatible = "socionext,uniphier-pxs2-usb3-reset",
-		.data = &uniphier_pxs2_data,
-	},
-	{
-		.compatible = "socionext,uniphier-ld20-usb3-reset",
-		.data = &uniphier_pxs2_data,
-	},
-	{
-		.compatible = "socionext,uniphier-pxs3-usb3-reset",
-		.data = &uniphier_pxs2_data,
-	},
-	{ /* Sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, uniphier_usb3_reset_match);
-
-static struct platform_driver uniphier_usb3_reset_driver = {
-	.probe = uniphier_usb3_reset_probe,
-	.remove = uniphier_usb3_reset_remove,
-	.driver = {
-		.name = "uniphier-usb3-reset",
-		.of_match_table = uniphier_usb3_reset_match,
-	},
-};
-module_platform_driver(uniphier_usb3_reset_driver);
-
-MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
-MODULE_DESCRIPTION("UniPhier USB3 Reset Driver");
-MODULE_LICENSE("GPL");
-- 
2.7.4

