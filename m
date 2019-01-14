Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41EBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F565206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WeHOHGmA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cQE5o6Dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfANQg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:36:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfANQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:36:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2E524609C6; Mon, 14 Jan 2019 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483816;
        bh=Pmq1jcQEHM8Y0sooBukLDQWW8797SUPkxUY+SUaya3I=;
        h=From:To:Cc:Subject:Date:From;
        b=WeHOHGmABfm5q3rAb6bJfMVGzNtC8k6zq4QrNWrp/R4gLym2P6RtIk6dTM6cnZ4ny
         V2SHAt+LTMdbTJve3ng2Ahtc8Yfv08CqOHXzVz0k8mBqnwAna2yPq6S7kPru/QxZHH
         XhSmae+FoZpedfYEbIH+vyjeVe0AVgmrhQ/0rP40=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C7B86099A;
        Mon, 14 Jan 2019 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547483813;
        bh=Pmq1jcQEHM8Y0sooBukLDQWW8797SUPkxUY+SUaya3I=;
        h=From:To:Cc:Subject:Date:From;
        b=cQE5o6Dpis/pjd1qxQFgRIwem00v2apJNackyErorSQw6mXwIMB8EuM/EUqkXo3kG
         jRMx7AmYmLxaKf1i8LJiO30xy1r6FFMrVuHcf9JsN2x4jenKkGExsAESD7KAbR0sMA
         yzuDuTXwPVHBElXQnmzFfanB6mmUwcV2a8c6Fy9A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C7B86099A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     kishon@ti.com
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 3/6] phy: qcom-qusb2: Add QUSB2 PHY support for msm8998
Date:   Mon, 14 Jan 2019 09:36:42 -0700
Message-Id: <1547483802-5408-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8998 contains one QUSB2 PHY which is very similar to the existing
sdm845 support.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 9177989f..e5e4f36 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -152,6 +152,32 @@ enum qusb2phy_reg_layout {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
 };
 
+static const unsigned int msm8998_regs_layout[] = {
+	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
+	[QUSB2PHY_PLL_STATUS]              = 0x1a0,
+	[QUSB2PHY_PORT_TUNE1]              = 0x23c,
+	[QUSB2PHY_PORT_TUNE2]              = 0x240,
+	[QUSB2PHY_PORT_TUNE3]              = 0x244,
+	[QUSB2PHY_PORT_TUNE4]              = 0x248,
+	[QUSB2PHY_PORT_TEST1]              = 0x24c,
+	[QUSB2PHY_PORT_TEST2]              = 0x250,
+	[QUSB2PHY_PORT_POWERDOWN]          = 0x210,
+	[QUSB2PHY_INTR_CTRL]               = 0x22c,
+};
+
+static const struct qusb2_phy_init_tbl msm8998_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x13),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_LOCK_DELAY, 0x0a),
+
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xa5),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x09),
+
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
+};
+
+
 static const unsigned int sdm845_regs_layout[] = {
 	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
 	[QUSB2PHY_PLL_STATUS]		= 0x1a0,
@@ -221,6 +247,18 @@ struct qusb2_phy_cfg {
 	.autoresume_en	 = BIT(3),
 };
 
+static const struct qusb2_phy_cfg msm8998_phy_cfg = {
+	.tbl            = msm8998_init_tbl,
+	.tbl_num        = ARRAY_SIZE(msm8998_init_tbl),
+	.regs           = msm8998_regs_layout,
+
+	.disable_ctrl   = POWER_DOWN,
+	.mask_core_ready = CORE_READY_STATUS,
+	.has_pll_override = true,
+	.autoresume_en   = BIT(0),
+	.update_tune1_with_efuse = true,
+};
+
 static const struct qusb2_phy_cfg sdm845_phy_cfg = {
 	.tbl		= sdm845_init_tbl,
 	.tbl_num	= ARRAY_SIZE(sdm845_init_tbl),
@@ -734,6 +772,9 @@ static int qusb2_phy_exit(struct phy *phy)
 		.compatible	= "qcom,msm8996-qusb2-phy",
 		.data		= &msm8996_phy_cfg,
 	}, {
+		.compatible	= "qcom,msm8998-qusb2-phy",
+		.data		= &msm8998_phy_cfg,
+	}, {
 		.compatible	= "qcom,sdm845-qusb2-phy",
 		.data		= &sdm845_phy_cfg,
 	},
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

