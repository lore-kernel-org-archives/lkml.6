Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A6AC5CFEC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EABA205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RrDTFB6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EABA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030633AbeFSToA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:44:00 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:24551 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030433AbeFSTnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:43:52 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJgsYh022473;
        Tue, 19 Jun 2018 14:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437374;
        bh=modL2jG/kiKtgtGIGFuxTlZlYEuOikqKeAhaf1/O05s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RrDTFB6ylp7JmhpNPE1fZvBG5jqPqAMGItuvkCVdcd9PHXWCZ3GETPDSjvDBiNt2v
         gTKcvejN/+JkR1gzb0SDFZNSSVJHisW0gEp857ZHzKvIt7Fsvyrb+RfWjPcb21SChT
         cMs/VWAvIFEyNUfi1VGbblegv7nZsLN4Va4cSLxM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgs9p023379;
        Tue, 19 Jun 2018 14:42:54 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:42:53 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:42:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgrw9016519;
        Tue, 19 Jun 2018 14:42:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 3/5] arm64: dts: ti: Add Support for AM654 SoC
Date:   Tue, 19 Jun 2018 14:42:51 -0500
Message-ID: <20180619194253.27288-4-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180619194253.27288-1-nm@ti.com>
References: <20180619194253.27288-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM654 SoC is a lead device of the K3 Multicore SoC architecture
platform, targeted for broad market and industrial control with aim to
meet the complex processing needs of modern embedded products.

Some highlights of this SoC are:
* Quad ARMv8 A53 cores split over two clusters
* GICv3 compliant GIC500
* Configurable L3 Cache and IO-coherent architecture
* Dual lock-step capable R5F uC for safety-critical applications
* High data throughput capable distributed DMA architecture under NAVSS
* Three Gigabit Industrial Communication Subsystems (ICSSG), each with dual
  PRUs and dual RTUs
* Hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
* Centralized System Controller for Security, Power, and Resource
  management.
* Dual ADCSS, eQEP/eCAP, eHRPWM, dual CAN-FD
* Flash subsystem with OSPI and Hyperbus interfaces
* Multimedia capability with CAL, DSS7-UL, SGX544, McASP
* Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
  GPIO

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

NOTE:
1. AM654 is the first of the device variants, hence we introduce a
   generic am65.dtsi.
2. We indicate the proper bus topology, the ranges are elaborated in
   each bus segment instead of using the top level ranges to make sure
   that peripherals in each segment use the address space accurately.
3. Peripherals in each bus segment is maintained in a separate dtsi
   allowing for reuse in different bus segment representation from a
   different core such as R5. This is also the reason for maintaining a
   1-1 address map in the ranges.
4. Cache descriptions follow the ARM64 standard description.

Further tweaks may be necessary as we introduce more complex devices,
but can be introduced in context of the device introduction.

Signed-off-by: Benjamin Fair <b-fair@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since RFC:
* Bus topology representation
* Device nodes underneath a bus segment moved to seperate dtsi (allowing reuse
  where applicable)
* Ranges used in the bus segments
* Processor level nodes moved to the root node
* SoC node dropped.
* Default for device nodes is "enabled" instead of explicitly enabling them in
  board dts.
* UART patches are spun off into a different series to prevent maintainer
  tree level conflicts. (wakeup and mcu domain peripherals to be introduced
  there)
* Few addresses had uppercase hexadecimal values, replaced with standard
  lowercase hex values
* Commit message updates
* Kconfig was spun out as seperate patch

RFC: https://patchwork.kernel.org/patch/10447719/ , https://patchwork.kernel.org/patch/10453659/

 MAINTAINERS                              |   1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi |  31 +++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi      |  87 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654.dtsi     | 115 +++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index fbd93eee41ae..6785ceaf5b0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2093,6 +2093,7 @@ M:	Nishanth Menon <nm@ti.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/arm/ti/k3.txt
+F:	arch/arm64/boot/dts/ti/k3-*
 
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
new file mode 100644
index 000000000000..2409344df4fa
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+&cbass_main {
+	gic500: interrupt-controller@1800000 {
+		compatible = "arm,gic-v3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x01800000 0x10000>,	/* GICD */
+		      <0x01880000 0x90000>;	/* GICR */
+		/*
+		 * vcpumntirq:
+		 * virtual CPU interface maintenance interrupt
+		 */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		gic_its: gic-its@18200000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x01820000 0x10000>;
+			msi-controller;
+			#msi-cells = <1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
new file mode 100644
index 000000000000..8c0f78332157
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC Family
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "Texas Instruments K3 AM654 SoC";
+	compatible = "ti,am654";
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	a53_timer0: timer-cl0-cpu0 {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
+	};
+
+	pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		/* Recommendation from GIC500 TRM Table A.3 */
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	cbass_main: cbass@100000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00100000 0x00 0x00100000 0x00020000>, /* ctrl mmr */
+			 <0x00600000 0x00 0x00600000 0x00001100>, /* GPIO */
+			 <0x00900000 0x00 0x00900000 0x00012000>, /* serdes */
+			 <0x01000000 0x00 0x01000000 0x0af02400>, /* Most peripherals */
+			 <0x30800000 0x00 0x30800000 0x0bc00000>, /* MAIN NAVSS */
+			 /* MCUSS Range */
+			 <0x28380000 0x00 0x28380000 0x03880000>,
+			 <0x40200000 0x00 0x40200000 0x00900100>,
+			 <0x42040000 0x00 0x42040000 0x03ac2400>,
+			 <0x45100000 0x00 0x45100000 0x00c24000>,
+			 <0x46000000 0x00 0x46000000 0x00200000>,
+			 <0x47000000 0x00 0x47000000 0x00068400>;
+
+		cbass_mcu: cbass@28380000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
+				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
+				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
+				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
+				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
+
+			cbass_wakeup: cbass@42040000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				/* WKUP  Basic peripherals */
+				ranges = <0x42040000 0x42040000 0x03ac2400>;
+			};
+		};
+	};
+};
+
+/* Now include the peripherals for each bus segments */
+#include "k3-am65-main.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
new file mode 100644
index 000000000000..2affa6f6617e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC family in Quad core configuration
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "k3-am65.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu-map {
+			cluster0: cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1: cluster1 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+
+				core1 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu2: cpu@100 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu3: cpu@101 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x101>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_1>;
+		};
+	};
+
+	L2_0: l2-cache0 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-size = <0x80000>;
+		cache-line-size = <64>;
+		cache-sets = <512>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	L2_1: l2-cache1 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-size = <0x80000>;
+		cache-line-size = <64>;
+		cache-sets = <512>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	msmc_l3: l3-cache0 {
+		compatible = "cache";
+		cache-level = <3>;
+	};
+};
-- 
2.15.1

