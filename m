Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeBHO3E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:29:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37957 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751984AbeBHO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:28:36 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Amelie Delaunay" <amelie.delaunay@st.com>
Subject: [PATCH 5/6] ARM: dts: stm32: add joystick support on stm32746g-eval
Date: Thu, 8 Feb 2018 15:27:36 +0100
Message-ID: <1518100057-23234-6-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The joystick on stm32746g-eval uses gpios on MFX gpio expander.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 99739f7..eb5f43b 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -43,6 +43,7 @@
 /dts-v1/;
 #include "stm32f746.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/st-mfx-gpio.h>
 
 / {
 	model = "STMicroelectronics STM32746g-EVAL board";
@@ -98,6 +99,36 @@
 		};
 	};
 
+	joystick {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button@1 {
+			label = "JoySel";
+			linux,code = <KEY_ENTER>;
+			gpios = <&mfxgpio 0 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+		button@2 {
+			label = "JoyDown";
+			linux,code = <KEY_DOWN>;
+			gpios = <&mfxgpio 1 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+		button@3 {
+			label = "JoyLeft";
+			linux,code = <KEY_LEFT>;
+			gpios = <&mfxgpio 2 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+		button@4 {
+			label = "JoyRight";
+			linux,code = <KEY_RIGHT>;
+			gpios = <&mfxgpio 3 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+		button@5 {
+			label = "JoyUp";
+			linux,code = <KEY_UP>;
+			gpios = <&mfxgpio 4 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+	};
 
 	mmc_vcard: mmc_vcard {
 		compatible = "regulator-fixed";
-- 
2.7.4
