Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05F9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0DA2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0DA2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937375AbeFSHci (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:32:38 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.112]:16148 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937324AbeFSHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:32:33 -0400
Received: from [67.219.250.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-west-2.aws.symcld.net id 82/78-01604-D81B82B5; Tue, 19 Jun 2018 07:32:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRWlGSWpSXmKPExsXi5LtOQLd3o0a
  0wafnfBbzj5xjtdi4+TaLxaqpO1ksNj2+xmrR9Wsls8XlXXPYLJZev8hk0br3CLvF3+2bWCxe
  bBF34PJYM28No8emVZ1sHpuX1HtsfLeDyaP/r4HH501yAWxRrJl5SfkVCawZ3affMxV0a1Ws2
  bKcqYFxuVIXIyeHkMBqRom1vzK7GLmA7DWMEp82fmKHcLYwSjy4vJ8VpIpNQEdiyv7DLCC2iI
  CkxNqVi5hBipgFfjFKvPxznA0kISwQKfFywy9mEJtFQFXi9ON/7CA2r4CrxPn5G5lAbAkBOYm
  b5zrBajgF3CTOffrIBnGGq8Sh1QuYIeoFJU7OfAK2jFlAU6J1+292CFteonnrbGaIemWJLSsu
  MELMVJBYe+A80wRGwVlI2mchaZ+FpH0BI/MqRoukosz0jJLcxMwcXUMDA11DQyNdQ2MTXSMDC
  73EKt0kvdJi3fLU4hJdI73E8mK94src5JwUvbzUkk2MwPhiAIIdjFcPpRxilORgUhLlFYvTiB
  biS8pPqcxILM6ILyrNSS0+xCjDwaEkwdu+ASgnWJSanlqRlpkDjHSYtAQHj5IIryZImre4IDG
  3ODMdInWKUVFKnPcSSEIAJJFRmgfXBksulxhlpYR5GYEOEeIpSC3KzSxBlX/FKM7BqCTMWwsy
  hSczrwRu+iugxUxAi7dUqYMsLklESEk1MO5nDTr7JNqv5ruWcXTe08/XvHM/iDPZm86bLZl27
  JhX2booYy3u7zuD/6hP3njg7qz73x4cve7yOda8JmJWnIRgYJb69yNTWDvMdD50fWrdUb7153
  bDqxcz53Yxqnsv2Gtmwq3+d7u2NBNzx3aZZZseJDRwaDbsfP0qw/Pgk9Z9HnYLGk8frVZiKc5
  INNRiLipOBACx/HpTKQMAAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-8.tower-345.messagelabs.com!1529393548!46107!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17807 invoked from network); 19 Jun 2018 07:32:29 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-8.tower-345.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Jun 2018 07:32:29 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 19 Jun 2018
 02:32:27 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH04.digi.com
 (10.10.8.198) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 19 Jun
 2018 02:32:26 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Tue, 19 Jun 2018 09:32:25 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL System-On-Module (SOM)
Date:   Tue, 19 Jun 2018 09:32:13 +0200
Message-ID: <1529393534-7827-2-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529393534-7827-1-git-send-email-alex.gonzalez@digi.com>
References: <1529393534-7827-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ConnectCore 6UL System-On-Module has the following hardware
specification:

* Based on a NXP i.MX6UL SoC
* Industrial temperature ranges (-40ºC to +85ºC)
* Up to 1GB DDR3 memory
* Up to 2GB NAND flash
* Dual Ethernet
* On module 802.11 WiFi and Bluetooth 4.2 (QCA6564)
* On module NXP Kinetis KL03
* On module Microchip ATECC508A crypto element

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 199 ++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
new file mode 100644
index 000000000000..23484a48f6e0
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Digi International's ConnectCore 6UL System-On-Module device tree source
+ *
+ * Copyright 2018 Digi International, Inc.
+ *
+ */
+
+/ {
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x4000000>;
+			linux,cma-default;
+		};
+	};
+};
+
+&adc1 {
+	vref-supply = <&vdda_adc_3v3>;
+	max-channel = <9>;
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pfuze3000@8 {
+		compatible = "fsl,pfuze3000";
+		reg = <0x08>;
+
+		regulators {
+			int_3v3: sw1a {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <6250>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_arm_soc_in: sw1b {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1475000>;
+				regulator-ramp-delay = <6250>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <925000>;
+				};
+			};
+
+			ext_3v3: sw2 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <6250>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr3: sw3 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1300000>;
+				};
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			vdd_snvs_3v3: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vrefddr: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdda_adc_3v3: vldo1 {
+				compatible = "regulator-fixed";
+				regulator-name = "vref-adc-3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			ldo2_ext: vldo2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vdda_wlan: vccsd {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_high_in: v33 {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_int: vldo3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			ldo4_ext: vldo4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			vcoin_chg: vcoin {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	imx6ul-ccimx6ul {
+		pinctrl_gpmi_nand: gpmigrp {
+			fsl,pins = <
+				MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
+				MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
+				MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
+				MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
+				MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
+				MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
+				MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
+				MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
+				MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
+				MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
+				MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
+				MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
+				MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
+				MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
+				MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb0b1
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
+				MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
+			>;
+		};
+	};
+};
+
+&reg_arm {
+	vin-supply = <&vdd_arm_soc_in>;
+	regulator-allow-bypass;
+};
+
+&reg_soc {
+	vin-supply = <&vdd_arm_soc_in>;
+	regulator-allow-bypass;
+};
+
