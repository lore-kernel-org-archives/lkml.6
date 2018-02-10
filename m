Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeBJBmp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:42:45 -0500
Received: from mout.perfora.net ([74.208.4.197]:39117 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751859AbeBJBmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:42:39 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] apalis_t30/tk1, colibri_t20/t30: fix i2c bus frequencies
Date: Sat, 10 Feb 2018 02:36:36 +0100
Message-Id: <20180210013638.28164-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013638.28164-1-marcel@ziswiler.com>
References: <20180210013638.28164-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:bGwqYmaKXCUw3VsNqeg6aR98RaLL3pz05Cp5vSA/MdvB4JK/Y5R
 IaaYVvM4NYSHUhs9I6xRGGRJgQp031kUPGINb126+3OWz2PP+IXa7bRC4xhtY8kNB24icjb
 2bSZ9cT2oRT8hASl/QPQS7Hs0V7r00cecQlJKQbBB1FUQDHArTCQZEQJN7WatGvy2G6oQtu
 /7fuBw3TboRneDMGj0Xvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:owWtZF+cB6k=:5x4Mj0KBIZd06NyoAubYPr
 BDAsV1bIQKV9e2ajVboPB1twa7yZSn5zqVk2FpJDo9Ta9KzaXMehEKc+b8RrSPkJMtPaGUvDh
 fVSnFsSFIMlsPW3rSNXWu8SZPMKohSa7VgxyXJLPzsAjVa8PVRpWQc+QPdYiFNZh/yP1utrlO
 RbcpiDqIwFH60JriHK5pa8TsEFh1G0J+2AZTtnvkRHeLGIJEJZvpmYhZL3FGxhDcPvCfTzbED
 p32CM4SfyiXVTkQt6Bga47KFl8XjrFSARxdk3MxaMbnnwEzFBaYEvSk3InhY49WJrFjRqkKa7
 VCMyozPiN+VlHQkwoHS5daxGw7EqReKrjzXHMdW+FYO6mVGmZeX3F/xuuolLmu5T7NfJHQWUP
 R1RFwWcvD3jpTuj3a1KkqvvwVAaIZefrC0dBFs0CJwQ5f1CSqxrSKUBPfdRQHg796aVf29+qp
 dus7qFgQPAtxDQdqHAdeuTyN2osD5RtZ+EXoMRG2hi9hRzlWPdWLvSkns/DEGH7MdRGKszGp+
 mf0mUStTRWuFWeVCfVoMfSr92xQCD/RsKTFjbYM4pu6jiqflj6xrNipG3NynEZb66B+zA6Fsb
 gZtqF6De7fqRgCTRaALhY9i9+akTz6HURwf/yYe8/omaXShGvDKS2Chb57FmF32x20ol9VZ8k
 /3EkPy0jLqTEGcOSQdMhpso/D97WTMsXg58v0EEEqJul/01SmzvZDgsZi5ylvUGyEXCUZNmVA
 elQjFTafM4hxOvrztQEbBYJbSo+ueLgG76IzWw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Use a faster speed of 400 kbit/s for regular I2C busses.

Use a slower speed of 10 kbit/s for DDC/EDID to improve reliability.

Use a slower speed of 100 kbit/s for power I2C to be within specs of
the LM95245 temperature sensor.

While at it further annotate I2C pin usage.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-eval.dts    |  5 ++---
 arch/arm/boot/dts/tegra124-apalis.dtsi        |  2 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi    | 16 +++++++++++-----
 arch/arm/boot/dts/tegra30-apalis-eval.dts     |  2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi         |  2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi        |  2 +-
 7 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index ecffcd115fa7..66b6c45ee865 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -105,7 +105,7 @@
 	 */
 	i2c@7000c000 {
 		status = "okay";
-		clock-frequency = <100000>;
+		clock-frequency = <400000>;
 
 		pcie-switch@58 {
 			compatible = "plx,pex8605";
@@ -124,7 +124,6 @@
 	 */
 	hdmi_ddc: i2c@7000c400 {
 		status = "okay";
-		clock-frequency = <100000>;
 	};
 
 	/*
@@ -133,7 +132,7 @@
 	 */
 	i2c@7000c500 {
 		status = "okay";
-		clock-frequency = <100000>;
+		clock-frequency = <400000>;
 	};
 
 	/* I2C4 (DDC): unused */
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 5d9b18ef5af6..7aef8928e115 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1579,7 +1579,7 @@
 	};
 
 	hdmi_ddc: i2c@7000c400 {
-		clock-frequency = <100000>;
+		clock-frequency = <10000>;
 	};
 
 	/* PWR_I2C: power I2C to audio codec, PMIC and temperature sensor */
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 813ae34edd6a..5c202b3e3bb1 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -213,21 +213,27 @@
 			GPIO_ACTIVE_HIGH>;
 	};
 
+	/*
+	 * GEN1_I2C: I2C_SDA/SCL on SODIMM pin 194/196 (e.g. RTC on carrier
+	 * board)
+	 */
 	i2c@7000c000 {
 		clock-frequency = <400000>;
 	};
 
+	/* DDC_SCL/SDA on X3 pin 15/16 (e.g. display EDID) */
 	i2c_ddc: i2c@7000c400 {
-		clock-frequency = <100000>;
+		clock-frequency = <10000>;
 	};
 
-	i2c@7000c500 {
-		clock-frequency = <400000>;
-	};
+	/* GEN2_I2C: unused */
 
+	/* CAM/GEN3_I2C: used as EXT_IO1/2 GPIOs on SODIMM pin 133/127 */
+
+	/* PWR_I2C: power I2C to PMIC and temperature sensor (On-module) */
 	i2c@7000d000 {
 		status = "okay";
-		clock-frequency = <400000>;
+		clock-frequency = <100000>;
 
 		pmic: tps6586x@34 {
 			compatible = "ti,tps6586x";
diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 07b945b0391a..fdca527a2248 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -79,7 +79,7 @@
 	 */
 	i2c@7000c000 {
 		status = "okay";
-		clock-frequency = <100000>;
+		clock-frequency = <400000>;
 
 		pcie-switch@58 {
 			compatible = "plx,pex8605";
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index bfb7913c0657..676a4c4b1512 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -437,7 +437,7 @@
 	};
 
 	hdmiddc: i2c@7000c700 {
-		clock-frequency = <100000>;
+		clock-frequency = <10000>;
 	};
 
 	/*
diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index b307feb7c330..8c62833197e5 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -56,7 +56,7 @@
 	 */
 	i2c@7000c000 {
 		status = "okay";
-		clock-frequency = <100000>;
+		clock-frequency = <400000>;
 
 		/* M41T0M6 real time clock on carrier board */
 		rtc@68 {
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 139bfa028b04..1f77273521bf 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -215,7 +215,7 @@
 	};
 
 	hdmiddc: i2c@7000c700 {
-		clock-frequency = <100000>;
+		clock-frequency = <10000>;
 	};
 
 	/*
-- 
2.14.3
