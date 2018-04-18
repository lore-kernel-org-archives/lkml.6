Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeDRHoc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:44:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43533 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751232AbeDRHob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:44:31 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <alexandre.torgue@st.com>, <robh+dt@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: dts: stm32: Add LPtimer support to stm32mp157c
Date: Wed, 18 Apr 2018 09:43:53 +0200
Message-ID: <1524037433-25915-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG7NODE6.st.com (10.75.127.85) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LPtimer definitions, depending on features they provide:
- lptimer1 & 2 can act as PWM, trigger and encoder/counter
- lptimer3 can act as PWM and trigger
- lptimer4 & 5 can act as PWM

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 108 +++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..7e6301c 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -104,6 +104,33 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		lptimer1: timer@40009000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-lptimer";
+			reg = <0x40009000 0x400>;
+			clocks = <&rcc LPTIM1_K>;
+			clock-names = "mux";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			trigger@0 {
+				compatible = "st,stm32-lptimer-trigger";
+				reg = <0>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-lptimer-counter";
+				status = "disabled";
+			};
+		};
+
 		usart2: serial@4000e000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000e000 0x400>;
@@ -167,6 +194,87 @@
 			#reset-cells = <1>;
 		};
 
+		lptimer2: timer@50021000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-lptimer";
+			reg = <0x50021000 0x400>;
+			clocks = <&rcc LPTIM2_K>;
+			clock-names = "mux";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			trigger@1 {
+				compatible = "st,stm32-lptimer-trigger";
+				reg = <1>;
+				status = "disabled";
+			};
+
+			counter {
+				compatible = "st,stm32-lptimer-counter";
+				status = "disabled";
+			};
+		};
+
+		lptimer3: timer@50022000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-lptimer";
+			reg = <0x50022000 0x400>;
+			clocks = <&rcc LPTIM3_K>;
+			clock-names = "mux";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			trigger@2 {
+				compatible = "st,stm32-lptimer-trigger";
+				reg = <2>;
+				status = "disabled";
+			};
+		};
+
+		lptimer4: timer@50023000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-lptimer";
+			reg = <0x50023000 0x400>;
+			clocks = <&rcc LPTIM4_K>;
+			clock-names = "mux";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+		};
+
+		lptimer5: timer@50024000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-lptimer";
+			reg = <0x50024000 0x400>;
+			clocks = <&rcc LPTIM5_K>;
+			clock-names = "mux";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+		};
+
 		usart1: serial@5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
1.9.1
