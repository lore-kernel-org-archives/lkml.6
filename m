Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-318979-1524642366-2-14822502386539539364
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524642365; b=A1dWjnuBLDeL5iN+3EzBtg4m7Fcx3DKIQsXCWUq7jSV6wxuDes
    0RzBsCBmC8/zRsfFzhnlz6UNlzTQuHOcUyMV2MoHCigFEhkpg+NDPHoXMNp5ZLJW
    +6eHmJGXnm28dQfu615gN8I5cgZm1Y7TchdnMfOCFV/oLQ7LBCa8IXVez6vK06P6
    kTpKSg1d3nTBegg2d5hQl1bkvJL1giI6e3Os90kkLsNocOdnEhN47PsMGgEswSm1
    VoonM/Efi8L3vQr3rF6ETs0JKNIMDNjRGqRMe5Zx01ifVkRltkPb+QoUzWl1WXCG
    m1r/0ULvVcs3J92W680VDOoXnsnl+dJTMsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524642365; bh=2ZCKm78Gx4zSOlpRBs0uzgTBhdOF25
    HnKFj2u/tXn6o=; b=U46D3a3Q9+YZLXWgoIbgaqqkh47bK0WOZzrQ3UcuyVx1f9
    IZc5S99khuNk+yS4zMe9S2uSCVZspSKjBDismErtK4uRoRIT7JWD+2KSOL6AI5UO
    m5SX39HIIVYUOs9skZw5+RhJGQ/7fYp/vM4wKV9YM8Ph2FPx1GNldGCBOywWJ5J0
    Q1D4jFAiPAu1hymJj4pdn5RmCtaWJElD3Jq9+kD4zNw7/WO1LdmS6xQhDPKItBuK
    x0gc4gs0sGu7M8yUvuxTDs7bPkz/qMXBTF58jM6EBi1dM2NFXfhfrYC+We3UqB7z
    AiPBsuEM9TDJq7e4Y6z0qUBEJvffp8IT2s/DTEBQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfObYz+0ugm01C8M4cML088iA7eqqLQlSr90MaC6Mli5nkquX+zKvG7OprUZZNuIsAd/hXGHFuGEaaA1DKpI5kOeaH8m0hmilgGP2GznI7zp9XEZJZ8jT
    qI+zWlAl/MAvEIaZJmDg6XX7oI/vfoKZfUoAE8eJwdUvelffOzRp6X2NvAmwgziHL7uwsXjIturfHouD9DVGLLikwGXGf3iiv1FOF125uKMMF30EIA++2a6k
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=DNGGwUqUthaFdjVQzHAA:9 a=E4_R7kkSb2iiQBoF:21
    a=ZN9WgvCKH2E5nXOX:21 a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDYHpv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 03:45:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41361 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751308AbeDYHpp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 03:45:45 -0400
X-UUID: 066a02b1671c4b4d9186ae047c1ecea9-20180425
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] phy: mediatek: add XS-PHY driver
Date: Wed, 25 Apr 2018 15:45:29 +0800
Message-ID: <1524642329-12255-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Support XS-PHY for MediaTek SoCs with USB3.1 GEN2 controller

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/Kconfig         |    9 +
 drivers/phy/mediatek/Makefile        |    1 +
 drivers/phy/mediatek/phy-mtk-xsphy.c |  600 ++++++++++++++++++++++++++++++++++
 3 files changed, 610 insertions(+)
 create mode 100644 drivers/phy/mediatek/phy-mtk-xsphy.c

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 88ab4e2..8857d00 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -12,3 +12,12 @@ config PHY_MTK_TPHY
 	  different banks layout, the T-PHY with shared banks between
 	  multi-ports is first version, otherwise is second veriosn,
 	  so you can easily distinguish them by banks layout.
+
+config PHY_MTK_XSPHY
+    tristate "MediaTek XS-PHY Driver"
+    depends on ARCH_MEDIATEK && OF
+    select GENERIC_PHY
+    help
+	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
+	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
+	  multiple USB2.0, USB3.1 GEN2 ports.
diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index 1bdab14..ee49edc 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_PHY_MTK_TPHY)		+= phy-mtk-tphy.o
+obj-$(CONFIG_PHY_MTK_XSPHY)		+= phy-mtk-xsphy.o
diff --git a/drivers/phy/mediatek/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
new file mode 100644
index 0000000..020cd02
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-xsphy.c
@@ -0,0 +1,600 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek USB3.1 gen2 xsphy Driver
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ *
+ */
+
+#include <dt-bindings/phy/phy.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+/* u2 phy banks */
+#define SSUSB_SIFSLV_MISC		0x000
+#define SSUSB_SIFSLV_U2FREQ		0x100
+#define SSUSB_SIFSLV_U2PHY_COM	0x300
+
+/* u3 phy shared banks */
+#define SSPXTP_SIFSLV_DIG_GLB		0x000
+#define SSPXTP_SIFSLV_PHYA_GLB		0x100
+
+/* u3 phy banks */
+#define SSPXTP_SIFSLV_DIG_LN_TOP	0x000
+#define SSPXTP_SIFSLV_DIG_LN_TX0	0x100
+#define SSPXTP_SIFSLV_DIG_LN_RX0	0x200
+#define SSPXTP_SIFSLV_DIG_LN_DAIF	0x300
+#define SSPXTP_SIFSLV_PHYA_LN		0x400
+
+#define XSP_U2FREQ_FMCR0	((SSUSB_SIFSLV_U2FREQ) + 0x00)
+#define P2F_RG_FREQDET_EN	BIT(24)
+#define P2F_RG_CYCLECNT		GENMASK(23, 0)
+#define P2F_RG_CYCLECNT_VAL(x)	((P2F_RG_CYCLECNT) & (x))
+
+#define XSP_U2FREQ_MMONR0  ((SSUSB_SIFSLV_U2FREQ) + 0x0c)
+
+#define XSP_U2FREQ_FMMONR1	((SSUSB_SIFSLV_U2FREQ) + 0x10)
+#define P2F_RG_FRCK_EN		BIT(8)
+#define P2F_USB_FM_VALID	BIT(0)
+
+#define XSP_USBPHYACR0	((SSUSB_SIFSLV_U2PHY_COM) + 0x00)
+#define P2A0_RG_INTR_EN	BIT(5)
+
+#define XSP_USBPHYACR1		((SSUSB_SIFSLV_U2PHY_COM) + 0x04)
+#define P2A1_RG_INTR_CAL		GENMASK(23, 19)
+#define P2A1_RG_INTR_CAL_VAL(x)	((0x1f & (x)) << 19)
+#define P2A1_RG_VRT_SEL			GENMASK(14, 12)
+#define P2A1_RG_VRT_SEL_VAL(x)	((0x7 & (x)) << 12)
+#define P2A1_RG_TERM_SEL		GENMASK(10, 8)
+#define P2A1_RG_TERM_SEL_VAL(x)	((0x7 & (x)) << 8)
+
+#define XSP_USBPHYACR5		((SSUSB_SIFSLV_U2PHY_COM) + 0x014)
+#define P2A5_RG_HSTX_SRCAL_EN	BIT(15)
+#define P2A5_RG_HSTX_SRCTRL		GENMASK(14, 12)
+#define P2A5_RG_HSTX_SRCTRL_VAL(x)	((0x7 & (x)) << 12)
+
+#define XSP_USBPHYACR6		((SSUSB_SIFSLV_U2PHY_COM) + 0x018)
+#define P2A6_RG_BC11_SW_EN	BIT(23)
+#define P2A6_RG_OTG_VBUSCMP_EN	BIT(20)
+
+#define XSP_U2PHYDTM1		((SSUSB_SIFSLV_U2PHY_COM) + 0x06C)
+#define P2D_FORCE_IDDIG		BIT(9)
+#define P2D_RG_VBUSVALID	BIT(5)
+#define P2D_RG_SESSEND		BIT(4)
+#define P2D_RG_AVALID		BIT(2)
+#define P2D_RG_IDDIG		BIT(1)
+
+#define SSPXTP_PHYA_GLB_00		((SSPXTP_SIFSLV_PHYA_GLB) + 0x00)
+#define RG_XTP_GLB_BIAS_INTR_CTRL		GENMASK(21, 16)
+#define RG_XTP_GLB_BIAS_INTR_CTRL_VAL(x)	((0x3f & (x)) << 16)
+
+#define SSPXTP_PHYA_LN_04	((SSPXTP_SIFSLV_PHYA_LN) + 0x04)
+#define RG_XTP_LN0_TX_IMPSEL		GENMASK(4, 0)
+#define RG_XTP_LN0_TX_IMPSEL_VAL(x)	(0x1f & (x))
+
+#define SSPXTP_PHYA_LN_14	((SSPXTP_SIFSLV_PHYA_LN) + 0x014)
+#define RG_XTP_LN0_RX_IMPSEL		GENMASK(4, 0)
+#define RG_XTP_LN0_RX_IMPSEL_VAL(x)	(0x1f & (x))
+
+#define XSP_REF_CLK		26	/* MHZ */
+#define XSP_SLEW_RATE_COEF	17
+#define XSP_SR_COEF_DIVISOR	1000
+#define XSP_FM_DET_CYCLE_CNT	1024
+
+struct xsphy_instance {
+	struct phy *phy;
+	void __iomem *port_base;
+	struct clk *ref_clk;	/* reference clock of anolog phy */
+	u32 index;
+	u32 type;
+	/* only for HQA test */
+	int efuse_intr;
+	int efuse_tx_imp;
+	int efuse_rx_imp;
+	/* u2 eye diagram */
+	int eye_src;
+	int eye_vrt;
+	int eye_term;
+};
+
+struct mtk_xsphy {
+	struct device *dev;
+	void __iomem *glb_base;	/* only shared u3 sif */
+	struct xsphy_instance **phys;
+	int nphys;
+	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
+	int src_coef;    /* coefficient for slew rate calibrate */
+};
+
+static void u2_phy_slew_rate_calibrate(struct mtk_xsphy *xsphy,
+					struct xsphy_instance *inst)
+{
+	void __iomem *pbase = inst->port_base;
+	int calib_val;
+	int fm_out;
+	u32 tmp;
+
+	/* use force value */
+	if (inst->eye_src)
+		return;
+
+	/* enable USB ring oscillator */
+	tmp = readl(pbase + XSP_USBPHYACR5);
+	tmp |= P2A5_RG_HSTX_SRCAL_EN;
+	writel(tmp, pbase + XSP_USBPHYACR5);
+	udelay(1);	/* wait clock stable */
+
+	/* enable free run clock */
+	tmp = readl(pbase + XSP_U2FREQ_FMMONR1);
+	tmp |= P2F_RG_FRCK_EN;
+	writel(tmp, pbase + XSP_U2FREQ_FMMONR1);
+
+	/* set cycle count as 1024 */
+	tmp = readl(pbase + XSP_U2FREQ_FMCR0);
+	tmp &= ~(P2F_RG_CYCLECNT);
+	tmp |= P2F_RG_CYCLECNT_VAL(XSP_FM_DET_CYCLE_CNT);
+	writel(tmp, pbase + XSP_U2FREQ_FMCR0);
+
+	/* enable frequency meter */
+	tmp = readl(pbase + XSP_U2FREQ_FMCR0);
+	tmp |= P2F_RG_FREQDET_EN;
+	writel(tmp, pbase + XSP_U2FREQ_FMCR0);
+
+	/* ignore return value */
+	readl_poll_timeout(pbase + XSP_U2FREQ_FMMONR1, tmp,
+			   (tmp & P2F_USB_FM_VALID), 10, 200);
+
+	fm_out = readl(pbase + XSP_U2FREQ_MMONR0);
+
+	/* disable frequency meter */
+	tmp = readl(pbase + XSP_U2FREQ_FMCR0);
+	tmp &= ~P2F_RG_FREQDET_EN;
+	writel(tmp, pbase + XSP_U2FREQ_FMCR0);
+
+	/* disable free run clock */
+	tmp = readl(pbase + XSP_U2FREQ_FMMONR1);
+	tmp &= ~P2F_RG_FRCK_EN;
+	writel(tmp, pbase + XSP_U2FREQ_FMMONR1);
+
+	if (fm_out) {
+		/* (1024 / FM_OUT) x reference clock frequency x coefficient */
+		tmp = xsphy->src_ref_clk * xsphy->src_coef;
+		tmp = (tmp * XSP_FM_DET_CYCLE_CNT) / fm_out;
+		calib_val = DIV_ROUND_CLOSEST(tmp, XSP_SR_COEF_DIVISOR);
+	} else {
+		/* if FM detection fail, set default value */
+		calib_val = 3;
+	}
+	dev_dbg(xsphy->dev, "phy.%d, fm_out:%d, calib:%d (clk:%d, coef:%d)\n",
+		inst->index, fm_out, calib_val,
+		xsphy->src_ref_clk, xsphy->src_coef);
+
+	/* set HS slew rate */
+	tmp = readl(pbase + XSP_USBPHYACR5);
+	tmp &= ~P2A5_RG_HSTX_SRCTRL;
+	tmp |= P2A5_RG_HSTX_SRCTRL_VAL(calib_val);
+	writel(tmp, pbase + XSP_USBPHYACR5);
+
+	/* disable USB ring oscillator */
+	tmp = readl(pbase + XSP_USBPHYACR5);
+	tmp &= ~P2A5_RG_HSTX_SRCAL_EN;
+	writel(tmp, pbase + XSP_USBPHYACR5);
+}
+
+static void u2_phy_instance_init(struct mtk_xsphy *xsphy,
+				 struct xsphy_instance *inst)
+{
+	void __iomem *pbase = inst->port_base;
+	u32 tmp;
+
+	/* DP/DM BC1.1 path Disable */
+	tmp = readl(pbase + XSP_USBPHYACR6);
+	tmp &= ~P2A6_RG_BC11_SW_EN;
+	writel(tmp, pbase + XSP_USBPHYACR6);
+
+	tmp = readl(pbase + XSP_USBPHYACR0);
+	tmp |= P2A0_RG_INTR_EN;
+	writel(tmp, pbase + XSP_USBPHYACR0);
+}
+
+static void u2_phy_instance_power_on(struct mtk_xsphy *xsphy,
+				     struct xsphy_instance *inst)
+{
+	void __iomem *pbase = inst->port_base;
+	u32 index = inst->index;
+	u32 tmp;
+
+	tmp = readl(pbase + XSP_USBPHYACR6);
+	tmp |= P2A6_RG_OTG_VBUSCMP_EN;
+	writel(tmp, pbase + XSP_USBPHYACR6);
+
+	tmp = readl(pbase + XSP_U2PHYDTM1);
+	tmp |= P2D_RG_VBUSVALID | P2D_RG_AVALID;
+	tmp &= ~P2D_RG_SESSEND;
+	writel(tmp, pbase + XSP_U2PHYDTM1);
+
+	dev_dbg(xsphy->dev, "%s(%d)\n", __func__, index);
+}
+
+static void u2_phy_instance_power_off(struct mtk_xsphy *xsphy,
+				      struct xsphy_instance *inst)
+{
+	void __iomem *pbase = inst->port_base;
+	u32 index = inst->index;
+	u32 tmp;
+
+	tmp = readl(pbase + XSP_USBPHYACR6);
+	tmp &= ~P2A6_RG_OTG_VBUSCMP_EN;
+	writel(tmp, pbase + XSP_USBPHYACR6);
+
+	tmp = readl(pbase + XSP_U2PHYDTM1);
+	tmp &= ~(P2D_RG_VBUSVALID | P2D_RG_AVALID);
+	tmp |= P2D_RG_SESSEND;
+	writel(tmp, pbase + XSP_U2PHYDTM1);
+
+	dev_dbg(xsphy->dev, "%s(%d)\n", __func__, index);
+}
+
+static void u2_phy_instance_set_mode(struct mtk_xsphy *xsphy,
+				     struct xsphy_instance *inst,
+				     enum phy_mode mode)
+{
+	u32 tmp;
+
+	tmp = readl(inst->port_base + XSP_U2PHYDTM1);
+	switch (mode) {
+	case PHY_MODE_USB_DEVICE:
+		tmp |= P2D_FORCE_IDDIG | P2D_RG_IDDIG;
+		break;
+	case PHY_MODE_USB_HOST:
+		tmp |= P2D_FORCE_IDDIG;
+		tmp &= ~P2D_RG_IDDIG;
+		break;
+	case PHY_MODE_USB_OTG:
+		tmp &= ~(P2D_FORCE_IDDIG | P2D_RG_IDDIG);
+		break;
+	default:
+		return;
+	}
+	writel(tmp, inst->port_base + XSP_U2PHYDTM1);
+}
+
+static void phy_parse_property(struct mtk_xsphy *xsphy,
+				struct xsphy_instance *inst)
+{
+	struct device *dev = &inst->phy->dev;
+
+	switch (inst->type) {
+	case PHY_TYPE_USB2:
+		device_property_read_u32(dev, "mediatek,efuse-intr",
+					 &inst->efuse_intr);
+		device_property_read_u32(dev, "mediatek,eye-src",
+					 &inst->eye_src);
+		device_property_read_u32(dev, "mediatek,eye-vrt",
+					 &inst->eye_vrt);
+		device_property_read_u32(dev, "mediatek,eye-term",
+					 &inst->eye_term);
+		dev_dbg(dev, "intr:%d, src:%d, vrt:%d, term:%d\n",
+			inst->efuse_intr, inst->eye_src,
+			inst->eye_vrt, inst->eye_term);
+		break;
+	case PHY_TYPE_USB3:
+		device_property_read_u32(dev, "mediatek,efuse-intr",
+					 &inst->efuse_intr);
+		device_property_read_u32(dev, "mediatek,efuse-tx-imp",
+					 &inst->efuse_tx_imp);
+		device_property_read_u32(dev, "mediatek,efuse-rx-imp",
+					 &inst->efuse_rx_imp);
+		dev_dbg(dev, "intr:%d, tx-imp:%d, rx-imp:%d\n",
+			inst->efuse_intr, inst->efuse_tx_imp,
+			inst->efuse_rx_imp);
+		break;
+	default:
+		dev_err(xsphy->dev, "incompatible phy type\n");
+		return;
+	}
+}
+
+static void u2_phy_props_set(struct mtk_xsphy *xsphy,
+			     struct xsphy_instance *inst)
+{
+	void __iomem *pbase = inst->port_base;
+	u32 tmp;
+
+	if (inst->efuse_intr) {
+		tmp = readl(pbase + XSP_USBPHYACR1);
+		tmp &= ~P2A1_RG_INTR_CAL;
+		tmp |= P2A1_RG_INTR_CAL_VAL(inst->efuse_intr);
+		writel(tmp, pbase + XSP_USBPHYACR1);
+	}
+
+	if (inst->eye_src) {
+		tmp = readl(pbase + XSP_USBPHYACR5);
+		tmp &= ~P2A5_RG_HSTX_SRCTRL;
+		tmp |= P2A5_RG_HSTX_SRCTRL_VAL(inst->eye_src);
+		writel(tmp, pbase + XSP_USBPHYACR5);
+	}
+
+	if (inst->eye_vrt) {
+		tmp = readl(pbase + XSP_USBPHYACR1);
+		tmp &= ~P2A1_RG_VRT_SEL;
+		tmp |= P2A1_RG_VRT_SEL_VAL(inst->eye_vrt);
+		writel(tmp, pbase + XSP_USBPHYACR1);
+	}
+
+	if (inst->eye_term) {
+		tmp = readl(pbase + XSP_USBPHYACR1);
+		tmp &= ~P2A1_RG_TERM_SEL;
+		tmp |= P2A1_RG_TERM_SEL_VAL(inst->eye_term);
+		writel(tmp, pbase + XSP_USBPHYACR1);
+	}
+}
+
+static void u3_phy_props_set(struct mtk_xsphy *xsphy,
+			     struct xsphy_instance *inst)
+{
+	void __iomem *pbase = inst->port_base;
+	u32 tmp;
+
+	if (inst->efuse_intr) {
+		tmp = readl(xsphy->glb_base + SSPXTP_PHYA_GLB_00);
+		tmp &= ~RG_XTP_GLB_BIAS_INTR_CTRL;
+		tmp |= RG_XTP_GLB_BIAS_INTR_CTRL_VAL(inst->efuse_intr);
+		writel(tmp, xsphy->glb_base + SSPXTP_PHYA_GLB_00);
+	}
+
+	if (inst->efuse_tx_imp) {
+		tmp = readl(pbase + SSPXTP_PHYA_LN_04);
+		tmp &= ~RG_XTP_LN0_TX_IMPSEL;
+		tmp |= RG_XTP_LN0_TX_IMPSEL_VAL(inst->efuse_tx_imp);
+		writel(tmp, pbase + SSPXTP_PHYA_LN_04);
+	}
+
+	if (inst->efuse_rx_imp) {
+		tmp = readl(pbase + SSPXTP_PHYA_LN_14);
+		tmp &= ~RG_XTP_LN0_RX_IMPSEL;
+		tmp |= RG_XTP_LN0_RX_IMPSEL_VAL(inst->efuse_rx_imp);
+		writel(tmp, pbase + SSPXTP_PHYA_LN_14);
+	}
+}
+
+static int mtk_phy_init(struct phy *phy)
+{
+	struct xsphy_instance *inst = phy_get_drvdata(phy);
+	struct mtk_xsphy *xsphy = dev_get_drvdata(phy->dev.parent);
+	int ret;
+
+	ret = clk_prepare_enable(inst->ref_clk);
+	if (ret) {
+		dev_err(xsphy->dev, "failed to enable ref_clk\n");
+		return ret;
+	}
+
+	switch (inst->type) {
+	case PHY_TYPE_USB2:
+		u2_phy_instance_init(xsphy, inst);
+		u2_phy_props_set(xsphy, inst);
+		break;
+	case PHY_TYPE_USB3:
+		u3_phy_props_set(xsphy, inst);
+		break;
+	default:
+		dev_err(xsphy->dev, "incompatible phy type\n");
+		clk_disable_unprepare(inst->ref_clk);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mtk_phy_power_on(struct phy *phy)
+{
+	struct xsphy_instance *inst = phy_get_drvdata(phy);
+	struct mtk_xsphy *xsphy = dev_get_drvdata(phy->dev.parent);
+
+	if (inst->type == PHY_TYPE_USB2) {
+		u2_phy_instance_power_on(xsphy, inst);
+		u2_phy_slew_rate_calibrate(xsphy, inst);
+	}
+
+	return 0;
+}
+
+static int mtk_phy_power_off(struct phy *phy)
+{
+	struct xsphy_instance *inst = phy_get_drvdata(phy);
+	struct mtk_xsphy *xsphy = dev_get_drvdata(phy->dev.parent);
+
+	if (inst->type == PHY_TYPE_USB2)
+		u2_phy_instance_power_off(xsphy, inst);
+
+	return 0;
+}
+
+static int mtk_phy_exit(struct phy *phy)
+{
+	struct xsphy_instance *inst = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(inst->ref_clk);
+	return 0;
+}
+
+static int mtk_phy_set_mode(struct phy *phy, enum phy_mode mode)
+{
+	struct xsphy_instance *inst = phy_get_drvdata(phy);
+	struct mtk_xsphy *xsphy = dev_get_drvdata(phy->dev.parent);
+
+	if (inst->type == PHY_TYPE_USB2)
+		u2_phy_instance_set_mode(xsphy, inst, mode);
+
+	return 0;
+}
+
+static struct phy *mtk_phy_xlate(struct device *dev,
+				 struct of_phandle_args *args)
+{
+	struct mtk_xsphy *xsphy = dev_get_drvdata(dev);
+	struct xsphy_instance *inst = NULL;
+	struct device_node *phy_np = args->np;
+	int index;
+
+	if (args->args_count != 1) {
+		dev_err(dev, "invalid number of cells in 'phy' property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	for (index = 0; index < xsphy->nphys; index++)
+		if (phy_np == xsphy->phys[index]->phy->dev.of_node) {
+			inst = xsphy->phys[index];
+			break;
+		}
+
+	if (!inst) {
+		dev_err(dev, "failed to find appropriate phy\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	inst->type = args->args[0];
+	if (!(inst->type == PHY_TYPE_USB2 ||
+	      inst->type == PHY_TYPE_USB3)) {
+		dev_err(dev, "unsupported phy type: %d\n", inst->type);
+		return ERR_PTR(-EINVAL);
+	}
+
+	phy_parse_property(xsphy, inst);
+
+	return inst->phy;
+}
+
+static const struct phy_ops mtk_xsphy_ops = {
+	.init		= mtk_phy_init,
+	.exit		= mtk_phy_exit,
+	.power_on	= mtk_phy_power_on,
+	.power_off	= mtk_phy_power_off,
+	.set_mode	= mtk_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id mtk_xsphy_id_table[] = {
+	{ .compatible = "mediatek,xsphy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mtk_xsphy_id_table);
+
+static int mtk_xsphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *child_np;
+	struct phy_provider *provider;
+	struct resource *glb_res;
+	struct mtk_xsphy *xsphy;
+	struct resource res;
+	int port, retval;
+
+	xsphy = devm_kzalloc(dev, sizeof(*xsphy), GFP_KERNEL);
+	if (!xsphy)
+		return -ENOMEM;
+
+	xsphy->nphys = of_get_child_count(np);
+	xsphy->phys = devm_kcalloc(dev, xsphy->nphys,
+				       sizeof(*xsphy->phys), GFP_KERNEL);
+	if (!xsphy->phys)
+		return -ENOMEM;
+
+	xsphy->dev = dev;
+	platform_set_drvdata(pdev, xsphy);
+
+	glb_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	/* optional, may not exist if no u3 phys */
+	if (glb_res) {
+		/* get banks shared by multiple u3 phys */
+		xsphy->glb_base = devm_ioremap_resource(dev, glb_res);
+		if (IS_ERR(xsphy->glb_base)) {
+			dev_err(dev, "failed to remap glb regs\n");
+			return PTR_ERR(xsphy->glb_base);
+		}
+	}
+
+	xsphy->src_ref_clk = XSP_REF_CLK;
+	xsphy->src_coef = XSP_SLEW_RATE_COEF;
+	/* update parameters of slew rate calibrate if exist */
+	device_property_read_u32(dev, "mediatek,src-ref-clk-mhz",
+				 &xsphy->src_ref_clk);
+	device_property_read_u32(dev, "mediatek,src-coef", &xsphy->src_coef);
+
+	port = 0;
+	for_each_child_of_node(np, child_np) {
+		struct xsphy_instance *inst;
+		struct phy *phy;
+
+		inst = devm_kzalloc(dev, sizeof(*inst), GFP_KERNEL);
+		if (!inst) {
+			retval = -ENOMEM;
+			goto put_child;
+		}
+
+		xsphy->phys[port] = inst;
+
+		phy = devm_phy_create(dev, child_np, &mtk_xsphy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create phy\n");
+			retval = PTR_ERR(phy);
+			goto put_child;
+		}
+
+		retval = of_address_to_resource(child_np, 0, &res);
+		if (retval) {
+			dev_err(dev, "failed to get address resource(id-%d)\n",
+				port);
+			goto put_child;
+		}
+
+		inst->port_base = devm_ioremap_resource(&phy->dev, &res);
+		if (IS_ERR(inst->port_base)) {
+			dev_err(dev, "failed to remap phy regs\n");
+			retval = PTR_ERR(inst->port_base);
+			goto put_child;
+		}
+
+		inst->phy = phy;
+		inst->index = port;
+		phy_set_drvdata(phy, inst);
+		port++;
+
+		inst->ref_clk = devm_clk_get(&phy->dev, "ref");
+		if (IS_ERR(inst->ref_clk)) {
+			dev_err(dev, "failed to get ref_clk(id-%d)\n", port);
+			retval = PTR_ERR(inst->ref_clk);
+			goto put_child;
+		}
+	}
+
+	provider = devm_of_phy_provider_register(dev, mtk_phy_xlate);
+	return PTR_ERR_OR_ZERO(provider);
+
+put_child:
+	of_node_put(child_np);
+	return retval;
+}
+
+static struct platform_driver mtk_xsphy_driver = {
+	.probe		= mtk_xsphy_probe,
+	.driver		= {
+		.name	= "mtk-xsphy",
+		.of_match_table = mtk_xsphy_id_table,
+	},
+};
+
+module_platform_driver(mtk_xsphy_driver);
+
+MODULE_AUTHOR("Chunfeng Yun <chunfeng.yun@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek USB XS-PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

