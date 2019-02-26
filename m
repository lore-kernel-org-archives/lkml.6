Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5432173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rircDHoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfBZG6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:58:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43423 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBZG6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:58:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so5749916pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7FR8/8tptUwO+k/1OIRErTD9JQTRZA+Sx4xaDDVuT1Y=;
        b=rircDHoo/OtYW/dFCQ1Phs2okekS4MbjLWmLgqoV86fiysVRl9A4nC0vbtFZXDrtwM
         tNYvNHHUtcms8zgHKinybcgWKcJDpo8sKI08i3448/8yIM8BRbryYteAtZO41Y5F1p6n
         /2gMn88w3JMNxc35Lfn7gAqUvpW4AxL8h0t5lJX8/gRMi9WqQjQeDQuxzDZ/nbaDOccM
         B/Mah/HLaNnH7iTLUeFY3YXtZKn5Qkw6Ou4XXqWChm8TN6PZGJuCpsfkJGqkCQE0hcb2
         WEoepSXb2TiXwwLn4BQvQtvd5or3OAUIvlv8wLPbf0Nu3mHPELgfJo2J6nBof4J/U3rM
         L7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7FR8/8tptUwO+k/1OIRErTD9JQTRZA+Sx4xaDDVuT1Y=;
        b=fUrZXdzp8F84D5R5UNrYy2m977G6nkc4goeDV2CEflgTHhNvpaSwL0L5dLLRSoPjO/
         zzvIh3NGjYOabDYTHrSHXw/b+/9YLE6NXplp5WnpLgdDPYQk9N20sESPlh1JI4xbOPC/
         e03akJDqnoRbzmQhRgHGmGQAucsRXUtpdN+eqJC2WsmZCLwZ2W5vY/hhpR6o7Y1ezW0g
         wYYti7IaLftbdskL6n1au8fWhdXJsd+Tt86WffGxvsGLis3y/ZJsecyOO8JTXqkejJhI
         KA+AQfd2Q9dikwEeT47kQQ3ef6MNyoFm6f9k5iC3aNyIQM3Xqn0LTdAmNU0NvS4Jo6O/
         6YHQ==
X-Gm-Message-State: AHQUAubZT9d9Rv9MXVDP8V3x+03djocmxLRIMprLdIRaSMzHRb0mF+E4
        vWezqYS2S3S7/CvfJuOIIF9pCg==
X-Google-Smtp-Source: AHgI3IbNGK/sZPU3e1yUNQiyGF4W6rUu8A83QZ0gVWZO6Ffw/OXyc95GgdMOyIB8T6TXIQfzYy5RLQ==
X-Received: by 2002:a63:6b03:: with SMTP id g3mr2834387pgc.239.1551164327937;
        Mon, 25 Feb 2019 22:58:47 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm2892148pfn.120.2019.02.25.22.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:58:47 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH] phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
Date:   Mon, 25 Feb 2019 22:59:19 -0800
Message-Id: <20190226065919.22218-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_qmp_phy_init() is extended to support the additional register
writes needed in PCS MISC and the appropriate sequences and resources
are defined for SDM845.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   7 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 160 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  12 ++
 3 files changed, 179 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 5d181fc3cc18..dd2725a9d3f7 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -11,6 +11,7 @@ Required properties:
 	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
 	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
 	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
+	       "qcom,sdm845-qmp-pcie-phy" for PCIe phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
 	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
@@ -48,6 +49,10 @@ Required properties:
 			"aux", "cfg_ahb", "ref".
 		For "qcom,msm8998-qmp-ufs-phy" must contain:
 			"ref", "ref_aux".
+		For "qcom,sdm845-qmp-usb3-phy" must contain:
+			"aux", "cfg_ahb", "ref", "refgen".
+		For "qcom,sdm845-qmp-usb3-phy" must contain:
+			"aux", "cfg_ahb", "ref", "com_aux".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"aux", "cfg_ahb", "ref", "com_aux".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
@@ -70,6 +75,8 @@ Required properties:
 		For "qcom,msm8998-qmp-usb3-phy" must contain
 			"phy", "common".
 		For "qcom,msm8998-qmp-ufs-phy": no resets are listed.
+		For "qcom,sdm845-qmp-pcie-phy" must contain:
+			"phy".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 08d6f6f7f039..c5ca4a217439 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -159,6 +159,11 @@ static const unsigned int qmp_v3_usb3phy_regs_layout[] = {
 	[QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x170,
 };
 
+static const unsigned int sdm845_pciephy_regs_layout[] = {
+	[QPHY_START_CTRL]		= 0x08,
+	[QPHY_PCS_READY_STATUS]		= 0x174,
+};
+
 static const unsigned int sdm845_ufsphy_regs_layout[] = {
 	[QPHY_START_CTRL]		= 0x00,
 	[QPHY_PCS_READY_STATUS]		= 0x160,
@@ -392,6 +397,109 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG_L(QPHY_START_CTRL, 0x3),
 };
 
+static const struct qmp_phy_init_tbl sdm845_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x007),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xc9),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_TIMER1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_TIMER2, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_EP_DIV, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_MODE, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x33),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_BUF_ENABLE, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER1, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE1, 0x7e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE2, 0x15),
+};
+
+static const struct qmp_phy_init_tbl sdm845_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
+};
+
+static const struct qmp_phy_init_tbl sdm845_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_ENABLES, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_GAIN_HALF, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x71),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_01, 0x59),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x71),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x40),
+};
+
+static const struct qmp_phy_init_tbl sdm845_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_ENDPOINT_REFCLK_DRIVE, 0x04),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_MSB, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_LSB, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LP_WAKEUP_DLY_TIME_AUXCLK_MSB, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LP_WAKEUP_DLY_TIME_AUXCLK, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PLL_LOCK_CHK_DLY_TIME, 0x73),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0xbb),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG1, 0x0d),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG4, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sdm845_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_CONFIG2, 0x52),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG2, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG4, 0x1a),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG5, 0x06),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MISC_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
+};
+
 static const struct qmp_phy_init_tbl qmp_v3_usb3_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x07),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0x14),
@@ -813,6 +921,8 @@ struct qmp_phy_cfg {
 	int rx_tbl_num;
 	const struct qmp_phy_init_tbl *pcs_tbl;
 	int pcs_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_misc_tbl;
+	int pcs_misc_tbl_num;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -949,6 +1059,10 @@ static const char * const qmp_v3_phy_clk_l[] = {
 	"aux", "cfg_ahb", "ref", "com_aux",
 };
 
+static const char * const sdm845_pciephy_clk_l[] = {
+	"aux", "cfg_ahb", "ref", "refgen",
+};
+
 static const char * const sdm845_ufs_phy_clk_l[] = {
 	"ref", "ref_aux",
 };
@@ -962,6 +1076,10 @@ static const char * const msm8996_usb3phy_reset_l[] = {
 	"phy", "common",
 };
 
+static const char * const sdm845_pciephy_reset_l[] = {
+	"phy",
+};
+
 /* list of regulators */
 static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
@@ -1059,6 +1177,39 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.pwrdn_delay_max	= 1005,		/* us */
 };
 
+static const struct qmp_phy_cfg sdm845_pciephy_cfg = {
+	.type = PHY_TYPE_PCIE,
+	.nlanes = 1,
+
+	.serdes_tbl		= sdm845_pcie_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sdm845_pcie_serdes_tbl),
+	.tx_tbl			= sdm845_pcie_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sdm845_pcie_tx_tbl),
+	.rx_tbl			= sdm845_pcie_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sdm845_pcie_rx_tbl),
+	.pcs_tbl		= sdm845_pcie_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sdm845_pcie_pcs_tbl),
+	.pcs_misc_tbl		= sdm845_pcie_pcs_misc_tbl,
+	.pcs_misc_tbl_num	= ARRAY_SIZE(sdm845_pcie_pcs_misc_tbl),
+	.clk_list		= sdm845_pciephy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sdm845_pciephy_regs_layout,
+
+	.start_ctrl		= PCS_START | SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.mask_com_pcs_ready	= PCS_READY,
+
+	.has_phy_com_ctrl	= false,
+	.has_lane_rst		= false,
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= 995,		/* us */
+	.pwrdn_delay_max	= 1005,		/* us */
+};
+
 static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -1344,6 +1495,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	void __iomem *tx = qphy->tx;
 	void __iomem *rx = qphy->rx;
 	void __iomem *pcs = qphy->pcs;
+	void __iomem *pcs_misc = qphy->pcs_misc;
 	void __iomem *dp_com = qmp->dp_com;
 	void __iomem *status;
 	unsigned int mask, val;
@@ -1384,6 +1536,11 @@ static int qcom_qmp_phy_init(struct phy *phy)
 
 	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
+	if (cfg->pcs_misc_tbl) {
+		qcom_qmp_phy_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
+				       cfg->pcs_misc_tbl_num);
+	}
+
 	/*
 	 * UFS PHY requires the deassert of software reset before serdes start.
 	 * For UFS PHYs that do not have software reset control bits, defer
@@ -1878,6 +2035,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,ipq8074-qmp-pcie-phy",
 		.data = &ipq8074_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qmp-pcie-phy",
+		.data = &sdm845_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sdm845-qmp-usb3-phy",
 		.data = &qmp_v3_usb3phy_cfg,
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index a1b6cdee9a08..335ea5d7ef40 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -241,6 +241,7 @@
 #define QSERDES_V3_RX_RX_BAND				0x110
 #define QSERDES_V3_RX_RX_INTERFACE_MODE			0x11c
 #define QSERDES_V3_RX_RX_MODE_00			0x164
+#define QSERDES_V3_RX_RX_MODE_01			0x168
 
 /* Only for QMP V3 PHY - PCS registers */
 #define QPHY_V3_PCS_POWER_DOWN_CONTROL			0x004
@@ -280,6 +281,7 @@
 #define QPHY_V3_PCS_TSYNC_RSYNC_TIME			0x08c
 #define QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK		0x0a0
 #define QPHY_V3_PCS_LP_WAKEUP_DLY_TIME_AUXCLK		0x0a4
+#define QPHY_V3_PCS_PLL_LOCK_CHK_DLY_TIME		0x0a8
 #define QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK		0x0b0
 #define QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME		0x0b8
 #define QPHY_V3_PCS_RXEQTRAINING_RUN_TIME		0x0bc
@@ -292,13 +294,23 @@
 #define QPHY_V3_PCS_RX_MIN_HIBERN8_TIME			0x138
 #define QPHY_V3_PCS_RX_SIGDET_CTRL1			0x13c
 #define QPHY_V3_PCS_RX_SIGDET_CTRL2			0x140
+#define QPHY_V3_PCS_LP_WAKEUP_DLY_TIME_AUXCLK_MSB	0x1a8
+#define QPHY_V3_PCS_OSC_DTCT_ACTIONS			0x1ac
+#define QPHY_V3_PCS_SIGDET_CNTRL			0x1b0
 #define QPHY_V3_PCS_TX_MID_TERM_CTRL1			0x1bc
 #define QPHY_V3_PCS_MULTI_LANE_CTRL1			0x1c4
 #define QPHY_V3_PCS_RX_SIGDET_LVL			0x1d8
+#define QPHY_V3_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_LSB	0x1dc
+#define QPHY_V3_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_MSB	0x1e0
 #define QPHY_V3_PCS_REFGEN_REQ_CONFIG1			0x20c
 #define QPHY_V3_PCS_REFGEN_REQ_CONFIG2			0x210
 
 /* Only for QMP V3 PHY - PCS_MISC registers */
 #define QPHY_V3_PCS_MISC_CLAMP_ENABLE			0x0c
+#define QPHY_V3_PCS_MISC_OSC_DTCT_CONFIG2		0x2c
+#define QPHY_V3_PCS_MISC_PCIE_INT_AUX_CLK_CONFIG1	0x44
+#define QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG2		0x54
+#define QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG4		0x5c
+#define QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG5		0x60
 
 #endif
-- 
2.18.0

