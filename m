Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3617087-1524602024-2-13898614787593045278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524602023; b=hhvtk5PRIfU4ZtgiHDEcwhbsdxWksiCpB/3g76xrUwkajz24Cr
    X+kyFs56FBeQXHsGkXr1c4U+T384dTEaKR93lkzAufX9B94VUq3urLtb5PdNwtHN
    dJpcobJVHms2RERjmpaKUEPFVGFsHqSppz93k7znkGC20fYke78BD0BbLrIko4sI
    umBe/ap7QWS8ayz8M47ZTLM3oX/V6EeT0Qu92tvJs6RyK5r7KedIEJ/GoQaKHnzG
    8rm/cl3U95tNA7flmXEYIZb1qXo3G9Y82aYgO5h/Dzm/BToAtqyklZVFMLytVwnC
    yGkOr2P2wCE3dyY1xYOq3JQz64F7yaCKjcEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524602023; bh=
    HlXi4Flxjp1J5ynUHT8wXCGah7OPLGMuzJqwO0/qpbA=; b=LhAR3bgUG+UpR8NJ
    Sr6HFCPX7+H9fWd+viRV5mUSFaeyxFVCIhc07uCE1Cn8ztdKWXakm4sfeSBnlTRn
    oFAZluhzEcRABMEOFirgD0yz25BEWsTcQvkwwet5oVkd9Bjz7YeAIUbkL1nOlhLZ
    0zrS9vJYxVsbS3ek4DynicK4AGPVI0sWgvonzk4svTgMCAGoo4PwWEeTv9KjQFaB
    LT7iU6Zo58bicU/K0wml6Wn9WCEw1SCY29SjTeOLHBaZ3Yj8TPwpC5cvnzo28g+v
    f/3b2JNxKdGPC4qnO1YixvJUfmzzdCnZcKeFgfWZgclZIbnQPJIO1f0h1W8s8ETu
    VvT/gQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBxqM4jUjxH7WVDBVDAZiRy2FqpJd3b9MbXDQATQQcNxy9WCq7YWrjB9IYgzkuAyNsbtj10KWhRTjLebAs8uaRQPs/BW/RG2cZI+gD98mKeNd3UdYVFr
    lGaG3jyhr452TT4oSoAGcvH681ZHXYHlXoE9lzJY5rG51T+UIXwFhUWWAtzQU80gHso5buPkortRMnI0okbof8KJ5JD8eAp/3MCgYI1nNdbHEFUAp5AyUXD7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=hD80L64hAAAA:8 a=nqX7noxv4Kg6fnzE7RgA:9 a=Qq0GqYJ9Hq47kM_b:21
    a=H7LcLAgTe0AhIlFY:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeDXUdi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 16:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeDXUdT (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 16:33:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C4A21838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC 01/10] ARM: dts: exynos: Remove Exynos5440
Date: Tue, 24 Apr 2018 22:32:30 +0200
Message-Id: <20180424203239.21885-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
server platforms but it did not make it to the market really.  There are
no development boards with it and probably there are no real products
neither.  The development for Exynos5440 ended in 2013 and since then
the platform is in maintenance mode.

Remove all Device Tree sources for Exynos5440, as first step of removal
of the platform to simplify the code and drivers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/arm/samsung/samsung-boards.txt        |   2 -
 arch/arm/boot/dts/Makefile                         |   2 -
 arch/arm/boot/dts/exynos5440-sd5v1.dts             |  42 ---
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |  81 -----
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  20 --
 arch/arm/boot/dts/exynos5440-trip-points.dtsi      |  21 --
 arch/arm/boot/dts/exynos5440.dtsi                  | 355 ---------------------
 7 files changed, 523 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos5440-sd5v1.dts
 delete mode 100644 arch/arm/boot/dts/exynos5440-ssdk5440.dts
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440.dtsi

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 14510b215480..bdadc3da9556 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -21,8 +21,6 @@ Required root node properties:
 	- "samsung,smdk5420"	- for Exynos5420-based Samsung SMDK5420 eval board.
 	- "samsung,tm2"		- for Exynos5433-based Samsung TM2 board.
 	- "samsung,tm2e"	- for Exynos5433-based Samsung TM2E board.
-	- "samsung,sd5v1"	- for Exynos5440-based Samsung board.
-	- "samsung,ssdk5440"	- for Exynos5440-based Samsung board.
 
 * Other companies Exynos SoC based
   * FriendlyARM
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9ea57f8ebc4e..bf098f59fd0a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -191,8 +191,6 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5422-odroidxu3.dtb \
 	exynos5422-odroidxu3-lite.dtb \
 	exynos5422-odroidxu4.dtb \
-	exynos5440-sd5v1.dtb \
-	exynos5440-ssdk5440.dtb \
 	exynos5800-peach-pi.dtb
 dtb-$(CONFIG_ARCH_GEMINI) += \
 	gemini-dlink-dir-685.dtb \
diff --git a/arch/arm/boot/dts/exynos5440-sd5v1.dts b/arch/arm/boot/dts/exynos5440-sd5v1.dts
deleted file mode 100644
index c4b8392d1ae1..000000000000
--- a/arch/arm/boot/dts/exynos5440-sd5v1.dts
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * SAMSUNG SD5v1 board device tree source
- *
- * Copyright (c) 2013 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- */
-
-/dts-v1/;
-#include "exynos5440.dtsi"
-
-/ {
-	model = "SAMSUNG SD5v1 board based on EXYNOS5440";
-	compatible = "samsung,sd5v1", "samsung,exynos5440", "samsung,exynos5";
-
-	chosen {
-		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel earlyprintk no_console_suspend mem=2048M@0x80000000 mem=6144M@0x100000000 console=ttySAC0,115200";
-	};
-
-	/* FIXME: set reg property with correct start address and size */
-	memory@0 {
-		device_type = "memory";
-		reg = <0 0>;
-	};
-
-	fixed-rate-clocks {
-		xtal {
-			compatible = "samsung,clock-xtal";
-			clock-frequency = <50000000>;
-		};
-	};
-
-	spi {
-		status = "disabled";
-	};
-
-};
-
-&gmac {
-	fixed_phy;
-	phy_addr = <1>;
-};
diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
deleted file mode 100644
index a33c4fc29ae5..000000000000
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ /dev/null
@@ -1,81 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * SAMSUNG SSDK5440 board device tree source
- *
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- */
-
-/dts-v1/;
-#include "exynos5440.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "SAMSUNG SSDK5440 board based on EXYNOS5440";
-	compatible = "samsung,ssdk5440", "samsung,exynos5440", "samsung,exynos5";
-
-	chosen {
-		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel earlyprintk no_console_suspend mem=2048M@0x80000000 mem=6144M@0x100000000 console=ttySAC0,115200";
-	};
-
-	/* FIXME: set reg property with correct start address and size */
-	memory@0 {
-		device_type = "memory";
-		reg = <0 0>;
-	};
-
-	fixed-rate-clocks {
-		xtal {
-			compatible = "samsung,clock-xtal";
-			clock-frequency = <50000000>;
-		};
-	};
-};
-
-&pcie_0 {
-	reset-gpio = <&pin_ctrl 5 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&pcie_1 {
-	reset-gpio = <&pin_ctrl 22 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&spi_0 {
-	flash: w25q128@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "winbond,w25q128";
-		spi-max-frequency = <15625000>;
-		reg = <0>;
-		controller-data {
-			samsung,spi-feedback-delay = <0>;
-		};
-
-		partition@0 {
-			label = "BootLoader";
-			reg = <0x60000 0x80000>;
-			read-only;
-		};
-
-		partition@e0000 {
-			label = "Recovery-Kernel";
-			reg = <0xe0000 0x300000>;
-			read-only;
-		};
-
-		partition@3e0000 {
-			label = "CRAM-FS";
-			reg = <0x3e0000 0x700000>;
-			read-only;
-		};
-
-		partition@ae0000 {
-			label = "User-Data";
-			reg = <0xae0000 0x520000>;
-		};
-
-	};
-
-};
diff --git a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
deleted file mode 100644
index 0421c3d42905..000000000000
--- a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5440 TMU sensor configuration
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <5>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <0x5d2d>;
-samsung,tmu_min_efuse_value = <16>;
-samsung,tmu_max_efuse_value = <76>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <70>;
-samsung,tmu_default_temp_offset = <25>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
diff --git a/arch/arm/boot/dts/exynos5440-trip-points.dtsi b/arch/arm/boot/dts/exynos5440-trip-points.dtsi
deleted file mode 100644
index a2b04fed7d0b..000000000000
--- a/arch/arm/boot/dts/exynos5440-trip-points.dtsi
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for default Exynos5440 thermal zone definition
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- */
-
-polling-delay-passive = <0>;
-polling-delay = <0>;
-trips {
-	cpu-alert-0 {
-		temperature = <100000>; /* millicelsius */
-		hysteresis = <0>; /* millicelsius */
-		type = "active";
-	};
-	cpu-crit-0 {
-		temperature = <105000>; /* millicelsius */
-		hysteresis = <0>; /* millicelsius */
-		type = "critical";
-	};
-};
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
deleted file mode 100644
index f3abecc44657..000000000000
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ /dev/null
@@ -1,355 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * SAMSUNG EXYNOS5440 SoC device tree source
- *
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- */
-
-#include <dt-bindings/clock/exynos5440.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	compatible = "samsung,exynos5440", "samsung,exynos5";
-
-	interrupt-parent = <&gic>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		serial0 = &serial_0;
-		serial1 = &serial_1;
-		spi0 = &spi_0;
-		tmuctrl0 = &tmuctrl_0;
-		tmuctrl1 = &tmuctrl_1;
-		tmuctrl2 = &tmuctrl_2;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0>;
-		};
-		cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <1>;
-		};
-		cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <2>;
-		};
-		cpu@3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <3>;
-		};
-	};
-
-	soc: soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		clock: clock-controller@160000 {
-			compatible = "samsung,exynos5440-clock";
-			reg = <0x160000 0x1000>;
-			#clock-cells = <1>;
-		};
-
-		gic: interrupt-controller@2e0000 {
-			compatible = "arm,cortex-a15-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg =	<0x2E1000 0x1000>,
-				<0x2E2000 0x2000>,
-				<0x2E4000 0x2000>,
-				<0x2E6000 0x2000>;
-			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		};
-
-
-		arm-pmu {
-			compatible = "arm,cortex-a15-pmu", "arm,cortex-a9-pmu";
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		timer {
-			compatible = "arm,cortex-a15-timer",
-				     "arm,armv7-timer";
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-			clock-frequency = <50000000>;
-		};
-
-		cpufreq@160000 {
-			compatible = "samsung,exynos5440-cpufreq";
-			reg = <0x160000 0x1000>;
-			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-			operating-points = <
-					/* KHz	  uV */
-					1500000 1100000
-					1400000 1075000
-					1300000 1050000
-					1200000 1025000
-					1100000 1000000
-					1000000 975000
-					900000  950000
-					800000  925000
-			>;
-		};
-
-		serial_0: serial@b0000 {
-			compatible = "samsung,exynos4210-uart";
-			reg = <0xB0000 0x1000>;
-			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_B_125>, <&clock CLK_B_125>;
-			clock-names = "uart", "clk_uart_baud0";
-		};
-
-		serial_1: serial@c0000 {
-			compatible = "samsung,exynos4210-uart";
-			reg = <0xC0000 0x1000>;
-			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_B_125>, <&clock CLK_B_125>;
-			clock-names = "uart", "clk_uart_baud0";
-		};
-
-		spi_0: spi@d0000 {
-			compatible = "samsung,exynos5440-spi";
-			reg = <0xD0000 0x100>;
-			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			samsung,spi-src-clk = <0>;
-			num-cs = <1>;
-			clocks = <&clock CLK_B_125>, <&clock CLK_SPI_BAUD>;
-			clock-names = "spi", "spi_busclk0";
-		};
-
-		pin_ctrl: pinctrl@e0000 {
-			compatible = "samsung,exynos5440-pinctrl";
-			reg = <0xE0000 0x1000>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			#gpio-cells = <2>;
-
-			fan: fan {
-				samsung,exynos5440-pin-function = <1>;
-			};
-
-			hdd_led0: hdd_led0 {
-				samsung,exynos5440-pin-function = <2>;
-			};
-
-			hdd_led1: hdd_led1 {
-				samsung,exynos5440-pin-function = <3>;
-			};
-
-			uart1: uart1 {
-				samsung,exynos5440-pin-function = <4>;
-			};
-		};
-
-		i2c@f0000 {
-			compatible = "samsung,exynos5440-i2c";
-			reg = <0xF0000 0x1000>;
-			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&clock CLK_B_125>;
-			clock-names = "i2c";
-		};
-
-		i2c@100000 {
-			compatible = "samsung,exynos5440-i2c";
-			reg = <0x100000 0x1000>;
-			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&clock CLK_B_125>;
-			clock-names = "i2c";
-		};
-
-		watchdog@110000 {
-			compatible = "samsung,s3c6410-wdt";
-			reg = <0x110000 0x1000>;
-			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_B_125>;
-			clock-names = "watchdog";
-		};
-
-		gmac: ethernet@230000 {
-			compatible = "snps,dwmac-3.70a", "snps,dwmac";
-			reg = <0x00230000 0x8000>;
-			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
-			phy-mode = "sgmii";
-			clocks = <&clock CLK_GMAC0>;
-			clock-names = "stmmaceth";
-		};
-
-		amba {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges;
-		};
-
-		rtc@130000 {
-			compatible = "samsung,s3c6410-rtc";
-			reg = <0x130000 0x1000>;
-			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_B_125>;
-			clock-names = "rtc";
-		};
-
-		tmuctrl_0: tmuctrl@160118 {
-			compatible = "samsung,exynos5440-tmu";
-			reg = <0x160118 0x230>, <0x160368 0x10>;
-			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_B_125>;
-			clock-names = "tmu_apbif";
-			#include "exynos5440-tmu-sensor-conf.dtsi"
-		};
-
-		tmuctrl_1: tmuctrl@16011c {
-			compatible = "samsung,exynos5440-tmu";
-			reg = <0x16011C 0x230>, <0x160368 0x10>;
-			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_B_125>;
-			clock-names = "tmu_apbif";
-			#include "exynos5440-tmu-sensor-conf.dtsi"
-		};
-
-		tmuctrl_2: tmuctrl@160120 {
-			compatible = "samsung,exynos5440-tmu";
-			reg = <0x160120 0x230>, <0x160368 0x10>;
-			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_B_125>;
-			clock-names = "tmu_apbif";
-			#include "exynos5440-tmu-sensor-conf.dtsi"
-		};
-
-		sata@210000 {
-			compatible = "snps,exynos5440-ahci";
-			reg = <0x210000 0x10000>;
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_SATA>;
-			clock-names = "sata";
-		};
-
-		ohci@220000 {
-			compatible = "samsung,exynos5440-ohci";
-			reg = <0x220000 0x1000>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_USB>;
-			clock-names = "usbhost";
-		};
-
-		ehci@221000 {
-			compatible = "samsung,exynos5440-ehci";
-			reg = <0x221000 0x1000>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_USB>;
-			clock-names = "usbhost";
-		};
-
-		pcie_phy0: pcie-phy@270000 {
-			#phy-cells = <0>;
-			compatible = "samsung,exynos5440-pcie-phy";
-			reg = <0x270000 0x1000>, <0x271000 0x40>;
-		};
-
-		pcie_phy1: pcie-phy@272000 {
-			#phy-cells = <0>;
-			compatible = "samsung,exynos5440-pcie-phy";
-			reg = <0x272000 0x1000>, <0x271040 0x40>;
-		};
-
-		pcie_0: pcie@290000 {
-			compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
-			reg = <0x290000 0x1000>, <0x40000000 0x1000>;
-			reg-names = "elbi", "config";
-			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_PR0_250_O>, <&clock CLK_PB0_250_O>;
-			clock-names = "pcie", "pcie_bus";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			device_type = "pci";
-			phys = <&pcie_phy0>;
-			ranges = <0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
-				  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
-			bus-range = <0x00 0xff>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0x0 0 &gic 53>;
-			num-lanes = <4>;
-			status = "disabled";
-		};
-
-		pcie_1: pcie@2a0000 {
-			compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
-			reg = <0x2a0000 0x1000>, <0x60000000 0x1000>;
-			reg-names = "elbi", "config";
-			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clock CLK_PR1_250_O>, <&clock CLK_PB0_250_O>;
-			clock-names = "pcie", "pcie_bus";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			device_type = "pci";
-			phys = <&pcie_phy1>;
-			ranges = <0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
-				  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
-			bus-range = <0x00 0xff>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0x0 0 &gic 56>;
-			num-lanes = <4>;
-			status = "disabled";
-		};
-	};
-
-	thermal-zones {
-		cpu0_thermal: cpu0-thermal {
-			thermal-sensors = <&tmuctrl_0>;
-			#include "exynos5440-trip-points.dtsi"
-		};
-		cpu1_thermal: cpu1-thermal {
-		       thermal-sensors = <&tmuctrl_1>;
-		       #include "exynos5440-trip-points.dtsi"
-		};
-		cpu2_thermal: cpu2-thermal {
-		       thermal-sensors = <&tmuctrl_2>;
-		       #include "exynos5440-trip-points.dtsi"
-		};
-	};
-};
-- 
2.14.1

