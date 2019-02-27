Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E49C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F316720842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfB0Jf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:35:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2902 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbfB0Jfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:35:30 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1R9Xfi9000431;
        Wed, 27 Feb 2019 10:35:14 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6cx2xa-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Feb 2019 10:35:14 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 52F443F;
        Wed, 27 Feb 2019 09:35:12 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DCBA27E9;
        Wed, 27 Feb 2019 09:35:11 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb
 2019 10:35:11 +0100
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb 2019 10:35:10 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v4 3/9] dt-bindings: pinctrl: document the STMFX pinctrl bindings
Date:   Wed, 27 Feb 2019 10:34:48 +0100
Message-ID: <1551260094-32570-4-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree bindings for the
STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
new file mode 100644
index 0000000..c1b4c18
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
@@ -0,0 +1,116 @@
+STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander bindings
+
+ST Multi-Function eXpander (STMFX) offers up to 24 GPIOs expansion.
+Please refer to ../mfd/stmfx.txt for STMFX Core bindings.
+
+Required properties:
+- compatible: should be "st,stmfx-0300-pinctrl".
+- #gpio-cells: should be <2>, the first cell is the GPIO number and the second
+  cell is the gpio flags in accordance with <dt-bindings/gpio/gpio.h>.
+- gpio-controller: marks the device as a GPIO controller.
+- #interrupt-cells: should be <2>, the first cell is the GPIO number and the
+  second cell is the interrupt flags in accordance with
+  <dt-bindings/interrupt-controller/irq.h>.
+- interrupt-controller: marks the device as an interrupt controller.
+- gpio-ranges: specifies the mapping between gpio controller and pin
+  controller pins. Check "Concerning gpio-ranges property" below.
+Please refer to ../gpio/gpio.txt.
+
+Please refer to pinctrl-bindings.txt for pin configuration.
+
+Required properties for pin configuration sub-nodes:
+- pins: list of pins to which the configuration applies.
+
+Optional properties for pin configuration sub-nodes (pinconf-generic ones):
+- bias-disable: disable any bias on the pin.
+- bias-pull-up: the pin will be pulled up.
+- bias-pull-pin-default: use the pin-default pull state.
+- bias-pull-down: the pin will be pulled down.
+- drive-open-drain: the pin will be driven with open drain.
+- drive-push-pull: the pin will be driven actively high and low.
+- output-high: the pin will be configured as an output driving high level.
+- output-low: the pin will be configured as an output driving low level.
+
+Note that STMFX pins[15:0] are called "gpio[15:0]", and STMFX pins[23:16] are
+called "agpio[7:0]". Example, to refer to pin 18 of STMFX, use "agpio2".
+
+Concerning gpio-ranges property:
+- if all STMFX pins[24:0] are available (no other STMFX function in use), you
+  should use gpio-ranges = <&stmfx_pinctrl 0 0 24>;
+- if agpio[3:0] are not available (STMFX Touchscreen function in use), you
+  should use gpio-ranges = <&stmfx_pinctrl 0 0 16>, <&stmfx_pinctrl 20 20 4>;
+- if agpio[7:4] are not available (STMFX IDD function in use), you
+  should use gpio-ranges = <&stmfx_pinctrl 0 0 20>;
+
+
+Example:
+
+	stmfx: stmfx@42 {
+		...
+
+		stmfx_pinctrl: stmfx-pin-controller {
+			compatible = "st,stmfx-0300-pinctrl";
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			interrupt-controller;
+			gpio-ranges = <&stmfx_pinctrl 0 0 24>;
+
+			joystick_pins: joystick {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4";
+				drive-push-pull;
+				bias-pull-up;
+			};
+		};
+	};
+
+Example of STMFX GPIO consumers:
+
+	joystick {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&joystick_pins>;
+		pinctrl-names = "default";
+		button-0 {
+			label = "JoySel";
+			linux,code = <KEY_ENTER>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-1 {
+			label = "JoyDown";
+			linux,code = <KEY_DOWN>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <1 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-2 {
+			label = "JoyLeft";
+			linux,code = <KEY_LEFT>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-3 {
+			label = "JoyRight";
+			linux,code = <KEY_RIGHT>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+		};
+		button-4 {
+			label = "JoyUp";
+			linux,code = <KEY_UP>;
+			interrupt-parent = <&stmfx_pinctrl>;
+			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		orange {
+			gpios = <&stmfx_pinctrl 17 1>;
+		};
+
+		blue {
+			gpios = <&stmfx_pinctrl 19 1>;
+		};
+	}
-- 
2.7.4

