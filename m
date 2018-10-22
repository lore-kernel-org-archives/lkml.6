Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43DFC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A366B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A366B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeJVRpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:45:19 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.210]:34020 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727519AbeJVRpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:45:19 -0400
Received: from [67.219.247.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-d.us-east-1.aws.symcld.net id 22/A5-08437-7089DCB5; Mon, 22 Oct 2018 09:27:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleJIrShJLcpLzFFi42Jx8l0noMs+42y
  0wa42Zov5R86xWmzcfJvFYtXUnSwWmx5fY7Xo+rWS2eLyrjlsFkuvX2SyaN17hN3i7/ZNLBYv
  tog7cHmsmbeG0WPTqk42j81L6j02vtvB5NH/18Dj8ya5ALYo1sy8pPyKBNaM1oevmAt+iFR8O
  xDawNgq2MXIxSEksIpR4tveRewQzhZGia0L9jB3MXJysAnoSEzZf5gFxBYRkJRYu3IRM0gRs8
  AUJonT33axgSSEBcIlOvacYQKxWQRUJZp/NrOD2LwCbhIzFrwAa5YQkJO4ea4TbCingLtEw+m
  rYL1CQDVT15xggqgXlDg58wlYPbOAhMTBFy+YIWqUJbasuMAIMUdBYu2B80wTGPlnIWmZhaRl
  ASPTKkazpKLM9IyS3MTMHF1DAwNdQ0MjINa1MNBLrNJN0Sst1k1NLC7RNdRLLC/WK67MTc5J0
  ctLLdnECIyIlALugB2Mz5amH2KU5GBSEuVNND4dLcSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCl2
  X62WghwaLU9NSKtMwcYGzCpCU4eJREeC9PA0rzFhck5hZnpkOkTjEac7Q9vT6DmaMDRAqx5OX
  npUqJ894GKRUAKc0ozYMbBEsZlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ8yqB3MOTmVcC
  t+8V0ClMQKdcVz8DckpJIkJKqoFxqX3hyUnVHxbs1+h+fOe47BF5bykecbOl+4OsuM/2VM154
  Vu5+O03+YqgAM9W0xX775rdWDEhvMWJxT1w+6H907o6CwPUjgpEpa+dfPFz0pvudw958+f+Ff
  +olFS6uivk+qWVfHuvctbNPn78ZvKva0/kPnY4h+VOtHFQc7/dydXQEsLgIXhPiaU4I9FQi7m
  oOBEAdTwTJRQDAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-11.tower-425.messagelabs.com!1540200454!930685!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16568 invoked from network); 22 Oct 2018 09:27:34 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-11.tower-425.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Oct 2018 09:27:34 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 22 Oct 2018
 04:27:34 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 22 Oct 2018 11:27:32 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v1] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant
Date:   Mon, 22 Oct 2018 11:27:23 +0200
Message-ID: <1540200443-24773-2-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540200443-24773-1-git-send-email-alex.gonzalez@digi.com>
References: <1540200443-24773-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wireless variants of the ConnecCore 6UL SOM include a Qualcomm
QCA6564 wireless chip with dual WiFi and Bluetooth.

Both the ConnectCore 6UL SBC Express and Pro boards fit a wireless SOM.

The Wifi is connected through the SDIO interface on usdhc1 and the
Bluetooth is connected via uart1.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
index c71a84da1af0..23bbcd4c71d1 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
@@ -161,6 +161,25 @@
 	};
 };
 
+/* UART1 (Bluetooth) */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* USDHC1 (Wireless) */
+&usdhc1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_wifibt_ctrl>;
+	pinctrl-1 = <&pinctrl_usdhc1_sleep &pinctrl_wifibt_ctrl_sleep>;
+	non-removable;
+	no-1-8-v;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_gpmi_nand: gpmigrp {
 		fsl,pins = <
@@ -188,6 +207,51 @@
 			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
 			>;
 		};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX   0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX   0x1b0b1
+			MX6UL_PAD_UART1_RTS_B__UART1_DCE_RTS    0x1b0b1
+			MX6UL_PAD_UART1_CTS_B__UART1_DCE_CTS    0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD           0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK           0x17051
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0       0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1       0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2       0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3       0x17059
+			 >;
+		};
+
+	pinctrl_usdhc1_sleep: usdhc1grp-sleep {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__GPIO2_IO16           0x3000
+			MX6UL_PAD_SD1_CLK__GPIO2_IO17           0x3000
+			MX6UL_PAD_SD1_DATA0__GPIO2_IO18         0x3000
+			MX6UL_PAD_SD1_DATA1__GPIO2_IO19         0x3000
+			MX6UL_PAD_SD1_DATA2__GPIO2_IO20         0x3000
+			MX6UL_PAD_SD1_DATA3__GPIO2_IO21         0x3000
+			 >;
+	};
+
+	pinctrl_wifibt_ctrl: wifibt-ctrl-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x08a0
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x08a0
+			  >;
+	};
+
+	pinctrl_wifibt_ctrl_sleep: wifibt-ctrl-grp-sleep {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x3000
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x3000
+			 >;
+	};
 };
 
 &reg_arm {
