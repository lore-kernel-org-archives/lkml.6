Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbeDQNqg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:46:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32123 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753282AbeDQNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:45:56 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <alexandre.torgue@st.com>, <robh+dt@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>
Subject: [PATCH 2/4] ARM: dts: stm32: add PWM pins used on stm32mp157c-ev1 board
Date: Tue, 17 Apr 2018 15:45:28 +0200
Message-ID: <1523972730-29240-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
References: <1523972730-29240-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG5NODE4.st.com (10.75.127.77) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stm32mp157c evaluation board has following PWM pins available on GPIO
expansion connector:
- TIM2_CH4 (PA3)
- TIM8_CH4 (PI2)
- TIM12_CH1 (PH6)

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 6f044100..867cfeb 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -158,6 +158,33 @@
 					bias-disable;
 				};
 			};
+
+			pwm2_pins_a: pwm2@0 {
+				pins {
+					pinmux = <STM32_PINMUX('A', 3, AF1)>; /* TIM2_CH4 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			pwm8_pins_a: pwm8@0 {
+				pins {
+					pinmux = <STM32_PINMUX('I', 2, AF3)>; /* TIM8_CH4 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
+
+			pwm12_pins_a: pwm12@0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 6, AF2)>; /* TIM12_CH1 */
+					bias-pull-down;
+					drive-push-pull;
+					slew-rate = <0>;
+				};
+			};
 		};
 
 		pinctrl_z: pin-controller-z {
-- 
1.9.1
