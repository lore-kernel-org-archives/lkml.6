Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A99C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4552D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4552D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeJPWNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:13:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48191 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbeJPWNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0075C20379; Tue, 16 Oct 2018 16:22:22 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B0E7520DCD;
        Tue, 16 Oct 2018 16:22:02 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 08/22] dt-bindings: clk: at91: Document new PMC binding
Date:   Tue, 16 Oct 2018 16:21:46 +0200
Message-Id: <20181016142200.19741-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new PMC binding with only one PMC node for all the PMC clocks
instead of one node per clock as this proved to be problematic.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/clock/at91-clock.txt  | 516 +-----------------
 1 file changed, 21 insertions(+), 495 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 8f8f95056f3d..e9f70fcdfe80 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -4,6 +4,8 @@ This binding uses the common clock binding[1].
 
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 
+Slow Clock controller:
+
 Required properties:
 - compatible : shall be one of the following:
 	"atmel,at91sam9x5-sckc" or
@@ -16,84 +18,6 @@ Required properties:
 
 	"atmel,at91sam9x5-clk-slow-rc-osc":
 		at91 internal slow RC oscillator
-
-	"atmel,<chip>-pmc":
-		at91 PMC (Power Management Controller)
-		All at91 specific clocks (clocks defined below) must be child
-		node of the PMC node.
-		<chip> can be: at91rm9200, at91sam9260, at91sam9261,
-		at91sam9263, at91sam9g45, at91sam9n12, at91sam9rl, at91sam9x5,
-		sama5d2, sama5d3 or sama5d4.
-
-	"atmel,at91sam9x5-clk-slow" (under sckc node)
-	or
-	"atmel,at91sam9260-clk-slow" (under pmc node):
-		at91 slow clk
-
-	"atmel,at91rm9200-clk-main-osc"
-	"atmel,at91sam9x5-clk-main-rc-osc"
-		at91 main clk sources
-
-	"atmel,at91sam9x5-clk-main"
-	"atmel,at91rm9200-clk-main":
-		at91 main clock
-
-	"atmel,at91rm9200-clk-master" or
-	"atmel,at91sam9x5-clk-master":
-		at91 master clock
-
-	"atmel,at91sam9x5-clk-peripheral" or
-	"atmel,at91rm9200-clk-peripheral":
-		at91 peripheral clocks
-
-	"atmel,at91rm9200-clk-pll" or
-	"atmel,at91sam9g45-clk-pll" or
-	"atmel,at91sam9g20-clk-pllb" or
-	"atmel,sama5d3-clk-pll":
-		at91 pll clocks
-
-	"atmel,at91sam9x5-clk-plldiv":
-		at91 plla divisor
-
-	"atmel,at91rm9200-clk-programmable" or
-	"atmel,at91sam9g45-clk-programmable" or
-	"atmel,at91sam9x5-clk-programmable":
-		at91 programmable clocks
-
-	"atmel,at91sam9x5-clk-smd":
-		at91 SMD (Soft Modem) clock
-
-	"atmel,at91rm9200-clk-system":
-		at91 system clocks
-
-	"atmel,at91rm9200-clk-usb" or
-	"atmel,at91sam9x5-clk-usb" or
-	"atmel,at91sam9n12-clk-usb":
-		at91 usb clock
-
-	"atmel,at91sam9x5-clk-utmi":
-		at91 utmi clock
-
-	"atmel,sama5d4-clk-h32mx":
-		at91 h32mx clock
-
-	"atmel,sama5d2-clk-generated":
-		at91 generated clock
-
-	"atmel,sama5d2-clk-audio-pll-frac":
-		at91 audio fractional pll
-
-	"atmel,sama5d2-clk-audio-pll-pad":
-		at91 audio pll CLK_AUDIO output pin
-
-	"atmel,sama5d2-clk-audio-pll-pmc"
-		at91 audio pll output on AUDIOPLLCLK that feeds the PMC
-		and can be used by peripheral clock or generic clock
-
-	"atmel,sama5d2-clk-i2s-mux" (under pmc node):
-		at91 I2S clock source selection
-
-Required properties for SCKC node:
 - reg : defines the IO memory reserved for the SCKC.
 - #size-cells : shall be 0 (reg is used to encode clk id).
 - #address-cells : shall be 1 (reg is used to encode clk id).
@@ -109,428 +33,30 @@ For example:
 		/* put at91 slow clocks here */
 	};
 
+Power Management Controller (PMC):
 
-Required properties for internal slow RC oscillator:
-- #clock-cells : from common clock binding; shall be set to 0.
-- clock-frequency : define the internal RC oscillator frequency.
-
-Optional properties:
-- clock-accuracy : define the internal RC oscillator accuracy.
-
-For example:
-	slow_rc_osc: slow_rc_osc {
-		compatible = "atmel,at91sam9x5-clk-slow-rc-osc";
-		clock-frequency = <32768>;
-		clock-accuracy = <50000000>;
-	};
-
-Required properties for slow oscillator:
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall encode the main osc source clk sources (see atmel datasheet).
+Required properties:
+- compatible : shall be "atmel,<chip>-pmc", "syscon":
+	<chip> can be: at91rm9200, at91sam9260, at91sam9261,
+	at91sam9263, at91sam9g45, at91sam9n12, at91sam9rl, at91sam9g15,
+	at91sam9g25, at91sam9g35, at91sam9x25, at91sam9x35, at91sam9x5,
+	sama5d2, sama5d3 or sama5d4.
+- #clock-cells : from common clock binding; shall be set to 2. The first entry
+  is the type of the clock (core, system, peripheral or generated) and the
+  second entry its index as provided by the datasheet
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names: Must include the following entries: "slow_clk", "main_xtal"
 
 Optional properties:
 - atmel,osc-bypass : boolean property. Set this when a clock signal is directly
   provided on XIN.
 
 For example:
-	slow_osc: slow_osc {
-		compatible = "atmel,at91rm9200-clk-slow-osc";
-		#clock-cells = <0>;
-		clocks = <&slow_xtal>;
-	};
-
-Required properties for slow clock:
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall encode the slow clk sources (see atmel datasheet).
-
-For example:
-	clk32k: slck {
-		compatible = "atmel,at91sam9x5-clk-slow";
-		#clock-cells = <0>;
-		clocks = <&slow_rc_osc &slow_osc>;
-	};
-
-Required properties for PMC node:
-- reg : defines the IO memory reserved for the PMC.
-- #size-cells : shall be 0 (reg is used to encode clk id).
-- #address-cells : shall be 1 (reg is used to encode clk id).
-- interrupts : shall be set to PMC interrupt line.
-- interrupt-controller : tell that the PMC is an interrupt controller.
-- #interrupt-cells : must be set to 1. The first cell encodes the interrupt id,
-	and reflect the bit position in the PMC_ER/DR/SR registers.
-	You can use the dt macros defined in dt-bindings/clock/at91.h.
-	0 (AT91_PMC_MOSCS) -> main oscillator ready
-	1 (AT91_PMC_LOCKA) -> PLL A ready
-	2 (AT91_PMC_LOCKB) -> PLL B ready
-	3 (AT91_PMC_MCKRDY) -> master clock ready
-	6 (AT91_PMC_LOCKU) -> UTMI PLL clock ready
-	8 .. 15 (AT91_PMC_PCKRDY(id)) -> programmable clock ready
-	16 (AT91_PMC_MOSCSELS) -> main oscillator selected
-	17 (AT91_PMC_MOSCRCS) -> RC main oscillator stabilized
-	18 (AT91_PMC_CFDEV) -> clock failure detected
-
-For example:
-	pmc: pmc@fffffc00 {
-		compatible = "atmel,sama5d3-pmc";
-		interrupts = <1 4 7>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		/* put at91 clocks here */
-	};
-
-Required properties for main clock internal RC oscillator:
-- interrupts : shall be set to "<0>".
-- clock-frequency : define the internal RC oscillator frequency.
-
-Optional properties:
-- clock-accuracy : define the internal RC oscillator accuracy.
-
-For example:
-	main_rc_osc: main_rc_osc {
-		compatible = "atmel,at91sam9x5-clk-main-rc-osc";
-		interrupt-parent = <&pmc>;
-		interrupts = <0>;
-		clock-frequency = <12000000>;
-		clock-accuracy = <50000000>;
-	};
-
-Required properties for main clock oscillator:
-- interrupts : shall be set to "<0>".
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall encode the main osc source clk sources (see atmel datasheet).
-
-Optional properties:
-- atmel,osc-bypass : boolean property. Specified if a clock signal is provided
-  on XIN.
-
-  clock signal is directly provided on XIN pin.
-
-For example:
-	main_osc: main_osc {
-		compatible = "atmel,at91rm9200-clk-main-osc";
-		interrupt-parent = <&pmc>;
-		interrupts = <0>;
-		#clock-cells = <0>;
-		clocks = <&main_xtal>;
-	};
-
-Required properties for main clock:
-- interrupts : shall be set to "<0>".
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall encode the main clk sources (see atmel datasheet).
-
-For example:
-	main: mainck {
-		compatible = "atmel,at91sam9x5-clk-main";
-		interrupt-parent = <&pmc>;
-		interrupts = <0>;
-		#clock-cells = <0>;
-		clocks = <&main_rc_osc &main_osc>;
-	};
-
-Required properties for master clock:
-- interrupts : shall be set to "<3>".
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall be the master clock sources (see atmel datasheet) phandles.
-	e.g. "<&ck32k>, <&main>, <&plla>, <&pllb>".
-- atmel,clk-output-range : minimum and maximum clock frequency (two u32
-			   fields).
-	   e.g. output = <0 133000000>; <=> 0 to 133MHz.
-- atmel,clk-divisors : master clock divisors table (four u32 fields).
-		0 <=> reserved value.
-		e.g. divisors = <1 2 4 6>;
-- atmel,master-clk-have-div3-pres : some SoC use the reserved value 7 in the
-				    PRES field as CLOCK_DIV3 (e.g sam9x5).
-
-For example:
-	mck: mck {
-		compatible = "atmel,at91rm9200-clk-master";
-		interrupt-parent = <&pmc>;
-		interrupts = <3>;
-		#clock-cells = <0>;
-		atmel,clk-output-range = <0 133000000>;
-		atmel,clk-divisors = <1 2 4 0>;
-	};
-
-Required properties for peripheral clocks:
-- #size-cells : shall be 0 (reg is used to encode clk id).
-- #address-cells : shall be 1 (reg is used to encode clk id).
-- clocks : shall be the master clock phandle.
-	e.g. clocks = <&mck>;
-- name: device tree node describing a specific peripheral clock.
-	* #clock-cells : from common clock binding; shall be set to 0.
-	* reg: peripheral id. See Atmel's datasheets to get a full
-	  list of peripheral ids.
-	* atmel,clk-output-range : minimum and maximum clock frequency
-	  (two u32 fields). Only valid on at91sam9x5-clk-peripheral
-	  compatible IPs.
-
-For example:
-	periph: periphck {
-		compatible = "atmel,at91sam9x5-clk-peripheral";
-		#size-cells = <0>;
-		#address-cells = <1>;
-		clocks = <&mck>;
-
-		ssc0_clk {
-			#clock-cells = <0>;
-			reg = <2>;
-			atmel,clk-output-range = <0 133000000>;
-		};
-
-		usart0_clk {
-			#clock-cells = <0>;
-			reg = <3>;
-			atmel,clk-output-range = <0 66000000>;
-		};
-	};
-
-
-Required properties for pll clocks:
-- interrupts : shall be set to "<1>".
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall be the main clock phandle.
-- reg : pll id.
-	0 -> PLL A
-	1 -> PLL B
-- atmel,clk-input-range : minimum and maximum source clock frequency (two u32
-			  fields).
-	  e.g. input = <1 32000000>; <=> 1 to 32MHz.
-- #atmel,pll-clk-output-range-cells : number of cells reserved for pll output
-				      range description. Sould be set to 2, 3
-				      or 4.
-	* 1st and 2nd cells represent the frequency range (min-max).
-	* 3rd cell is optional and represents the OUT field value for the given
-	  range.
-	* 4th cell is optional and represents the ICPLL field (PLLICPR
-	  register)
-- atmel,pll-clk-output-ranges : pll output frequency ranges + optional parameter
-				depending on #atmel,pll-output-range-cells
-				property value.
-
-For example:
-	plla: pllack {
-		compatible = "atmel,at91sam9g45-clk-pll";
-		interrupt-parent = <&pmc>;
-		interrupts = <1>;
-		#clock-cells = <0>;
-		clocks = <&main>;
-		reg = <0>;
-		atmel,clk-input-range = <2000000 32000000>;
-		#atmel,pll-clk-output-range-cells = <4>;
-		atmel,pll-clk-output-ranges = <74500000 800000000 0 0
-					       69500000 750000000 1 0
-					       64500000 700000000 2 0
-					       59500000 650000000 3 0
-					       54500000 600000000 0 1
-					       49500000 550000000 1 1
-					       44500000 500000000 2 1
-					       40000000 450000000 3 1>;
-	};
-
-Required properties for plldiv clocks (plldiv = pll / 2):
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall be the plla clock phandle.
-
-The pll divisor is equal to 2 and cannot be changed.
-
-For example:
-	plladiv: plladivck {
-		compatible = "atmel,at91sam9x5-clk-plldiv";
-		#clock-cells = <0>;
-		clocks = <&plla>;
-	};
-
-Required properties for programmable clocks:
-- #size-cells : shall be 0 (reg is used to encode clk id).
-- #address-cells : shall be 1 (reg is used to encode clk id).
-- clocks : shall be the programmable clock source phandles.
-	e.g. clocks = <&clk32k>, <&main>, <&plla>, <&pllb>;
-- name: device tree node describing a specific prog clock.
-	* #clock-cells : from common clock binding; shall be set to 0.
-	* reg : programmable clock id (register offset from  PCKx
-			 register).
-	* interrupts : shall be set to "<(8 + id)>".
-
-For example:
-	prog: progck {
-		compatible = "atmel,at91sam9g45-clk-programmable";
-		#size-cells = <0>;
-		#address-cells = <1>;
-		interrupt-parent = <&pmc>;
-		clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
-
-		prog0 {
-			#clock-cells = <0>;
-			reg = <0>;
-			interrupts = <8>;
-		};
-
-		prog1 {
-			#clock-cells = <0>;
-			reg = <1>;
-			interrupts = <9>;
-		};
-	};
-
-
-Required properties for smd clock:
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall be the smd clock source phandles.
-	e.g. clocks = <&plladiv>, <&utmi>;
-
-For example:
-	smd: smdck {
-		compatible = "atmel,at91sam9x5-clk-smd";
-		#clock-cells = <0>;
-		clocks = <&plladiv>, <&utmi>;
-	};
-
-Required properties for system clocks:
-- #size-cells : shall be 0 (reg is used to encode clk id).
-- #address-cells : shall be 1 (reg is used to encode clk id).
-- name: device tree node describing a specific system clock.
-	* #clock-cells : from common clock binding; shall be set to 0.
-	* reg: system clock id (bit position in SCER/SCDR/SCSR registers).
-	      See Atmel's datasheet to get a full list of system clock ids.
-
-For example:
-	system: systemck {
-		compatible = "atmel,at91rm9200-clk-system";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ddrck {
-			#clock-cells = <0>;
-			reg = <2>;
-			clocks = <&mck>;
-		};
-
-		uhpck {
-			#clock-cells = <0>;
-			reg = <6>;
-			clocks = <&usb>;
-		};
-
-		udpck {
-			#clock-cells = <0>;
-			reg = <7>;
-			clocks = <&usb>;
-		};
-	};
-
-
-Required properties for usb clock:
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall be the smd clock source phandles.
-	e.g. clocks = <&pllb>;
-- atmel,clk-divisors (only available for "atmel,at91rm9200-clk-usb"):
-	usb clock divisor table.
-	e.g. divisors = <1 2 4 0>;
-
-For example:
-	usb: usbck {
-		compatible = "atmel,at91sam9x5-clk-usb";
-		#clock-cells = <0>;
-		clocks = <&plladiv>, <&utmi>;
-	};
-
-	usb: usbck {
-		compatible = "atmel,at91rm9200-clk-usb";
-		#clock-cells = <0>;
-		clocks = <&pllb>;
-		atmel,clk-divisors = <1 2 4 0>;
-	};
-
-
-Required properties for utmi clock:
-- interrupts : shall be set to "<AT91_PMC_LOCKU IRQ_TYPE_LEVEL_HIGH>".
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall be the main clock source phandle.
-
-For example:
-	utmi: utmick {
-		compatible = "atmel,at91sam9x5-clk-utmi";
-		interrupt-parent = <&pmc>;
-		interrupts = <AT91_PMC_LOCKU IRQ_TYPE_LEVEL_HIGH>;
-		#clock-cells = <0>;
-		clocks = <&main>;
-	};
-
-Required properties for 32 bits bus Matrix clock (h32mx clock):
-- #clock-cells : from common clock binding; shall be set to 0.
-- clocks : shall be the master clock source phandle.
-
-For example:
-	h32ck: h32mxck {
-		#clock-cells = <0>;
-		compatible = "atmel,sama5d4-clk-h32mx";
-		clocks = <&mck>;
-	};
-
-Required properties for generated clocks:
-- #size-cells : shall be 0 (reg is used to encode clk id).
-- #address-cells : shall be 1 (reg is used to encode clk id).
-- clocks : shall be the generated clock source phandles.
-	e.g. clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>, <&audio_pll_pmc>;
-- name: device tree node describing a specific generated clock.
-	* #clock-cells : from common clock binding; shall be set to 0.
-	* reg: peripheral id. See Atmel's datasheets to get a full
-	  list of peripheral ids.
-	* atmel,clk-output-range : minimum and maximum clock frequency
-	  (two u32 fields).
-
-For example:
-	gck {
-		compatible = "atmel,sama5d2-clk-generated";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>, <&audio_pll_pmc>;
-
-		tcb0_gclk: tcb0_gclk {
-			#clock-cells = <0>;
-			reg = <35>;
-			atmel,clk-output-range = <0 83000000>;
-		};
-
-		pwm_gclk: pwm_gclk {
-			#clock-cells = <0>;
-			reg = <38>;
-			atmel,clk-output-range = <0 83000000>;
-		};
-	};
-
-Required properties for I2S mux clocks:
-- #size-cells : shall be 0 (reg is used to encode I2S bus id).
-- #address-cells : shall be 1 (reg is used to encode I2S bus id).
-- name: device tree node describing a specific mux clock.
-	* #clock-cells : from common clock binding; shall be set to 0.
-	* clocks : shall be the mux clock parent phandles; shall be 2 phandles:
-	  peripheral and generated clock; the first phandle shall belong to the
-	  peripheral clock and the second one shall belong to the generated
-	  clock; "clock-indices" property can be user to specify
-	  the correct order.
-	* reg: I2S bus id of the corresponding mux clock.
-	  e.g. reg = <0>; for i2s0, reg = <1>; for i2s1
-
-For example:
-	i2s_clkmux {
-		compatible = "atmel,sama5d2-clk-i2s-mux";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		i2s0muxck: i2s0_muxclk {
-			clocks = <&i2s0_clk>, <&i2s0_gclk>;
-			#clock-cells = <0>;
-			reg = <0>;
-		};
-
-		i2s1muxck: i2s1_muxclk {
-			clocks = <&i2s1_clk>, <&i2s1_gclk>;
-			#clock-cells = <0>;
-			reg = <1>;
-		};
+	pmc: pmc@f0018000 {
+		compatible = "atmel,sama5d4-pmc", "syscon";
+		reg = <0xf0018000 0x120>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+		#clock-cells = <2>;
+		clocks = <&clk32k>, <&main_xtal>;
+		clock-names = "slow_clk", "main_xtal";
 	};
-- 
2.19.1

