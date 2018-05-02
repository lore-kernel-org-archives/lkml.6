Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525295259-2-17961296351975173113
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295258; b=Pu2pVRWRQxAB93RtcETx1+bImD67Zn63QYe11gwTN20sAVQ+5O
    327868b9anMBwhJawhZeufpmpi1D6voeVBtRQ/RX0Y2322hOsiynpqGxVgKV4M8U
    jSh4ZeVI2CA5uC5aEClcwqvmpNhdymwKcAbQ9j+tpNwBJABLn8+OEYI/RrGrAUIJ
    8gC4MCVoATYxd+rANA2hWN7XFsgHnFUoI21VahqGmMulUiRIG2H5+Go8jkXw1qUF
    SeI5xIxG0L2bhgZ7J9+x7XViGKut4uja8aAk5qehM1VDejL3xYxdjYE+hhLAg/P/
    LBt3BwNqu5sR95N1buIjsJHUKm2awH46jryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295258; bh=
    /SxGwBhaqu0VHKOWdJRzM9b8u39YtgEU/9nd2STEA60=; b=Ox1LEHIcoHIXDtkZ
    Yv2eAHP9YBRgtCqgKkM1kfbTbG6oAS29jSVU1u6IOY/QnQ3Xs/IXx5bkcoWsSdDS
    oWqfljMaKJHPb+W36wLWHC8en1q0bikcOUYbBphRid2YIddo/jlNbdann27w0cn2
    nxsvPS+yKHdW5WM/P+um4rYGYzv3vMYyXg5n0FD75WFaMb8rcuQQE1O2VWfp5c+w
    /UXTm43wwEGqIJmMMm6uvFLFxx9jSbdvW8AfdCGxC1SmXpKQ9F9xbp7fKLuR8FKB
    zIIpl7FV7aXtSJjyo4vXkwY86EulaHvOZ9M2IeYabuxtqjR5T5A5lN4OJdR5UPZd
    9dVYSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=FcuTub6I
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=FzxOirMv
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=FcuTub6I
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=FzxOirMv
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIruaT/B5ZREcbkM7Iwo3q/vsQmBwa2hiZUeDetyVk1gBV/L8Ii7zhUpFgizPVdp4bCsCWkNCx+zH13eM8888caYbmzZwrfZdaCK49AdOxNllLjblCbt
    IPqJhxrwAFYMUi3/55QIEXtwc4KNgewCvNzWYKypfl/aKwz6XVqiKDy33+KJx3XIr8TeyJGJMlg0UnFKvbnez8IAn1P2j8/XmmAKwxSMMlVvjnBebbiDuaBM
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=nHvXBg3kIfRBC4TYM8sA:9 a=xqhMSNp5RF3ZOXZ6:21
    a=To4UrYgvm08osRY3:21 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeEBVHc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:07:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeEBVHC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 17:07:02 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44A2D60585
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>, robh@kernel.org,
        sboyd@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v5 7/7] phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845
Date: Thu,  3 May 2018 02:36:14 +0530
Message-Id: <1525295174-15995-8-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are two QUSB2 PHYs present on sdm845. In order
to improve eye diagram for both the PHYs some parameters
need to be changed. Provide device tree properties to
override these from board specific device tree files.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 126 +++++++++++++++++++++++++++++++---
 1 file changed, 118 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 40fdef8..e70e425 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -20,6 +20,8 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
+#include <dt-bindings/phy/phy-qcom-qusb2.h>
+
 #define QUSB2PHY_PLL_TEST		0x04
 #define CLK_REF_SEL			BIT(7)
 
@@ -60,6 +62,17 @@
 #define CORE_RESET				BIT(5)
 #define CORE_RESET_MUX				BIT(6)
 
+/* QUSB2PHY_IMP_CTRL1 register bits */
+#define IMP_RES_OFFSET_MASK			GENMASK(5, 0)
+#define IMP_RES_OFFSET_SHIFT			0x0
+
+/* QUSB2PHY_PORT_TUNE1 register bits */
+#define HSTX_TRIM_MASK				GENMASK(7, 4)
+#define HSTX_TRIM_SHIFT				0x4
+#define PREEMPH_WIDTH_HALF_BIT			BIT(2)
+#define PREEMPHASIS_EN_MASK			GENMASK(1, 0)
+#define PREEMPHASIS_EN_SHIFT			0x0
+
 #define QUSB2PHY_PLL_ANALOG_CONTROLS_TWO	0x04
 #define QUSB2PHY_PLL_CLOCK_INVERTERS		0x18c
 #define QUSB2PHY_PLL_CMODE			0x2c
@@ -139,7 +152,7 @@ enum qusb2phy_reg_layout {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
 };
 
-static const unsigned int qusb2_v2_regs_layout[] = {
+static const unsigned int sdm845_regs_layout[] = {
 	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
 	[QUSB2PHY_PLL_STATUS]		= 0x1a0,
 	[QUSB2PHY_PORT_TUNE1]		= 0x240,
@@ -153,7 +166,7 @@ enum qusb2phy_reg_layout {
 	[QUSB2PHY_INTR_CTRL]		= 0x230,
 };
 
-static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
+static const struct qusb2_phy_init_tbl sdm845_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
@@ -208,10 +221,10 @@ struct qusb2_phy_cfg {
 	.autoresume_en	 = BIT(3),
 };
 
-static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
-	.tbl		= qusb2_v2_init_tbl,
-	.tbl_num	= ARRAY_SIZE(qusb2_v2_init_tbl),
-	.regs		= qusb2_v2_regs_layout,
+static const struct qusb2_phy_cfg sdm845_phy_cfg = {
+	.tbl		= sdm845_init_tbl,
+	.tbl_num	= ARRAY_SIZE(sdm845_init_tbl),
+	.regs		= sdm845_regs_layout,
 
 	.disable_ctrl	= (PWR_CTRL1_VREF_SUPPLY_TRIM | PWR_CTRL1_CLAMP_N_EN |
 			   POWER_DOWN),
@@ -241,6 +254,15 @@ struct qusb2_phy_cfg {
  * @tcsr: TCSR syscon register map
  * @cell: nvmem cell containing phy tuning value
  *
+ * @override_imp_res_offset: PHY should use different rescode offset
+ * @imp_res_offset_value: rescode offset to be updated in IMP_CTRL1 register
+ * @override_hstx_trim: PHY should use different HSTX o/p current value
+ * @hstx_trim_value: HSTX_TRIM value to be updated in TUNE1 register
+ * @override_preemphasis: PHY should use different pre-amphasis amplitude
+ * @preemphasis_level: Amplitude Pre-Emphasis to be updated in TUNE1 register
+ * @override_preemphasis_width: PHY should use different pre-emphasis duration
+ * @preemphasis_width: half/full-width Pre-Emphasis updated via TUNE1
+ *
  * @cfg: phy config data
  * @has_se_clk_scheme: indicate if PHY has single-ended ref clock scheme
  * @phy_initialized: indicate if PHY has been initialized
@@ -259,12 +281,35 @@ struct qusb2_phy {
 	struct regmap *tcsr;
 	struct nvmem_cell *cell;
 
+	bool override_imp_res_offset;
+	u8 imp_res_offset_value;
+	bool override_hstx_trim;
+	u8 hstx_trim_value;
+	bool override_preemphasis;
+	u8 preemphasis_level;
+	bool override_preemphasis_width;
+	u8 preemphasis_width;
+
 	const struct qusb2_phy_cfg *cfg;
 	bool has_se_clk_scheme;
 	bool phy_initialized;
 	enum phy_mode mode;
 };
 
+static inline void qusb2_write_mask(void __iomem *base, u32 offset,
+				    u32 val, u32 mask)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~mask;
+	reg |= val & mask;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
 static inline void qusb2_setbits(void __iomem *base, u32 offset, u32 val)
 {
 	u32 reg;
@@ -305,6 +350,42 @@ void qcom_qusb2_phy_configure(void __iomem *base,
 }
 
 /*
+ * Update board specific PHY tuning override values if specified from
+ * device tree.
+ */
+static void qusb2_phy_override_phy_params(struct qusb2_phy *qphy)
+{
+	const struct qusb2_phy_cfg *cfg = qphy->cfg;
+
+	if (qphy->override_imp_res_offset)
+		qusb2_write_mask(qphy->base, QUSB2PHY_IMP_CTRL1,
+			     qphy->imp_res_offset_value << IMP_RES_OFFSET_SHIFT,
+			     IMP_RES_OFFSET_MASK);
+
+	if (qphy->override_hstx_trim)
+		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
+				 qphy->hstx_trim_value << HSTX_TRIM_SHIFT,
+				 HSTX_TRIM_MASK);
+
+	if (qphy->override_preemphasis)
+		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
+				qphy->preemphasis_level << PREEMPHASIS_EN_SHIFT,
+				PREEMPHASIS_EN_MASK);
+
+	if (qphy->override_preemphasis_width) {
+		if (qphy->preemphasis_width ==
+		    QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT)
+			qusb2_setbits(qphy->base,
+				      cfg->regs[QUSB2PHY_PORT_TUNE1],
+				      PREEMPH_WIDTH_HALF_BIT);
+		else
+			qusb2_clrbits(qphy->base,
+				      cfg->regs[QUSB2PHY_PORT_TUNE1],
+				      PREEMPH_WIDTH_HALF_BIT);
+	}
+}
+
+/*
  * Fetches HS Tx tuning value from nvmem and sets the
  * QUSB2PHY_PORT_TUNE1/2 register.
  * For error case, skip setting the value and use the default value.
@@ -525,6 +606,9 @@ static int qusb2_phy_init(struct phy *phy)
 	qcom_qusb2_phy_configure(qphy->base, cfg->regs, cfg->tbl,
 				 cfg->tbl_num);
 
+	/* Override board specific PHY tuning values */
+	qusb2_phy_override_phy_params(qphy);
+
 	/* Set efuse value for tuning the PHY */
 	qusb2_phy_set_tune2_param(qphy);
 
@@ -647,8 +731,8 @@ static int qusb2_phy_exit(struct phy *phy)
 		.compatible	= "qcom,msm8996-qusb2-phy",
 		.data		= &msm8996_phy_cfg,
 	}, {
-		.compatible	= "qcom,qusb2-v2-phy",
-		.data		= &qusb2_v2_phy_cfg,
+		.compatible	= "qcom,sdm845-qusb2-phy",
+		.data		= &sdm845_phy_cfg,
 	},
 	{ },
 };
@@ -668,6 +752,7 @@ static int qusb2_phy_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, i;
 	int num;
+	u32 value;
 
 	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
 	if (!qphy)
@@ -736,6 +821,31 @@ static int qusb2_phy_probe(struct platform_device *pdev)
 		qphy->cell = NULL;
 		dev_dbg(dev, "failed to lookup tune2 hstx trim value\n");
 	}
+
+	if (!of_property_read_u32(dev->of_node, "qcom,imp-res-offset-value",
+				  &value)) {
+		qphy->imp_res_offset_value = (u8)value;
+		qphy->override_imp_res_offset = true;
+	}
+
+	if (!of_property_read_u32(dev->of_node, "qcom,hstx-trim-value",
+				  &value)) {
+		qphy->hstx_trim_value = (u8)value;
+		qphy->override_hstx_trim = true;
+	}
+
+	if (!of_property_read_u32(dev->of_node, "qcom,preemphasis-level",
+				     &value)) {
+		qphy->preemphasis_level = (u8)value;
+		qphy->override_preemphasis = true;
+	}
+
+	if (!of_property_read_u32(dev->of_node, "qcom,preemphasis-width",
+				     &value)) {
+		qphy->preemphasis_width = (u8)value;
+		qphy->override_preemphasis_width = true;
+	}
+
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 	/*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

