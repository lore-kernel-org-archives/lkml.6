Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeB1RSc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:18:32 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46838 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933337AbeB1Pr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:47:57 -0500
From: Ludovic Barre <ludovic.Barre@st.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 4/5] ARM: dts: stm32: add sdmmc1 support for stm32h743i-eval
Date: Wed, 28 Feb 2018 16:47:23 +0100
Message-ID: <1519832844-28068-5-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds support of micro sd card connected to sdmmc1.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts    | 11 +++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index 65c1cd0..ef17192 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -164,6 +164,32 @@
 					bias-disable;
 				};
 			};
+
+			sdmmc1_b4_pins_a: sdmmc1-b4@0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
+						 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
+						 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-disable;
+				};
+			};
+
+			sdmmc1_dir_pins_a: sdmmc1-dir@0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
+						 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
+						 <STM32_PINMUX('B', 9, AF7)>, /* SDMMC1_CDIR */
+						 <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
+					slew-rate = <3>;
+					drive-push-pull;
+					bias-pull-up;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index c6ceda8..e1dbfaf 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -98,6 +98,17 @@
 	clock-frequency = <25000000>;
 };
 
+&sdmmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
+	broken-cd;
+	st,dir-output-high;
+	st,neg-edge;
+	st,use-ckin;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
