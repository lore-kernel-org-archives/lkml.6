Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id czR3HdrBGVv2RgAAmS7hNA
	; Thu, 07 Jun 2018 23:39:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C5107608BA; Thu,  7 Jun 2018 23:39:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c0T5goxB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 01404608D2;
	Thu,  7 Jun 2018 23:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01404608D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeFGXja (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 19:39:30 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:36587 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeFGXj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 19:39:27 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w57NcsHN031022;
        Thu, 7 Jun 2018 18:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528414734;
        bh=TEUq83+PVQl0IKrV75rmbgjDBHGn1dNvsRk6NwZmhh0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=c0T5goxBQf2dgJyTWO1Mapww7hcruCXF75uwms9ojVpttax908H7tU3VbtK8SIqG2
         tb+Sn9HKwIPIZ+NKYdVh25to/EWYVBqopOV+bBGYNt8QWe3JuleRLilR9rIiAZdvEd
         6Tjm7dnW9mxfnIULsM3Nd11p3NUZQylcriCLOO70=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w57Ncsck006716;
        Thu, 7 Jun 2018 18:38:54 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 7 Jun
 2018 18:38:53 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 7 Jun 2018 18:38:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w57NcrJU030288;
        Thu, 7 Jun 2018 18:38:53 -0500
Date: Thu, 7 Jun 2018 18:38:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Rob Herring <robh+dt@kernel.org>
CC: Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
Message-ID: <20180607233853.p7iw7nlxxuyi66og@kahuna>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:05-20180605, Rob Herring wrote:
> On Tue, Jun 5, 2018 at 1:05 AM, Nishanth Menon <nm@ti.com> wrote:
[...]

> > +       soc0: soc0 {
> > +               compatible = "simple-bus";
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> 
> Really need 64-bit addresses and sizes? Use ranges to limit the
> address space if possible.

Done -> overall the addresses are really in the 64bit addresses, but
used bus segments and ranges to reduce to 32bit maps where possible.

OSPI, PCIE, FSS (Flash subsystem) , CPTS are some of the ones that
probably will need some level of cleanups when those are introduced
later.

Unfortunately, there is a lot of interleaved addressing between bus
segments themselves, I have tried to keep the ranges as clean as
reasonably possible. I also tried to use 1-1 map for children nodes to
maintain some level of sanity as we add more device nodes. There might
be a few exceptions, but overall the ranges currently map 1-1 physical
32bit address - OSPI, CPTS, FSS will however have to have a different
mapping.

See [1]
> 
> > +
> > +               a53_timer0: timer-cl0-cpu0 {
> > +                       compatible = "arm,armv8-timer";
> > +                       interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
> > +                                    <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
> > +                                    <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
> > +                                    <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
> > +               };
> > +
> > +               pmu: pmu {
> > +                       compatible = "arm,armv8-pmuv3";
> > +                       /* Recommendation from GIC500 TRM Table A.3 */
> > +                       interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +               };
> 
> These 2 nodes aren't on the bus, so move them up a level.

Thanks. oversight on my end. I have fixed it (see [1])
> 
> > +
> > +               gic: interrupt-controller@1800000 {
> > +                       compatible = "arm,gic-v3";
> 
> gic-500?

Yes, GIC500.

> 
> > +                       #address-cells = <2>;
> > +                       #size-cells = <2>;
> > +                       ranges;
> > +                       #interrupt-cells = <3>;
> > +                       interrupt-controller;
> > +                       /*
> > +                        * NOTE: we are NOT gicv2 backward compat, so no GICC,
> > +                        * GICH or GICV
> 
> The compatible should imply this.

GIC500 at SoC design instantiation takes a parameter
"are_option" -> this is set to no-compatibility for V2 for AM6. This is indeed
discovered by the driver, However,
Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
just notes that GICC, GICH, GICV as optional.. With backward
compatibility disabled, these are'nt even present.

I have dropped the comment, was helpful for me when I was first
adding support for GIC500, It is pretty common knowledge now for other
ARMV8 developers, so no point in retaining newbie info as comment.

[...]
> > diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> > new file mode 100644
> > index 000000000000..d9b70081daba
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Device Tree Source for AM6 SoC family in Quad core configuration
> > + *
> > + * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> > + */
> > +
> > +#include "k3-am6.dtsi"
> > +
> > +/ {
> > +       cpus: cpus {
> 
> Really need a label?

Thanks. Dropped.

> 
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               cpu-map {
> 
> IIRC, this goes at the top level.

Documentation/devicetree/bindings/arm/topology.txt
States to keep in cpus node. Quote:

| The ARM CPU topology is defined within the cpu-map node, which is a direct
| child of the cpus node and provides a container where the actual topology
| nodes are listed.

Retained as is to stay in sync with binding.

> > +               cpu0: cpu@0 {
> > +                       compatible = "arm,cortex-a53","arm,armv8";
> 
> space between compatibles.

Oops. Fixed. thanks.

> 
> > +                       reg = <0x000>;
> > +                       device_type = "cpu";
> > +                       enable-method = "psci";
> 
> > +                       i-cache-size = <0x8000>;
> > +                       i-cache-line-size = <64>;
> > +                       i-cache-sets = <256>;
> > +                       d-cache-size = <0x8000>;
> > +                       d-cache-line-size = <64>;
> > +                       d-cache-sets = <128>;
> 
> All this should be discoverable.

Unfortunately no.
Previously CCSIDR_EL1 was a good place to lookup this data.
But as Sudeep pointed me offline:
commit a8d4636f96ad ("arm64: cacheinfo: Remove CCSIDR-based cache information probing")
and commit 9a802431c527 ("arm64: cacheinfo: add support to override cache levels via device tree")
had already provided options to override cache information from the device tree.

This is what I am using.
Quote from commit:
The architecture explicitly states:

| You cannot make any inference about the actual sizes of caches based
| on these parameters.

[...]
> > +
> > +&soc0 {
> > +       L2_0: l2-cache0 {
> > +               compatible = "cache";
> 
> Is this documented?

Just what Documentation/devicetree/bindings/arm/cpu-capacity.txt states
as an example. We dont seem to have anything similar to
Documentation/devicetree/bindings/arm/l2c2x0.txt in armv8 as per the
comments in the document at least.

> 
> > +               cache-level = <2>;
> > +               cache-size = <0x80000>;
> > +               cache-line-size = <64>;
> > +               cache-sets = <512>;
> 
> Discoverable?

Same comment as L1 cache details.

> 
> > +               next-level-cache = <&msmc_l3>;
> > +       };
> > +
> > +       L2_1: l2-cache1 {
> > +               compatible = "cache";
> > +               cache-level = <2>;
> > +               cache-size = <0x80000>;
> > +               cache-line-size = <64>;
> > +               cache-sets = <512>;
> > +               next-level-cache = <&msmc_l3>;
> > +       };
> > +
> > +       msmc_l3: l3-cache0 {
> > +               compatible = "cache";
> 
> Is this something TI specific or follows the (ARM) architecture?

ARM Architecture permits an L3 Cache. TI implements it differently (we
dont use CCI), instead an L3 Cache is always active in our
implementation - backing memory is configurable and is designed to be
completely transparent to s/w running on ARMv8.

Description here is to meet the hardware description of cache topology
to be accurate.

[...]
> > diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> > index 92770d84a288..be4570baad96 100644
> > --- a/drivers/soc/ti/Kconfig
> > +++ b/drivers/soc/ti/Kconfig
> > @@ -1,3 +1,17 @@
> > +# 64-bit ARM SoCs from TI
> > +if ARM64
> > +
> > +if ARCH_K3
> > +
> > +config ARCH_K3_AM6_SOC
> 
> This should be in another patch (or dropped?).

Agreed and split off into another patch.

[1]
Here is how the patch looks now (after incorporating changes suggested
by Tony as well) - Thoughts please:
https://github.com/nmenon/linux-2.6-playground/tree/upstream/next-20180604/k3-5-defconfig/arch/arm64/boot/dts/ti
has everything consolidated.

8<--
>From 88857a8241fc67d63021e5c9070092b11398d11f Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Wed, 14 Sep 2016 19:12:42 -0500
Subject: [RFC V2 PATCH] arm64: dts: ti: Add Support for AM654 SoC

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
* Flash subystem with OSPI and Hyperbus interfaces
* Multimedia capability with CAL, DSS7-UL, SGX544, McASP
* Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
  GPIO

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

We introduce the Kconfig symbol for the SoC along with this patch since
it is logically relevant point, however the usage is in subsequent
patches.

NOTE: AM654 is the first of the device variants, hence we introduce a
generic am6.dtsi.

Signed-off-by: Benjamin Fair <b-fair@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 MAINTAINERS                          |   1 +
 arch/arm64/boot/dts/ti/k3-am6.dtsi   | 172 +++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654.dtsi | 117 ++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index cfb35b252ac7..5f5c4eddec7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2092,6 +2092,7 @@ M:	Nishanth Menon <nm@ti.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/arm/ti/k3.txt
+F:	arch/arm64/boot/dts/ti/k3-*
 
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
diff --git a/arch/arm64/boot/dts/ti/k3-am6.dtsi b/arch/arm64/boot/dts/ti/k3-am6.dtsi
new file mode 100644
index 000000000000..700c56eda12d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6.dtsi
@@ -0,0 +1,172 @@
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
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+	};
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
+	soc0: soc0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		main_domain: cbass@100000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00100000 0x00 0x00100000 0x00020000>, /* ctrl mmr */
+				 <0x00600000 0x00 0x00600000 0x00001100>, /* GPIO */
+				 <0x00900000 0x00 0x00900000 0x00012000>, /* serdes */
+				 <0x01000000 0x00 0x01000000 0x0AF02400>, /* Most peripherals */
+				 <0x30800000 0x00 0x30800000 0x0BC00000>; /* MAIN NAVSS */
+
+			gic500: interrupt-controller@1800000 {
+				compatible = "arm,gic-v3";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				reg = <0x01800000 0x10000>,	/* GICD */
+				      <0x01880000 0x90000>;	/* GICR */
+
+				/*
+				 * vcpumntirq:
+				 * virtual CPU interface maintenance interrupt
+				 */
+				interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+				gic_its: gic-its@18200000 {
+					compatible = "arm,gic-v3-its";
+					reg = <0x01820000 0x10000>;
+					msi-controller;
+					#msi-cells = <1>;
+				};
+			};
+
+			main_uart0: serial@2800000 {
+				compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
+				reg = <0x02800000 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency = <48000000>;
+				current-speed = <115200>;
+				status = "disabled";
+			};
+
+			main_uart1: serial@2810000 {
+				compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
+				reg = <0x02810000 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency = <48000000>;
+				current-speed = <115200>;
+				status = "disabled";
+			};
+
+			main_uart2: serial@2820000 {
+				compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
+				reg = <0x02820000 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency = <48000000>;
+				current-speed = <115200>;
+				status = "disabled";
+			};
+		};
+
+		wkup_domain: cbass@42040000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x42040000 0x00 0x42040000 0x03AC2400>; /* Basic peripherals */
+
+			wkup_uart0: serial@42300000 {
+				compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
+				reg = <0x42300000 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency = <48000000>;
+				current-speed = <115200>;
+				status = "disabled";
+			};
+
+		};
+
+		mcu_domain: cbass@28380000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x28380000 0x00 0x28380000 0x03880000>, /* MCU NAVSS*/
+				 <0x40200000 0x00 0x40200000 0x00900100>, /* First peripheral window */
+				 <0x45100000 0x00 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x46000000 0x00 0x46000000 0x00200000>, /* CPSW */
+				 <0x47000000 0x00 0x47000000 0x00068400>; /* OSPI space 1 */
+
+			mcu_uart0: serial@40a00000 {
+				compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
+				reg = <0x40a00000 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency = <96000000>;
+				current-speed = <115200>;
+				status = "disabled";
+			};
+
+		};
+
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
new file mode 100644
index 000000000000..bffa414180ea
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC family in Quad core configuration
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "k3-am6.dtsi"
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
+};
+
+&soc0 {
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

-- 
Regards,
Nishanth Menon
