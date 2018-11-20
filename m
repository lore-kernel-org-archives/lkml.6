Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B6C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6674C206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6674C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbeKUAqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:46:08 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38534 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbeKUAqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:46:07 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKEEQB2013982;
        Tue, 20 Nov 2018 08:16:35 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ntg9sv5q3-1;
        Tue, 20 Nov 2018 08:16:35 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 10779611E124;
        Tue, 20 Nov 2018 08:16:35 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 14:16:32 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAKEGVqx000703; Tue,
 20 Nov 2018 14:16:32 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v5 4/8] pinctrl: lochnagar: Add initial binding documentation
Date:   Tue, 20 Nov 2018 14:16:27 +0000
Message-ID: <20181120141631.18949-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200128
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
---
 .../bindings/pinctrl/cirrus,lochnagar.txt          | 141 +++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
new file mode 100644
index 000000000000..36de6b0555f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
@@ -0,0 +1,141 @@
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
+This binding document describes the binding for the pinctrl portion
+of the driver.
+
+Also see these documents for generic binding information:
+  [1] GPIO : ../gpio/gpio.txt
+  [2] Pinctrl: ../pinctrl/pinctrl-bindings.txt
+
+And these for relevant defines:
+  [3] include/dt-bindings/pinctrl/lochnagar.h
+
+This binding must be part of the Lochnagar MFD binding:
+  [4] ../mfd/cirrus,lochnagar.txt
+
+Required properties:
+
+  - compatible : One of the following strings:
+                 "cirrus,lochnagar-pinctrl"
+
+  - gpio-controller : Indicates this device is a GPIO controller.
+  - #gpio-cells : Must be 2. The first cell is the pin number, see
+    [3] for available pins and the second cell is used to specify
+    optional parameters, see [1].
+  - gpio-ranges : Range of pins managed by the GPIO controller, see
+    [1]. Both the GPIO and Pinctrl base should be set to zero and the
+    count to the appropriate of the LOCHNAGARx_PIN_NUM_GPIOS define,
+    see [3].
+
+  - pinctrl-names : A pinctrl state named "default" must be defined.
+  - pinctrl-0 : A phandle to the default pinctrl state.
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
+  - output-enable : Specifies that an AIF group will be used as a master
+    interface (either this or input-enable is required if a group is
+    being muxed to an AIF)
+  - input-enable : Specifies that an AIF group will be used as a slave
+    interface (either this or output-enable is required if a group is
+    being muxed to an AIF)
+
+Example:
+
+lochnagar-pinctrl {
+	compatible = "cirrus,lochnagar-pinctrl";
+
+	gpio-controller;
+	#gpio-cells = <2>;
+	gpio-ranges = <&lochnagar 0 0 LOCHNAGAR2_PIN_NUM_GPIOS>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pin-settings>;
+
+	pin-settings: pin-settings {
+		ap-aif {
+			input-enable;
+			groups = "gf-aif1";
+			function = "codec-aif3";
+		};
+		codec-aif {
+			output-enable;
+			groups = "codec-aif3";
+			function = "gf-aif1";
+		};
+	};
+};
-- 
2.11.0

