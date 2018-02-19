Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeBSHf5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 02:35:57 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45687 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeBSHfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 02:35:55 -0500
X-Google-Smtp-Source: AH8x226zvWDVxRj608YPMH4+azfJlAb5KNEopTZBZlDCRPvw9uD0eabh3yCUfwSQXBuzoNSVgay1rw==
From: Joel Stanley <joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH] ARM: dts: aspeed: Add LPC reset controller node
Date: Mon, 19 Feb 2018 18:05:40 +1030
Message-Id: <20180219073540.24520-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On both the ast2400 and ast2500 SoCs, the LPC reset controller is
required to bring the UARTs out of reset without waiting for the LPC
reset to be deasserted.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Bindings and driver change is under reivew:
  https://lkml.org/lkml/2018/2/19/12

 arch/arm/boot/dts/aspeed-g4.dtsi | 10 ++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 48c28a71ae7e..36ae23aa3b48 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -162,6 +162,7 @@
 				reg-shift = <2>;
 				interrupts = <9>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+				resets = <&lpc_reset 4>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -249,6 +250,12 @@
 						reg = <0x20 0x24 0x48 0x8>;
 					};
 
+					lpc_reset: reset-controller@18 {
+						compatible = "aspeed,ast2400-lpc-reset";
+						reg = <0x18 0x4>;
+						#reset-cells = <1>;
+					};
+
 					ibt: ibt@c0  {
 						compatible = "aspeed,ast2400-ibt-bmc";
 						reg = <0xc0 0x18>;
@@ -264,6 +271,7 @@
 				reg-shift = <2>;
 				interrupts = <32>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
+				resets = <&lpc_reset 5>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -274,6 +282,7 @@
 				reg-shift = <2>;
 				interrupts = <33>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
+				resets = <&lpc_reset 6>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -284,6 +293,7 @@
 				reg-shift = <2>;
 				interrupts = <34>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
+				resets = <&lpc_reset 7>;
 				no-loopback-test;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 8eac57c33880..17ee0fa33a14 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -205,6 +205,7 @@
 				reg-shift = <2>;
 				interrupts = <9>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+				resets = <&lpc_reset 4>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -299,6 +300,12 @@
 						reg = <0x20 0x24 0x48 0x8>;
 					};
 
+					lpc_reset: reset-controller@18 {
+						compatible = "aspeed,ast2500-lpc-reset";
+						reg = <0x18 0x4>;
+						#reset-cells = <1>;
+					};
+
 					ibt: ibt@c0 {
 						compatible = "aspeed,ast2500-ibt-bmc";
 						reg = <0xc0 0x18>;
@@ -314,6 +321,7 @@
 				reg-shift = <2>;
 				interrupts = <32>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
+				resets = <&lpc_reset 5>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -324,6 +332,7 @@
 				reg-shift = <2>;
 				interrupts = <33>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
+				resets = <&lpc_reset 6>;
 				no-loopback-test;
 				status = "disabled";
 			};
@@ -334,6 +343,7 @@
 				reg-shift = <2>;
 				interrupts = <34>;
 				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
+				resets = <&lpc_reset 7>;
 				no-loopback-test;
 				status = "disabled";
 			};
-- 
2.15.1
