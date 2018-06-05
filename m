Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeFEGCn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:02:43 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:36568 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbeFEGC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:02:27 -0400
From: Nishanth Menon <nm@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>, Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 1/6] Documentation: arm: ti: Add bindings for AM654 SoC
Date: Tue, 5 Jun 2018 01:01:20 -0500
Message-ID: <20180605060125.9518-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605060125.9518-1-nm@ti.com>
References: <20180605060125.9518-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
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
* Flash subystem with OSPI and Hyperbus interfaces
* Multimedia capability with CAL, DSS7-UL, SGX544, McASP
* Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
  GPIO

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.txt | 33 +++++++++++++++++++++++++
 MAINTAINERS                                     |  7 ++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.txt b/Documentation/devicetree/bindings/arm/ti/k3.txt
new file mode 100644
index 000000000000..cbabb1b89f6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/k3.txt
@@ -0,0 +1,33 @@
+Texas Instruments K3 Multicore SoC architecture device tree bindings
+--------------------------------------------------------------------
+
+Boards based on K3 Multicore SoC architecture shall have the following property:
+- compatible: Every hardware block introduced in K3 Multicore SoC
+  architecture shall be of the form:
+  "ti,XXX-YYY", where:
+     'XXX' represents the specific SoC part for which the support is added.
+     'YYY' represents the corresponding peripheral in SoC being supported.
+
+  NOTE: Generic devices such as GIC or legacy devices shall use the specified
+  compatible for those devices.
+
+  Example:
+    compatible = "ti,am654-i2c";
+
+SoCs
+-------------------------------------------
+
+Each device tree root node must specify which exact SoC in K3 Multicore SoC
+architecture it uses, using one of the following compatible values:
+
+- AM654
+  compatible = "ti,am654";
+
+Boards
+-------------------------------------------
+
+In addition, each device tree root node must specify which one or more
+of the following board-specific compatible values:
+
+- AM654 EVM
+  compatible = "ti,am654-evm", "ti,am654";
diff --git a/MAINTAINERS b/MAINTAINERS
index f39a8de1bbd7..cfb35b252ac7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2086,6 +2086,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/memory/*emif*
 
+ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
+M:	Tero Kristo <t-kristo@ti.com>
+M:	Nishanth Menon <nm@ti.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/arm/ti/k3.txt
+
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.15.1
