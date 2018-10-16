Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9099DC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4959E20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4959E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJPWNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:13:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48260 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbeJPWNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 26D1820DFC; Tue, 16 Oct 2018 16:22:33 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3BEB320DFF;
        Tue, 16 Oct 2018 16:22:06 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 20/22] ARM: dts: at91: at91sam9263: switch to new clock bindings
Date:   Tue, 16 Oct 2018 16:21:58 +0200
Message-Id: <20181016142200.19741-21-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch at91sam9263 boards to the new PMC clock bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 315 +++--------------------------
 1 file changed, 30 insertions(+), 285 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index af68a86c9973..c5766da4e54e 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -96,264 +96,9 @@
 				compatible = "atmel,at91sam9263-pmc", "syscon";
 				reg = <0xfffffc00 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#interrupt-cells = <1>;
-
-				main_osc: main_osc {
-					compatible = "atmel,at91rm9200-clk-main-osc";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MOSCS>;
-					clocks = <&main_xtal>;
-				};
-
-				main: mainck {
-					compatible = "atmel,at91rm9200-clk-main";
-					#clock-cells = <0>;
-					clocks = <&main_osc>;
-				};
-
-				plla: pllack {
-					compatible = "atmel,at91rm9200-clk-pll";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKA>;
-					clocks = <&main>;
-					reg = <0>;
-					atmel,clk-input-range = <1000000 32000000>;
-					#atmel,pll-clk-output-range-cells = <4>;
-					atmel,pll-clk-output-ranges = <80000000 200000000 0 1>,
-								<190000000 240000000 2 1>;
-				};
-
-				pllb: pllbck {
-					compatible = "atmel,at91rm9200-clk-pll";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKB>;
-					clocks = <&main>;
-					reg = <1>;
-					atmel,clk-input-range = <1000000 32000000>;
-					#atmel,pll-clk-output-range-cells = <4>;
-					atmel,pll-clk-output-ranges = <80000000 200000000 0 1>,
-								<190000000 240000000 2 1>;
-				};
-
-				mck: masterck {
-					compatible = "atmel,at91rm9200-clk-master";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MCKRDY>;
-					clocks = <&slow_xtal>, <&main>, <&plla>, <&pllb>;
-					atmel,clk-output-range = <0 120000000>;
-					atmel,clk-divisors = <1 2 4 0>;
-				};
-
-				usb: usbck {
-					compatible = "atmel,at91rm9200-clk-usb";
-					#clock-cells = <0>;
-					atmel,clk-divisors = <1 2 4 0>;
-					clocks = <&pllb>;
-				};
-
-				prog: progck {
-					compatible = "atmel,at91rm9200-clk-programmable";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					interrupt-parent = <&pmc>;
-					clocks = <&slow_xtal>, <&main>, <&plla>, <&pllb>;
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
-
-					prog3: prog3 {
-						#clock-cells = <0>;
-						reg = <3>;
-						interrupts = <AT91_PMC_PCKRDY(3)>;
-					};
-				};
-
-				systemck {
-					compatible = "atmel,at91rm9200-clk-system";
-					#address-cells = <1>;
-					#size-cells = <0>;
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
-					pck3: pck3 {
-						#clock-cells = <0>;
-						reg = <11>;
-						clocks = <&prog3>;
-					};
-				};
-
-				periphck {
-					compatible = "atmel,at91rm9200-clk-peripheral";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&mck>;
-
-					pioA_clk: pioA_clk {
-						#clock-cells = <0>;
-						reg = <2>;
-					};
-
-					pioB_clk: pioB_clk {
-						#clock-cells = <0>;
-						reg = <3>;
-					};
-
-					pioCDE_clk: pioCDE_clk {
-						#clock-cells = <0>;
-						reg = <4>;
-					};
-
-					usart0_clk: usart0_clk {
-						#clock-cells = <0>;
-						reg = <7>;
-					};
-
-					usart1_clk: usart1_clk {
-						#clock-cells = <0>;
-						reg = <8>;
-					};
-
-					usart2_clk: usart2_clk {
-						#clock-cells = <0>;
-						reg = <9>;
-					};
-
-					mci0_clk: mci0_clk {
-						#clock-cells = <0>;
-						reg = <10>;
-					};
-
-					mci1_clk: mci1_clk {
-						#clock-cells = <0>;
-						reg = <11>;
-					};
-
-					can_clk: can_clk {
-						#clock-cells = <0>;
-						reg = <12>;
-					};
-
-					twi0_clk: twi0_clk {
-						#clock-cells = <0>;
-						reg = <13>;
-					};
-
-					spi0_clk: spi0_clk {
-						#clock-cells = <0>;
-						reg = <14>;
-					};
-
-					spi1_clk: spi1_clk {
-						#clock-cells = <0>;
-						reg = <15>;
-					};
-
-					ssc0_clk: ssc0_clk {
-						#clock-cells = <0>;
-						reg = <16>;
-					};
-
-					ssc1_clk: ssc1_clk {
-						#clock-cells = <0>;
-						reg = <17>;
-					};
-
-					ac97_clk: ac97_clk {
-						#clock-cells = <0>;
-						reg = <18>;
-					};
-
-					tcb_clk: tcb_clk {
-						#clock-cells = <0>;
-						reg = <19>;
-					};
-
-					pwm_clk: pwm_clk {
-						#clock-cells = <0>;
-						reg = <20>;
-					};
-
-					macb0_clk: macb0_clk {
-						#clock-cells = <0>;
-						reg = <21>;
-					};
-
-					g2de_clk: g2de_clk {
-						#clock-cells = <0>;
-						reg = <23>;
-					};
-
-					udc_clk: udc_clk {
-						#clock-cells = <0>;
-						reg = <24>;
-					};
-
-					isi_clk: isi_clk {
-						#clock-cells = <0>;
-						reg = <25>;
-					};
-
-					lcd_clk: lcd_clk {
-						#clock-cells = <0>;
-						reg = <26>;
-					};
-
-					dma_clk: dma_clk {
-						#clock-cells = <0>;
-						reg = <27>;
-					};
-
-					ohci_clk: ohci_clk {
-						#clock-cells = <0>;
-						reg = <29>;
-					};
-				};
+				#clock-cells = <2>;
+				clocks = <&slow_xtal>, <&main_xtal>;
+				clock-names = "slow_xtal", "main_xtal";
 			};
 
 			ramc0: ramc@ffffe200 {
@@ -385,7 +130,7 @@
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffd30 0xf>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
 			tcb0: timer@fff7c000 {
@@ -394,7 +139,7 @@
 				#size-cells = <0>;
 				reg = <0xfff7c000 0x100>;
 				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb_clk>, <&slow_xtal>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 19>, <&slow_xtal>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -736,7 +481,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioA_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 				};
 
 				pioB: gpio@fffff400 {
@@ -747,7 +492,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioB_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 				};
 
 				pioC: gpio@fffff600 {
@@ -758,7 +503,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioCDE_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
 				};
 
 				pioD: gpio@fffff800 {
@@ -769,7 +514,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioCDE_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
 				};
 
 				pioE: gpio@fffffa00 {
@@ -780,7 +525,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioCDE_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
 				};
 			};
 
@@ -790,7 +535,7 @@
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -803,7 +548,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
-				clocks = <&usart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -816,7 +561,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
-				clocks = <&usart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -829,7 +574,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
-				clocks = <&usart2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -840,7 +585,7 @@
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
-				clocks = <&ssc0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -851,7 +596,7 @@
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
-				clocks = <&ssc1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -862,7 +607,7 @@
 				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ac97>;
-				clocks = <&ac97_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
 				clock-names = "ac97_clk";
 				status = "disabled";
 			};
@@ -873,7 +618,7 @@
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb_rmii>;
-				clocks = <&macb0_clk>, <&macb0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 21>, <&pmc PMC_TYPE_PERIPHERAL 21>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 			};
@@ -882,7 +627,7 @@
 				compatible = "atmel,at91sam9263-udc";
 				reg = <0xfff78000 0x4000>;
 				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 2>;
-				clocks = <&udc_clk>, <&udpck>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 24>, <&pmc PMC_TYPE_SYSTEM 7>;
 				clock-names = "pclk", "hclk";
 				status = "disabled";
 			};
@@ -893,7 +638,7 @@
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 6>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&twi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
 				status = "disabled";
 			};
 
@@ -904,7 +649,7 @@
 				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&mci0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
 				clock-names = "mci_clk";
 				status = "disabled";
 			};
@@ -916,7 +661,7 @@
 				pinctrl-names = "default";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				clocks = <&mci1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
 				clock-names = "mci_clk";
 				status = "disabled";
 			};
@@ -940,7 +685,7 @@
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
-				clocks = <&spi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -953,7 +698,7 @@
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
-				clocks = <&spi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -963,7 +708,7 @@
 				reg = <0xfffb8000 0x300>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 4>;
 				#pwm-cells = <3>;
-				clocks = <&pwm_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
 				clock-names = "pwm_clk";
 				status = "disabled";
 			};
@@ -974,7 +719,7 @@
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can_rx_tx>;
-				clocks = <&can_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				clock-names = "can_clk";
 			};
 
@@ -1007,7 +752,7 @@
 			interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_fb>;
-			clocks = <&lcd_clk>, <&lcd_clk>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 26>, <&pmc PMC_TYPE_PERIPHERAL 26>;
 			clock-names = "lcdc_clk", "hclk";
 			status = "disabled";
 		};
@@ -1016,7 +761,7 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00a00000 0x100000>;
 			interrupts = <29 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&ohci_clk>, <&ohci_clk>, <&uhpck>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 29>, <&pmc PMC_TYPE_PERIPHERAL 29>, <&pmc PMC_TYPE_SYSTEM 6>;
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
@@ -1034,7 +779,7 @@
 				  0x3 0x0 0x40000000 0x10000000
 				  0x4 0x0 0x50000000 0x10000000
 				  0x5 0x0 0x60000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			status = "disabled";
 
 			nand_controller0: nand-controller {
@@ -1055,7 +800,7 @@
 			reg = <0x80000000 0x20000000>;
 			ranges = <0x0 0x0 0x80000000 0x10000000
 				  0x1 0x0 0x90000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			status = "disabled";
 
 			nand_controller1: nand-controller {
-- 
2.19.1

