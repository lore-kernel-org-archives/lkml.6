Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11937ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DA920869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DA920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJSXWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:22:31 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.214]:54433 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbeJSXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:22:30 -0400
Received: from [67.219.246.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-east-1.aws.symcld.net id 72/5C-10908-C25F9CB5; Fri, 19 Oct 2018 15:15:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleJIrShJLcpLzFFi42Jx8l0noKvz9WS
  0wfFD0hbzj5xjtdi4+TaLxaqpO1ksNj2+xmrR9Wsls8XlXXPYLJZev8hk0br3CLvF3+2bWCxe
  bBF34PJYM28No8emVZ1sHpuX1HtsfLeDyaP/r4HH501yAWxRrJl5SfkVCawZq1s8Cn6JVEw5K
  dfA2CbYxcjFISSwilFiatN0ZghnC6PEhxMP2LoYOTnYBHQkpuw/zAJiiwhISqxduQisiFlgCp
  PE6W+7wIqEBUIkvvzaC1bEIqAq8WL+EnYQm1fATeL45gOMILaEgJzEzXOdzCA2p4C7xNsJ38H
  qhYBqdl/qY4GoF5Q4OfMJmM0sICFx8MULZogaZYktKy5AzVGQWHvgPNMERv5ZSFpmIWlZwMi0
  itEsqSgzPaMkNzEzR9fQwEDX0NBI11TXyNBAL7FKN1mvtFg3NbG4RNdQL7G8WK+4Mjc5J0UvL
  7VkEyMwHlIKWC/tYDzdkn6IUZKDSUmUt0D9ZLQQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd5dX4
  BygkWp6akVaZk5wMiESUtw8CiJ8LaCpHmLCxJzizPTIVKnGI052p5en8HM0QEihVjy8vNSpcR
  5t4GUCoCUZpTmwQ2CJYxLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5v30GmsKTmVcCt+8V
  0ClMQKecMD0BckpJIkJKqoGRi/3Hpscqfo+4ZhVFxPPPsoxWKA8UnLl0e8P+bz8SwjeWWL0r5
  8len3BvQQxDm0fX/XxhEb5OWw8tjWlLLM//lUzZvjLk1OLzC0zvZUisOjoncuZc58Vf3N/sv3
  EvY3aQ5VeVDc0LsoTaT3g9Nt6mIXp7TnU1+wFGyQp71p5zbgYbVbxrdk1QYinOSDTUYi4qTgQ
  AgxX5HBMDAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-8.tower-405.messagelabs.com!1539962155!902137!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10334 invoked from network); 19 Oct 2018 15:15:56 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-8.tower-405.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Oct 2018 15:15:56 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 19 Oct 2018
 10:15:55 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 19 Oct 2018 17:15:53 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant
Date:   Fri, 19 Oct 2018 17:15:41 +0200
Message-ID: <1539962141-32418-2-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539962141-32418-1-git-send-email-alex.gonzalez@digi.com>
References: <1539962141-32418-1-git-send-email-alex.gonzalez@digi.com>
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
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 65 +++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
index c71a84da1af0..f465e2d97832 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
@@ -161,6 +161,26 @@
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
+
 &iomuxc {
 	pinctrl_gpmi_nand: gpmigrp {
 		fsl,pins = <
@@ -188,6 +208,51 @@
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
