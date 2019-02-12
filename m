Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53012C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E19217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iQO8kbl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfBLPOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:14:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37633 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbfBLPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:14:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so3376466wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 07:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gsq17jOveVaPpdOsp4iUxKzX6UR/llKkyBjljOGUIGI=;
        b=iQO8kbl1ees3MCrw+wTvgK6b9jiCQGIdWPH5R10FXFSyyc0JUWe0c8L1baaWsOO2w7
         3td1WNXBuKXJbUosze4OsPuSLCFwK+vHGKm+biurRAudWDHoOhVDiLxNbqZkDsGo2jOt
         rUzug7jUMrcuomnQPQXt0BC5/38XOP3WayE6UmciufOOPLXdIgroZSpoUc04jcemCIUy
         uaV0q5vTGoDI6fZcgnPM4tuZLyWwgQnS5QhHUIAIeXsK8RHU5HDezLxXqHRkKa1ioYUH
         gE78W04/zPqxgP/obJKS9ieqCofGMwReyVo1D2oQB19W4kjpNu01+NNusKC74Up0hipz
         IDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gsq17jOveVaPpdOsp4iUxKzX6UR/llKkyBjljOGUIGI=;
        b=dwhHWDR7sy8Jf0+JlHqM8JDfjekTkVW2m3RbVWF0LQCyrlLWYRpBXgX4HsBO1xkNT8
         gBYp828mF9UKWSWkKFmAEHJsovq5tkfmxYa9/GQCmTECMxKi/9dQBB++5Rz1qtUhQmPV
         EiZuAcVAcBq1pRD+em3NAx7Ocm1+/Ub0qFnRXpzyHFPuwnCGB+6wz4t+sRVZgQkbUVMs
         KAVyQHGW3R5tJNQON6oVKsdfUz9N8H/YGsqNzN9UOTV8MyBS80RC462V07jXCIMuGuHD
         QqZbKH+pVjwBOqGsI7OFJeGJNr35gFKKYMNo8irvR7O966vvQwPhh8tdHt89f5vIAsPG
         u9dg==
X-Gm-Message-State: AHQUAubwxmBFRis6gWs+iTaIxMzP52/Wj0N/1fCuiNQY77xqBtViF4eL
        qCQ/uyEeoiWn86vN/vt7My2bXQ==
X-Google-Smtp-Source: AHgI3Ia0tlG9NoF2lsr6Zy/7oPVT7yf1S3TetRm1/tz233B6JwUmBSnPeF6lG9+13EF1t8wuWcK4KQ==
X-Received: by 2002:a1c:400a:: with SMTP id n10mr3220840wma.56.1549984469970;
        Tue, 12 Feb 2019 07:14:29 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 07:14:28 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
Date:   Tue, 12 Feb 2019 16:14:13 +0100
Message-Id: <20190212151413.24632-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for Amlogic G12A USB Control Glue HW.

The Amlogic G12A SoC Family embeds 2 USB Controllers :
- a DWC3 IP configured as Host for USB2 and USB3
- a DWC2 IP configured as Peripheral USB2 Only

A glue connects these both controllers to 2 USB2 PHYs, and optionnally
to an USB3+PCIE Combo PHY shared with the PCIE controller.

The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
routing of the OTG PHY between the DWC3 and DWC2 controllers, and
setups the on-chip OTG mode selection for this PHY.

The PHYs are childen of the Glue node since the Glue controls the interface
with the PHY, not the DWC3 controller.
The drivers collects the mode of each PHY and determine which PHY
is to be routed between the DWC2 and DWC3 controllers.

This drivers supports the on-probe setup of the OTG mode, and manually
via a debugfs interface. The IRQ mode change detect is yet to be added
in a future patchset, mainly due to lack of hardware to validate on.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/Kconfig           |   9 +
 drivers/usb/dwc3/Makefile          |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c | 650 +++++++++++++++++++++++++++++
 3 files changed, 660 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 1a0404fda596..4335e5e76bbb 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -93,6 +93,15 @@ config USB_DWC3_KEYSTONE
 	  Support of USB2/3 functionality in TI Keystone2 platforms.
 	  Say 'Y' or 'M' here if you have one such device
 
+config USB_DWC3_MESON_G12A
+       tristate "Amlogic Meson G12A Platforms"
+       depends on OF && COMMON_CLK
+       depends on ARCH_MESON || COMPILE_TEST
+       default USB_DWC3
+       help
+         Support USB2/3 functionality in Amlogic G12A platforms.
+	 Say 'Y' or 'M' if you have one such device.
+
 config USB_DWC3_OF_SIMPLE
        tristate "Generic OF Simple Glue Layer"
        depends on OF && COMMON_CLK
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 6e3ef6144e5d..ae86da0dc5bd 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
 obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
 obj-$(CONFIG_USB_DWC3_HAPS)		+= dwc3-haps.o
 obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
+obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
 obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
 obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
new file mode 100644
index 000000000000..abeff2d56b1d
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -0,0 +1,650 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Glue for Amlogic G12A SoCs
+ *
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/*
+ * The USB is organized with a glue around the DWC3 Controller IP as :
+ * - Control registers for each USB2 Ports
+ * - Control registers for the USB PHY layer
+ * - SuperSpeed PHY can be enabled only if port is used
+ *
+ * TOFIX:
+ * - Add dynamic OTG switching with ID change interrupt
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/reset.h>
+#include <linux/of_graph.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/otg.h>
+#include <linux/debugfs.h>
+
+/* USB Glue Control Registers */
+
+#define USB_R0							0x00
+	#define USB_R0_P30_LANE0_TX2RX_LOOPBACK			BIT(17)
+	#define USB_R0_P30_LANE0_EXT_PCLK_REQ			BIT(18)
+	#define USB_R0_P30_PCS_RX_LOS_MASK_VAL_MASK		GENMASK(28, 19)
+	#define USB_R0_U2D_SS_SCALEDOWN_MODE_MASK		GENMASK(30, 29)
+	#define USB_R0_U2D_ACT					BIT(31)
+
+#define USB_R1							0x04
+	#define USB_R1_U3H_BIGENDIAN_GS				BIT(0)
+	#define USB_R1_U3H_PME_ENABLE				BIT(1)
+	#define USB_R1_U3H_HUB_PORT_OVERCURRENT_MASK		GENMASK(4, 2)
+	#define USB_R1_U3H_HUB_PORT_PERM_ATTACH_MASK		GENMASK(9, 7)
+	#define USB_R1_U3H_HOST_U2_PORT_DISABLE_MASK		GENMASK(13, 12)
+	#define USB_R1_U3H_HOST_U3_PORT_DISABLE			BIT(16)
+	#define USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT	BIT(17)
+	#define USB_R1_U3H_HOST_MSI_ENABLE			BIT(18)
+	#define USB_R1_U3H_FLADJ_30MHZ_REG_MASK			GENMASK(24, 19)
+	#define USB_R1_P30_PCS_TX_SWING_FULL_MASK		GENMASK(31, 25)
+
+#define USB_R2							0x08
+	#define USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK		GENMASK(25, 20)
+	#define USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK		GENMASK(31, 26)
+
+#define USB_R3							0x0c
+	#define USB_R3_P30_SSC_ENABLE				BIT(0)
+	#define USB_R3_P30_SSC_RANGE_MASK			GENMASK(3, 1)
+	#define USB_R3_P30_SSC_REF_CLK_SEL_MASK			GENMASK(12, 4)
+	#define USB_R3_P30_REF_SSP_EN				BIT(13)
+
+#define USB_R4							0x10
+	#define USB_R4_P21_PORT_RESET_0				BIT(0)
+	#define USB_R4_P21_SLEEP_M0				BIT(1)
+	#define USB_R4_MEM_PD_MASK				GENMASK(3, 2)
+	#define USB_R4_P21_ONLY					BIT(4)
+
+#define USB_R5							0x14
+	#define USB_R5_ID_DIG_SYNC				BIT(0)
+	#define USB_R5_ID_DIG_REG				BIT(1)
+	#define USB_R5_ID_DIG_CFG_MASK				GENMASK(3, 2)
+	#define USB_R5_ID_DIG_EN_0				BIT(4)
+	#define USB_R5_ID_DIG_EN_1				BIT(5)
+	#define USB_R5_ID_DIG_CURR				BIT(6)
+	#define USB_R5_ID_DIG_IRQ				BIT(7)
+	#define USB_R5_ID_DIG_TH_MASK				GENMASK(15, 8)
+	#define USB_R5_ID_DIG_CNT_MASK				GENMASK(23, 16)
+
+/* USB2 Ports Control Registers */
+
+#define U2P_R0							0x0
+	#define U2P_R0_HOST_DEVICE				BIT(0)
+	#define U2P_R0_POWER_OK					BIT(1)
+	#define U2P_R0_HAST_MODE				BIT(2)
+	#define U2P_R0_POWER_ON_RESET				BIT(3)
+	#define U2P_R0_ID_PULLUP				BIT(4)
+	#define U2P_R0_DRV_VBUS					BIT(5)
+
+#define U2P_R1							0x4
+	#define U2P_R1_PHY_READY				BIT(0)
+	#define U2P_R1_ID_DIG					BIT(1)
+	#define U2P_R1_OTG_SESSION_VALID			BIT(2)
+	#define U2P_R1_VBUS_VALID				BIT(3)
+
+#define MAX_PHY							5
+
+#define USB2_MAX_PHY						4
+#define USB3_PHY						4
+
+struct dwc3_meson_g12a {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct clk		*clk;
+	struct reset_control	*reset;
+	struct phy		*phys[5];
+	enum usb_dr_mode	phy_modes[5];
+	enum phy_mode		otg_phy_mode;
+	unsigned int		usb2_ports;
+	unsigned int		usb3_ports;
+	struct dentry		*root;
+};
+
+#define U2P_REG_SIZE						0x20
+#define USB_REG_OFFSET						0x80
+
+static void dwc3_meson_g12a_usb2_set_mode(struct dwc3_meson_g12a *priv,
+					  int i, enum usb_dr_mode mode)
+{
+	switch (mode) {
+	case USB_DR_MODE_HOST:
+	case USB_DR_MODE_OTG:
+	case USB_DR_MODE_UNKNOWN:
+		regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
+				U2P_R0_HOST_DEVICE,
+				U2P_R0_HOST_DEVICE);
+		break;
+
+	case USB_DR_MODE_PERIPHERAL:
+		regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
+				U2P_R0_HOST_DEVICE, 0);
+		break;
+	}
+}
+
+static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
+{
+	enum usb_dr_mode id_mode;
+	u32 val;
+	int i;
+
+	/* Read ID current level */
+	regmap_read(priv->regmap, USB_R5, &val);
+	if (val & USB_R5_ID_DIG_CURR)
+		id_mode = USB_DR_MODE_PERIPHERAL;
+	else
+		id_mode = USB_DR_MODE_HOST;
+
+	dev_info(priv->dev, "ID mode %s\n",
+		 id_mode ==  USB_DR_MODE_HOST ? "host" : "peripheral");
+
+	for (i = 0 ; i < USB2_MAX_PHY ; ++i) {
+		if (!priv->phys[i])
+			continue;
+
+		regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
+				   U2P_R0_POWER_ON_RESET,
+				   U2P_R0_POWER_ON_RESET);
+
+		if (priv->phy_modes[i] == USB_DR_MODE_PERIPHERAL ||
+		    (priv->phy_modes[i] == USB_DR_MODE_OTG &&
+		     id_mode == USB_DR_MODE_PERIPHERAL)) {
+			dwc3_meson_g12a_usb2_set_mode(priv, i,
+						      USB_DR_MODE_PERIPHERAL);
+
+			if (priv->phy_modes[i] == USB_DR_MODE_OTG)
+				priv->otg_phy_mode = PHY_MODE_USB_DEVICE;
+		} else {
+			dwc3_meson_g12a_usb2_set_mode(priv, i,
+						      USB_DR_MODE_HOST);
+
+			if (priv->phy_modes[i] == USB_DR_MODE_OTG)
+				priv->otg_phy_mode = PHY_MODE_USB_HOST;
+		}
+
+		regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
+				   U2P_R0_POWER_ON_RESET, 0);
+	}
+
+	return 0;
+}
+
+static void dwc3_meson_g12a_usb3_init(struct dwc3_meson_g12a *priv)
+{
+	regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R3,
+			USB_R3_P30_SSC_RANGE_MASK |
+			USB_R3_P30_REF_SSP_EN,
+			USB_R3_P30_SSC_ENABLE |
+			FIELD_PREP(USB_R3_P30_SSC_RANGE_MASK, 2) |
+			USB_R3_P30_REF_SSP_EN);
+	udelay(2);
+
+	regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R2,
+			USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK,
+			FIELD_PREP(USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK, 0x15));
+
+	regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R2,
+			USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK,
+			FIELD_PREP(USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK, 0x20));
+
+	udelay(2);
+
+	regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R1,
+			USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT,
+			USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT);
+
+	regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R1,
+			USB_R1_P30_PCS_TX_SWING_FULL_MASK,
+			FIELD_PREP(USB_R1_P30_PCS_TX_SWING_FULL_MASK, 127));
+}
+
+static void dwc3_meson_g12a_usb_init_mode(struct dwc3_meson_g12a *priv,
+					  bool is_peripheral)
+{
+	if (is_peripheral) {
+		regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R0,
+				USB_R0_U2D_ACT, USB_R0_U2D_ACT);
+		regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R0,
+				USB_R0_U2D_SS_SCALEDOWN_MODE_MASK, 0);
+		regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R4,
+				USB_R4_P21_SLEEP_M0, USB_R4_P21_SLEEP_M0);
+	} else {
+		regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R0,
+				USB_R0_U2D_ACT, 0);
+		regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R4,
+				USB_R4_P21_SLEEP_M0, 0);
+	}
+}
+
+static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
+{
+	int ret;
+
+	ret = dwc3_meson_g12a_usb2_init(priv);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R1,
+			USB_R1_U3H_FLADJ_30MHZ_REG_MASK,
+			FIELD_PREP(USB_R1_U3H_FLADJ_30MHZ_REG_MASK, 0x20));
+
+	regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R5,
+			USB_R5_ID_DIG_EN_0,
+			USB_R5_ID_DIG_EN_0);
+	regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R5,
+			USB_R5_ID_DIG_EN_1,
+			USB_R5_ID_DIG_EN_1);
+	regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R5,
+			USB_R5_ID_DIG_TH_MASK,
+			FIELD_PREP(USB_R5_ID_DIG_TH_MASK, 0xff));
+
+	/* If we have an actual SuperSpeed port, initialize it */
+	if (priv->usb3_ports)
+		dwc3_meson_g12a_usb3_init(priv);
+
+	dwc3_meson_g12a_usb_init_mode(priv,
+				(priv->otg_phy_mode == PHY_MODE_USB_DEVICE));
+
+	return 0;
+}
+
+static const struct regmap_config phy_meson_g12a_usb3_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = USB_REG_OFFSET + USB_R5,
+};
+
+static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
+{
+	struct device_node *port, *phy_node;
+	struct of_phandle_args args;
+	enum usb_dr_mode mode;
+	const char *dr_mode;
+	struct phy *phy;
+	int ret, i;
+
+	for (i = 0 ; i < MAX_PHY ; ++i) {
+		port = of_graph_get_port_by_id(priv->dev->of_node, i);
+
+		/* Ignore port if not defined or disabled */
+		if (!of_device_is_available(port)) {
+			of_node_put(port);
+			continue;
+		}
+
+		/* Get associated PHY */
+		phy = of_phy_get(port, NULL);
+		if (IS_ERR(phy)) {
+			of_node_put(port);
+			ret = PTR_ERR(phy);
+			goto err_phy_get;
+		}
+
+		of_node_put(port);
+
+		/* Get phy dr_mode */
+		ret = of_parse_phandle_with_args(port, "phys", "#phy-cells",
+						 0, &args);
+		if (ret) {
+			of_node_put(port);
+			goto err_phy_get;
+		}
+
+		phy_node = args.np;
+
+		ret = of_property_read_string(phy_node, "dr_mode", &dr_mode);
+		if (ret) {
+			dr_mode = "unknown";
+			mode = USB_DR_MODE_UNKNOWN;
+		} else {
+			if (!strcmp(dr_mode, "host"))
+				mode = USB_DR_MODE_HOST;
+			else if (!strcmp(dr_mode, "otg"))
+				mode = USB_DR_MODE_OTG;
+			else if (!strcmp(dr_mode, "peripheral"))
+				mode = USB_DR_MODE_PERIPHERAL;
+			else {
+				mode = USB_DR_MODE_UNKNOWN;
+				dr_mode = "unknown";
+			}
+		}
+
+		dev_info(priv->dev, "port%d: %s mode %s\n",
+			 i, of_node_full_name(phy_node), dr_mode);
+
+		of_node_put(phy_node);
+
+		priv->phy_modes[i] = mode;
+		priv->phys[i] = phy;
+
+		if (i == USB3_PHY)
+			priv->usb3_ports++;
+		else
+			priv->usb2_ports++;
+	}
+
+	dev_info(priv->dev, "usb2 ports: %d\n", priv->usb2_ports);
+	dev_info(priv->dev, "usb3 ports: %d\n", priv->usb3_ports);
+
+	return 0;
+
+err_phy_get:
+	for (i = 0 ; i < MAX_PHY ; ++i)
+		if (priv->phys[i])
+			phy_put(priv->phys[i]);
+
+	return ret;
+}
+
+static int dwc3_meson_g12a_mode_force_get(void *data, u64 *val)
+{
+	struct dwc3_meson_g12a *priv = data;
+
+	if (priv->otg_phy_mode == PHY_MODE_USB_HOST)
+		*val = 1;
+	else if (priv->otg_phy_mode == PHY_MODE_USB_DEVICE)
+		*val = 0;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dwc3_meson_g12a_mode_force_set(void *data, u64 val)
+{
+	struct dwc3_meson_g12a *priv = data;
+	int i;
+
+	if ((val && priv->otg_phy_mode == PHY_MODE_USB_HOST) ||
+	    (!val && priv->otg_phy_mode == PHY_MODE_USB_DEVICE))
+		return 0;
+
+	for (i = 0 ; i < USB2_MAX_PHY ; ++i) {
+		if (!priv->phys[i])
+			continue;
+
+		if (priv->phy_modes[i] != USB_DR_MODE_OTG)
+			continue;
+
+		if (val) {
+			dev_info(priv->dev, "switching to Host Mode\n");
+
+			dwc3_meson_g12a_usb2_set_mode(priv, i,
+						      USB_DR_MODE_HOST);
+
+			dwc3_meson_g12a_usb_init_mode(priv, false);
+
+			priv->otg_phy_mode = PHY_MODE_USB_HOST;
+		} else {
+			dev_info(priv->dev, "switching to Device Mode\n");
+
+			dwc3_meson_g12a_usb2_set_mode(priv, i,
+						      USB_DR_MODE_PERIPHERAL);
+
+			dwc3_meson_g12a_usb_init_mode(priv, true);
+
+			priv->otg_phy_mode = PHY_MODE_USB_DEVICE;
+		}
+
+		return phy_set_mode(priv->phys[i], priv->otg_phy_mode);
+	}
+
+	return -EINVAL;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(dwc3_meson_g12a_mode_force_fops,
+			 dwc3_meson_g12a_mode_force_get,
+			 dwc3_meson_g12a_mode_force_set, "%llu\n");
+
+static int dwc3_meson_g12a_otg_id_get(void *data, u64 *val)
+{
+	struct dwc3_meson_g12a *priv = data;
+	u32 reg;
+
+	regmap_read(priv->regmap, USB_R5, &reg);
+
+	*val = (reg & USB_R5_ID_DIG_CURR);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(dwc3_meson_g12a_otg_id_fops,
+			 dwc3_meson_g12a_otg_id_get, NULL, "%llu\n");
+
+/* We provide a DebugFS interface to get the ID value and force OTG switch */
+static int dwc3_meson_g12a_debugfs_init(struct dwc3_meson_g12a *priv)
+{
+	priv->root = debugfs_create_dir("dwc3-meson-g12a", NULL);
+	if (IS_ERR(priv->root))
+		return PTR_ERR(priv->root);
+
+	debugfs_create_file("mode_force", 0600, priv->root, priv,
+			    &dwc3_meson_g12a_mode_force_fops);
+
+	debugfs_create_file("otg_id", 0400, priv->root, priv,
+			    &dwc3_meson_g12a_otg_id_fops);
+
+	return 0;
+}
+
+static int dwc3_meson_g12a_probe(struct platform_device *pdev)
+{
+	struct dwc3_meson_g12a	*priv;
+	struct device		*dev = &pdev->dev;
+	struct device_node	*np = dev->of_node;
+	void __iomem *base;
+	struct resource *res;
+	int ret, i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap = devm_regmap_init_mmio(dev, base,
+					     &phy_meson_g12a_usb3_regmap_conf);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->clk = devm_clk_get(dev, "usb");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+	priv->dev = dev;
+
+	priv->reset = devm_reset_control_get(dev, "usb");
+	if (IS_ERR(priv->reset)) {
+		ret = PTR_ERR(priv->reset);
+		dev_err(dev, "failed to get device reset, err=%d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
+
+	ret = dwc3_meson_g12a_get_phys(priv);
+	if (ret)
+		return ret;
+
+	dwc3_meson_g12a_usb_init(priv);
+
+	/* Init PHYs */
+	for (i = 0 ; i < MAX_PHY ; ++i) {
+		if (priv->phys[i]) {
+			ret = phy_init(priv->phys[i]);
+			if (ret)
+				goto err_phys_put;
+		}
+	}
+
+	/* Set OTG PHY mode */
+	for (i = 0 ; i < MAX_PHY ; ++i) {
+		if (priv->phys[i] && priv->phy_modes[i] == USB_DR_MODE_OTG) {
+			ret = phy_set_mode(priv->phys[i], priv->otg_phy_mode);
+			if (ret)
+				goto err_phys_put;
+		}
+	}
+
+	ret = of_platform_populate(np, NULL, NULL, dev);
+	if (ret) {
+		clk_disable_unprepare(priv->clk);
+		clk_put(priv->clk);
+
+		goto err_phys_exit;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	if (dwc3_meson_g12a_debugfs_init(priv))
+		dev_dbg(dev, "Failed to add DebugFS interface\n");
+
+	return 0;
+
+err_phys_exit:
+	for (i = 0 ; i < MAX_PHY ; ++i)
+		if (priv->phys[i])
+			phy_exit(priv->phys[i]);
+
+err_phys_put:
+	for (i = 0 ; i < MAX_PHY ; ++i)
+		if (priv->phys[i])
+			phy_put(priv->phys[i]);
+
+	return ret;
+}
+
+static int dwc3_meson_g12a_remove(struct platform_device *pdev)
+{
+	struct dwc3_meson_g12a *priv = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int i;
+
+	debugfs_remove_recursive(priv->root);
+
+	of_platform_depopulate(dev);
+
+	for (i = 0 ; i < MAX_PHY ; ++i)
+		if (priv->phys[i])
+			phy_exit(priv->phys[i]);
+
+	for (i = 0 ; i < MAX_PHY ; ++i)
+		if (priv->phys[i])
+			phy_put(priv->phys[i]);
+
+	clk_disable_unprepare(priv->clk);
+	clk_put(priv->clk);
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(dev);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_meson_g12a_runtime_suspend(struct device *dev)
+{
+	struct dwc3_meson_g12a	*priv = dev_get_drvdata(dev);
+
+	clk_disable(priv->clk);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_meson_g12a_runtime_resume(struct device *dev)
+{
+	struct dwc3_meson_g12a	*priv = dev_get_drvdata(dev);
+
+	return clk_enable(priv->clk);
+}
+
+static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
+{
+	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0 ; i < MAX_PHY ; ++i)
+		if (priv->phys[i])
+			phy_exit(priv->phys[i]);
+
+	reset_control_assert(priv->reset);
+
+	return 0;
+}
+
+static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
+{
+	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
+	int i, ret;
+
+	reset_control_deassert(priv->reset);
+
+	dwc3_meson_g12a_usb_init(priv);
+
+	/* Init PHYs */
+	for (i = 0 ; i < MAX_PHY ; ++i) {
+		if (priv->phys[i]) {
+			ret = phy_init(priv->phys[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc3_meson_g12a_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_meson_g12a_suspend, dwc3_meson_g12a_resume)
+	SET_RUNTIME_PM_OPS(dwc3_meson_g12a_runtime_suspend,
+			dwc3_meson_g12a_runtime_resume, NULL)
+};
+
+static const struct of_device_id dwc3_meson_g12a_match[] = {
+	{ .compatible = "amlogic,meson-g12a-usb-ctrl" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dwc3_meson_g12a_match);
+
+static struct platform_driver dwc3_meson_g12a_driver = {
+	.probe		= dwc3_meson_g12a_probe,
+	.remove		= dwc3_meson_g12a_remove,
+	.driver		= {
+		.name	= "dwc3-meson-g12a",
+		.of_match_table = dwc3_meson_g12a_match,
+		.pm	= &dwc3_meson_g12a_dev_pm_ops,
+	},
+};
+
+module_platform_driver(dwc3_meson_g12a_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Amlogic Meson G12A USB Glue Layer");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
-- 
2.20.1

