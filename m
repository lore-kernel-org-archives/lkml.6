Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96A4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF1120840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF1120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbeHAUTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:19:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbeHATDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E882F12CC;
        Wed,  1 Aug 2018 17:10:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 291/336] ARM: dts: imx6qdl-wandboard: Let the codec control MCLK pinctrl
Date:   Wed,  1 Aug 2018 18:50:26 +0200
Message-Id: <20180801165040.157166087@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit 6e1386b2ee6822b00ae944a3de2c3304d2d422e6 ]

sgtl5000 codec needs MCLK clock to be present so that it can
successfully read/write via I2C.

In the case of wandboard, MCLK is provided via
MX6QDL_PAD_GPIO_0__CCM_CLKO1 pad.

Move the MCLK pinctrl from hog group to the codec group, so that the
codec clock can be present prior to reading the codec ID.

This avoids the following error that happens from time to time:

[    2.484443] sgtl5000 1-000a: Error reading chip id -6

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi |    1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi |    1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi |    1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi       |    8 ++++++++
 4 files changed, 8 insertions(+), 3 deletions(-)

--- a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
@@ -17,7 +17,6 @@
 	imx6qdl-wandboard {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
 				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
 				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
 				MX6QDL_PAD_EIM_EB1__GPIO2_IO29		0x0f0b0		/* WL_REF_ON */
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
@@ -17,7 +17,6 @@
 	imx6qdl-wandboard {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
 				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
 				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
 				MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00	0x0f0b0		/* WIFI_ON (reset, active low) */
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
@@ -147,7 +147,6 @@
 	imx6qdl-wandboard {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1     	0x130b0
 				MX6QDL_PAD_EIM_D22__USB_OTG_PWR		0x80000000	/* USB Power Enable */
 				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* USDHC1 CD */
 				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -83,6 +83,8 @@
 	status = "okay";
 
 	codec: sgtl5000@a {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mclk>;
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
@@ -142,6 +144,12 @@
 			>;
 		};
 
+		pinctrl_mclk: mclkgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
+			>;
+		};
+
 		pinctrl_spdif: spdifgrp {
 			fsl,pins = <
 				MX6QDL_PAD_ENET_RXD0__SPDIF_OUT		0x1b0b0


