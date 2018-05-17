Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeEQOWf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:22:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4505 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751619AbeEQOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:22:32 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: add STM32 SPI support on stm32mp157c
Date: Thu, 17 May 2018 16:21:42 +0200
Message-ID: <1526566904-24514-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
References: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds all STM32 SPI instances on stm32mp157c.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673..49ce7f0 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -311,6 +311,34 @@
 			};
 		};
 
+		spi2: spi@4000b000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32h7-spi";
+			reg = <0x4000b000 0x400>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI2_K>;
+			resets = <&rcc SPI2_R>;
+			dmas = <&dmamux1 39 0x400 0x05>,
+			       <&dmamux1 40 0x400 0x05>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi3: spi@4000c000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32h7-spi";
+			reg = <0x4000c000 0x400>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI3_K>;
+			resets = <&rcc SPI3_R>;
+			dmas = <&dmamux1 61 0x400 0x05>,
+			       <&dmamux1 62 0x400 0x05>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		usart2: serial@4000e000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000e000 0x400>;
@@ -494,6 +522,34 @@
 			status = "disabled";
 		};
 
+		spi1: spi@44004000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32h7-spi";
+			reg = <0x44004000 0x400>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI1_K>;
+			resets = <&rcc SPI1_R>;
+			dmas = <&dmamux1 37 0x400 0x05>,
+			       <&dmamux1 38 0x400 0x05>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi4: spi@44005000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32h7-spi";
+			reg = <0x44005000 0x400>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI4_K>;
+			resets = <&rcc SPI4_R>;
+			dmas = <&dmamux1 83 0x400 0x05>,
+			       <&dmamux1 84 0x400 0x05>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		timers15: timer@44006000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -556,6 +612,20 @@
 			};
 		};
 
+		spi5: spi@44009000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32h7-spi";
+			reg = <0x44009000 0x400>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI5_K>;
+			resets = <&rcc SPI5_R>;
+			dmas = <&dmamux1 85 0x400 0x05>,
+			       <&dmamux1 86 0x400 0x05>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		dma1: dma@48000000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48000000 0x400>;
@@ -805,6 +875,20 @@
 			status = "disabled";
 		};
 
+		spi6: spi@5c001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32h7-spi";
+			reg = <0x5c001000 0x400>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI6_K>;
+			resets = <&rcc SPI6_R>;
+			dmas = <&mdma1 34 0x0 0x40008 0x0 0x0 0>,
+			       <&mdma1 35 0x0 0x40002 0x0 0x0 0>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		i2c4: i2c@5c002000 {
 			compatible = "st,stm32f7-i2c";
 			reg = <0x5c002000 0x400>;
-- 
2.7.4
