Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7950BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3328320862
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3328320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbeGLI3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:29:21 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.3]:35768 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbeGLI3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:29:19 -0400
Received: from [67.219.246.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-east-1.aws.symcld.net id 93/5A-01621-F5F074B5; Thu, 12 Jul 2018 08:20:47 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRWlGSWpSXmKPExsXi5LtOQDee3z3
  aYPliCYv5R86xWmzcfJvFYtXUnSwWmx5fY7Xo+rWS2eLyrjlsFkuvX2SyaN17hN3i7/ZNLBYv
  tog7cHmsmbeG0WPTqk42j81L6j02vtvB5NH/18Dj8ya5ALYo1sy8pPyKBNaM5v69rAVXNCuO/
  V3H0sDYodTFyMUhJLCKUaJ5+UZWCGcLo8SbvQ+Yuxg5OdgEdCSm7D/MAmKLCEhKrF25iBmkiF
  lgCpPE6W+72LoYOTiEBWIkPrWJg5gsAqoSq/prQMp5BVwlNl66yQRiSwjISdw81wk2klPATeL
  fmv2sILYQUE3vk1fMEPWCEidnPgFbxSygKdG6/Tc7hC0v0bx1NjNEvbLElhUXGCFmKkisPXCe
  aQKjwCwk7bOQtM9C0r6AkXkVo1lSUWZ6RkluYmaOrqGBga6hoZGuga6RsaleYpVukl5psW5qY
  nGJrqFeYnmxXnFlbnJOil5easkmRmD8MADBDsYfs1IPMUpyMCmJ8kpZuUYL8SXlp1RmJBZnxB
  eV5qQWH2KU4eBQkuBt5HOPFhIsSk1PrUjLzAFGMkxagoNHSYRXGSTNW1yQmFucmQ6ROsWoy/H
  n/dRJzEIsefl5qVLivOUgRQIgRRmleXAjYEnlEqOslDAvI9BRQjwFqUW5mSWo8q8YxTkYlYR5
  60Cm8GTmlcBtegV0BBPQEXEpbiBHlCQipKQaGI+VK3q2HD76nN3P+N2jGl9FJ8lj1tkruV54J
  YXmiqov7xZ5xPxGbbnPnrydzUWhRQIp7ww3pKre8HzddfSNk3j4at2/rKFz6mP7pvQcfKtpHL
  XpS9yFG5rTpver3Ly2uFlE8Zh3uMnxZt19DkLbHO9byYt/KClvs3u86540xwr/htmrPryLU2I
  pzkg01GIuKk4EABY8pEclAwAA
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-8.tower-385.messagelabs.com!1531383646!835803!2
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12031 invoked from network); 12 Jul 2018 08:20:47 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-8.tower-385.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Jul 2018 08:20:47 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 12 Jul 2018
 03:20:46 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.399.0; Thu, 12 Jul 2018 10:20:44 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v2 1/2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL System-On-Module (SOM)
Date:   Thu, 12 Jul 2018 10:20:35 +0200
Message-ID: <1531383636-3406-2-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531383636-3406-1-git-send-email-alex.gonzalez@digi.com>
References: <1531383636-3406-1-git-send-email-alex.gonzalez@digi.com>
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
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 202 ++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
new file mode 100644
index 000000000000..255c482ce56f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
@@ -0,0 +1,202 @@
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
+	pfuze3000: pmic@8 {
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
+
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
+
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
+
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
+
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
+
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
+
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
+	pinctrl_gpmi_nand: gpmigrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb0b1
+			>;
+		};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
+			>;
+		};
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
