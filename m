Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34857C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2872083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VzxKw0ho";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="an+zYlf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2872083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965698AbeFSIhW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:37:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49902 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965400AbeFSIhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:37:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3480360AFF; Tue, 19 Jun 2018 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529397435;
        bh=aKxrFTR24EHraaG7ijLlo8wgL3M8x9U3mIZQoUSmVSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzxKw0hoLXcZG7E1CjCiEsNdlQ7Gs8N4Khwz6ZDeeI8Nj43eCYcY3Tfsw5acUkxzd
         kfr2aK4USPcMlICKj4ELckd42G9st+xDpw/+xnCggyMuA1QNGkeg2kKrBZCBNn/Gox
         HULabZvg3+qjXmKRnZjUbOujHw2ls/9Wm7dKAIoU=
Received: from CANG02.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1507D60227;
        Tue, 19 Jun 2018 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529397434;
        bh=aKxrFTR24EHraaG7ijLlo8wgL3M8x9U3mIZQoUSmVSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=an+zYlf+wkcCmRjVenapKt3nYqIxjmc1jyVq2CewznH7Re+6BuZcol7NMYE/jvWei
         iu5CTVQ9d0A4u/r0hN8DYOjW6X523drUSMVQVRmaLmPVbNFsxEGP2EHTfqKK/bi8zw
         q9xbQjfwUz4xCDrgWOK3424iEKzclGKM6PIGTxa0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1507D60227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v7 2/4] phy: General struct and field cleanup
Date:   Tue, 19 Jun 2018 16:36:45 +0800
Message-Id: <20180619083647.10116-3-cang@codeaurora.org>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20180619083647.10116-1-cang@codeaurora.org>
References: <20180619083647.10116-1-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MSM8996 specific PHY vreg list struct name to a genernal one as it is
used by all PHYs. Add a specific field to handle dual lane situation.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index ccb8578..9be9754 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -649,6 +649,8 @@ struct qmp_phy_cfg {
 
 	/* true, if PHY has a separate DP_COM control block */
 	bool has_phy_dp_com_ctrl;
+	/* true, if PHY has secondary tx/rx lanes to be configured */
+	bool is_dual_lane_phy;
 	/* Register offset of secondary tx/rx lanes for USB DP combo PHY */
 	unsigned int tx_b_lane_offset;
 	unsigned int rx_b_lane_offset;
@@ -758,7 +760,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 };
 
 /* list of regulators */
-static const char * const msm8996_phy_vreg_l[] = {
+static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
 };
 
@@ -778,8 +780,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
 	.reset_list		= msm8996_pciephy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_pciephy_reset_l),
-	.vreg_list		= msm8996_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= pciephy_regs_layout,
 
 	.start_ctrl		= PCS_START | PLL_READY_GATE_EN,
@@ -809,8 +811,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= msm8996_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= usb3phy_regs_layout,
 
 	.start_ctrl		= SERDES_START | PCS_START,
@@ -870,8 +872,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= msm8996_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
 	.start_ctrl		= SERDES_START | PCS_START,
@@ -883,6 +885,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 
 	.has_phy_dp_com_ctrl	= true,
+	.is_dual_lane_phy	= true,
 	.tx_b_lane_offset	= 0x400,
 	.rx_b_lane_offset	= 0x400,
 };
@@ -903,8 +906,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
-	.vreg_list		= msm8996_phy_vreg_l,
-	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
 	.start_ctrl		= SERDES_START | PCS_START,
@@ -1116,12 +1119,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
 	/* Configuration for other LANE for USB-DP combo PHY */
-	if (cfg->has_phy_dp_com_ctrl)
+	if (cfg->is_dual_lane_phy)
 		qcom_qmp_phy_configure(tx + cfg->tx_b_lane_offset, cfg->regs,
 				       cfg->tx_tbl, cfg->tx_tbl_num);
 
 	qcom_qmp_phy_configure(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num);
-	if (cfg->has_phy_dp_com_ctrl)
+	if (cfg->is_dual_lane_phy)
 		qcom_qmp_phy_configure(rx + cfg->rx_b_lane_offset, cfg->regs,
 				       cfg->rx_tbl, cfg->rx_tbl_num);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

