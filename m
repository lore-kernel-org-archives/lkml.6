Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D246820882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D246820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeKEUDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:03:01 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.214]:34269 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727275AbeKEUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:03:01 -0500
Received: from [67.219.246.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-east-1.aws.symcld.net id C1/81-10908-BEE10EB5; Mon, 05 Nov 2018 10:43:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRWlGSWpSXmKPExsXi5LtOQPe13IN
  ogytiFvOPnGO12Lj5NovFqqk7WSw2Pb7GatH1ayWzxeVdc9gsll6/yGTRuvcIu8Xf7ZtYLF5s
  EXfg8lgzbw2jx6ZVnWwem5fUe2x8t4PJo/+vgcfnTXIBbFGsmXlJ+RUJrBmHulsYC+aJVux59
  oG5gXGjYBcjF4eQwCpGiTX3rjFCOKsZJd4t6mGDcDYzSnxe85S5i5GTg01AR2LK/sMsILaIgK
  TE2pWLmEGKmAWmMEmc/raLDSQhLBAuMfHzdfYuRg4OFgEViR+rs0HCvAJuEj86T7KC2BICchI
  3z3Uyg5RwCrhL/FnlDhIWAip5uvMfI0S5oMTJmU/AVjELSEgcfPGCGaJGWWLLiguMEGMUJNYe
  OM80gVFgFpKWWUhaFjAyrWI0TSrKTM8oyU3MzNE1NDDQNTQ00jXVNTbXS6zSTdYrLdZNTSwu0
  TXUSywv1iuuzE3OSdHLSy3ZxAiMkpQCVtUdjOu70g8xSnIwKYnypl+6Hy3El5SfUpmRWJwRX1
  Sak1p8iFGGg0NJgtcWGHVCgkWp6akVaZk5wHiFSUtw8CiJ8IaApHmLCxJzizPTIVKnGBWlxCH
  6BEASGaV5cG2wFHGJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjCvJsgUnsy8Erjpr4AWMwEt
  vicLtrgkESEl1cA4yTr+uwdThJsj06upB9tdeizFPjel8d6ZFca+8F25sF37n8ierDK5k7azG
  Vetn14y56L7q/92P/Ptrt+U75cvDjp0oKtIb5PUstU9iV/i4oJaJBIFWy3vii1Kb7i/6Oc0ji
  0KgdU/dZWP1hrav5Xbv8V7Lb/gUyv/wt7G0CmBbY116zRnzFJiKc5INNRiLipOBACvqx94DAM
  AAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-15.tower-405.messagelabs.com!1541414634!2056435!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12306 invoked from network); 5 Nov 2018 10:43:54 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-15.tower-405.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Nov 2018 10:43:54 -0000
Received: from MTK-SMS-XCH03.digi.com (10.10.8.197) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 5 Nov 2018
 04:43:54 -0600
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH03.digi.com
 (10.10.8.197) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 5 Nov 2018
 04:43:53 -0600
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 5 Nov 2018 11:43:52 +0100
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v2] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant
Date:   Mon, 5 Nov 2018 11:43:42 +0100
Message-ID: <1541414622-18795-2-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541414622-18795-1-git-send-email-alex.gonzalez@digi.com>
References: <1541414622-18795-1-git-send-email-alex.gonzalez@digi.com>
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

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
index c71a84da1af0..ef26b2389c8f 100644
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
+		>;
+	};
+
+	pinctrl_usdhc1_sleep: usdhc1grp-sleep {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__GPIO2_IO16           0x3000
+			MX6UL_PAD_SD1_CLK__GPIO2_IO17           0x3000
+			MX6UL_PAD_SD1_DATA0__GPIO2_IO18         0x3000
+			MX6UL_PAD_SD1_DATA1__GPIO2_IO19         0x3000
+			MX6UL_PAD_SD1_DATA2__GPIO2_IO20         0x3000
+			MX6UL_PAD_SD1_DATA3__GPIO2_IO21         0x3000
+		>;
+	};
+
+	pinctrl_wifibt_ctrl: wifibt-ctrl-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x08a0
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x08a0
+		>;
+	};
+
+	pinctrl_wifibt_ctrl_sleep: wifibt-ctrl-grp-sleep {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x3000
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x3000
+		>;
+	};
 };
 
 &reg_arm {
