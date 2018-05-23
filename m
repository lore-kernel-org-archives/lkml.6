Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbeEWJbO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:31:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56542 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932118AbeEWJbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:31:11 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <alexandre.torgue@st.com>
CC: <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@st.com>, <arnaud.pouliquen@st.com>
Subject: [PATCH] ARM: dts: stm32: Add DFSDM support to stm32mp157c
Date: Wed, 23 May 2018 11:30:35 +0200
Message-ID: <1527067835-22303-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stm32mp157c has DFSDM (Digital Filter For Sigma Delta Modulators) hardware
with 6 filter instances.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 70 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 66d7496..3d2f4e7 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -556,6 +556,76 @@
 			};
 		};
 
+		dfsdm: dfsdm@4400d000 {
+			compatible = "st,stm32mp1-dfsdm";
+			reg = <0x4400d000 0x800>;
+			clocks = <&rcc DFSDM_K>;
+			clock-names = "dfsdm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			dfsdm0: filter@0 {
+				compatible = "st,stm32-dfsdm-adc";
+				#io-channel-cells = <1>;
+				reg = <0>;
+				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dmamux1 101 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
+			dfsdm1: filter@1 {
+				compatible = "st,stm32-dfsdm-adc";
+				#io-channel-cells = <1>;
+				reg = <1>;
+				interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dmamux1 102 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
+			dfsdm2: filter@2 {
+				compatible = "st,stm32-dfsdm-adc";
+				#io-channel-cells = <1>;
+				reg = <2>;
+				interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dmamux1 103 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
+			dfsdm3: filter@3 {
+				compatible = "st,stm32-dfsdm-adc";
+				#io-channel-cells = <1>;
+				reg = <3>;
+				interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dmamux1 104 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
+			dfsdm4: filter@4 {
+				compatible = "st,stm32-dfsdm-adc";
+				#io-channel-cells = <1>;
+				reg = <4>;
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dmamux1 91 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
+			dfsdm5: filter@5 {
+				compatible = "st,stm32-dfsdm-adc";
+				#io-channel-cells = <1>;
+				reg = <5>;
+				interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dmamux1 92 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+		};
+
 		dma1: dma@48000000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48000000 0x400>;
-- 
1.9.1
