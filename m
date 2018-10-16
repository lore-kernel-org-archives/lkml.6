Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3612C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822B22086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822B22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJPWNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:13:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48253 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbeJPWNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2287720DFF; Tue, 16 Oct 2018 16:22:33 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7D56F20DE1;
        Tue, 16 Oct 2018 16:22:06 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 21/22] ARM: dts: at91: at91sam9x5: switch to new clock bindings
Date:   Tue, 16 Oct 2018 16:21:59 +0200
Message-Id: <20181016142200.19741-22-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch at91sam9x5 boards to the new PMC clock bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91sam9g15.dtsi       |   4 +
 arch/arm/boot/dts/at91sam9g25.dtsi       |   4 +
 arch/arm/boot/dts/at91sam9g25ek.dts      |   4 +-
 arch/arm/boot/dts/at91sam9g35.dtsi       |   4 +
 arch/arm/boot/dts/at91sam9x25.dtsi       |   4 +
 arch/arm/boot/dts/at91sam9x35.dtsi       |   4 +
 arch/arm/boot/dts/at91sam9x5.dtsi        | 326 +++--------------------
 arch/arm/boot/dts/at91sam9x5_can.dtsi    |  18 +-
 arch/arm/boot/dts/at91sam9x5_isi.dtsi    |  11 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi    |  19 +-
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi  |  11 +-
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi  |  11 +-
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  11 +-
 13 files changed, 62 insertions(+), 369 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g15.dtsi b/arch/arm/boot/dts/at91sam9g15.dtsi
index 27de7dc0f0e0..b34a6c65bd44 100644
--- a/arch/arm/boot/dts/at91sam9g15.dtsi
+++ b/arch/arm/boot/dts/at91sam9g15.dtsi
@@ -24,6 +24,10 @@
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
 			};
+
+			pmc: pmc@fffffc00 {
+				compatible = "atmel,at91sam9g15-pmc", "atmel,at91sam9x5-pmc", "syscon";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
index 0898213f3bb2..d8bb56253e64 100644
--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -26,6 +26,10 @@
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
 			};
+
+			pmc: pmc@fffffc00 {
+				compatible = "atmel,at91sam9g25-pmc", "atmel,at91sam9x5-pmc", "syscon";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 31fecc2cdaf9..ac730812a81d 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -32,9 +32,9 @@
 					pinctrl-0 = <&pinctrl_pck0_as_isi_mck &pinctrl_sensor_power &pinctrl_sensor_reset>;
 					resetb-gpios = <&pioA 7 GPIO_ACTIVE_LOW>;
 					pwdn-gpios = <&pioA 13 GPIO_ACTIVE_HIGH>;
-					clocks = <&pck0>;
+					clocks = <&pmc PMC_TYPE_SYSTEM 8>;
 					clock-names = "xvclk";
-					assigned-clocks = <&pck0>;
+					assigned-clocks = <&pmc PMC_TYPE_SYSTEM 8>;
 					assigned-clock-rates = <25000000>;
 					status = "okay";
 
diff --git a/arch/arm/boot/dts/at91sam9g35.dtsi b/arch/arm/boot/dts/at91sam9g35.dtsi
index ff4115886f97..333e158feb61 100644
--- a/arch/arm/boot/dts/at91sam9g35.dtsi
+++ b/arch/arm/boot/dts/at91sam9g35.dtsi
@@ -25,6 +25,10 @@
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
 			};
+
+			pmc: pmc@fffffc00 {
+				compatible = "atmel,at91sam9g35-pmc", "atmel,at91sam9x5-pmc", "syscon";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91sam9x25.dtsi
index 3c5fa3388997..a99703a262c9 100644
--- a/arch/arm/boot/dts/at91sam9x25.dtsi
+++ b/arch/arm/boot/dts/at91sam9x25.dtsi
@@ -27,6 +27,10 @@
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
 			};
+
+			pmc: pmc@fffffc00 {
+				compatible = "atmel,at91sam9x25-pmc", "atmel,at91sam9x5-pmc", "syscon";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x35.dtsi b/arch/arm/boot/dts/at91sam9x35.dtsi
index d9054e8167b7..bca274d33f68 100644
--- a/arch/arm/boot/dts/at91sam9x35.dtsi
+++ b/arch/arm/boot/dts/at91sam9x35.dtsi
@@ -26,6 +26,10 @@
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
 			};
+
+			pmc: pmc@fffffc00 {
+				compatible = "atmel,at91sam9x35-pmc", "atmel,at91sam9x5-pmc", "syscon";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 11c0ef102ab1..07443a387a8f 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -111,7 +111,7 @@
 			ramc0: ramc@ffffe800 {
 				compatible = "atmel,at91sam9g45-ddramc";
 				reg = <0xffffe800 0x200>;
-				clocks = <&ddrck>;
+				clocks = <&pmc PMC_TYPE_SYSTEM 2>;
 				clock-names = "ddrck";
 			};
 
@@ -124,269 +124,9 @@
 				compatible = "atmel,at91sam9x5-pmc", "syscon";
 				reg = <0xfffffc00 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				#interrupt-cells = <1>;
-
-				main_rc_osc: main_rc_osc {
-					compatible = "atmel,at91sam9x5-clk-main-rc-osc";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MOSCRCS>;
-					clock-frequency = <12000000>;
-					clock-accuracy = <50000000>;
-				};
-
-				main_osc: main_osc {
-					compatible = "atmel,at91rm9200-clk-main-osc";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MOSCS>;
-					clocks = <&main_xtal>;
-				};
-
-				main: mainck {
-					compatible = "atmel,at91sam9x5-clk-main";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MOSCSELS>;
-					clocks = <&main_rc_osc>, <&main_osc>;
-				};
-
-				plla: pllack {
-					compatible = "atmel,at91rm9200-clk-pll";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKA>;
-					clocks = <&main>;
-					reg = <0>;
-					atmel,clk-input-range = <2000000 32000000>;
-					#atmel,pll-clk-output-range-cells = <4>;
-					atmel,pll-clk-output-ranges = <745000000 800000000 0 0
-								       695000000 750000000 1 0
-								       645000000 700000000 2 0
-								       595000000 650000000 3 0
-								       545000000 600000000 0 1
-								       495000000 555000000 1 1
-								       445000000 500000000 2 1
-								       400000000 450000000 3 1>;
-				};
-
-				plladiv: plladivck {
-					compatible = "atmel,at91sam9x5-clk-plldiv";
-					#clock-cells = <0>;
-					clocks = <&plla>;
-				};
-
-				utmi: utmick {
-					compatible = "atmel,at91sam9x5-clk-utmi";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_LOCKU>;
-					clocks = <&main>;
-				};
-
-				mck: masterck {
-					compatible = "atmel,at91sam9x5-clk-master";
-					#clock-cells = <0>;
-					interrupts-extended = <&pmc AT91_PMC_MCKRDY>;
-					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>;
-					atmel,clk-output-range = <0 133333333>;
-					atmel,clk-divisors = <1 2 4 3>;
-					atmel,master-clk-have-div3-pres;
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
-				};
-
-				smd: smdclk {
-					compatible = "atmel,at91sam9x5-clk-smd";
-					#clock-cells = <0>;
-					clocks = <&plladiv>, <&utmi>;
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
-					smdck: smdck {
-						#clock-cells = <0>;
-						reg = <4>;
-						clocks = <&smd>;
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
-				};
-
-				periphck {
-					compatible = "atmel,at91sam9x5-clk-peripheral";
-					#address-cells = <1>;
-					#size-cells = <0>;
-					clocks = <&mck>;
-
-					pioAB_clk: pioAB_clk {
-						#clock-cells = <0>;
-						reg = <2>;
-					};
-
-					pioCD_clk: pioCD_clk {
-						#clock-cells = <0>;
-						reg = <3>;
-					};
-
-					smd_clk: smd_clk {
-						#clock-cells = <0>;
-						reg = <4>;
-					};
-
-					usart0_clk: usart0_clk {
-						#clock-cells = <0>;
-						reg = <5>;
-					};
-
-					usart1_clk: usart1_clk {
-						#clock-cells = <0>;
-						reg = <6>;
-					};
-
-					usart2_clk: usart2_clk {
-						#clock-cells = <0>;
-						reg = <7>;
-					};
-
-					twi0_clk: twi0_clk {
-						reg = <9>;
-						#clock-cells = <0>;
-					};
-
-					twi1_clk: twi1_clk {
-						#clock-cells = <0>;
-						reg = <10>;
-					};
-
-					twi2_clk: twi2_clk {
-						#clock-cells = <0>;
-						reg = <11>;
-					};
-
-					mci0_clk: mci0_clk {
-						#clock-cells = <0>;
-						reg = <12>;
-					};
-
-					spi0_clk: spi0_clk {
-						#clock-cells = <0>;
-						reg = <13>;
-					};
-
-					spi1_clk: spi1_clk {
-						#clock-cells = <0>;
-						reg = <14>;
-					};
-
-					uart0_clk: uart0_clk {
-						#clock-cells = <0>;
-						reg = <15>;
-					};
-
-					uart1_clk: uart1_clk {
-						#clock-cells = <0>;
-						reg = <16>;
-					};
-
-					tcb0_clk: tcb0_clk {
-						#clock-cells = <0>;
-						reg = <17>;
-					};
-
-					pwm_clk: pwm_clk {
-						#clock-cells = <0>;
-						reg = <18>;
-					};
-
-					adc_clk: adc_clk {
-						#clock-cells = <0>;
-						reg = <19>;
-					};
-
-					dma0_clk: dma0_clk {
-						#clock-cells = <0>;
-						reg = <20>;
-					};
-
-					dma1_clk: dma1_clk {
-						#clock-cells = <0>;
-						reg = <21>;
-					};
-
-					uhphs_clk: uhphs_clk {
-						#clock-cells = <0>;
-						reg = <22>;
-					};
-
-					udphs_clk: udphs_clk {
-						#clock-cells = <0>;
-						reg = <23>;
-					};
-
-					mci1_clk: mci1_clk {
-						#clock-cells = <0>;
-						reg = <26>;
-					};
-
-					ssc0_clk: ssc0_clk {
-						#clock-cells = <0>;
-						reg = <28>;
-					};
-				};
+				#clock-cells = <2>;
+				clocks = <&clk32k>, <&main_xtal>;
+				clock-names = "slow_clk", "main_xtal";
 			};
 
 			reset_controller: rstc@fffffe00 {
@@ -405,7 +145,7 @@
 				compatible = "atmel,at91sam9260-pit";
 				reg = <0xfffffe30 0xf>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
 			sckc@fffffe50 {
@@ -438,7 +178,7 @@
 				#size-cells = <0>;
 				reg = <0xf8008000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb0_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -448,7 +188,7 @@
 				#size-cells = <0>;
 				reg = <0xf800c000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb0_clk>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k>;
 				clock-names = "t0_clk", "slow_clk";
 			};
 
@@ -457,7 +197,7 @@
 				reg = <0xffffec00 0x200>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
-				clocks = <&dma0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
 				clock-names = "dma_clk";
 			};
 
@@ -466,7 +206,7 @@
 				reg = <0xffffee00 0x200>;
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH 0>;
 				#dma-cells = <2>;
-				clocks = <&dma1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 21>;
 				clock-names = "dma_clk";
 			};
 
@@ -864,7 +604,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioAB_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 				};
 
 				pioB: gpio@fffff600 {
@@ -876,7 +616,7 @@
 					#gpio-lines = <19>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioAB_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
 				};
 
 				pioC: gpio@fffff800 {
@@ -887,7 +627,7 @@
 					gpio-controller;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioCD_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 				};
 
 				pioD: gpio@fffffa00 {
@@ -899,7 +639,7 @@
 					#gpio-lines = <22>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
-					clocks = <&pioCD_clk>;
+					clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 				};
 			};
 
@@ -912,7 +652,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
-				clocks = <&ssc0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
 				clock-names = "pclk";
 				status = "disabled";
 			};
@@ -924,7 +664,7 @@
 				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				pinctrl-names = "default";
-				clocks = <&mci0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 12>;
 				clock-names = "mci_clk";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -938,7 +678,7 @@
 				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(0)>;
 				dma-names = "rxtx";
 				pinctrl-names = "default";
-				clocks = <&mci1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 26>;
 				clock-names = "mci_clk";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -954,7 +694,7 @@
 				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(8)>,
 				       <&dma1 1 (AT91_DMA_CFG_PER_ID(9) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
 				dma-names = "tx", "rx";
-				clocks = <&mck>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -968,7 +708,7 @@
 				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(3)>,
 				       <&dma0 1 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
 				dma-names = "tx", "rx";
-				clocks = <&usart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -982,7 +722,7 @@
 				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(5)>,
 				       <&dma0 1 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
 				dma-names = "tx", "rx";
-				clocks = <&usart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -996,7 +736,7 @@
 				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(12)>,
 				       <&dma1 1 (AT91_DMA_CFG_PER_ID(13) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
 				dma-names = "tx", "rx";
-				clocks = <&usart2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1012,7 +752,7 @@
 				#size-cells = <0>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c0>;
-				clocks = <&twi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				status = "disabled";
 			};
 
@@ -1027,7 +767,7 @@
 				#size-cells = <0>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c1>;
-				clocks = <&twi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
 				status = "disabled";
 			};
 
@@ -1042,7 +782,7 @@
 				#size-cells = <0>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c2>;
-				clocks = <&twi2_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
 				status = "disabled";
 			};
 
@@ -1052,7 +792,7 @@
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
-				clocks = <&uart0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1063,7 +803,7 @@
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1>;
-				clocks = <&uart1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
 				clock-names = "usart";
 				status = "disabled";
 			};
@@ -1074,7 +814,7 @@
 				compatible = "atmel,at91sam9x5-adc";
 				reg = <0xf804c000 0x100>;
 				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&adc_clk>,
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 19>,
 					 <&adc_op_clk>;
 				clock-names = "adc_clk", "adc_op_clk";
 				atmel,adc-use-external-triggers;
@@ -1121,7 +861,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0>;
-				clocks = <&spi0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -1137,7 +877,7 @@
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi1>;
-				clocks = <&spi1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
 				clock-names = "spi_clk";
 				status = "disabled";
 			};
@@ -1149,7 +889,7 @@
 				reg = <0x00500000 0x80000
 				       0xf803c000 0x400>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&utmi>, <&udphs_clk>;
+				clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_PERIPHERAL 23>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 
@@ -1229,7 +969,7 @@
 				compatible = "atmel,at91sam9rl-pwm";
 				reg = <0xf8034000 0x300>;
 				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 4>;
-				clocks = <&pwm_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
@@ -1239,7 +979,7 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 22>, <&pmc PMC_TYPE_PERIPHERAL 22>, <&pmc PMC_TYPE_SYSTEM 6>;
 			clock-names = "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
@@ -1248,7 +988,7 @@
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00700000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&utmi>, <&uhphs_clk>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_PERIPHERAL 22>;
 			clock-names = "usb_clk", "ehci_clk";
 			status = "disabled";
 		};
@@ -1266,7 +1006,7 @@
 				  0x3 0x0 0x40000000 0x10000000
 				  0x4 0x0 0x50000000 0x10000000
 				  0x5 0x0 0x60000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			status = "disabled";
 
 			nand_controller: nand-controller {
diff --git a/arch/arm/boot/dts/at91sam9x5_can.dtsi b/arch/arm/boot/dts/at91sam9x5_can.dtsi
index 8eb2f9c1b978..125f9e3b49ad 100644
--- a/arch/arm/boot/dts/at91sam9x5_can.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_can.dtsi
@@ -13,27 +13,13 @@
 / {
 	ahb {
 		apb {
-			pmc: pmc@fffffc00 {
-				periphck {
-					can0_clk: can0_clk {
-						#clock-cells = <0>;
-						reg = <29>;
-					};
-
-					can1_clk: can1_clk {
-						#clock-cells = <0>;
-						reg = <30>;
-					};
-				};
-			};
-
 			can0: can@f8000000 {
 				compatible = "atmel,at91sam9x5-can";
 				reg = <0xf8000000 0x300>;
 				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can0_rx_tx>;
-				clocks = <&can0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 29>;
 				clock-names = "can_clk";
 				status = "disabled";
 			};
@@ -44,7 +30,7 @@
 				interrupts = <30 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can1_rx_tx>;
-				clocks = <&can1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 30>;
 				clock-names = "can_clk";
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/at91sam9x5_isi.dtsi b/arch/arm/boot/dts/at91sam9x5_isi.dtsi
index 8fc45ca4dcb5..c3e45b57b6a2 100644
--- a/arch/arm/boot/dts/at91sam9x5_isi.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_isi.dtsi
@@ -44,22 +44,13 @@
 				};
 			};
 
-			pmc: pmc@fffffc00 {
-				periphck {
-					isi_clk: isi_clk {
-						#clock-cells = <0>;
-						reg = <25>;
-					};
-				};
-			};
-
 			isi: isi@f8048000 {
 				compatible = "atmel,at91sam9g45-isi";
 				reg = <0xf8048000 0x4000>;
 				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_isi_data_0_7>;
-				clocks = <&isi_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 25>;
 				clock-names = "isi_clk";
 				status = "disabled";
 				port {
diff --git a/arch/arm/boot/dts/at91sam9x5_lcd.dtsi b/arch/arm/boot/dts/at91sam9x5_lcd.dtsi
index 1629db9dd563..12595fb11691 100644
--- a/arch/arm/boot/dts/at91sam9x5_lcd.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_lcd.dtsi
@@ -17,7 +17,7 @@
 				compatible = "atmel,at91sam9x5-hlcdc";
 				reg = <0xf8038000 0x4000>;
 				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 25>, <&pmc PMC_TYPE_SYSTEM 3>, <&clk32k>;
 				clock-names = "periph_clk","sys_clk", "slow_clk";
 				status = "disabled";
 
@@ -143,23 +143,6 @@
 					};
 				};
 			};
-
-			pmc: pmc@fffffc00 {
-				periphck {
-					lcdc_clk: lcdc_clk {
-						#clock-cells = <0>;
-						reg = <25>;
-					};
-				};
-
-				systemck {
-					lcdck: lcdck {
-						#clock-cells = <0>;
-						reg = <3>;
-						clocks = <&mck>;
-					};
-				};
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9x5_macb0.dtsi b/arch/arm/boot/dts/at91sam9x5_macb0.dtsi
index 73d7e30965ba..57c2e5a4fb53 100644
--- a/arch/arm/boot/dts/at91sam9x5_macb0.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_macb0.dtsi
@@ -43,22 +43,13 @@
 				};
 			};
 
-			pmc: pmc@fffffc00 {
-				periphck {
-					macb0_clk: macb0_clk {
-						#clock-cells = <0>;
-						reg = <24>;
-					};
-				};
-			};
-
 			macb0: ethernet@f802c000 {
 				compatible = "cdns,at91sam9260-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
 				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb0_rmii>;
-				clocks = <&macb0_clk>, <&macb0_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 24>, <&pmc PMC_TYPE_PERIPHERAL 24>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/at91sam9x5_macb1.dtsi b/arch/arm/boot/dts/at91sam9x5_macb1.dtsi
index d81980c40c7d..59b8da87d3c1 100644
--- a/arch/arm/boot/dts/at91sam9x5_macb1.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_macb1.dtsi
@@ -31,22 +31,13 @@
 				};
 			};
 
-			pmc: pmc@fffffc00 {
-				periphck {
-					macb1_clk: macb1_clk {
-						#clock-cells = <0>;
-						reg = <27>;
-					};
-				};
-			};
-
 			macb1: ethernet@f8030000 {
 				compatible = "cdns,at91sam9260-macb", "cdns,macb";
 				reg = <0xf8030000 0x100>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb1_rmii>;
-				clocks = <&macb1_clk>, <&macb1_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 27>, <&pmc PMC_TYPE_PERIPHERAL 27>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
index a32d12b406a3..9102dfbed5d8 100644
--- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
@@ -42,15 +42,6 @@
 				};
 			};
 
-			pmc: pmc@fffffc00 {
-				periphck {
-					usart3_clk: usart3_clk {
-						#clock-cells = <0>;
-						reg = <8>;
-					};
-				};
-			};
-
 			usart3: serial@f8028000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8028000 0x200>;
@@ -60,7 +51,7 @@
 				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(14)>,
 				       <&dma1 1 (AT91_DMA_CFG_PER_ID(15) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
 				dma-names = "tx", "rx";
-				clocks = <&usart3_clk>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				clock-names = "usart";
 				status = "disabled";
 			};
-- 
2.19.1

