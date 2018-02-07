Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeBGNqt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:46:49 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33020 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754191AbeBGNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:46:12 -0500
X-Google-Smtp-Source: AH8x225lZ5Na0HgBxM1QdMO8dR4lYT/yY9gd3Ds9XJqeeWYy7TRKyXD2vWmfBPhqBuTEZv3UmqmYcg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/7] ARM: dts: da850: add power-domains properties to device nodes
Date: Wed,  7 Feb 2018 14:45:51 +0100
Message-Id: <20180207134553.13510-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Make all devices managed by PSCs use the genpd driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index ac2eef4e6b7c..a2a1a3b7de3c 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -83,6 +83,7 @@
 			ti,intc-size = <101>;
 			reg = <0xfffee000 0x2000>;
 			clocks = <&psc0 6>;
+			power-domains = <&pwc0>;
 		};
 	};
 	clocks: clocks {
@@ -125,6 +126,7 @@
 		interrupt-parent = <&intc>;
 		interrupts = <28>;
 		clocks = <&psc0 15>;
+		power-domains = <&pwc0>;
 		status = "disabled";
 	};
 	soc@1c00000 {
@@ -400,12 +402,14 @@
 				clocks = <&psc1 1>, <&usb_refclkin>,
 					 <&pll0_auxclk>;
 				clock-names = "fck", "usb_refclkin", "auxclk";
+				power-domains = <&pwc1>;
 			};
 			ehrpwm_tbclk: ehrpwm_tbclk {
 				compatible = "ti,da830-tbclksync";
 				#clock-cells = <0>;
 				clocks = <&psc1 17>;
 				clock-names = "fck";
+				power-domains = <&pwc1>;
 			};
 			div4p5_clk: div4.5 {
 				compatible = "ti,da830-div4p5ena";
@@ -439,6 +443,7 @@
 
 			ti,tptcs = <&edma0_tptc0 7>, <&edma0_tptc1 0>;
 			clocks = <&psc0 0>;
+			power-domains = <&pwc0>;
 		};
 		edma0_tptc0: tptc@8000 {
 			compatible = "ti,edma3-tptc";
@@ -446,6 +451,7 @@
 			interrupts = <13>;
 			interrupt-names = "edm3_tcerrint";
 			clocks = <&psc0 1>;
+			power-domains = <&pwc0>;
 		};
 		edma0_tptc1: tptc@8400 {
 			compatible = "ti,edma3-tptc";
@@ -453,6 +459,7 @@
 			interrupts = <32>;
 			interrupt-names = "edm3_tcerrint";
 			clocks = <&psc0 2>;
+			power-domains = <&pwc0>;
 		};
 		edma1: edma@230000 {
 			compatible = "ti,edma3-tpcc";
@@ -465,6 +472,7 @@
 
 			ti,tptcs = <&edma1_tptc0 7>;
 			clocks = <&psc1 0>;
+			power-domains = <&pwc1>;
 		};
 		edma1_tptc0: tptc@238000 {
 			compatible = "ti,edma3-tptc";
@@ -472,6 +480,7 @@
 			interrupts = <95>;
 			interrupt-names = "edm3_tcerrint";
 			clocks = <&psc1 21>;
+			power-domains = <&pwc1>;
 		};
 		serial0: serial@42000 {
 			compatible = "ti,da830-uart", "ns16550a";
@@ -480,6 +489,7 @@
 			reg-shift = <2>;
 			interrupts = <25>;
 			clocks = <&psc0 9>;
+			power-domains = <&pwc0>;
 			status = "disabled";
 		};
 		serial1: serial@10c000 {
@@ -489,6 +499,7 @@
 			reg-shift = <2>;
 			interrupts = <53>;
 			clocks = <&psc1 12>;
+			power-domains = <&pwc1>;
 			status = "disabled";
 		};
 		serial2: serial@10d000 {
@@ -498,6 +509,7 @@
 			reg-shift = <2>;
 			interrupts = <61>;
 			clocks = <&psc1 13>;
+			power-domains = <&pwc1>;
 			status = "disabled";
 		};
 		rtc0: rtc@23000 {
@@ -523,6 +535,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&psc1 11>;
+			power-domains = <&pwc1>;
 			status = "disabled";
 		};
 		clocksource: timer@20000 {
@@ -545,6 +558,7 @@
 			dmas = <&edma0 16 0>, <&edma0 17 0>;
 			dma-names = "rx", "tx";
 			clocks = <&psc0 5>;
+			power-domains = <&pwc0>;
 			status = "disabled";
 		};
 		vpif: video@217000 {
@@ -552,6 +566,7 @@
 			reg = <0x217000 0x1000>;
 			interrupts = <92>;
 			clocks = <&psc1 9>;
+			power-domains = <&pwc1>;
 			status = "disabled";
 
 			/* VPIF capture port */
@@ -575,6 +590,7 @@
 			dmas = <&edma1 28 0>, <&edma1 29 0>;
 			dma-names = "rx", "tx";
 			clocks = <&psc1 18>;
+			power-domains = <&pwc1>;
 			status = "disabled";
 		};
 		ehrpwm0: pwm@300000 {
@@ -585,6 +601,7 @@
 			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
 			clock-names = "fck", "tbclk";
 			status = "disabled";
+			power-domains = <&pwc1>;
 		};
 		ehrpwm1: pwm@302000 {
 			compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
@@ -592,6 +609,7 @@
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
 			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
+			power-domains = <&pwc1>;
 			clock-names = "fck", "tbclk";
 			status = "disabled";
 		};
@@ -601,6 +619,7 @@
 			#pwm-cells = <3>;
 			reg = <0x306000 0x80>;
 			clocks = <&psc1 20>;
+			power-domains = <&pwc1>;
 			clock-names = "fck";
 			status = "disabled";
 		};
@@ -610,6 +629,7 @@
 			#pwm-cells = <3>;
 			reg = <0x307000 0x80>;
 			clocks = <&psc1 20>;
+			power-domains = <&pwc1>;
 			clock-names = "fck";
 			status = "disabled";
 		};
@@ -619,6 +639,7 @@
 			#pwm-cells = <3>;
 			reg = <0x308000 0x80>;
 			clocks = <&psc1 20>;
+			power-domains = <&pwc1>;
 			clock-names = "fck";
 			status = "disabled";
 		};
@@ -633,6 +654,7 @@
 			dmas = <&edma0 14 0>, <&edma0 15 0>;
 			dma-names = "rx", "tx";
 			clocks = <&psc0 4>;
+			power-domains = <&pwc0>;
 			status = "disabled";
 		};
 		spi1: spi@30e000 {
@@ -646,6 +668,7 @@
 			dmas = <&edma0 18 0>, <&edma0 19 0>;
 			dma-names = "rx", "tx";
 			clocks = <&psc1 10>;
+			power-domains = <&pwc1>;
 			status = "disabled";
 		};
 		usb0: usb@200000 {
@@ -658,6 +681,7 @@
 			phys = <&usb_phy 0>;
 			phy-names = "usb-phy";
 			clocks = <&psc1 1>;
+			power-domains = <&pwc1>;
 			status = "disabled";
 
 			#address-cells = <1>;
@@ -682,6 +706,7 @@
 				#dma-cells = <2>;
 				#dma-channels = <4>;
 				clocks = <&psc1 1>;
+				power-domains = <&pwc1>;
 				status = "okay";
 			};
 		};
@@ -690,6 +715,7 @@
 			reg = <0x218000 0x2000>, <0x22c018 0x4>;
 			interrupts = <67>;
 			clocks = <&psc1 8>, <&sata_refclk>;
+			power-domains = <&pwc1>;
 			clock-names = "fck", "refclk";
 			status = "disabled";
 		};
@@ -713,6 +739,7 @@
 			reg = <0x224000 0x1000>;
 			clocks = <&psc1 5>;
 			clock-names = "fck";
+			power-domains = <&pwc1>;
 			status = "disabled";
 		};
 		eth0: ethernet@220000 {
@@ -729,6 +756,7 @@
 					36
 					>;
 			clocks = <&psc1 5>;
+			power-domains = <&pwc1>;
 			status = "disabled";
 		};
 		usb1: usb@225000 {
@@ -738,6 +766,7 @@
 			phys = <&usb_phy 1>;
 			phy-names = "usb-phy";
 			clocks = <&psc1 2>;
+			power-domains = <&pwc1>;
 			status = "disabled";
 		};
 		gpio: gpio@226000 {
@@ -756,6 +785,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			clocks = <&psc1 3>;
+			power-domains = <&pwc1>;
 			clock-names = "gpio";
 		};
 		psc1: clock-controller@227000 {
@@ -788,6 +818,7 @@
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
 			clocks = <&psc1 7>;
+			power-domains = <&pwc1>;
 		};
 
 		lcdc: display@213000 {
@@ -797,6 +828,7 @@
 			max-pixelclock = <37500>;
 			clocks = <&psc1 16>;
 			clock-names = "fck";
+			power-domains = <&pwc1>;
 			status = "disabled";
 		};
 	};
@@ -809,6 +841,7 @@
 		ranges = <0 0 0x60000000 0x08000000
 			  1 0 0x68000000 0x00008000>;
 		clocks = <&psc0 3>;
+		power-domains = <&pwc0>;
 		status = "disabled";
 	};
 	memctrl: memory-controller@b0000000 {
-- 
2.16.1
