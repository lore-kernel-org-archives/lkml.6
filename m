Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D36BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACBB20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACBB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeJSRzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:55:36 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60376 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbeJSRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:55:35 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9J9nq6p018797;
        Fri, 19 Oct 2018 04:50:05 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2n3es40mhb-1;
        Fri, 19 Oct 2018 04:50:05 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id AE8FA611C8A7;
        Fri, 19 Oct 2018 04:52:23 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Oct 2018
 10:50:03 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9J9o3ow015276; Fri,
 19 Oct 2018 10:50:03 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 1/5] mfd: lochnagar: Add initial binding documentation
Date:   Fri, 19 Oct 2018 10:49:59 +0100
Message-ID: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810190090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform. This driver supports the board
controller chip on the Lochnagar board.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes since v2:
 - Used vendor prefix on aif-master and aif-slave
 - Used -gpios instead of -gpio in example DT
 - Used - rather than _ on node names in example DT
 - Removed some clocks from the clock DT binding doc since they are
   now being registered purely through DT as fixed clocks

Thanks,
Charles

 .../devicetree/bindings/mfd/cirrus,lochnagar.txt   | 230 +++++++++++++++++++++
 include/dt-bindings/clk/lochnagar.h                |  26 +++
 include/dt-bindings/pinctrl/lochnagar.h            | 132 ++++++++++++
 3 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
 create mode 100644 include/dt-bindings/clk/lochnagar.h
 create mode 100644 include/dt-bindings/pinctrl/lochnagar.h

diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
new file mode 100644
index 0000000000000..4bed850aa7101
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
@@ -0,0 +1,230 @@
+Cirrus Logic Lochnagar Audio Development Board
+
+Lochnagar is an evaluation and development board for Cirrus Logic
+Smart CODEC and Amp devices. It allows the connection of most Cirrus
+Logic devices on mini-cards, as well as allowing connection of
+various application processor systems to provide a full evaluation
+platform.  Audio system topology, clocking and power can all be
+controlled through the Lochnagar, allowing the device under test
+to be used in a variety of possible use cases.
+
+Also see these documents for generic binding information:
+  [1] GPIO : ../gpio/gpio.txt
+  [2] Pinctrl: ../pinctrl/pinctrl-bindings.txt
+  [3] Clock : ../clock/clock-bindings.txt
+  [4] Regulator: ../regulator/regulator.txt
+
+And these for relevant defines:
+  [5] include/dt-bindings/pinctrl/lochnagar.h
+  [6] include/dt-bindings/clock/lochnagar.h
+
+Required properties:
+
+  - compatible : One of the following strings:
+                 "cirrus,lochnagar1"
+                 "cirrus,lochnagar2"
+
+  - reg : I2C slave address
+
+  - gpio-controller : Indicates this device is a GPIO controller.
+  - #gpio-cells : Must be 2. The first cell is the pin number, see
+    [5] for available pins and the second cell is used to specify
+    optional parameters, see [1].
+  - gpio-ranges : Range of pins managed by the GPIO controller, see
+    [1]. Both the GPIO and Pinctrl base should be set to zero and the
+    count to the appropriate of the LOCHNAGARx_PIN_NUM_GPIOS define,
+    see [5].
+
+  - reset-gpios : Reset line to the Lochnagar, see [1].
+
+  - #clock-cells : Must be 1. The first cell indicates the clock
+    number, see [6] for available clocks and [3].
+
+  - pinctrl-names : A pinctrl state named "default" must be defined.
+  - pinctrl-0 : A phandle to the default pinctrl state.
+
+  - SYSVDD-supply: Primary power supply for the Lochnagar.
+
+Optional properties:
+
+  - present-gpios : Host present line, indicating the presence of a
+    host system, see [1]. This can be omitted if the present line is
+    tied in hardware.
+
+  - clocks : Must contain an entry for each clock in clock-names.
+  - clock-names : May contain entries for each of the following
+    clocks:
+     - ln-cdc-clkout : Output clock from CODEC card.
+     - ln-dsp-clkout : Output clock from DSP card.
+     - ln-gf-mclk1,ln-gf-mclk2,ln-gf-mclk3,ln-gf-mclk4 : Optional
+       input audio clocks from host system.
+     - ln-psia1-mclk, ln-psia2-mclk : Optional input audio clocks from
+       external connector.
+     - ln-spdif-clkout : Optional input audio clock from SPDIF.
+     - ln-adat-clkout : Optional input audio clock from ADAT.
+
+  - assigned-clocks : A list of Lochnagar clocks to be reparented, see
+    [6] for available clocks.
+  - assigned-clock-parents : Parents to be assigned to the clocks
+    listed in "assigned-clocks".
+
+  - MICBIAS1-supply, MICBIAS2-supply: Regulator supplies for the
+    MICxVDD outputs, supplying the digital microphones, normally
+    supplied from the attached CODEC.
+
+Required sub-nodes:
+
+The pin configurations are defined as a child of the pinctrl states
+node, see [2]. Each sub-node can have the following properties:
+  - groups : A list of groups to select (either this or "pins" must be
+    specified), available groups:
+      codec-aif1, codec-aif2, codec-aif3, dsp-aif1, dsp-aif2, psia1,
+      psia2, gf-aif1, gf-aif2, gf-aif3, gf-aif4, spdif-aif, usb-aif1,
+      usb-aif2, adat-aif, soundcard-aif
+  - pins : A list of pin names to select (either this or "groups" must
+    be specified), available pins:
+      fgpa-gpio1, fgpa-gpio2, fgpa-gpio3, fgpa-gpio4, fgpa-gpio5,
+      fgpa-gpio6, codec-gpio1, codec-gpio2, codec-gpio3, codec-gpio4,
+      codec-gpio5, codec-gpio6, codec-gpio7, codec-gpio8, dsp-gpio1,
+      dsp-gpio2, dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6, gf-gpio2,
+      gf-gpio3, gf-gpio7, codec-aif1-bclk, codec-aif1-rxdat,
+      codec-aif1-lrclk, codec-aif1-txdat, codec-aif2-bclk,
+      codec-aif2-rxdat, codec-aif2-lrclk, codec-aif2-txdat,
+      codec-aif3-bclk, codec-aif3-rxdat, codec-aif3-lrclk,
+      codec-aif3-txdat, dsp-aif1-bclk, dsp-aif1-rxdat, dsp-aif1-lrclk,
+      dsp-aif1-txdat, dsp-aif2-bclk, dsp-aif2-rxdat,
+      dsp-aif2-lrclk, dsp-aif2-txdat, psia1-bclk, psia1-rxdat,
+      psia1-lrclk, psia1-txdat, psia2-bclk, psia2-rxdat, psia2-lrclk,
+      psia2-txdat, gf-aif3-bclk, gf-aif3-rxdat, gf-aif3-lrclk,
+      gf-aif3-txdat, gf-aif4-bclk, gf-aif4-rxdat, gf-aif4-lrclk,
+      gf-aif4-txdat, gf-aif1-bclk, gf-aif1-rxdat, gf-aif1-lrclk,
+      gf-aif1-txdat, gf-aif2-bclk, gf-aif2-rxdat, gf-aif2-lrclk,
+      gf-aif2-txdat, dsp-uart1-rx, dsp-uart1-tx, dsp-uart2-rx,
+      dsp-uart2-tx, gf-uart2-rx, gf-uart2-tx, usb-uart-rx,
+      codec-pdmclk1, codec-pdmdat1, codec-pdmclk2, codec-pdmdat2,
+      codec-dmicclk1, codec-dmicdat1, codec-dmicclk2, codec-dmicdat2,
+      codec-dmicclk3, codec-dmicdat3, codec-dmicclk4, codec-dmicdat4,
+      dsp-dmicclk1, dsp-dmicdat1, dsp-dmicclk2, dsp-dmicdat2, i2c2-scl,
+      i2c2-sda, i2c3-scl, i2c3-sda, i2c4-scl, i2c4-sda, dsp-standby,
+      codec-mclk1, codec-mclk2, dsp-clkin, psia1-mclk, psia2-mclk,
+      gf-gpio1, gf-gpio5, dsp-gpio20, led1, led2
+  - function : The mux function to select, available functions:
+      aif, fgpa-gpio1, fgpa-gpio2, fgpa-gpio3, fgpa-gpio4, fgpa-gpio5,
+      fgpa-gpio6, codec-gpio1, codec-gpio2, codec-gpio3, codec-gpio4,
+      codec-gpio5, codec-gpio6, codec-gpio7, codec-gpio8, dsp-gpio1,
+      dsp-gpio2, dsp-gpio3, dsp-gpio4, dsp-gpio5, dsp-gpio6, gf-gpio2,
+      gf-gpio3, gf-gpio7, gf-gpio1, gf-gpio5, dsp-gpio20, codec-clkout,
+      dsp-clkout, pmic-32k, spdif-clkout, clk-12m288, clk-11m2986,
+      clk-24m576, clk-22m5792, xmos-mclk, gf-clkout1, gf-mclk1,
+      gf-mclk3, gf-mclk2, gf-clkout2, codec-mclk1, codec-mclk2,
+      dsp-clkin, psia1-mclk, psia2-mclk, spdif-mclk, codec-irq,
+      codec-reset, dsp-reset, dsp-irq, dsp-standby, codec-pdmclk1,
+      codec-pdmdat1, codec-pdmclk2, codec-pdmdat2, codec-dmicclk1,
+      codec-dmicdat1, codec-dmicclk2, codec-dmicdat2, codec-dmicclk3,
+      codec-dmicdat3, codec-dmicclk4, codec-dmicdat4, dsp-dmicclk1,
+      dsp-dmicdat1, dsp-dmicclk2, dsp-dmicdat2, dsp-uart1-rx,
+      dsp-uart1-tx, dsp-uart2-rx, dsp-uart2-tx, gf-uart2-rx,
+      gf-uart2-tx, usb-uart-rx, usb-uart-tx, i2c2-scl, i2c2-sda,
+      i2c3-scl, i2c3-sda, i2c4-scl, i2c4-sda, gpio, spdif-aif, psia1,
+      psia1-bclk, psia1-lrclk, psia1-rxdat, psia1-txdat, psia2,
+      psia2-bclk, psia2-lrclk, psia2-rxdat, psia2-txdat, codec-aif1,
+      codec-aif1-bclk, codec-aif1-lrclk, codec-aif1-rxdat,
+      codec-aif1-txdat, codec-aif2, codec-aif2-bclk, codec-aif2-lrclk,
+      codec-aif2-rxdat, codec-aif2-txdat, codec-aif3, codec-aif3-bclk,
+      codec-aif3-lrclk, codec-aif3-rxdat, codec-aif3-txdat, dsp-aif1,
+      dsp-aif1-bclk, dsp-aif1-lrclk, dsp-aif1-rxdat, dsp-aif1-txdat,
+      dsp-aif2, dsp-aif2-bclk, dsp-aif2-lrclk, dsp-aif2-rxdat,
+      dsp-aif2-txdat, gf-aif3, gf-aif3-bclk, gf-aif3-lrclk,
+      gf-aif3-rxdat, gf-aif3-txdat, gf-aif4, gf-aif4-bclk,
+      gf-aif4-lrclk, gf-aif4-rxdat, gf-aif4-txdat, gf-aif1,
+      gf-aif1-bclk, gf-aif1-lrclk, gf-aif1-rxdat, gf-aif1-txdat,
+      gf-aif2, gf-aif2-bclk, gf-aif2-lrclk, gf-aif2-rxdat,
+      gf-aif2-txdat, usb-aif1, usb-aif2, adat-aif, soundcard-aif,
+
+  - aif-master : Specifies that an AIF group will be used as a master
+    interface (either this or aif-slave is required if a group is
+    being muxed to an AIF)
+  - aif-slave : Specifies that an AIF group will be used as a slave
+    interface (either this or aif-master is required if a group is
+    being muxed to an AIF)
+
+Optional sub-nodes:
+
+  - VDDCORE : Initialisation data for the VDDCORE regulator, which
+    supplies the CODECs digital core if it has no build regulator for that
+    purpose.
+
+  - MICVDD : Initialisation data for the MICVDD regulator, which
+    supplies the CODECs MICVDD.
+  - MIC1VDD, MIC2VDD : Initialisation data for the MICxVDD supplies.
+      Optional Properties:
+      - cirrus,micbias-input : A property selecting which of the CODEC
+        minicard micbias outputs should be used, valid values are 1 - 4.
+
+  - VDD1V8 : Recommended fixed regulator for the VDD1V8 regulator, which supplies the
+    CODECs analog and 1.8V digital supplies.
+      Required Properties:
+      - compatible : Should be set to "regulator-fixed"
+      - regulator-min-microvolt : Should be set to 1.8V
+      - regulator-max-microvolt : Should be set to 1.8V
+      - regulator-boot-on
+      - regulator-always-on
+      - vin-supply : Should be set to same supply as SYSVDD
+
+Example:
+lochnagar: lochnagar@22 {
+	compatible = "cirrus,lochnagar2";
+	reg = <0x22>;
+
+	gpio-controller;
+	#gpio-cells = <2>;
+	gpio-ranges = <&lochnagar 0 0 110>;
+
+	reset-gpios = <&gpio0 55 0>;
+	present-gpios = <&gpio0 60 0>;
+
+	#clock-cells = <1>;
+
+	clocks = <&clk-audio>;
+	clock-names = "ln-gf-mclk2";
+
+	assigned-clocks = <&lochnagar LOCHNAGAR_CDC_MCLK1>,
+			  <&lochnagar LOCHNAGAR_CDC_MCLK2>;
+	assigned-clock-parents = <&clk-audio>,
+				 <&lochnagar LOCHNAGAR_PMIC_32K>;
+
+	SYSVDD-supply = <&wallvdd>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pin-settings>;
+
+	pin-settings: pin-settings {
+		ap-aif {
+			aif-slave;
+			groups = "gf-aif1";
+			function = "codec-aif3";
+		};
+		codec-aif {
+			aif-master;
+			groups = "codec-aif3";
+			function = "gf-aif1";
+		};
+	};
+
+	lochnagar-micvdd: MICVDD {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	lochnagar-vdd1v8: VDD1V8 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDD1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+
+		vin-supply = <&wallvdd>;
+	};
+};
diff --git a/include/dt-bindings/clk/lochnagar.h b/include/dt-bindings/clk/lochnagar.h
new file mode 100644
index 0000000000000..8fa20551ff171
--- /dev/null
+++ b/include/dt-bindings/clk/lochnagar.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device Tree defines for Lochnagar clocking
+ *
+ * Copyright (c) 2017-2018 Cirrus Logic, Inc. and
+ *                         Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#ifndef DT_BINDINGS_CLK_LOCHNAGAR_H
+#define DT_BINDINGS_CLK_LOCHNAGAR_H
+
+#define LOCHNAGAR_CDC_MCLK1		0
+#define LOCHNAGAR_CDC_MCLK2		1
+#define LOCHNAGAR_DSP_CLKIN		2
+#define LOCHNAGAR_GF_CLKOUT1		3
+#define LOCHNAGAR_GF_CLKOUT2		4
+#define LOCHNAGAR_PSIA1_MCLK		5
+#define LOCHNAGAR_PSIA2_MCLK		6
+#define LOCHNAGAR_SPDIF_MCLK		7
+#define LOCHNAGAR_ADAT_MCLK		8
+#define LOCHNAGAR_SOUNDCARD_MCLK	9
+#define LOCHNAGAR_SPDIF_CLKOUT		10
+
+#endif
diff --git a/include/dt-bindings/pinctrl/lochnagar.h b/include/dt-bindings/pinctrl/lochnagar.h
new file mode 100644
index 0000000000000..644760bf5725b
--- /dev/null
+++ b/include/dt-bindings/pinctrl/lochnagar.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device Tree defines for Lochnagar pinctrl
+ *
+ * Copyright (c) 2018 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ *
+ * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+ */
+
+#ifndef DT_BINDINGS_PINCTRL_LOCHNAGAR_H
+#define DT_BINDINGS_PINCTRL_LOCHNAGAR_H
+
+#define LOCHNAGAR1_PIN_CDC_RESET		0
+#define LOCHNAGAR1_PIN_DSP_RESET		1
+#define LOCHNAGAR1_PIN_CDC_CIF1MODE		2
+#define LOCHNAGAR1_PIN_NUM_GPIOS		3
+
+#define LOCHNAGAR2_PIN_CDC_RESET		0
+#define LOCHNAGAR2_PIN_DSP_RESET		1
+#define LOCHNAGAR2_PIN_CDC_CIF1MODE		2
+#define LOCHNAGAR2_PIN_CDC_LDOENA		3
+#define LOCHNAGAR2_PIN_SPDIF_HWMODE		4
+#define LOCHNAGAR2_PIN_SPDIF_RESET		5
+#define LOCHNAGAR2_PIN_FPGA_GPIO1		6
+#define LOCHNAGAR2_PIN_FPGA_GPIO2		7
+#define LOCHNAGAR2_PIN_FPGA_GPIO3		8
+#define LOCHNAGAR2_PIN_FPGA_GPIO4		9
+#define LOCHNAGAR2_PIN_FPGA_GPIO5		10
+#define LOCHNAGAR2_PIN_FPGA_GPIO6		11
+#define LOCHNAGAR2_PIN_CDC_GPIO1		12
+#define LOCHNAGAR2_PIN_CDC_GPIO2		13
+#define LOCHNAGAR2_PIN_CDC_GPIO3		14
+#define LOCHNAGAR2_PIN_CDC_GPIO4		15
+#define LOCHNAGAR2_PIN_CDC_GPIO5		16
+#define LOCHNAGAR2_PIN_CDC_GPIO6		17
+#define LOCHNAGAR2_PIN_CDC_GPIO7		18
+#define LOCHNAGAR2_PIN_CDC_GPIO8		19
+#define LOCHNAGAR2_PIN_DSP_GPIO1		20
+#define LOCHNAGAR2_PIN_DSP_GPIO2		21
+#define LOCHNAGAR2_PIN_DSP_GPIO3		22
+#define LOCHNAGAR2_PIN_DSP_GPIO4		23
+#define LOCHNAGAR2_PIN_DSP_GPIO5		24
+#define LOCHNAGAR2_PIN_DSP_GPIO6		25
+#define LOCHNAGAR2_PIN_GF_GPIO2			26
+#define LOCHNAGAR2_PIN_GF_GPIO3			27
+#define LOCHNAGAR2_PIN_GF_GPIO7			28
+#define LOCHNAGAR2_PIN_CDC_AIF1_BCLK		29
+#define LOCHNAGAR2_PIN_CDC_AIF1_RXDAT		30
+#define LOCHNAGAR2_PIN_CDC_AIF1_LRCLK		31
+#define LOCHNAGAR2_PIN_CDC_AIF1_TXDAT		32
+#define LOCHNAGAR2_PIN_CDC_AIF2_BCLK		33
+#define LOCHNAGAR2_PIN_CDC_AIF2_RXDAT		34
+#define LOCHNAGAR2_PIN_CDC_AIF2_LRCLK		35
+#define LOCHNAGAR2_PIN_CDC_AIF2_TXDAT		36
+#define LOCHNAGAR2_PIN_CDC_AIF3_BCLK		37
+#define LOCHNAGAR2_PIN_CDC_AIF3_RXDAT		38
+#define LOCHNAGAR2_PIN_CDC_AIF3_LRCLK		39
+#define LOCHNAGAR2_PIN_CDC_AIF3_TXDAT		40
+#define LOCHNAGAR2_PIN_DSP_AIF1_BCLK		41
+#define LOCHNAGAR2_PIN_DSP_AIF1_RXDAT		42
+#define LOCHNAGAR2_PIN_DSP_AIF1_LRCLK		43
+#define LOCHNAGAR2_PIN_DSP_AIF1_TXDAT		44
+#define LOCHNAGAR2_PIN_DSP_AIF2_BCLK		45
+#define LOCHNAGAR2_PIN_DSP_AIF2_RXDAT		46
+#define LOCHNAGAR2_PIN_DSP_AIF2_LRCLK		47
+#define LOCHNAGAR2_PIN_DSP_AIF2_TXDAT		48
+#define LOCHNAGAR2_PIN_PSIA1_BCLK		49
+#define LOCHNAGAR2_PIN_PSIA1_RXDAT		50
+#define LOCHNAGAR2_PIN_PSIA1_LRCLK		51
+#define LOCHNAGAR2_PIN_PSIA1_TXDAT		52
+#define LOCHNAGAR2_PIN_PSIA2_BCLK		53
+#define LOCHNAGAR2_PIN_PSIA2_RXDAT		54
+#define LOCHNAGAR2_PIN_PSIA2_LRCLK		55
+#define LOCHNAGAR2_PIN_PSIA2_TXDAT		56
+#define LOCHNAGAR2_PIN_GF_AIF3_BCLK		57
+#define LOCHNAGAR2_PIN_GF_AIF3_RXDAT		58
+#define LOCHNAGAR2_PIN_GF_AIF3_LRCLK		59
+#define LOCHNAGAR2_PIN_GF_AIF3_TXDAT		60
+#define LOCHNAGAR2_PIN_GF_AIF4_BCLK		61
+#define LOCHNAGAR2_PIN_GF_AIF4_RXDAT		62
+#define LOCHNAGAR2_PIN_GF_AIF4_LRCLK		63
+#define LOCHNAGAR2_PIN_GF_AIF4_TXDAT		64
+#define LOCHNAGAR2_PIN_GF_AIF1_BCLK		65
+#define LOCHNAGAR2_PIN_GF_AIF1_RXDAT		66
+#define LOCHNAGAR2_PIN_GF_AIF1_LRCLK		67
+#define LOCHNAGAR2_PIN_GF_AIF1_TXDAT		68
+#define LOCHNAGAR2_PIN_GF_AIF2_BCLK		69
+#define LOCHNAGAR2_PIN_GF_AIF2_RXDAT		70
+#define LOCHNAGAR2_PIN_GF_AIF2_LRCLK		71
+#define LOCHNAGAR2_PIN_GF_AIF2_TXDAT		72
+#define LOCHNAGAR2_PIN_DSP_UART1_RX		73
+#define LOCHNAGAR2_PIN_DSP_UART1_TX		74
+#define LOCHNAGAR2_PIN_DSP_UART2_RX		75
+#define LOCHNAGAR2_PIN_DSP_UART2_TX		76
+#define LOCHNAGAR2_PIN_GF_UART2_RX		77
+#define LOCHNAGAR2_PIN_GF_UART2_TX		78
+#define LOCHNAGAR2_PIN_USB_UART_RX		79
+#define LOCHNAGAR2_PIN_CDC_PDMCLK1		80
+#define LOCHNAGAR2_PIN_CDC_PDMDAT1		81
+#define LOCHNAGAR2_PIN_CDC_PDMCLK2		82
+#define LOCHNAGAR2_PIN_CDC_PDMDAT2		83
+#define LOCHNAGAR2_PIN_CDC_DMICCLK1		84
+#define LOCHNAGAR2_PIN_CDC_DMICDAT1		85
+#define LOCHNAGAR2_PIN_CDC_DMICCLK2		86
+#define LOCHNAGAR2_PIN_CDC_DMICDAT2		87
+#define LOCHNAGAR2_PIN_CDC_DMICCLK3		88
+#define LOCHNAGAR2_PIN_CDC_DMICDAT3		89
+#define LOCHNAGAR2_PIN_CDC_DMICCLK4		90
+#define LOCHNAGAR2_PIN_CDC_DMICDAT4		91
+#define LOCHNAGAR2_PIN_DSP_DMICCLK1		92
+#define LOCHNAGAR2_PIN_DSP_DMICDAT1		93
+#define LOCHNAGAR2_PIN_DSP_DMICCLK2		94
+#define LOCHNAGAR2_PIN_DSP_DMICDAT2		95
+#define LOCHNAGAR2_PIN_I2C2_SCL			96
+#define LOCHNAGAR2_PIN_I2C2_SDA			97
+#define LOCHNAGAR2_PIN_I2C3_SCL			98
+#define LOCHNAGAR2_PIN_I2C3_SDA			99
+#define LOCHNAGAR2_PIN_I2C4_SCL			100
+#define LOCHNAGAR2_PIN_I2C4_SDA			101
+#define LOCHNAGAR2_PIN_DSP_STANDBY		102
+#define LOCHNAGAR2_PIN_CDC_MCLK1		103
+#define LOCHNAGAR2_PIN_CDC_MCLK2		104
+#define LOCHNAGAR2_PIN_DSP_CLKIN		105
+#define LOCHNAGAR2_PIN_PSIA1_MCLK		106
+#define LOCHNAGAR2_PIN_PSIA2_MCLK		107
+#define LOCHNAGAR2_PIN_GF_GPIO1			108
+#define LOCHNAGAR2_PIN_GF_GPIO5			109
+#define LOCHNAGAR2_PIN_DSP_GPIO20		110
+#define LOCHNAGAR2_PIN_NUM_GPIOS		111
+
+#endif
-- 
2.11.0

