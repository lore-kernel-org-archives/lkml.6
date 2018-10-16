Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D924C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446D42086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446D42086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJPWNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:13:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48242 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbeJPWNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2D3BF20E0C; Tue, 16 Oct 2018 16:22:31 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5566720DFA;
        Tue, 16 Oct 2018 16:22:05 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 17/22] ARM: dts: at91: sama5d2: switch to new binding
Date:   Tue, 16 Oct 2018 16:21:55 +0200
Message-Id: <20181016142200.19741-18-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch sama5d2 boards to the new PMC clock bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts |  12 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |   4 +-
 arch/arm/boot/dts/sama5d2.dtsi              | 642 ++------------------
 4 files changed, 64 insertions(+), 596 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index e86e0c00eb6b..2b0ddabe4178 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -165,7 +165,7 @@
 					dma-names = "tx", "rx";
 					#address-cells = <1>;
 					#size-cells = <0>;
-					clocks = <&flx1_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_mikrobus_i2c>;
 					atmel,fifo-size = <16>;
@@ -211,7 +211,7 @@
 					compatible = "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <22 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks = <&flx3_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 22>;
 					clock-names = "usart";
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx3_default>;
@@ -223,7 +223,7 @@
 					compatible = "atmel,at91rm9200-spi";
 					reg = <0x400 0x200>;
 					interrupts = <22 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks = <&flx3_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 22>;
 					clock-names = "spi_clk";
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx3_default>;
@@ -240,7 +240,7 @@
 					compatible = "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <23 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks = <&flx4_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
 					clock-names = "usart";
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx4_default>;
@@ -252,7 +252,7 @@
 					compatible = "atmel,at91rm9200-spi";
 					reg = <0x400 0x200>;
 					interrupts = <23 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks = <&flx4_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
 					clock-names = "spi_clk";
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_mikrobus_spi &pinctrl_mikrobus1_spi_cs &pinctrl_mikrobus2_spi_cs>;
@@ -268,7 +268,7 @@
 					dma-names = "tx", "rx";
 					#address-cells = <1>;
 					#size-cells = <0>;
-					clocks = <&flx4_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx4_default>;
 					atmel,fifo-size = <16>;
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index b10dccd0958f..835ff9b715c7 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -196,7 +196,7 @@
 					dma-names = "tx", "rx";
 					#address-cells = <1>;
 					#size-cells = <0>;
-					clocks = <&flx0_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 19>;
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx0_default>;
 					atmel,fifo-size = <16>;
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index fcc85d70f36e..7546116b3b64 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -258,7 +258,7 @@
 					compatible = "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
-					clocks = <&flx0_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 19>;
 					clock-names = "usart";
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx0_default>;
@@ -307,7 +307,7 @@
 					dma-names = "tx", "rx";
 					#address-cells = <1>;
 					#size-cells = <0>;
-					clocks = <&flx4_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx4_default>;
 					atmel,fifo-size = <16>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5c48e9..6c70a928defb 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -81,7 +81,7 @@
 		compatible = "arm,coresight-etb10", "arm,primecell";
 		reg = <0x740000 0x1000>;
 
-		clocks = <&mck>;
+		clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 		clock-names = "apb_pclk";
 
 		port {
@@ -96,7 +96,7 @@
 		compatible = "arm,coresight-etm3x", "arm,primecell";
 		reg = <0x73C000 0x1000>;
 
-		clocks = <&mck>;
+		clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 		clock-names = "apb_pclk";
 
 		port {
@@ -148,7 +148,7 @@
 			reg = <0x00300000 0x100000
 			       0xfc02c000 0x400>;
 			interrupts = <42 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&udphs_clk>, <&utmi>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 42>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
 
@@ -275,7 +275,7 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00400000 0x100000>;
 			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 41>, <&pmc PMC_TYPE_PERIPHERAL 41>, <&pmc PMC_TYPE_SYSTEM 6>;
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
@@ -284,7 +284,7 @@
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&utmi>, <&uhphs_clk>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_PERIPHERAL 41>;
 			clock-names = "usb_clk", "ehci_clk";
 			status = "disabled";
 		};
@@ -308,7 +308,7 @@
 				  0x1 0x0 0x60000000 0x10000000
 				  0x2 0x0 0x70000000 0x10000000
 				  0x3 0x0 0x80000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			status = "disabled";
 
 			nand_controller: nand-controller {
@@ -356,7 +356,7 @@
 					/* NFC SRAM banks */
 					0x00100000 0x00100000
 					>;
-				clocks = <&hsmc_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>;
 				atmel,write-by-sram;
 			};
 		};
@@ -365,7 +365,7 @@
 			compatible = "atmel,sama5d2-sdhci";
 			reg = <0xa0000000 0x300>;
 			interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 31>, <&pmc PMC_TYPE_GCK 31>, <&pmc PMC_TYPE_CORE PMC_MAIN>;
 			clock-names = "hclock", "multclk", "baseclk";
 			status = "disabled";
 		};
@@ -374,7 +374,7 @@
 			compatible = "atmel,sama5d2-sdhci";
 			reg = <0xb0000000 0x300>;
 			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&sdmmc1_hclk>, <&sdmmc1_gclk>, <&main>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 32>, <&pmc PMC_TYPE_GCK 32>, <&pmc PMC_TYPE_CORE PMC_MAIN>;
 			clock-names = "hclock", "multclk", "baseclk";
 			status = "disabled";
 		};
@@ -394,7 +394,7 @@
 				compatible = "atmel,sama5d2-hlcdc";
 				reg = <0xf0000000 0x2000>;
 				interrupts = <45 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 45>, <&pmc PMC_TYPE_SYSTEM 3>, <&clk32k>;
 				clock-names = "periph_clk","sys_clk", "slow_clk";
 				status = "disabled";
 
@@ -420,7 +420,7 @@
 				compatible = "atmel,sama5d2-isc";
 				reg = <0xf0008000 0x4000>;
 				interrupts = <46 IRQ_TYPE_LEVEL_HIGH 5>;
-				clocks = <&isc_clk>, <&iscck>, <&isc_gclk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 46>, <&pmc PMC_TYPE_SYSTEM 18>, <&pmc PMC_TYPE_GCK 46>;
 				clock-names = "hclock", "iscck", "gck";
 				#clock-cells = <0>;
 				clock-output-names = "isc-mck";
@@ -430,7 +430,7 @@
 			ramc0: ramc@f000c000 {
 				compatible = "atmel,sama5d3-ddramc";
 				reg = <0xf000c000 0x200>;
-				clocks = <&ddrck>, <&mpddr_clk>;
+				clocks = <&pmc PMC_TYPE_SYSTEM 2>, <&pmc PMC_TYPE_PERIPHERAL 13>;
 				clock-names = "ddrck", "mpddr";
 			};
 
@@ -439,7 +439,7 @@
 				reg = <0xf0010000 0x1000>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <1>;
-				clocks = <&dma0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "dma_clk";
 			};
 
@@ -449,7 +449,7 @@
 				reg = <0xf0004000 0x1000>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <1>;
-				clocks = <&dma1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "dma_clk";
 			};
 
@@ -457,541 +457,9 @@
 				compatible = "atmel,sama5d2-pmc", "syscon";
 				reg = <0xf0014000 0x160>;
 				interrupts = <74 IRQ_TYPE_LEVEL_HIGH 7>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#interrupt-cells = <1>;
-
-				main_rc_osc: main_rc_osc {
-					compatible = "atmel,at91sam9x5-clk-main-rc-osc";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_MOSCRCS>;
-					clock-frequency = <12000000>;
-					clock-accuracy = <100000000>;
-				};
-
-				main_osc: main_osc {
-					compatible = "atmel,at91rm9200-clk-main-osc";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_MOSCS>;
-					clocks = <&main_xtal>;
-				};
-
-				main: mainck {
-					compatible = "atmel,at91sam9x5-clk-main";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_MOSCSELS>;
-					clocks = <&main_rc_osc &main_osc>;
-				};
-
-				plla: pllack {
-					compatible = "atmel,sama5d3-clk-pll";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_LOCKA>;
-					clocks = <&main>;
-					reg = <0>;
-					atmel,clk-input-range = <12000000 12000000>;
-					#atmel,pll-clk-output-range-cells = <4>;
-					atmel,pll-clk-output-ranges = <600000000 1200000000 0 0>;
-				};
-
-				plladiv: plladivck {
-					compatible = "atmel,at91sam9x5-clk-plldiv";
-					#clock-cells = <0>;
-					clocks = <&plla>;
-				};
-
-				audio_pll_frac: audiopll_fracck {
-					compatible = "atmel,sama5d2-clk-audio-pll-frac";
-					#clock-cells = <0>;
-					clocks = <&main>;
-				};
-
-				audio_pll_pad: audiopll_padck {
-					compatible = "atmel,sama5d2-clk-audio-pll-pad";
-					#clock-cells = <0>;
-					clocks = <&audio_pll_frac>;
-				};
-
-				audio_pll_pmc: audiopll_pmcck {
-					compatible = "atmel,sama5d2-clk-audio-pll-pmc";
-					#clock-cells = <0>;
-					clocks = <&audio_pll_frac>;
-				};
-
-				utmi: utmick {
-					compatible = "atmel,at91sam9x5-clk-utmi";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_LOCKU>;
-					clocks = <&main>;
-				};
-
-				mck: masterck {
-					compatible = "atmel,at91sam9x5-clk-master";
-					#clock-cells = <0>;
-					interrupt-parent = <&pmc>;
-					interrupts = <AT91_PMC_MCKRDY>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>;
-					atmel,clk-output-range = <124000000 166000000>;
-					atmel,clk-divisors = <1 2 4 3>;
-				};
-
-				h32ck: h32mxck {
-					#clock-cells = <0>;
-					compatible = "atmel,sama5d4-clk-h32mx";
-					clocks = <&mck>;
-				};
-
-				usb: usbck {
-					compatible = "atmel,at91sam9x5-clk-usb";
-					#clock-cells = <0>;
-					clocks = <&plladiv>, <&utmi>;
-				};
-
-				prog: progck {
-					compatible = "atmel,at91sam9x5-clk-programmable";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					interrupt-parent = <&pmc>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
-
-					prog0: prog0 {
-						#clock-cells = <0>;
-						reg = <0>;
-						interrupts = <AT91_PMC_PCKRDY(0)>;
-					};
-
-					prog1: prog1 {
-						#clock-cells = <0>;
-						reg = <1>;
-						interrupts = <AT91_PMC_PCKRDY(1)>;
-					};
-
-					prog2: prog2 {
-						#clock-cells = <0>;
-						reg = <2>;
-						interrupts = <AT91_PMC_PCKRDY(2)>;
-					};
-				};
-
-				systemck {
-					compatible = "atmel,at91rm9200-clk-system";
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					ddrck: ddrck {
-						#clock-cells = <0>;
-						reg = <2>;
-						clocks = <&mck>;
-					};
-
-					lcdck: lcdck {
-						#clock-cells = <0>;
-						reg = <3>;
-						clocks = <&mck>;
-					};
-
-					uhpck: uhpck {
-						#clock-cells = <0>;
-						reg = <6>;
-						clocks = <&usb>;
-					};
-
-					udpck: udpck {
-						#clock-cells = <0>;
-						reg = <7>;
-						clocks = <&usb>;
-					};
-
-					pck0: pck0 {
-						#clock-cells = <0>;
-						reg = <8>;
-						clocks = <&prog0>;
-					};
-
-					pck1: pck1 {
-						#clock-cells = <0>;
-						reg = <9>;
-						clocks = <&prog1>;
-					};
-
-					pck2: pck2 {
-						#clock-cells = <0>;
-						reg = <10>;
-						clocks = <&prog2>;
-					};
-
-					iscck: iscck {
-						#clock-cells = <0>;
-						reg = <18>;
-						clocks = <&mck>;
-					};
-				};
-
-				periph32ck {
-					compatible = "atmel,at91sam9x5-clk-peripheral";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&h32ck>;
-
-					macb0_clk: macb0_clk {
-						#clock-cells = <0>;
-						reg = <5>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					tdes_clk: tdes_clk {
-						#clock-cells = <0>;
-						reg = <11>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					matrix1_clk: matrix1_clk {
-						#clock-cells = <0>;
-						reg = <14>;
-					};
-
-					hsmc_clk: hsmc_clk {
-						#clock-cells = <0>;
-						reg = <17>;
-					};
-
-					pioA_clk: pioA_clk {
-						#clock-cells = <0>;
-						reg = <18>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					flx0_clk: flx0_clk {
-						#clock-cells = <0>;
-						reg = <19>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					flx1_clk: flx1_clk {
-						#clock-cells = <0>;
-						reg = <20>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					flx2_clk: flx2_clk {
-						#clock-cells = <0>;
-						reg = <21>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					flx3_clk: flx3_clk {
-						#clock-cells = <0>;
-						reg = <22>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					flx4_clk: flx4_clk {
-						#clock-cells = <0>;
-						reg = <23>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					uart0_clk: uart0_clk {
-						#clock-cells = <0>;
-						reg = <24>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					uart1_clk: uart1_clk {
-						#clock-cells = <0>;
-						reg = <25>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					uart2_clk: uart2_clk {
-						#clock-cells = <0>;
-						reg = <26>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					uart3_clk: uart3_clk {
-						#clock-cells = <0>;
-						reg = <27>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					uart4_clk: uart4_clk {
-						#clock-cells = <0>;
-						reg = <28>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					twi0_clk: twi0_clk {
-						reg = <29>;
-						#clock-cells = <0>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					twi1_clk: twi1_clk {
-						#clock-cells = <0>;
-						reg = <30>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					spi0_clk: spi0_clk {
-						#clock-cells = <0>;
-						reg = <33>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					spi1_clk: spi1_clk {
-						#clock-cells = <0>;
-						reg = <34>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					tcb0_clk: tcb0_clk {
-						#clock-cells = <0>;
-						reg = <35>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					tcb1_clk: tcb1_clk {
-						#clock-cells = <0>;
-						reg = <36>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					pwm_clk: pwm_clk {
-						#clock-cells = <0>;
-						reg = <38>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					adc_clk: adc_clk {
-						#clock-cells = <0>;
-						reg = <40>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					uhphs_clk: uhphs_clk {
-						#clock-cells = <0>;
-						reg = <41>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					udphs_clk: udphs_clk {
-						#clock-cells = <0>;
-						reg = <42>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					ssc0_clk: ssc0_clk {
-						#clock-cells = <0>;
-						reg = <43>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					ssc1_clk: ssc1_clk {
-						#clock-cells = <0>;
-						reg = <44>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					trng_clk: trng_clk {
-						#clock-cells = <0>;
-						reg = <47>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					pdmic_clk: pdmic_clk {
-						#clock-cells = <0>;
-						reg = <48>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					securam_clk: securam_clk {
-						#clock-cells = <0>;
-						reg = <51>;
-					};
-
-					i2s0_clk: i2s0_clk {
-						#clock-cells = <0>;
-						reg = <54>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					i2s1_clk: i2s1_clk {
-						#clock-cells = <0>;
-						reg = <55>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					can0_clk: can0_clk {
-						#clock-cells = <0>;
-						reg = <56>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					can1_clk: can1_clk {
-						#clock-cells = <0>;
-						reg = <57>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					classd_clk: classd_clk {
-						#clock-cells = <0>;
-						reg = <59>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-				};
-
-				periph64ck {
-					compatible = "atmel,at91sam9x5-clk-peripheral";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&mck>;
-
-					dma0_clk: dma0_clk {
-						#clock-cells = <0>;
-						reg = <6>;
-					};
-
-					dma1_clk: dma1_clk {
-						#clock-cells = <0>;
-						reg = <7>;
-					};
-
-					aes_clk: aes_clk {
-						#clock-cells = <0>;
-						reg = <9>;
-					};
-
-					aesb_clk: aesb_clk {
-						#clock-cells = <0>;
-						reg = <10>;
-					};
-
-					sha_clk: sha_clk {
-						#clock-cells = <0>;
-						reg = <12>;
-					};
-
-					mpddr_clk: mpddr_clk {
-						#clock-cells = <0>;
-						reg = <13>;
-					};
-
-					matrix0_clk: matrix0_clk {
-						#clock-cells = <0>;
-						reg = <15>;
-					};
-
-					sdmmc0_hclk: sdmmc0_hclk {
-						#clock-cells = <0>;
-						reg = <31>;
-					};
-
-					sdmmc1_hclk: sdmmc1_hclk {
-						#clock-cells = <0>;
-						reg = <32>;
-					};
-
-					lcdc_clk: lcdc_clk {
-						#clock-cells = <0>;
-						reg = <45>;
-					};
-
-					isc_clk: isc_clk {
-						#clock-cells = <0>;
-						reg = <46>;
-					};
-
-					qspi0_clk: qspi0_clk {
-						#clock-cells = <0>;
-						reg = <52>;
-					};
-
-					qspi1_clk: qspi1_clk {
-						#clock-cells = <0>;
-						reg = <53>;
-					};
-				};
-
-				gck {
-					compatible = "atmel,sama5d2-clk-generated";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					interrupt-parent = <&pmc>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>, <&audio_pll_pmc>;
-
-					sdmmc0_gclk: sdmmc0_gclk {
-						#clock-cells = <0>;
-						reg = <31>;
-					};
-
-					sdmmc1_gclk: sdmmc1_gclk {
-						#clock-cells = <0>;
-						reg = <32>;
-					};
-
-					tcb0_gclk: tcb0_gclk {
-						#clock-cells = <0>;
-						reg = <35>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					tcb1_gclk: tcb1_gclk {
-						#clock-cells = <0>;
-						reg = <36>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					pwm_gclk: pwm_gclk {
-						#clock-cells = <0>;
-						reg = <38>;
-						atmel,clk-output-range = <0 83000000>;
-					};
-
-					isc_gclk: isc_gclk {
-						#clock-cells = <0>;
-						reg = <46>;
-					};
-
-					pdmic_gclk: pdmic_gclk {
-						#clock-cells = <0>;
-						reg = <48>;
-					};
-
-					i2s0_gclk: i2s0_gclk {
-						#clock-cells = <0>;
-						reg = <54>;
-					};
-
-					i2s1_gclk: i2s1_gclk {
-						#clock-cells = <0>;
-						reg = <55>;
-					};
-
-					can0_gclk: can0_gclk {
-						#clock-cells = <0>;
-						reg = <56>;
-						atmel,clk-output-range = <0 80000000>;
-					};
-
-					can1_gclk: can1_gclk {
-						#clock-cells = <0>;
-						reg = <57>;
-						atmel,clk-output-range = <0 80000000>;
-					};
-
-					classd_gclk: classd_gclk {
-						#clock-cells = <0>;
-						reg = <59>;
-						atmel,clk-output-range = <0 100000000>;
-					};
-				};
+				#clock-cells = <2>;
+				clocks = <&clk32k>, <&main_xtal>;
+				clock-names = "slow_clk", "main_xtal";
 			};
 
 			qspi0: spi@f0020000 {
@@ -999,7 +467,7 @@
 				reg = <0xf0020000 0x100>, <0xd0000000 0x08000000>;
 				reg-names = "qspi_base", "qspi_mmap";
 				interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&qspi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1010,7 +478,7 @@
 				reg = <0xf0024000 0x100>, <0xd8000000 0x08000000>;
 				reg-names = "qspi_base", "qspi_mmap";
 				interrupts = <53 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&qspi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 53>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1024,7 +492,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(30))>;
 				dma-names = "tx";
-				clocks = <&sha_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				clock-names = "sha_clk";
 				status = "okay";
 			};
@@ -1040,7 +508,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(27))>;
 				dma-names = "tx", "rx";
-				clocks = <&aes_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "aes_clk";
 				status = "okay";
 			};
@@ -1056,7 +524,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(7))>;
 				dma-names = "tx", "rx";
-				clocks = <&spi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
 				clock-names = "spi_clk";
 				atmel,fifo-size = <16>;
 				#address-cells = <1>;
@@ -1075,7 +543,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					AT91_XDMAC_DT_PERID(22))>;
 				dma-names = "tx", "rx";
-				clocks = <&ssc0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 43>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -1088,7 +556,7 @@
 					      67 IRQ_TYPE_LEVEL_HIGH 3>;        /* Queue 2 */
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&macb0_clk>, <&macb0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>, <&pmc PMC_TYPE_PERIPHERAL 5>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 			};
@@ -1099,7 +567,7 @@
 				#size-cells = <0>;
 				reg = <0xf800c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb0_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&clk32k>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -1109,7 +577,7 @@
 				#size-cells = <0>;
 				reg = <0xf8010000 0x100>;
 				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb1_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>, <&clk32k>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -1117,7 +585,7 @@
 				compatible = "atmel,sama5d2-smc", "syscon", "simple-mfd";
 				reg = <0xf8014000 0x1000>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 6>;
-				clocks = <&hsmc_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges;
@@ -1137,7 +605,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 					| AT91_XDMAC_DT_PERID(50))>;
 				dma-names = "rx";
-				clocks = <&pdmic_clk>, <&pdmic_gclk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 48>, <&pmc PMC_TYPE_GCK 48>;
 				clock-names = "pclk", "gclk";
 				status = "disabled";
 			};
@@ -1153,7 +621,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(36))>;
 				dma-names = "tx", "rx";
-				clocks = <&uart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 24>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1169,7 +637,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(38))>;
 				dma-names = "tx", "rx";
-				clocks = <&uart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 25>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1185,7 +653,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(40))>;
 				dma-names = "tx", "rx";
-				clocks = <&uart2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 26>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1203,7 +671,7 @@
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&twi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 29>;
 				atmel,fifo-size = <16>;
 				status = "disabled";
 			};
@@ -1213,7 +681,7 @@
 				reg = <0xf802c000 0x4000>;
 				interrupts = <38 IRQ_TYPE_LEVEL_HIGH 7>;
 				#pwm-cells = <3>;
-				clocks = <&pwm_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
 			};
 
 			sfr: sfr@f8030000 {
@@ -1224,7 +692,7 @@
 			flx0: flexcom@f8034000 {
 				compatible = "atmel,sama5d2-flexcom";
 				reg = <0xf8034000 0x200>;
-				clocks = <&flx0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 19>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0x0 0xf8034000 0x800>;
@@ -1234,7 +702,7 @@
 			flx1: flexcom@f8038000 {
 				compatible = "atmel,sama5d2-flexcom";
 				reg = <0xf8038000 0x200>;
-				clocks = <&flx1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0x0 0xf8038000 0x800>;
@@ -1244,7 +712,7 @@
 			securam: sram@f8044000 {
 				compatible = "atmel,sama5d2-securam", "mmio-sram";
 				reg = <0xf8044000 0x1420>;
-				clocks = <&securam_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 51>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0 0xf8044000 0x1420>;
@@ -1269,7 +737,7 @@
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xf8048030 0x10>;
 				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 5>;
-				clocks = <&h32ck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK2>;
 			};
 
 			watchdog@f8048040 {
@@ -1302,10 +770,10 @@
 				interrupts = <56 IRQ_TYPE_LEVEL_HIGH 7>,
 					     <64 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-names = "int0", "int1";
-				clocks = <&can0_clk>, <&can0_gclk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 56>, <&pmc PMC_TYPE_GCK 56>;
 				clock-names = "hclk", "cclk";
-				assigned-clocks = <&can0_gclk>;
-				assigned-clock-parents = <&utmi>;
+				assigned-clocks = <&pmc PMC_TYPE_GCK 56>;
+				assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_UTMI>;
 				assigned-clock-rates = <40000000>;
 				bosch,mram-cfg = <0x0 0 0 64 0 0 32 32>;
 				status = "disabled";
@@ -1322,7 +790,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(9))>;
 				dma-names = "tx", "rx";
-				clocks = <&spi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 34>;
 				clock-names = "spi_clk";
 				atmel,fifo-size = <16>;
 				#address-cells = <1>;
@@ -1341,7 +809,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(42))>;
 				dma-names = "tx", "rx";
-				clocks = <&uart3_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1357,7 +825,7 @@
 					 AT91_XDMAC_DT_PERID(44))>;
 				dma-names = "tx", "rx";
 				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&uart4_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1365,7 +833,7 @@
 			flx2: flexcom@fc010000 {
 				compatible = "atmel,sama5d2-flexcom";
 				reg = <0xfc010000 0x200>;
-				clocks = <&flx2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 21>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0x0 0xfc010000 0x800>;
@@ -1375,7 +843,7 @@
 			flx3: flexcom@fc014000 {
 				compatible = "atmel,sama5d2-flexcom";
 				reg = <0xfc014000 0x200>;
-				clocks = <&flx3_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 22>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0x0 0xfc014000 0x800>;
@@ -1385,7 +853,7 @@
 			flx4: flexcom@fc018000 {
 				compatible = "atmel,sama5d2-flexcom";
 				reg = <0xfc018000 0x200>;
-				clocks = <&flx4_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0x0 0xfc018000 0x800>;
@@ -1396,7 +864,7 @@
 				compatible = "atmel,at91sam9g45-trng";
 				reg = <0xfc01c000 0x100>;
 				interrupts = <47 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&trng_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 47>;
 			};
 
 			aic: interrupt-controller@fc020000 {
@@ -1420,7 +888,7 @@
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&twi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 30>;
 				atmel,fifo-size = <16>;
 				status = "disabled";
 			};
@@ -1429,7 +897,7 @@
 				compatible = "atmel,sama5d2-adc";
 				reg = <0xfc030000 0x100>;
 				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&adc_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
 				clock-names = "adc_clk";
 				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
 				dma-names = "rx";
@@ -1451,7 +919,7 @@
 				#interrupt-cells = <2>;
 				gpio-controller;
 				#gpio-cells = <2>;
-				clocks = <&pioA_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
 			};
 
 			secumod@fc040000 {
@@ -1470,7 +938,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(29))>;
 				dma-names = "tx", "rx";
-				clocks = <&tdes_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
 				clock-names = "tdes_clk";
 				status = "okay";
 			};
@@ -1483,7 +951,7 @@
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(47))>;
 				dma-names = "tx";
-				clocks = <&classd_clk>, <&classd_gclk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 59>, <&pmc PMC_TYPE_GCK 59>;
 				clock-names = "pclk", "gclk";
 				status = "disabled";
 			};
@@ -1495,10 +963,10 @@
 				interrupts = <57 IRQ_TYPE_LEVEL_HIGH 7>,
 					     <65 IRQ_TYPE_LEVEL_HIGH 7>;
 				interrupt-names = "int0", "int1";
-				clocks = <&can1_clk>, <&can1_gclk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 57>, <&pmc PMC_TYPE_GCK 57>;
 				clock-names = "hclk", "cclk";
-				assigned-clocks = <&can1_gclk>;
-				assigned-clock-parents = <&utmi>;
+				assigned-clocks = <&pmc PMC_TYPE_GCK 57>;
+				assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_UTMI>;
 				assigned-clock-rates = <40000000>;
 				bosch,mram-cfg = <0x1100 0 0 64 0 0 32 32>;
 				status = "disabled";
-- 
2.19.1

