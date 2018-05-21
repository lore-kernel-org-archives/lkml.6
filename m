Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeEUT6u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:58:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:51594 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbeEUT6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:58:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,427,1520924400";
   d="scan'208";a="43589719"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [v4 05/11] ARM: dts: aspeed: peci: Add PECI node
Date: Mon, 21 May 2018 12:58:46 -0700
Message-Id: <20180521195846.27894-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds PECI bus/adapter node of AST24xx/AST25xx into
aspeed-g4 and aspeed-g5.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: Jason M Biils <jason.m.bills@linux.intel.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 518d2bc7c7fc..c101601429b4 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -29,6 +29,7 @@
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
+		peci0 = &peci0;
 	};
 
 	cpus {
@@ -270,6 +271,13 @@
 				};
 			};
 
+			peci: peci@1e78b000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e78b000 0x60>;
+			};
+
 			uart2: serial@1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
@@ -313,6 +321,24 @@
 	};
 };
 
+&peci {
+	peci0: peci-bus@0 {
+		compatible = "aspeed,ast2400-peci";
+		reg = <0x0 0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <15>;
+		clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+		resets = <&syscon ASPEED_RESET_PECI>;
+		clock-frequency = <24000000>;
+		msg-timing = <1>;
+		addr-timing = <1>;
+		rd-sampling-point = <8>;
+		cmd-timeout-ms = <1000>;
+		status = "disabled";
+	};
+};
+
 &i2c {
 	i2c_ic: interrupt-controller@0 {
 		#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index f9917717dd08..0c4850c3f456 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -29,6 +29,7 @@
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
+		peci0 = &peci0;
 	};
 
 	cpus {
@@ -320,6 +321,13 @@
 				};
 			};
 
+			peci: peci@1e78b000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e78b000 0x60>;
+			};
+
 			uart2: serial@1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
@@ -363,6 +371,24 @@
 	};
 };
 
+&peci {
+	peci0: peci-bus@0 {
+		compatible = "aspeed,ast2500-peci";
+		reg = <0x0 0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <15>;
+		clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+		resets = <&syscon ASPEED_RESET_PECI>;
+		clock-frequency = <24000000>;
+		msg-timing = <1>;
+		addr-timing = <1>;
+		rd-sampling-point = <8>;
+		cmd-timeout-ms = <1000>;
+		status = "disabled";
+	};
+};
+
 &i2c {
 	i2c_ic: interrupt-controller@0 {
 		#interrupt-cells = <1>;
-- 
2.17.0
