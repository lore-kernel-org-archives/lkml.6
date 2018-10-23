Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58310C7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA4C20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HB34n2uv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OjG0/6ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA4C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJWM54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:57:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJWM5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:57:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1B21D61309; Tue, 23 Oct 2018 04:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269378;
        bh=YI6a5Q0HGLwKjizFSW2cEEIaRoKPDm3Mpw28U05ro6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HB34n2uvUKOGijKtatgZOt0wK0q6w9ioRD63ILqau9ial49QqPMHTlV3jdOfa/XAU
         RO427oGb9PK2z0zsdOjRFEQwp3P4KXxyQMLXakUqWyjglszhQlQKzbHydAGB17+sHM
         eTrDK7LYApDs6b5YPHCWQ61/88YfFx6DIVnzuosI=
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFF9C61308;
        Tue, 23 Oct 2018 04:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269377;
        bh=YI6a5Q0HGLwKjizFSW2cEEIaRoKPDm3Mpw28U05ro6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjG0/6ap6BIy86q8rlh4Hn62c4rEqfI37Y/80W1/xuUtx4CbYvVoiPNJAUmIWdwJ/
         tr9mk7hgWx+du5mQ0DA+THRoBW9/5B12SQnHrg6bOgC/fYgcEkdNirHQY+kmdrNtlf
         uxFN9cxcmblGrpvq8GJmNhQJVfkvIcDOoWW3h5ck=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFF9C61308
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v10 2/6] phy: General struct and field cleanup
Date:   Mon, 22 Oct 2018 21:35:57 -0700
Message-Id: <1540269361-28185-3-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
References: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MSM8996 specific PHY vreg list struct name to a genernal one as it is
used by all PHYs. Add a specific field to handle dual lane situation.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Manu Gautam <mgautam@codeaurora.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
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

