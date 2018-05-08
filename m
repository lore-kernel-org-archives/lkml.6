Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933199AbeEHIZA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933111AbeEHIY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:24:57 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 1/3] ARM: dts: tegra: Remove skeleton.dtsi and fix DTC warnings for /memory
Date: Tue,  8 May 2018 10:24:39 +0200
Message-Id: <1525767881-28516-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525767881-28516-1-git-send-email-krzk@kernel.org>
References: <1525767881-28516-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the usage of skeleton.dtsi and add necessary properties to /memory
node to fix the DTC warnings:

    arch/arm/boot/dts/tegra20-harmony.dtb: Warning (unit_address_vs_reg):
        /memory: node has a reg or ranges property, but no unit name

The DTB after the change is the same as before except adding
unit-address to /memory node.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/tegra114-dalmore.dts      | 3 ++-
 arch/arm/boot/dts/tegra114-roth.dts         | 3 ++-
 arch/arm/boot/dts/tegra114-tn7.dts          | 3 ++-
 arch/arm/boot/dts/tegra114.dtsi             | 4 ++--
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 3 ++-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 3 ++-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts   | 3 ++-
 arch/arm/boot/dts/tegra124-nyan.dtsi        | 3 ++-
 arch/arm/boot/dts/tegra124-venice2.dts      | 3 ++-
 arch/arm/boot/dts/tegra124.dtsi             | 2 --
 arch/arm/boot/dts/tegra20-colibri-512.dtsi  | 3 ++-
 arch/arm/boot/dts/tegra20-harmony.dts       | 3 ++-
 arch/arm/boot/dts/tegra20-paz00.dts         | 3 ++-
 arch/arm/boot/dts/tegra20-seaboard.dts      | 3 ++-
 arch/arm/boot/dts/tegra20-tamonten.dtsi     | 3 ++-
 arch/arm/boot/dts/tegra20-trimslice.dts     | 3 ++-
 arch/arm/boot/dts/tegra20-ventana.dts       | 3 ++-
 arch/arm/boot/dts/tegra20.dtsi              | 7 +++++--
 arch/arm/boot/dts/tegra30-apalis.dtsi       | 5 +++++
 arch/arm/boot/dts/tegra30-beaver.dts        | 3 ++-
 arch/arm/boot/dts/tegra30-cardhu.dtsi       | 3 ++-
 arch/arm/boot/dts/tegra30-colibri.dtsi      | 3 ++-
 arch/arm/boot/dts/tegra30.dtsi              | 7 +++++--
 23 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index eafff16765b4..5cdcedfc19cb 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -23,7 +23,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts
index 7ed7370ee67a..b4f329a07c60 100644
--- a/arch/arm/boot/dts/tegra114-roth.dts
+++ b/arch/arm/boot/dts/tegra114-roth.dts
@@ -28,7 +28,8 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
+		device_type = "memory";
 		/* memory >= 0x79600000 is reserved for firmware usage */
 		reg = <0x80000000 0x79600000>;
 	};
diff --git a/arch/arm/boot/dts/tegra114-tn7.dts b/arch/arm/boot/dts/tegra114-tn7.dts
index 7fc4a8b31e45..12092d344ce8 100644
--- a/arch/arm/boot/dts/tegra114-tn7.dts
+++ b/arch/arm/boot/dts/tegra114-tn7.dts
@@ -28,7 +28,8 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
+		device_type = "memory";
 		/* memory >= 0x37e00000 is reserved for firmware usage */
 		reg = <0x80000000 0x37e00000>;
 	};
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 0e4a13295d8a..b917784d3f97 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -5,11 +5,11 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "nvidia,tegra114";
 	interrupt-parent = <&lic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	host1x@50000000 {
 		compatible = "nvidia,tegra114-host1x", "simple-bus";
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index bb67edb016c5..80b52c612891 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -15,7 +15,8 @@
 	compatible = "toradex,apalis-tk1-v1.2", "toradex,apalis-tk1",
 		     "nvidia,tegra124";
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 65a2161b9b8e..3ca7601cafe9 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -50,7 +50,8 @@
 	model = "Toradex Apalis TK1";
 	compatible = "toradex,apalis-tk1", "nvidia,tegra124";
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 6dbcf84dafbc..8d9e6ee6c6a7 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -24,7 +24,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 3609367037a6..15a2b0e3237e 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -13,7 +13,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 89bcc178994d..241cdc4b6600 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -18,7 +18,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 174092bfac90..df1642876a4c 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -7,8 +7,6 @@
 #include <dt-bindings/reset/tegra124-car.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "nvidia,tegra124";
 	interrupt-parent = <&lic>;
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 5c202b3e3bb1..305efb275b48 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -10,7 +10,8 @@
 		rtc1 = "/rtc@7000e000";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 628a55a9318b..5009a55ae15c 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -18,7 +18,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x00000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 30436969adc0..e794ac5442ef 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -19,7 +19,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 284aae351ff2..6cb832cfa4f3 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -18,7 +18,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x00000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 872046d48709..6ceb1228fed3 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -15,7 +15,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index d55c6b240a30..3f94be3da9e5 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -18,7 +18,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x00000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index ee3fbf941e79..c897a90289bc 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -18,7 +18,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@0 {
+		device_type = "memory";
 		reg = <0x00000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 0a7136462a1a..290ebbeb210f 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -4,11 +4,14 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "nvidia,tegra20";
 	interrupt-parent = <&lic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen { };
+	aliases { };
 
 	iram@40000000 {
 		compatible = "mmio-sram";
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index d1d21ec2a844..184f60c720fa 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -10,6 +10,11 @@
 	model = "Toradex Apalis T30";
 	compatible = "toradex,apalis_t30", "nvidia,tegra30";
 
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
 	pcie@3000 {
 		avdd-pexa-supply = <&vdd2_reg>;
 		vdd-pexa-supply = <&vdd2_reg>;
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index ae52a5039506..72369877d284 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -17,7 +17,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x7ff00000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 92a9740c533f..24c04d4c335d 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -40,7 +40,8 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c44d8c40c410..cc46cedf80b9 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -10,7 +10,8 @@
 	model = "Toradex Colibri T30";
 	compatible = "toradex,colibri_t30", "nvidia,tegra30";
 
-	memory {
+	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index a110cf84d85f..4383f0fd789d 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -5,11 +5,14 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "nvidia,tegra30";
 	interrupt-parent = <&lic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen { };
+	aliases { };
 
 	pcie@3000 {
 		compatible = "nvidia,tegra30-pcie";
-- 
2.7.4
