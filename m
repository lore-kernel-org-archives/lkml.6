Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeDQNp5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:45:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2026 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753347AbeDQNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:45:52 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <alexandre.torgue@st.com>, <robh+dt@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>
Subject: [PATCH 1/4] ARM: dts: stm32: add timers support to stm32mp157c
Date: Tue, 17 Apr 2018 15:45:27 +0200
Message-ID: <1523972730-29240-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
References: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG7NODE4.st.com (10.75.127.83) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM and trigger support to stm32mp157c.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 283 +++++++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..115ec73 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -104,6 +104,185 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		timers2: timer@40000000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000000 0x400>;
+			clocks = <&rcc TIM2_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@1 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <1>;
+				status = "disabled";
+			};
+		};
+
+		timers3: timer@40001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001000 0x400>;
+			clocks = <&rcc TIM3_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@2 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <2>;
+				status = "disabled";
+			};
+		};
+
+		timers4: timer@40002000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40002000 0x400>;
+			clocks = <&rcc TIM4_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@3 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <3>;
+				status = "disabled";
+			};
+		};
+
+		timers5: timer@40003000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40003000 0x400>;
+			clocks = <&rcc TIM5_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@4 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <4>;
+				status = "disabled";
+			};
+		};
+
+		timers6: timer@40004000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40004000 0x400>;
+			clocks = <&rcc TIM6_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			timer@5 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <5>;
+				status = "disabled";
+			};
+		};
+
+		timers7: timer@40005000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40005000 0x400>;
+			clocks = <&rcc TIM7_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			timer@6 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <6>;
+				status = "disabled";
+			};
+		};
+
+		timers12: timer@40006000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40006000 0x400>;
+			clocks = <&rcc TIM12_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@11 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <11>;
+				status = "disabled";
+			};
+		};
+
+		timers13: timer@40007000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40007000 0x400>;
+			clocks = <&rcc TIM13_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@12 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <12>;
+				status = "disabled";
+			};
+		};
+
+		timers14: timer@40008000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40008000 0x400>;
+			clocks = <&rcc TIM14_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@13 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <13>;
+				status = "disabled";
+			};
+		};
+
 		usart2: serial@4000e000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000e000 0x400>;
@@ -152,6 +331,48 @@
 			status = "disabled";
 		};
 
+		timers1: timer@44000000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x44000000 0x400>;
+			clocks = <&rcc TIM1_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <0>;
+				status = "disabled";
+			};
+		};
+
+		timers8: timer@44001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x44001000 0x400>;
+			clocks = <&rcc TIM8_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@7 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <7>;
+				status = "disabled";
+			};
+		};
+
 		usart6: serial@44003000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x44003000 0x400>;
@@ -160,6 +381,68 @@
 			status = "disabled";
 		};
 
+		timers15: timer@44006000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x44006000 0x400>;
+			clocks = <&rcc TIM15_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@14 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <14>;
+				status = "disabled";
+			};
+		};
+
+		timers16: timer@44007000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x44007000 0x400>;
+			clocks = <&rcc TIM16_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+			timer@15 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <15>;
+				status = "disabled";
+			};
+		};
+
+		timers17: timer@44008000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x44008000 0x400>;
+			clocks = <&rcc TIM17_K>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@16 {
+				compatible = "st,stm32h7-timer-trigger";
+				reg = <16>;
+				status = "disabled";
+			};
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
1.9.1
