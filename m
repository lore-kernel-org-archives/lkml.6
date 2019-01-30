Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DCFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1102184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAw6gyHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbfA3Suq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:50:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45728 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfA3Suo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:50:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so581217wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecUbVsN8uqs8tjjRxYkvRQ9Yo8oPmLrGQCqfZU0F2EQ=;
        b=OAw6gyHz3ai1Trh6BL/CpGom+DzR7YmhIGc5eo7nsm9kU0EMcA2ceu5udXcMz2SW+v
         coNFE/y4zgdLKkYMQyoe/7TUojyiwYdAs4C/5HmDEuElFYXlmyTamSmplU59ESVL01ci
         hIPTGKgHx86YK/v0DbhtrFm0Ffkbruq7qb2g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecUbVsN8uqs8tjjRxYkvRQ9Yo8oPmLrGQCqfZU0F2EQ=;
        b=KMvETpPL6nIZ6zFTVbF8LtnQqk51tREHN0h7bNeH74eV010kUVOALnMUHvcwb5wjwv
         yVjM2UcOoLMIA+lUm3Vg57ujU7eLBvXWA/PXIxhZsVFbawuDp/V0Eymhfd/QNUPruRjp
         FVo7Snpew5yJXcNHYbRQkjjsAhBhXGl5jviw0nSjupDPAcPeMN2wQq70X3rEYdpY60wh
         UWKz+8Z1byhC9OutZmLn/qVeZ2k0QCMOY4mjDROmqLiA9iLkrCXiL9yjbnWY9f+9jRrE
         /jTP5Rd4yYHK4aOYkBxo3Ltfly5hjE7Y/iEs6BW2iFsDixmI8Qcnpo6brXdlT1k/JDO3
         di/A==
X-Gm-Message-State: AJcUukeQZeBwLoNlwwWAgELISudSN07PEtZywy8QpGOceVrLtAvPpFiR
        XxuickJv2OXdQTJDkxIAqbfPHw==
X-Google-Smtp-Source: ALg8bN6y9ilqz1Ae1LF1JzQsoxZQfHdhx5/qF1yawttps9brp1CcynGbUKKl0i5hQeOwS8cauEoKbw==
X-Received: by 2002:adf:b783:: with SMTP id s3mr32733611wre.274.1548874242467;
        Wed, 30 Jan 2019 10:50:42 -0800 (PST)
Received: from localhost.localdomain (99.red-79-146-83.dynamicip.rima-tde.net. [79.146.83.99])
        by smtp.gmail.com with ESMTPSA id a17sm2802575wrs.58.2019.01.30.10.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 10:50:41 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org
Cc:     shawn.guo@linaro.org, vkoul@kernel.org, khasim.mohammed@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] phy: qualcomm: usb: Add SuperSpeed PHY driver
Date:   Wed, 30 Jan 2019 19:50:31 +0100
Message-Id: <20190130185031.24798-3-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130185031.24798-1-jorge.ramirez-ortiz@linaro.org>
References: <20190130185031.24798-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controls Qualcomm's SS phy 1.0.0 implemented in the QCS404 and some
other Qualcomm platforms.

Based on Sriharsha Allenki's <sallenki@codeaurora.org> original code.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/phy/qualcomm/Kconfig           |  11 +
 drivers/phy/qualcomm/Makefile          |   1 +
 drivers/phy/qualcomm/phy-qcom-usb-ss.c | 328 +++++++++++++++++++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 32f7d34eb784..a8dc550d25fb 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -82,3 +82,14 @@ config PHY_QCOM_USB_HSIC
 	select GENERIC_PHY
 	help
 	  Support for the USB HSIC ULPI compliant PHY on QCOM chipsets.
+
+config PHY_QCOM_USB_SS
+	tristate "Qualcomm USB SS PHY driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
+	select GENERIC_PHY
+	help
+	  Enable this to support the Super-Speed USB transceiver on Qualcomm
+	  chips. This driver supports the PHY which uses the QSCRATCH-based
+	  register set for its control sequences, normally paired with newer
+	  DWC3-based Super-Speed controllers on Qualcomm SoCs.
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index c56efd3af205..d594d532d137 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PHY_QCOM_UFS_14NM)		+= phy-qcom-ufs-qmp-14nm.o
 obj-$(CONFIG_PHY_QCOM_UFS_20NM)		+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
 obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
+obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
diff --git a/drivers/phy/qualcomm/phy-qcom-usb-ss.c b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
new file mode 100644
index 000000000000..9e5f4fd9c3a5
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012-2014,2017 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#define PHY_CTRL0			0x6C
+#define PHY_CTRL1			0x70
+#define PHY_CTRL2			0x74
+#define PHY_CTRL4			0x7C
+
+/* PHY_CTRL bits */
+#define REF_PHY_EN			BIT(0)
+#define LANE0_PWR_ON			BIT(2)
+#define SWI_PCS_CLK_SEL			BIT(4)
+#define TST_PWR_DOWN			BIT(4)
+#define PHY_RESET			BIT(7)
+
+#define NUM_BULK_CLKS	3
+#define NUM_BULK_REGS	2
+
+struct ssphy_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct reset_control *reset_com;
+	struct reset_control *reset_phy;
+	struct regulator_bulk_data regs[NUM_BULK_REGS];
+	struct clk_bulk_data clks[NUM_BULK_CLKS];
+	/* optional vbus regulator */
+	struct vbus_regulator {
+		struct regulator *consumer;
+		bool voted; /* regulator balancing: extcon controlled voltage */
+	} vbus;
+	enum phy_mode mode;
+};
+
+static inline void qcom_ssphy_updatel(void __iomem *addr, u32 mask, u32 val)
+{
+	writel((readl(addr) & ~mask) | val, addr);
+}
+
+static inline int qcom_ssphy_vbus_enable(struct vbus_regulator *vbus)
+{
+	struct regulator *consumer = vbus->consumer;
+	int ret;
+
+	if (vbus->voted || !consumer)
+		return 0;
+
+	ret = regulator_enable(consumer);
+	if (!ret) {
+		/* use count only increments on success */
+		vbus->voted = true;
+	}
+
+	return ret;
+}
+
+static inline int qcom_ssphy_vbus_disable(struct vbus_regulator *vbus)
+{
+	struct regulator *consumer = vbus->consumer;
+
+	if (!vbus->voted || !consumer)
+		return 0;
+
+	vbus->voted = false;
+
+	return regulator_disable(consumer);
+}
+
+static int qcom_ssphy_vbus_ctrl(struct vbus_regulator *vbus, enum phy_mode mode)
+{
+	if (mode == PHY_MODE_INVALID)
+		return 0;
+
+	/* gadget attached */
+	if (mode == PHY_MODE_USB_HOST)
+		return qcom_ssphy_vbus_enable(vbus);
+
+	/* USB_DEVICE: gadget removed: enable detection */
+	return qcom_ssphy_vbus_disable(vbus);
+}
+
+static int qcom_ssphy_do_reset(struct ssphy_priv *priv)
+{
+	int ret;
+
+	if (!priv->reset_com) {
+		qcom_ssphy_updatel(priv->base + PHY_CTRL1, PHY_RESET,
+				   PHY_RESET);
+		usleep_range(10, 20);
+		qcom_ssphy_updatel(priv->base + PHY_CTRL1, PHY_RESET, 0);
+	} else {
+		ret = reset_control_assert(priv->reset_com);
+		if (ret) {
+			dev_err(priv->dev, "Failed to assert reset com\n");
+			return ret;
+		}
+
+		ret = reset_control_assert(priv->reset_phy);
+		if (ret) {
+			dev_err(priv->dev, "Failed to assert reset phy\n");
+			return ret;
+		}
+
+		usleep_range(10, 20);
+
+		ret = reset_control_deassert(priv->reset_com);
+		if (ret) {
+			dev_err(priv->dev, "Failed to deassert reset com\n");
+			return ret;
+		}
+
+		ret = reset_control_deassert(priv->reset_phy);
+		if (ret) {
+			dev_err(priv->dev, "Failed to deassert reset phy\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int qcom_ssphy_power_on(struct phy *phy)
+{
+	struct ssphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = regulator_bulk_enable(NUM_BULK_REGS, priv->regs);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(NUM_BULK_CLKS, priv->clks);
+	if (ret)
+		goto err_disable_regulator;
+
+	/* depending on the extcon reported mode, enable or disable vbus */
+	ret = qcom_ssphy_vbus_ctrl(&priv->vbus, priv->mode);
+	if (ret)
+		goto err_disable_clock;
+
+	ret = qcom_ssphy_do_reset(priv);
+	if (ret)
+		goto err_disable_vbus;
+
+	writeb(SWI_PCS_CLK_SEL, priv->base + PHY_CTRL0);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, LANE0_PWR_ON);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, REF_PHY_EN);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, 0);
+
+	return 0;
+
+err_disable_vbus:
+	qcom_ssphy_vbus_disable(&priv->vbus);
+err_disable_clock:
+	clk_bulk_disable_unprepare(NUM_BULK_CLKS, priv->clks);
+err_disable_regulator:
+	regulator_bulk_disable(NUM_BULK_REGS, priv->regs);
+
+	return ret;
+}
+
+static int qcom_ssphy_power_off(struct phy *phy)
+{
+	struct ssphy_priv *priv = phy_get_drvdata(phy);
+
+	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, 0);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, 0);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, TST_PWR_DOWN);
+
+	clk_bulk_disable_unprepare(NUM_BULK_CLKS, priv->clks);
+	regulator_bulk_disable(NUM_BULK_REGS, priv->regs);
+	qcom_ssphy_vbus_disable(&priv->vbus);
+
+	return 0;
+}
+
+static int qcom_ssphy_init_clock(struct ssphy_priv *priv)
+{
+	priv->clks[0].id = "ref";
+	priv->clks[1].id = "phy";
+	priv->clks[2].id = "pipe";
+
+	return devm_clk_bulk_get(priv->dev, NUM_BULK_CLKS, priv->clks);
+}
+
+static int qcom_ssphy_init_regulator(struct ssphy_priv *priv)
+{
+	int ret;
+
+	priv->regs[0].supply = "vdd";
+	priv->regs[1].supply = "vdda1p8";
+	ret = devm_regulator_bulk_get(priv->dev, NUM_BULK_REGS, priv->regs);
+	if (ret)
+		return ret;
+
+	priv->vbus.voted = false;
+	priv->vbus.consumer = devm_regulator_get_optional(priv->dev, "vbus");
+	if (IS_ERR(priv->vbus.consumer)) {
+		if (PTR_ERR(priv->vbus.consumer) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		/* regulator_get_optional does not return NULL if not found */
+		priv->vbus.consumer = NULL;
+	}
+
+	return 0;
+}
+
+static int qcom_ssphy_init_reset(struct ssphy_priv *priv)
+{
+	priv->reset_com = devm_reset_control_get_optional(priv->dev, "com");
+	if (IS_ERR(priv->reset_com)) {
+		dev_err(priv->dev, "Failed to get reset control com\n");
+		return PTR_ERR(priv->reset_com);
+	}
+
+	if (priv->reset_com) {
+		/* if reset_com is present, reset_phy is no longer optional */
+		priv->reset_phy = devm_reset_control_get(priv->dev, "phy");
+		if (IS_ERR(priv->reset_phy)) {
+			dev_err(priv->dev, "Failed to get reset control phy\n");
+			return PTR_ERR(priv->reset_phy);
+		}
+	}
+
+	return 0;
+}
+
+static int qcom_ssphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct ssphy_priv *priv = phy_get_drvdata(phy);
+
+	if (!priv->vbus.consumer)
+		return 0;
+
+	if (mode != PHY_MODE_USB_HOST && mode != PHY_MODE_USB_DEVICE)
+		return -EINVAL;
+
+	priv->mode = mode;
+	dev_dbg(priv->dev, "mode %d", mode);
+
+	return qcom_ssphy_vbus_ctrl(&priv->vbus, priv->mode);
+}
+
+static const struct phy_ops qcom_ssphy_ops = {
+	.set_mode = qcom_ssphy_set_mode,
+	.power_off = qcom_ssphy_power_off,
+	.power_on = qcom_ssphy_power_on,
+	.owner = THIS_MODULE,
+};
+
+static int qcom_ssphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct ssphy_priv *priv;
+	struct resource *res;
+	struct phy *phy;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(struct ssphy_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->mode = PHY_MODE_INVALID;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = qcom_ssphy_init_clock(priv);
+	if (ret)
+		return ret;
+
+	ret = qcom_ssphy_init_reset(priv);
+	if (ret)
+		return ret;
+
+	ret = qcom_ssphy_init_regulator(priv);
+	if (ret)
+		return ret;
+
+	phy = devm_phy_create(dev, dev->of_node, &qcom_ssphy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "Failed to create the SS phy\n");
+		return PTR_ERR(phy);
+	}
+
+	phy_set_drvdata(phy, priv);
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id qcom_ssphy_match[] = {
+	{ .compatible = "qcom,usb-ssphy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_ssphy_match);
+
+static struct platform_driver qcom_ssphy_driver = {
+	.probe		= qcom_ssphy_probe,
+	.driver = {
+		.name	= "qcom_usb_ssphy",
+		.of_match_table = qcom_ssphy_match,
+	},
+};
+module_platform_driver(qcom_ssphy_driver);
+
+MODULE_DESCRIPTION("Qualcomm SuperSpeed USB PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

