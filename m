Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeBTRBk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:01:40 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:33964 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeBTRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:01:37 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: arm@kernel.org, Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>, Niklas Cassel <niklass@axis.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] ARM: dts: artpec: add and utilize artpec6 pin controller
Date: Tue, 20 Feb 2018 18:00:46 +0100
Message-Id: <20180220170049.22809-6-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180220170049.22809-1-niklas.cassel@axis.com>
References: <20180220170049.22809-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the pin controller used in the artpec6 SoC,
and start using it for the exising UARTs.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 981aecd27b0b..7a6d8f39823a 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -180,6 +180,32 @@
 		status = "disabled";
 	};
 
+	pinctrl: pinctrl@f801d000 {
+		compatible = "axis,artpec6-pinctrl";
+		reg = <0xf801d000 0x400>;
+
+		pinctrl_uart0: uart0grp {
+			function = "uart0";
+			groups = "uart0grp2";
+			bias-pull-up;
+		};
+		pinctrl_uart1: uart1grp {
+			function = "uart1";
+			groups = "uart1grp0";
+			bias-pull-up;
+		};
+		pinctrl_uart2: uart2grp {
+			function = "uart2";
+			groups = "uart2grp1";
+			bias-pull-up;
+		};
+		pinctrl_uart3: uart3grp {
+			function = "uart3";
+			groups = "uart3grp0";
+			bias-pull-up;
+		};
+	};
+
 	amba@0 {
 		compatible = "simple-bus";
 		#address-cells = <0x1>;
@@ -238,6 +264,8 @@
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart0>;
 			status = "disabled";
 		};
 		uart1: serial@f8037000 {
@@ -247,6 +275,8 @@
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1>;
 			status = "disabled";
 		};
 		uart2: serial@f8038000 {
@@ -256,6 +286,8 @@
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart2>;
 			status = "disabled";
 		};
 		uart3: serial@f8039000 {
@@ -265,6 +297,8 @@
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart3>;
 			status = "disabled";
 		};
 	};
-- 
2.14.2
