Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeBWNio (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:38:44 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48921 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeBWNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:38:38 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v4 07/10] ARM: dts: sun8i: a83t: Add CCI-400 node
Date: Fri, 23 Feb 2018 14:37:39 +0100
Message-Id: <20180223133742.26044-8-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CCI-400 node and control-port on CPUs needed by SMP bringup.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 3eae3c27e04d..84d6c7738125 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -64,48 +64,56 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu@100 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0x100>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu@101 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0x101>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu@102 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0x102>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu@103 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0x103>;
+			cci-control-port = <&cci_control1>;
 		};
 	};
 
@@ -236,6 +244,39 @@
 			reg = <0x01700000 0x400>;
 		};
 
+		cci@1790000 {
+			compatible = "arm,cci-400";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x01790000 0x10000>;
+			ranges = <0x0 0x01790000 0x10000>;
+
+			cci_control0: slave-if@4000 {
+				compatible = "arm,cci-400-ctrl-if";
+				interface-type = "ace";
+				reg = <0x4000 0x1000>;
+			};
+
+			cci_control1: slave-if@5000 {
+				compatible = "arm,cci-400-ctrl-if";
+				interface-type = "ace";
+				reg = <0x5000 0x1000>;
+			};
+
+			pmu@9000 {
+				compatible = "arm,cci-400-pmu,r1";
+				reg = <0x9000 0x5000>;
+				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		syscon: syscon@1c00000 {
 			compatible = "allwinner,sun8i-a83t-system-controller",
 				"syscon";
-- 
2.11.0
