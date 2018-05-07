Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1186102-1525706509-2-10623683547118370111
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='io',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525706508; b=G/ikGHnAbXqctIjVRt0N3fpdM+5z7456tbU7BVJblRvXI/2fNz
    mKxuquTsLQD9dTsON7rsZdUuYxVd/Q6B8JfdPv6utZVmDB10HlOH83bNGF/rXSb/
    ZJ72mRXNDZLyhh7fTy8WZVXsevHz2K/hGKD5QQvJGnPCl10mt/6XlN+Is8YDhPWk
    j70vFJxxC6hY5BofQXmFILmiMcDuA88urFhfWLC96r8DIFh8IcItJCrhaLF8B/sM
    xiaBqSmw+H6tBMDDDB4MrSXQMjj5PhwR8+DFjTMUiCO4QpLO4k6/NbuEyhFxUx0x
    NxpC/xU5jsoDGnoOWYm6n5vxg+iv7MXx3EXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525706508; bh=
    IQMN7l1p5lPUi2Bclk+MpEgOCUtmrOV4vXaS7xUHXH0=; b=dFYnsBlwMzgdVYH1
    g/Zhq1cHeK8aEaQAOzdCxrA2oseYcQvREr9B7RdfM/6bD0XnlHN/qgFijCx2wSOT
    082gTAqxBy6kzl6llS5641XLZoJgtuqSTo7oGK2GDZO9ZW3Ew1Wozo7gxKCd6TSu
    g+Jv0FZ8y6C7XcYHyPpyTrZncSq2cd9Bh5Ptj7A7hpGUkd3ePaBQrXJjUpUGex4T
    6psTNA5U6Dp9MRYBUz96ke5UOjbJUfQ/P2kjlQGY5jJUv7z8RgesBcItg6rfZgz0
    wmqDEayBQ1w/4h0B6db+XaDt9MQaljDn+PzOq+z5sdX9EW3Ve4BaDrpgP6/zXop5
    +iclIw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aosc.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=aosc.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aosc.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=aosc.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGpr5l8h+vKvmlsTVbSLDt0EIjL3x5sI8XjqW0HLOTWsP48WMjJJ6QlX3u1kqHozGGz0ed+vylo9dA10CQT7v/kzgPbxwniNK+IhlD7lFpBDiEDQmuJK
    vP8wfMVs14iyMNn9QqJ19WvpB3iINBy94vxULSByBz7rDdI8guoJ/PwvR/xGYhcIVNnYjg/hgVj7TTNyrWMr9ot2Hc5ZQzL/nxtQV53nZ2aCms/kWjNdnOej
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=zu6OG0ZhAAAA:8
    a=VwQbUJbxAAAA:8 a=07EnoWN-HkJ8iBvaf9gA:9 a=x8gzFH9gYPwA:10
    a=pAN39diAhXWuPx0-Vjn3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeEGPVp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 11:21:45 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48393 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbeEGPVn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 7 May 2018 11:21:43 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Felipe Balbi <balbi@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/5] phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
Date: Mon,  7 May 2018 23:18:13 +0800
Message-Id: <20180507151817.55663-2-icenowy@aosc.io>
In-Reply-To: <20180507151817.55663-1-icenowy@aosc.io>
References: <20180507151817.55663-1-icenowy@aosc.io>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
controlled).

Add a driver for it.

The register operations in this driver is mainly extracted from the BSP
USB3 driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../bindings/phy/sun50i-usb3-phy.txt          |  24 +++
 drivers/phy/allwinner/Kconfig                 |  13 ++
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c       | 195 ++++++++++++++++++
 4 files changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
new file mode 100644
index 000000000000..912d55f9f69d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
@@ -0,0 +1,24 @@
+Allwinner sun50i USB3 PHY
+-----------------------
+
+Required properties:
+- compatible : should be one of
+  * allwinner,sun60i-h6-usb3-phy
+- reg : a list of offset + length pairs
+- #phy-cells : from the generic phy bindings, must be 0
+- clocks : phandle + clock specifier for the phy clock
+- resets : phandle + reset specifier for the phy reset
+
+Optional Properties:
+- phy-supply : from the generic phy bindings, a phandle to a regulator that
+	       provides power to VBUS.
+
+Example:
+	usb3phy: phy@5210000 {
+		compatible = "allwinner,sun50i-h6-usb3-phy";
+		reg = <0x5210000 0x10000>;
+		clocks = <&ccu CLK_USB_PHY1>;
+		resets = <&ccu RST_USB_PHY1>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index cdc1e745ba47..cf373bcee034 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -29,3 +29,16 @@ config PHY_SUN9I_USB
 	  sun9i SoCs.
 
 	  This driver controls each individual USB 2 host PHY.
+
+config PHY_SUN50I_USB3
+	tristate "Allwinner sun50i SoC USB3 PHY driver"
+	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
+	depends on USB_SUPPORT
+	select USB_COMMON
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB3.0-capable transceiver that is
+	  part of some Allwinner sun50i SoCs.
+
+	  This driver controls each individual USB 2+3 host PHY combo.
diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
index 8605529c01a1..a8d01e9073c2 100644
--- a/drivers/phy/allwinner/Makefile
+++ b/drivers/phy/allwinner/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
 obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
+obj-$(CONFIG_PHY_SUN50I_USB3)		+= phy-sun50i-usb3.o
diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
new file mode 100644
index 000000000000..000a3e04e6d1
--- /dev/null
+++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Allwinner sun50i(H6) USB 3.0 phy driver
+ *
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Based on phy-sun9i-usb.c, which is:
+ *
+ * Copyright (C) 2014-2015 Chen-Yu Tsai <wens@csie.org>
+ *
+ * Based on code from Allwinner BSP, which is:
+ *
+ * Copyright (c) 2010-2015 Allwinner Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+/* Interface Status and Control Registers */
+#define SUNXI_ISCR			0x00
+#define SUNXI_PIPE_CLOCK_CONTROL	0x14
+#define SUNXI_PHY_TUNE_LOW		0x18
+#define SUNXI_PHY_TUNE_HIGH		0x1c
+#define SUNXI_PHY_EXTERNAL_CONTROL	0x20
+
+/* USB2.0 Interface Status and Control Register */
+#define SUNXI_ISCR_FORCE_VBUS		(3 << 12)
+
+/* PIPE Clock Control Register */
+#define SUNXI_PCC_PIPE_CLK_OPEN		(1 << 6)
+
+/* PHY External Control Register */
+#define SUNXI_PEC_EXTERN_VBUS		(3 << 1)
+#define SUNXI_PEC_SSC_EN		(1 << 24)
+#define SUNXI_PEC_REF_SSP_EN		(1 << 26)
+
+/* PHY Tune High Register */
+#define SUNXI_TX_DEEMPH_3P5DB(n)	((n) << 19)
+#define SUNXI_TX_DEEMPH_3P5DB_MASK	GENMASK(24, 19)
+#define SUNXI_TX_DEEMPH_6DB(n)		((n) << 13)
+#define SUNXI_TX_DEEMPH_6GB_MASK	GENMASK(18, 13)
+#define SUNXI_TX_SWING_FULL(n)		((n) << 6)
+#define SUNXI_TX_SWING_FULL_MASK	GENMASK(12, 6)
+#define SUNXI_LOS_BIAS(n)		((n) << 3)
+#define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
+#define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
+#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
+
+struct sun50i_usb3_phy {
+	struct phy *phy;
+	void __iomem *regs;
+	struct reset_control *reset;
+	struct clk *clk;
+};
+
+static void sun50i_usb3_phy_open(struct sun50i_usb3_phy *phy)
+{
+	u32 val;
+
+	val = readl(phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
+	val |= SUNXI_PEC_EXTERN_VBUS;
+	val |= SUNXI_PEC_SSC_EN | SUNXI_PEC_REF_SSP_EN;
+	writel(val, phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
+
+	val = readl(phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
+	val |= SUNXI_PCC_PIPE_CLK_OPEN;
+	writel(val, phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
+
+	val = readl(phy->regs + SUNXI_ISCR);
+	val |= SUNXI_ISCR_FORCE_VBUS;
+	writel(val, phy->regs + SUNXI_ISCR);
+
+	/*
+	 * All the magic numbers written to the PHY_TUNE_{LOW_HIGH}
+	 * registers are directly taken from the BSP USB3 driver from
+	 * Allwiner.
+	 */
+	writel(0x0047fc87, phy->regs + SUNXI_PHY_TUNE_LOW);
+
+	val = readl(phy->regs + SUNXI_PHY_TUNE_HIGH);
+	val &= ~(SUNXI_TXVBOOSTLVL_MASK | SUNXI_LOS_BIAS_MASK |
+		 SUNXI_TX_SWING_FULL_MASK | SUNXI_TX_DEEMPH_6GB_MASK |
+		 SUNXI_TX_DEEMPH_3P5DB_MASK);
+	val |= SUNXI_TXVBOOSTLVL(0x7);
+	val |= SUNXI_LOS_BIAS(0x7);
+	val |= SUNXI_TX_SWING_FULL(0x55);
+	val |= SUNXI_TX_DEEMPH_6DB(0x20);
+	val |= SUNXI_TX_DEEMPH_3P5DB(0x15);
+	writel(val, phy->regs + SUNXI_PHY_TUNE_HIGH);
+}
+
+static int sun50i_usb3_phy_init(struct phy *_phy)
+{
+	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
+	int ret;
+
+	ret = clk_prepare_enable(phy->clk);
+	if (ret)
+		goto err_clk;
+
+	ret = reset_control_deassert(phy->reset);
+	if (ret)
+		goto err_reset;
+
+	sun50i_usb3_phy_open(phy);
+	return 0;
+
+err_reset:
+	clk_disable_unprepare(phy->clk);
+
+err_clk:
+	return ret;
+}
+
+static int sun50i_usb3_phy_exit(struct phy *_phy)
+{
+	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
+
+	reset_control_assert(phy->reset);
+	clk_disable_unprepare(phy->clk);
+
+	return 0;
+}
+
+static const struct phy_ops sun50i_usb3_phy_ops = {
+	.init		= sun50i_usb3_phy_init,
+	.exit		= sun50i_usb3_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int sun50i_usb3_phy_probe(struct platform_device *pdev)
+{
+	struct sun50i_usb3_phy *phy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(phy->clk)) {
+		dev_err(dev, "failed to get phy clock\n");
+		return PTR_ERR(phy->clk);
+	}
+
+	phy->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(phy->reset)) {
+		dev_err(dev, "failed to get reset control\n");
+		return PTR_ERR(phy->reset);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	phy->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(phy->regs))
+		return PTR_ERR(phy->regs);
+
+	phy->phy = devm_phy_create(dev, NULL, &sun50i_usb3_phy_ops);
+	if (IS_ERR(phy->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(phy->phy);
+	}
+
+	phy_set_drvdata(phy->phy, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id sun50i_usb3_phy_of_match[] = {
+	{ .compatible = "allwinner,sun50i-h6-usb3-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun50i_usb3_phy_of_match);
+
+static struct platform_driver sun50i_usb3_phy_driver = {
+	.probe	= sun50i_usb3_phy_probe,
+	.driver = {
+		.of_match_table	= sun50i_usb3_phy_of_match,
+		.name  = "sun50i-usb3-phy",
+	}
+};
+module_platform_driver(sun50i_usb3_phy_driver);
+
+MODULE_DESCRIPTION("Allwinner sun50i USB 3.0 phy driver");
+MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.io>");
+MODULE_LICENSE("GPL");
-- 
2.17.0

