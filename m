Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754353AbeDTJFo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:05:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18442 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754224AbeDTJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:05:38 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 1/3] ARM: dts: stm32: Append additional I2Cs for STM32F746 SoC
Date: Fri, 20 Apr 2018 11:05:08 +0200
Message-ID: <1524215110-13967-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.117]
X-ClientProxiedBy: GPXDAG5NODE4.st.com (10.75.127.77) To GPXDAG5NODE5.st.com
 (10.75.127.78)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append 3 additional I2C instance for STM32F746 SoC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32f746.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 4be2ee5..1479e3e 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -345,6 +345,42 @@
 			status = "disabled";
 		};
 
+		i2c2: i2c@40005800 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40005800 0x400>;
+			interrupts = <33>,
+				     <34>;
+			resets = <&rcc STM32F7_APB1_RESET(I2C2)>;
+			clocks = <&rcc 1 CLK_I2C2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@40005C00 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40005C00 0x400>;
+			interrupts = <72>,
+				     <73>;
+			resets = <&rcc STM32F7_APB1_RESET(I2C3)>;
+			clocks = <&rcc 1 CLK_I2C3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@40006000 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40006000 0x400>;
+			interrupts = <95>,
+				     <96>;
+			resets = <&rcc STM32F7_APB1_RESET(I2C4)>;
+			clocks = <&rcc 1 CLK_I2C4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		cec: cec@40006c00 {
 			compatible = "st,stm32-cec";
 			reg = <0x40006C00 0x400>;
-- 
2.7.4
