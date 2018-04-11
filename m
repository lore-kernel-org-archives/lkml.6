Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbeDKJr7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:47:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48977 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752953AbeDKJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:47:56 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 5/5] ARM: dts: stm32: add joystick support on stm32746g-eval
Date: Wed, 11 Apr 2018 11:47:05 +0200
Message-ID: <1523440025-18077-6-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The joystick (B3) on stm32746g-eval uses gpios on STMFX gpio expander.
These gpios need a pin configuration (push-pull and bias-pull-up),
described under stmfxpinctrl node.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index fd03f54..ee9ec55 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -90,6 +90,44 @@
 		};
 	};
 
+	joystick {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&joystick_pins>;
+		pinctrl-names = "default";
+		button@0 {
+			label = "JoySel";
+			linux,code = <KEY_ENTER>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <0 2>;
+		};
+		button@1 {
+			label = "JoyDown";
+			linux,code = <KEY_DOWN>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <1 2>;
+		};
+		button@2 {
+			label = "JoyLeft";
+			linux,code = <KEY_LEFT>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <2 2>;
+		};
+		button@3 {
+			label = "JoyRight";
+			linux,code = <KEY_RIGHT>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <3 2>;
+		};
+		button@4 {
+			label = "JoyUp";
+			linux,code = <KEY_UP>;
+			interrupt-parent = <&stmfxgpio>;
+			interrupts = <4 2>;
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
@@ -127,6 +165,12 @@
 			interrupt-controller;
 			status = "okay";
 		};
+
+		joystick_pins: joystick@0 {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4";
+			drive-push-pull;
+			bias-pull-up;
+		};
 	};
 };
 
-- 
2.7.4
