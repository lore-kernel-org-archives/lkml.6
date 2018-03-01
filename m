Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967654AbeCAKzY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:55:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43685 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966899AbeCAKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:54:26 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@st.com>,
        <lee.jones@linaro.org>
CC: <mcoquelin.stm32@gmail.com>, Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH v2 1/6] ARM: dts: stm32: Add sdio pins definition for stm32f7
Date: Thu, 1 Mar 2018 11:53:38 +0100
Message-ID: <1519901623-23216-2-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Add sdio pins definition for the 2 sdio instances embeds in stm32f746.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a 

 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
index f518de184e52..9314128df185 100644
--- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
@@ -222,6 +222,68 @@
 					slew-rate = <2>;
 				};
 			};
+
+			sdio_pins_a: sdio_pins_a@0 {
+				pins {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1 D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1 D3 */
+						 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1 CLK */
+						 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1 CMD */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			sdio_pins_od_a: sdio_pins_od_a@0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
+						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
+						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1 D2 */
+						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1 D3 */
+						 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1 CLK */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1 CMD */
+					drive-open-drain;
+					slew-rate = <2>;
+				};
+			};
+
+			sdio_pins_b: sdio_pins_b@0 {
+				pins {
+					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
+						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
+						 <STM32_PINMUX('B', 3, AF10)>, /* SDMMC2 D2 */
+						 <STM32_PINMUX('B', 4, AF10)>, /* SDMMC2 D3 */
+						 <STM32_PINMUX('D', 6, AF11)>, /* SDMMC2 CLK */
+						 <STM32_PINMUX('D', 7, AF11)>; /* SDMMC2 CMD */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			sdio_pins_od_b: sdio_pins_od_b@0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
+						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
+						 <STM32_PINMUX('B', 3, AF10)>, /* SDMMC2 D2 */
+						 <STM32_PINMUX('B', 4, AF10)>, /* SDMMC2 D3 */
+						 <STM32_PINMUX('D', 6, AF11)>; /* SDMMC2 CLK */
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 7, AF11)>; /* SDMMC2 CMD */
+					drive-open-drain;
+					slew-rate = <2>;
+				};
+			};
 		};
 	};
 };
-- 
1.9.1
