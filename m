Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB4C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D34820824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D34820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJXR1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:27:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45673 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeJXR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:27:51 -0400
Received: from [185.7.230.213] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gFF1W-0004rD-FL; Wed, 24 Oct 2018 11:00:18 +0200
Date:   Wed, 24 Oct 2018 10:00:12 +0100 (BST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: [GIT pull] irq updates for 4.20
Message-ID: <alpine.DEB.2.21.1810240954100.1645@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

The interrupt brigade came up with the following updates:

  - Driver for the Marvell System Error Interrupt machinery

  - Overhaul of the GIC-V3 ITS driver

  - Small updates and fixes all over the place

The EFI parts of it are required to support GIC-V3 ITS working accross
kexec.

Thanks,

	tglx

------------------>
Ard Biesheuvel (3):
      efi: honour memory reservations passed via a linux specific config table
      efi/arm: libstub: add a root memreserve config table
      efi: add API to reserve memory persistently across kexec reboot

Biju Das (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a7744 support

Geert Uytterhoeven (2):
      dt-bindings: irqchip: renesas-irqc: Document R-Car E3 support
      genirq: Fix grammar s/an /a /

Julien Thierry (2):
      irqchip/gic-v3: Remove acknowledge loop
      irqchip/gic: Unify GIC priority definitions

Lina Iyer (1):
      irqchip/pdc: Setup all edge interrupts as rising edge at GIC

Lukas Wunner (1):
      genirq: Fix race on spurious interrupt detection

Marc Zyngier (13):
      genirq/debugfs: Reset domain debugfs_file on removal of the debugfs file
      genirq/debugfs: Reinstate full OF path for domain name
      irqchip/gic-v3-its: Change initialization ordering for LPIs
      irqchip/gic-v3-its: Simplify LPI_PENDBASE_SZ usage
      irqchip/gic-v3-its: Split property table clearing from allocation
      irqchip/gic-v3-its: Move pending table allocation to init time
      irqchip/gic-v3-its: Keep track of property table's PA and VA
      irqchip/gic-v3-its: Allow use of pre-programmed LPI tables
      irqchip/gic-v3-its: Use pre-programmed redistributor tables with kdump kernels
      irqchip/gic-v3-its: Check that all RDs have the same property table
      irqchip/gic-v3-its: Register LPI tables with EFI config table
      irqchip/gic-v3-its: Allow use of LPI tables in reserved memory
      genirq/msi: Allow creation of a tree-based irqdomain for platform-msi

Miquel Raynal (10):
      dt-bindings/interrupt-controller: Fix Marvell ICU length in the example
      irqchip/irq-mvebu-icu: Fix wrong private data retrieval
      irqchip/irq-mvebu-icu: Clarify the reset operation of configured interrupts
      irqchip/irq-mvebu-icu: Disociate ICU and NSR
      irqchip/irq-mvebu-icu: Support ICU subnodes
      irqchip/irq-mvebu-sei: Add new driver for Marvell SEI
      arm64: marvell: Enable SEI driver
      irqchip/irq-mvebu-icu: Add support for System Error Interrupts (SEI)
      dt-bindings/interrupt-controller: Update Marvell ICU bindings
      dt-bindings/interrupt-controller: Add documentation for Marvell SEI controller

Yangtao Li (1):
      softirq: Fix typo in __do_softirq() comments


 .../bindings/interrupt-controller/marvell,icu.txt  |  85 +++-
 .../bindings/interrupt-controller/marvell,sei.txt  |  36 ++
 .../bindings/interrupt-controller/renesas,irqc.txt |   5 +-
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/base/platform-msi.c                        |  14 +-
 drivers/firmware/efi/efi.c                         |  59 ++-
 drivers/firmware/efi/libstub/arm-stub.c            |  27 ++
 drivers/irqchip/Kconfig                            |   3 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-gic-v3-its.c                   | 249 +++++++---
 drivers/irqchip/irq-gic-v3.c                       |  85 ++--
 drivers/irqchip/irq-mvebu-icu.c                    | 253 +++++++---
 drivers/irqchip/irq-mvebu-sei.c                    | 507 +++++++++++++++++++++
 drivers/irqchip/qcom-pdc.c                         |   1 +
 include/linux/efi.h                                |   9 +
 include/linux/interrupt.h                          |   2 +-
 include/linux/irqchip/arm-gic-common.h             |   6 +
 include/linux/irqchip/arm-gic-v3.h                 |   4 +-
 include/linux/irqchip/arm-gic.h                    |   5 -
 include/linux/irqdomain.h                          |   1 +
 include/linux/msi.h                                |  17 +-
 kernel/irq/irqdomain.c                             |   5 +-
 kernel/irq/manage.c                                |   8 +-
 kernel/softirq.c                                   |   6 +-
 24 files changed, 1187 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
 create mode 100644 drivers/irqchip/irq-mvebu-sei.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
index aa8bf2ec8905..1c94a57a661e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
@@ -5,6 +5,8 @@ The Marvell ICU (Interrupt Consolidation Unit) controller is
 responsible for collecting all wired-interrupt sources in the CP and
 communicating them to the GIC in the AP, the unit translates interrupt
 requests on input wires to MSG memory mapped transactions to the GIC.
+These messages will access a different GIC memory area depending on
+their type (NSR, SR, SEI, REI, etc).
 
 Required properties:
 
@@ -12,20 +14,23 @@ Required properties:
 
 - reg: Should contain ICU registers location and length.
 
-- #interrupt-cells: Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 3.
+Subnodes: Each group of interrupt is declared as a subnode of the ICU,
+with their own compatible.
+
+Required properties for the icu_nsr/icu_sei subnodes:
 
-  The 1st cell is the group type of the ICU interrupt. Possible group
-  types are:
+- compatible: Should be one of:
+              * "marvell,cp110-icu-nsr"
+	      * "marvell,cp110-icu-sr"
+	      * "marvell,cp110-icu-sei"
+	      * "marvell,cp110-icu-rei"
 
-   ICU_GRP_NSR (0x0) : Shared peripheral interrupt, non-secure
-   ICU_GRP_SR  (0x1) : Shared peripheral interrupt, secure
-   ICU_GRP_SEI (0x4) : System error interrupt
-   ICU_GRP_REI (0x5) : RAM error interrupt
+- #interrupt-cells: Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
 
-  The 2nd cell is the index of the interrupt in the ICU unit.
+  The 1st cell is the index of the interrupt in the ICU unit.
 
-  The 3rd cell is the type of the interrupt. See arm,gic.txt for
+  The 2nd cell is the type of the interrupt. See arm,gic.txt for
   details.
 
 - interrupt-controller: Identifies the node as an interrupt
@@ -35,17 +40,73 @@ Required properties:
   that allows to trigger interrupts using MSG memory mapped
   transactions.
 
+Note: each 'interrupts' property referring to any 'icu_xxx' node shall
+      have a different number within [0:206].
+
 Example:
 
 icu: interrupt-controller@1e0000 {
 	compatible = "marvell,cp110-icu";
-	reg = <0x1e0000 0x10>;
+	reg = <0x1e0000 0x440>;
+
+	CP110_LABEL(icu_nsr): interrupt-controller@10 {
+		compatible = "marvell,cp110-icu-nsr";
+		reg = <0x10 0x20>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		msi-parent = <&gicp>;
+	};
+
+	CP110_LABEL(icu_sei): interrupt-controller@50 {
+		compatible = "marvell,cp110-icu-sei";
+		reg = <0x50 0x10>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		msi-parent = <&sei>;
+	};
+};
+
+node1 {
+	interrupt-parent = <&icu_nsr>;
+	interrupts = <106 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+node2 {
+	interrupt-parent = <&icu_sei>;
+	interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+/* Would not work with the above nodes */
+node3 {
+	interrupt-parent = <&icu_nsr>;
+	interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+The legacy bindings were different in this way:
+
+- #interrupt-cells: The value was 3.
+	The 1st cell was the group type of the ICU interrupt. Possible
+	group types were:
+	ICU_GRP_NSR (0x0) : Shared peripheral interrupt, non-secure
+	ICU_GRP_SR  (0x1) : Shared peripheral interrupt, secure
+	ICU_GRP_SEI (0x4) : System error interrupt
+	ICU_GRP_REI (0x5) : RAM error interrupt
+	The 2nd cell was the index of the interrupt in the ICU unit.
+	The 3rd cell was the type of the interrupt. See arm,gic.txt for
+	details.
+
+Example:
+
+icu: interrupt-controller@1e0000 {
+	compatible = "marvell,cp110-icu";
+	reg = <0x1e0000 0x440>;
+
 	#interrupt-cells = <3>;
 	interrupt-controller;
 	msi-parent = <&gicp>;
 };
 
-usb3h0: usb3@500000 {
+node1 {
 	interrupt-parent = <&icu>;
 	interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
 };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
new file mode 100644
index 000000000000..0beafed502f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
@@ -0,0 +1,36 @@
+Marvell SEI (System Error Interrupt) Controller
+-----------------------------------------------
+
+Marvell SEI (System Error Interrupt) controller is an interrupt
+aggregator. It receives interrupts from several sources and aggregates
+them to a single interrupt line (an SPI) on the parent interrupt
+controller.
+
+This interrupt controller can handle up to 64 SEIs, a set comes from the
+AP and is wired while a second set comes from the CPs by the mean of
+MSIs.
+
+Required properties:
+
+- compatible: should be one of:
+              * "marvell,ap806-sei"
+- reg: SEI registers location and length.
+- interrupts: identifies the parent IRQ that will be triggered.
+- #interrupt-cells: number of cells to define an SEI wired interrupt
+                    coming from the AP, should be 1. The cell is the IRQ
+                    number.
+- interrupt-controller: identifies the node as an interrupt controller
+                        for AP interrupts.
+- msi-controller: identifies the node as an MSI controller for the CPs
+                  interrupts.
+
+Example:
+
+        sei: interrupt-controller@3f0200 {
+                compatible = "marvell,ap806-sei";
+                reg = <0x3f0200 0x40>;
+                interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+                #interrupt-cells = <1>;
+                interrupt-controller;
+                msi-controller;
+        };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index a046ed374d80..8de96a4fb2d5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -2,10 +2,12 @@ DT bindings for the R-Mobile/R-Car/RZ/G interrupt controller
 
 Required properties:
 
-- compatible: has to be "renesas,irqc-<soctype>", "renesas,irqc" as fallback.
+- compatible: must be "renesas,irqc-<soctype>" or "renesas,intc-ex-<soctype>",
+	      and "renesas,irqc" as fallback.
   Examples with soctypes are:
     - "renesas,irqc-r8a73a4" (R-Mobile APE6)
     - "renesas,irqc-r8a7743" (RZ/G1M)
+    - "renesas,irqc-r8a7744" (RZ/G1N)
     - "renesas,irqc-r8a7745" (RZ/G1E)
     - "renesas,irqc-r8a77470" (RZ/G1C)
     - "renesas,irqc-r8a7790" (R-Car H2)
@@ -19,6 +21,7 @@ Required properties:
     - "renesas,intc-ex-r8a77965" (R-Car M3-N)
     - "renesas,intc-ex-r8a77970" (R-Car V3M)
     - "renesas,intc-ex-r8a77980" (R-Car V3H)
+    - "renesas,intc-ex-r8a77990" (R-Car E3)
     - "renesas,intc-ex-r8a77995" (R-Car D3)
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
   interrupts.txt in this directory
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 393d2b524284..5a89a957641b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -128,6 +128,7 @@ config ARCH_MVEBU
 	select MVEBU_ICU
 	select MVEBU_ODMI
 	select MVEBU_PIC
+	select MVEBU_SEI
 	select OF_GPIO
 	select PINCTRL
 	select PINCTRL_ARMADA_37XX
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 60d6cc618f1c..f39a920496fb 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -321,11 +321,12 @@ void *platform_msi_get_host_data(struct irq_domain *domain)
  * Returns an irqdomain for @nvec interrupts
  */
 struct irq_domain *
-platform_msi_create_device_domain(struct device *dev,
-				  unsigned int nvec,
-				  irq_write_msi_msg_t write_msi_msg,
-				  const struct irq_domain_ops *ops,
-				  void *host_data)
+__platform_msi_create_device_domain(struct device *dev,
+				    unsigned int nvec,
+				    bool is_tree,
+				    irq_write_msi_msg_t write_msi_msg,
+				    const struct irq_domain_ops *ops,
+				    void *host_data)
 {
 	struct platform_msi_priv_data *data;
 	struct irq_domain *domain;
@@ -336,7 +337,8 @@ platform_msi_create_device_domain(struct device *dev,
 		return NULL;
 
 	data->host_data = host_data;
-	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
+	domain = irq_domain_create_hierarchy(dev->msi_domain, 0,
+					     is_tree ? 0 : nvec,
 					     dev->fwnode, ops, data);
 	if (!domain)
 		goto free_priv;
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 2a29dd9c986d..249eb70691b0 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -52,7 +52,8 @@ struct efi __read_mostly efi = {
 	.properties_table	= EFI_INVALID_TABLE_ADDR,
 	.mem_attr_table		= EFI_INVALID_TABLE_ADDR,
 	.rng_seed		= EFI_INVALID_TABLE_ADDR,
-	.tpm_log		= EFI_INVALID_TABLE_ADDR
+	.tpm_log		= EFI_INVALID_TABLE_ADDR,
+	.mem_reserve		= EFI_INVALID_TABLE_ADDR,
 };
 EXPORT_SYMBOL(efi);
 
@@ -484,6 +485,7 @@ static __initdata efi_config_table_type_t common_tables[] = {
 	{EFI_MEMORY_ATTRIBUTES_TABLE_GUID, "MEMATTR", &efi.mem_attr_table},
 	{LINUX_EFI_RANDOM_SEED_TABLE_GUID, "RNG", &efi.rng_seed},
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
+	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
 	{NULL_GUID, NULL, NULL},
 };
 
@@ -591,6 +593,29 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 		early_memunmap(tbl, sizeof(*tbl));
 	}
 
+	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
+		unsigned long prsv = efi.mem_reserve;
+
+		while (prsv) {
+			struct linux_efi_memreserve *rsv;
+
+			/* reserve the entry itself */
+			memblock_reserve(prsv, sizeof(*rsv));
+
+			rsv = early_memremap(prsv, sizeof(*rsv));
+			if (rsv == NULL) {
+				pr_err("Could not map UEFI memreserve entry!\n");
+				return -ENOMEM;
+			}
+
+			if (rsv->size)
+				memblock_reserve(rsv->base, rsv->size);
+
+			prsv = rsv->next;
+			early_memunmap(rsv, sizeof(*rsv));
+		}
+	}
+
 	return 0;
 }
 
@@ -937,6 +962,38 @@ bool efi_is_table_address(unsigned long phys_addr)
 	return false;
 }
 
+static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
+
+int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
+{
+	struct linux_efi_memreserve *rsv, *parent;
+
+	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
+		return -ENODEV;
+
+	rsv = kmalloc(sizeof(*rsv), GFP_KERNEL);
+	if (!rsv)
+		return -ENOMEM;
+
+	parent = memremap(efi.mem_reserve, sizeof(*rsv), MEMREMAP_WB);
+	if (!parent) {
+		kfree(rsv);
+		return -ENOMEM;
+	}
+
+	rsv->base = addr;
+	rsv->size = size;
+
+	spin_lock(&efi_mem_reserve_persistent_lock);
+	rsv->next = parent->next;
+	parent->next = __pa(rsv);
+	spin_unlock(&efi_mem_reserve_persistent_lock);
+
+	memunmap(parent);
+
+	return 0;
+}
+
 #ifdef CONFIG_KEXEC
 static int update_efi_random_seed(struct notifier_block *nb,
 				  unsigned long code, void *unused)
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 6920033de6d4..30ac0c975f8a 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -69,6 +69,31 @@ static struct screen_info *setup_graphics(efi_system_table_t *sys_table_arg)
 	return si;
 }
 
+void install_memreserve_table(efi_system_table_t *sys_table_arg)
+{
+	struct linux_efi_memreserve *rsv;
+	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
+	efi_status_t status;
+
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
+				(void **)&rsv);
+	if (status != EFI_SUCCESS) {
+		pr_efi_err(sys_table_arg, "Failed to allocate memreserve entry!\n");
+		return;
+	}
+
+	rsv->next = 0;
+	rsv->base = 0;
+	rsv->size = 0;
+
+	status = efi_call_early(install_configuration_table,
+				&memreserve_table_guid,
+				rsv);
+	if (status != EFI_SUCCESS)
+		pr_efi_err(sys_table_arg, "Failed to install memreserve config table!\n");
+}
+
+
 /*
  * This function handles the architcture specific differences between arm and
  * arm64 regarding where the kernel image must be loaded and any memory that
@@ -235,6 +260,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 		}
 	}
 
+	install_memreserve_table(sys_table);
+
 	new_fdt_addr = fdt_addr;
 	status = allocate_new_fdt_and_exit_boot(sys_table, handle,
 				&new_fdt_addr, efi_get_max_fdt_addr(dram_base),
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 383e7b70221d..96451b581452 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -310,6 +310,9 @@ config MVEBU_ODMI
 config MVEBU_PIC
 	bool
 
+config MVEBU_SEI
+        bool
+
 config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
 	depends on PCI && PCI_MSI
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index fbd1ec8070ef..b822199445ff 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_MVEBU_GICP)		+= irq-mvebu-gicp.o
 obj-$(CONFIG_MVEBU_ICU)			+= irq-mvebu-icu.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
+obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c2df341ff6fa..db20e992a40f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -19,13 +19,16 @@
 #include <linux/acpi_iort.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
+#include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
+#include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/list_sort.h>
 #include <linux/log2.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
 #include <linux/of.h>
@@ -52,6 +55,7 @@
 #define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
+#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
 
 static u32 lpi_id_bits;
 
@@ -64,7 +68,7 @@ static u32 lpi_id_bits;
 #define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
 #define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
 
-#define LPI_PROP_DEFAULT_PRIO	0xa0
+#define LPI_PROP_DEFAULT_PRIO	GICD_INT_DEF_PRI
 
 /*
  * Collection structure - just an ID, and a redistributor address to
@@ -173,6 +177,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
 static DEFINE_IDA(its_vpeid_ida);
 
 #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
+#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
@@ -1028,7 +1033,7 @@ static inline u32 its_get_event_id(struct irq_data *d)
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
 	irq_hw_number_t hwirq;
-	struct page *prop_page;
+	void *va;
 	u8 *cfg;
 
 	if (irqd_is_forwarded_to_vcpu(d)) {
@@ -1036,7 +1041,7 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		u32 event = its_get_event_id(d);
 		struct its_vlpi_map *map;
 
-		prop_page = its_dev->event_map.vm->vprop_page;
+		va = page_address(its_dev->event_map.vm->vprop_page);
 		map = &its_dev->event_map.vlpi_maps[event];
 		hwirq = map->vintid;
 
@@ -1044,11 +1049,11 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		map->properties &= ~clr;
 		map->properties |= set | LPI_PROP_GROUP1;
 	} else {
-		prop_page = gic_rdists->prop_page;
+		va = gic_rdists->prop_table_va;
 		hwirq = d->hwirq;
 	}
 
-	cfg = page_address(prop_page) + hwirq - 8192;
+	cfg = va + hwirq - 8192;
 	*cfg &= ~clr;
 	*cfg |= set | LPI_PROP_GROUP1;
 
@@ -1597,6 +1602,15 @@ static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
 	kfree(bitmap);
 }
 
+static void gic_reset_prop_table(void *va)
+{
+	/* Priority 0xa0, Group-1, disabled */
+	memset(va, LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1, LPI_PROPBASE_SZ);
+
+	/* Make sure the GIC will observe the written configuration */
+	gic_flush_dcache_to_poc(va, LPI_PROPBASE_SZ);
+}
+
 static struct page *its_allocate_prop_table(gfp_t gfp_flags)
 {
 	struct page *prop_page;
@@ -1605,13 +1619,7 @@ static struct page *its_allocate_prop_table(gfp_t gfp_flags)
 	if (!prop_page)
 		return NULL;
 
-	/* Priority 0xa0, Group-1, disabled */
-	memset(page_address(prop_page),
-	       LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1,
-	       LPI_PROPBASE_SZ);
-
-	/* Make sure the GIC will observe the written configuration */
-	gic_flush_dcache_to_poc(page_address(prop_page), LPI_PROPBASE_SZ);
+	gic_reset_prop_table(page_address(prop_page));
 
 	return prop_page;
 }
@@ -1622,20 +1630,74 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
-static int __init its_alloc_lpi_tables(void)
+static bool gic_check_reserved_range(phys_addr_t addr, unsigned long size)
 {
-	phys_addr_t paddr;
+	phys_addr_t start, end, addr_end;
+	u64 i;
 
-	lpi_id_bits = min_t(u32, GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
-				ITS_MAX_LPI_NRBITS);
-	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
-	if (!gic_rdists->prop_page) {
-		pr_err("Failed to allocate PROPBASE\n");
-		return -ENOMEM;
+	/*
+	 * We don't bother checking for a kdump kernel as by
+	 * construction, the LPI tables are out of this kernel's
+	 * memory map.
+	 */
+	if (is_kdump_kernel())
+		return true;
+
+	addr_end = addr + size - 1;
+
+	for_each_reserved_mem_region(i, &start, &end) {
+		if (addr >= start && addr_end <= end)
+			return true;
+	}
+
+	/* Not found, not a good sign... */
+	pr_warn("GICv3: Expected reserved range [%pa:%pa], not found\n",
+		&addr, &addr_end);
+	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+	return false;
+}
+
+static int gic_reserve_range(phys_addr_t addr, unsigned long size)
+{
+	if (efi_enabled(EFI_CONFIG_TABLES))
+		return efi_mem_reserve_persistent(addr, size);
+
+	return 0;
+}
+
+static int __init its_setup_lpi_prop_table(void)
+{
+	if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
+		u64 val;
+
+		val = gicr_read_propbaser(gic_data_rdist_rd_base() + GICR_PROPBASER);
+		lpi_id_bits = (val & GICR_PROPBASER_IDBITS_MASK) + 1;
+
+		gic_rdists->prop_table_pa = val & GENMASK_ULL(51, 12);
+		gic_rdists->prop_table_va = memremap(gic_rdists->prop_table_pa,
+						     LPI_PROPBASE_SZ,
+						     MEMREMAP_WB);
+		gic_reset_prop_table(gic_rdists->prop_table_va);
+	} else {
+		struct page *page;
+
+		lpi_id_bits = min_t(u32,
+				    GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
+				    ITS_MAX_LPI_NRBITS);
+		page = its_allocate_prop_table(GFP_NOWAIT);
+		if (!page) {
+			pr_err("Failed to allocate PROPBASE\n");
+			return -ENOMEM;
+		}
+
+		gic_rdists->prop_table_pa = page_to_phys(page);
+		gic_rdists->prop_table_va = page_address(page);
+		WARN_ON(gic_reserve_range(gic_rdists->prop_table_pa,
+					  LPI_PROPBASE_SZ));
 	}
 
-	paddr = page_to_phys(gic_rdists->prop_page);
-	pr_info("GIC: using LPI property table @%pa\n", &paddr);
+	pr_info("GICv3: using LPI property table @%pa\n",
+		&gic_rdists->prop_table_pa);
 
 	return its_lpi_init(lpi_id_bits);
 }
@@ -1924,12 +1986,9 @@ static int its_alloc_collections(struct its_node *its)
 static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 {
 	struct page *pend_page;
-	/*
-	 * The pending pages have to be at least 64kB aligned,
-	 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
-	 */
+
 	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
-				get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
+				get_order(LPI_PENDBASE_SZ));
 	if (!pend_page)
 		return NULL;
 
@@ -1941,36 +2000,103 @@ static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 
 static void its_free_pending_table(struct page *pt)
 {
-	free_pages((unsigned long)page_address(pt),
-		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
+	free_pages((unsigned long)page_address(pt), get_order(LPI_PENDBASE_SZ));
+}
+
+/*
+ * Booting with kdump and LPIs enabled is generally fine. Any other
+ * case is wrong in the absence of firmware/EFI support.
+ */
+static bool enabled_lpis_allowed(void)
+{
+	phys_addr_t addr;
+	u64 val;
+
+	/* Check whether the property table is in a reserved region */
+	val = gicr_read_propbaser(gic_data_rdist_rd_base() + GICR_PROPBASER);
+	addr = val & GENMASK_ULL(51, 12);
+
+	return gic_check_reserved_range(addr, LPI_PROPBASE_SZ);
+}
+
+static int __init allocate_lpi_tables(void)
+{
+	u64 val;
+	int err, cpu;
+
+	/*
+	 * If LPIs are enabled while we run this from the boot CPU,
+	 * flag the RD tables as pre-allocated if the stars do align.
+	 */
+	val = readl_relaxed(gic_data_rdist_rd_base() + GICR_CTLR);
+	if ((val & GICR_CTLR_ENABLE_LPIS) && enabled_lpis_allowed()) {
+		gic_rdists->flags |= (RDIST_FLAGS_RD_TABLES_PREALLOCATED |
+				      RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING);
+		pr_info("GICv3: Using preallocated redistributor tables\n");
+	}
+
+	err = its_setup_lpi_prop_table();
+	if (err)
+		return err;
+
+	/*
+	 * We allocate all the pending tables anyway, as we may have a
+	 * mix of RDs that have had LPIs enabled, and some that
+	 * don't. We'll free the unused ones as each CPU comes online.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct page *pend_page;
+
+		pend_page = its_allocate_pending_table(GFP_NOWAIT);
+		if (!pend_page) {
+			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
+			return -ENOMEM;
+		}
+
+		gic_data_rdist_cpu(cpu)->pend_page = pend_page;
+	}
+
+	return 0;
 }
 
 static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
 	struct page *pend_page;
+	phys_addr_t paddr;
 	u64 val, tmp;
 
-	/* If we didn't allocate the pending table yet, do it now */
-	pend_page = gic_data_rdist()->pend_page;
-	if (!pend_page) {
-		phys_addr_t paddr;
+	if (gic_data_rdist()->lpi_enabled)
+		return;
 
-		pend_page = its_allocate_pending_table(GFP_NOWAIT);
-		if (!pend_page) {
-			pr_err("Failed to allocate PENDBASE for CPU%d\n",
-			       smp_processor_id());
-			return;
-		}
+	val = readl_relaxed(rbase + GICR_CTLR);
+	if ((gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) &&
+	    (val & GICR_CTLR_ENABLE_LPIS)) {
+		/*
+		 * Check that we get the same property table on all
+		 * RDs. If we don't, this is hopeless.
+		 */
+		paddr = gicr_read_propbaser(rbase + GICR_PROPBASER);
+		paddr &= GENMASK_ULL(51, 12);
+		if (WARN_ON(gic_rdists->prop_table_pa != paddr))
+			add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+
+		paddr = gicr_read_pendbaser(rbase + GICR_PENDBASER);
+		paddr &= GENMASK_ULL(51, 16);
 
-		paddr = page_to_phys(pend_page);
-		pr_info("CPU%d: using LPI pending table @%pa\n",
-			smp_processor_id(), &paddr);
-		gic_data_rdist()->pend_page = pend_page;
+		WARN_ON(!gic_check_reserved_range(paddr, LPI_PENDBASE_SZ));
+		its_free_pending_table(gic_data_rdist()->pend_page);
+		gic_data_rdist()->pend_page = NULL;
+
+		goto out;
 	}
 
+	pend_page = gic_data_rdist()->pend_page;
+	paddr = page_to_phys(pend_page);
+	WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
+
 	/* set PROPBASE */
-	val = (page_to_phys(gic_rdists->prop_page) |
+	val = (gic_rdists->prop_table_pa |
 	       GICR_PROPBASER_InnerShareable |
 	       GICR_PROPBASER_RaWaWb |
 	       ((LPI_NRBITS - 1) & GICR_PROPBASER_IDBITS_MASK));
@@ -2020,6 +2146,12 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
+out:
+	gic_data_rdist()->lpi_enabled = true;
+	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
+		smp_processor_id(),
+		gic_data_rdist()->pend_page ? "allocated" : "reserved",
+		&paddr);
 }
 
 static void its_cpu_init_collection(struct its_node *its)
@@ -3498,16 +3630,6 @@ static int redist_disable_lpis(void)
 	u64 timeout = USEC_PER_SEC;
 	u64 val;
 
-	/*
-	 * If coming via a CPU hotplug event, we don't need to disable
-	 * LPIs before trying to re-enable them. They are already
-	 * configured and all is well in the world. Detect this case
-	 * by checking the allocation of the pending table for the
-	 * current CPU.
-	 */
-	if (gic_data_rdist()->pend_page)
-		return 0;
-
 	if (!gic_rdists_supports_plpis()) {
 		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
 		return -ENXIO;
@@ -3517,7 +3639,21 @@ static int redist_disable_lpis(void)
 	if (!(val & GICR_CTLR_ENABLE_LPIS))
 		return 0;
 
-	pr_warn("CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
+	/*
+	 * If coming via a CPU hotplug event, we don't need to disable
+	 * LPIs before trying to re-enable them. They are already
+	 * configured and all is well in the world.
+	 *
+	 * If running with preallocated tables, there is nothing to do.
+	 */
+	if (gic_data_rdist()->lpi_enabled ||
+	    (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED))
+		return 0;
+
+	/*
+	 * From that point on, we only try to do some damage control.
+	 */
+	pr_warn("GICv3: CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
 		smp_processor_id());
 	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
 
@@ -3773,7 +3909,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	err = its_alloc_lpi_tables();
+
+	err = allocate_lpi_tables();
 	if (err)
 		return err;
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d5912f1ec884..8f87f40c9460 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -348,48 +348,45 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 {
 	u32 irqnr;
 
-	do {
-		irqnr = gic_read_iar();
+	irqnr = gic_read_iar();
 
-		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
-			int err;
+	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
+		int err;
 
-			if (static_branch_likely(&supports_deactivate_key))
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_eoir(irqnr);
+		else
+			isb();
+
+		err = handle_domain_irq(gic_data.domain, irqnr, regs);
+		if (err) {
+			WARN_ONCE(true, "Unexpected interrupt received!\n");
+			if (static_branch_likely(&supports_deactivate_key)) {
+				if (irqnr < 8192)
+					gic_write_dir(irqnr);
+			} else {
 				gic_write_eoir(irqnr);
-			else
-				isb();
-
-			err = handle_domain_irq(gic_data.domain, irqnr, regs);
-			if (err) {
-				WARN_ONCE(true, "Unexpected interrupt received!\n");
-				if (static_branch_likely(&supports_deactivate_key)) {
-					if (irqnr < 8192)
-						gic_write_dir(irqnr);
-				} else {
-					gic_write_eoir(irqnr);
-				}
 			}
-			continue;
 		}
-		if (irqnr < 16) {
-			gic_write_eoir(irqnr);
-			if (static_branch_likely(&supports_deactivate_key))
-				gic_write_dir(irqnr);
+		return;
+	}
+	if (irqnr < 16) {
+		gic_write_eoir(irqnr);
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_dir(irqnr);
 #ifdef CONFIG_SMP
-			/*
-			 * Unlike GICv2, we don't need an smp_rmb() here.
-			 * The control dependency from gic_read_iar to
-			 * the ISB in gic_write_eoir is enough to ensure
-			 * that any shared data read by handle_IPI will
-			 * be read after the ACK.
-			 */
-			handle_IPI(irqnr, regs);
+		/*
+		 * Unlike GICv2, we don't need an smp_rmb() here.
+		 * The control dependency from gic_read_iar to
+		 * the ISB in gic_write_eoir is enough to ensure
+		 * that any shared data read by handle_IPI will
+		 * be read after the ACK.
+		 */
+		handle_IPI(irqnr, regs);
 #else
-			WARN_ONCE(true, "Unexpected SGI received!\n");
+		WARN_ONCE(true, "Unexpected SGI received!\n");
 #endif
-			continue;
-		}
-	} while (irqnr != ICC_IAR1_EL1_SPURIOUS);
+	}
 }
 
 static void __init gic_dist_init(void)
@@ -653,7 +650,9 @@ early_param("irqchip.gicv3_nolpi", gicv3_nolpi_cfg);
 
 static int gic_dist_supports_lpis(void)
 {
-	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) && !gicv3_nolpi;
+	return (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) &&
+		!!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) &&
+		!gicv3_nolpi);
 }
 
 static void gic_cpu_init(void)
@@ -673,10 +672,6 @@ static void gic_cpu_init(void)
 
 	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
 
-	/* Give LPIs a spin */
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_cpu_init();
-
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
 }
@@ -689,6 +684,10 @@ static void gic_cpu_init(void)
 static int gic_starting_cpu(unsigned int cpu)
 {
 	gic_cpu_init();
+
+	if (gic_dist_supports_lpis())
+		its_cpu_init();
+
 	return 0;
 }
 
@@ -1127,14 +1126,16 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_update_vlpi_properties();
 
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_init(handle, &gic_data.rdists, gic_data.domain);
-
 	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
 	gic_cpu_pm_init();
 
+	if (gic_dist_supports_lpis()) {
+		its_init(handle, &gic_data.rdists, gic_data.domain);
+		its_cpu_init();
+	}
+
 	return 0;
 
 out_free:
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 13063339b416..547045d89c4b 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
+#include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
@@ -26,6 +27,10 @@
 #define ICU_SETSPI_NSR_AH	0x14
 #define ICU_CLRSPI_NSR_AL	0x18
 #define ICU_CLRSPI_NSR_AH	0x1c
+#define ICU_SET_SEI_AL		0x50
+#define ICU_SET_SEI_AH		0x54
+#define ICU_CLR_SEI_AL		0x58
+#define ICU_CLR_SEI_AH		0x5C
 #define ICU_INT_CFG(x)          (0x100 + 4 * (x))
 #define   ICU_INT_ENABLE	BIT(24)
 #define   ICU_IS_EDGE		BIT(28)
@@ -36,12 +41,23 @@
 #define ICU_SATA0_ICU_ID	109
 #define ICU_SATA1_ICU_ID	107
 
+struct mvebu_icu_subset_data {
+	unsigned int icu_group;
+	unsigned int offset_set_ah;
+	unsigned int offset_set_al;
+	unsigned int offset_clr_ah;
+	unsigned int offset_clr_al;
+};
+
 struct mvebu_icu {
-	struct irq_chip irq_chip;
 	void __iomem *base;
-	struct irq_domain *domain;
 	struct device *dev;
+};
+
+struct mvebu_icu_msi_data {
+	struct mvebu_icu *icu;
 	atomic_t initialized;
+	const struct mvebu_icu_subset_data *subset_data;
 };
 
 struct mvebu_icu_irq_data {
@@ -50,28 +66,40 @@ struct mvebu_icu_irq_data {
 	unsigned int type;
 };
 
-static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
+DEFINE_STATIC_KEY_FALSE(legacy_bindings);
+
+static void mvebu_icu_init(struct mvebu_icu *icu,
+			   struct mvebu_icu_msi_data *msi_data,
+			   struct msi_msg *msg)
 {
-	if (atomic_cmpxchg(&icu->initialized, false, true))
+	const struct mvebu_icu_subset_data *subset = msi_data->subset_data;
+
+	if (atomic_cmpxchg(&msi_data->initialized, false, true))
 		return;
 
-	/* Set Clear/Set ICU SPI message address in AP */
-	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
-	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
-	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
-	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
+	/* Set 'SET' ICU SPI message address in AP */
+	writel_relaxed(msg[0].address_hi, icu->base + subset->offset_set_ah);
+	writel_relaxed(msg[0].address_lo, icu->base + subset->offset_set_al);
+
+	if (subset->icu_group != ICU_GRP_NSR)
+		return;
+
+	/* Set 'CLEAR' ICU SPI message address in AP (level-MSI only) */
+	writel_relaxed(msg[1].address_hi, icu->base + subset->offset_clr_ah);
+	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
 }
 
 static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct irq_data *d = irq_get_irq_data(desc->irq);
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d->domain);
 	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
 	struct mvebu_icu *icu = icu_irqd->icu;
 	unsigned int icu_int;
 
 	if (msg->address_lo || msg->address_hi) {
-		/* One off initialization */
-		mvebu_icu_init(icu, msg);
+		/* One off initialization per domain */
+		mvebu_icu_init(icu, msi_data, msg);
 		/* Configure the ICU with irq number & type */
 		icu_int = msg->data | ICU_INT_ENABLE;
 		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
@@ -101,37 +129,66 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	}
 }
 
+static struct irq_chip mvebu_icu_nsr_chip = {
+	.name			= "ICU-NSR",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static struct irq_chip mvebu_icu_sei_chip = {
+	.name			= "ICU-SEI",
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
 static int
 mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
-	struct mvebu_icu *icu = d->host_data;
-	unsigned int icu_group;
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
+	struct mvebu_icu *icu = platform_msi_get_host_data(d);
+	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
 
 	/* Check the count of the parameters in dt */
-	if (WARN_ON(fwspec->param_count < 3)) {
+	if (WARN_ON(fwspec->param_count != param_count)) {
 		dev_err(icu->dev, "wrong ICU parameter count %d\n",
 			fwspec->param_count);
 		return -EINVAL;
 	}
 
-	/* Only ICU group type is handled */
-	icu_group = fwspec->param[0];
-	if (icu_group != ICU_GRP_NSR && icu_group != ICU_GRP_SR &&
-	    icu_group != ICU_GRP_SEI && icu_group != ICU_GRP_REI) {
-		dev_err(icu->dev, "wrong ICU group type %x\n", icu_group);
-		return -EINVAL;
+	if (static_branch_unlikely(&legacy_bindings)) {
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		if (fwspec->param[0] != ICU_GRP_NSR) {
+			dev_err(icu->dev, "wrong ICU group type %x\n",
+				fwspec->param[0]);
+			return -EINVAL;
+		}
+	} else {
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+		/*
+		 * The ICU receives level interrupts. While the NSR are also
+		 * level interrupts, SEI are edge interrupts. Force the type
+		 * here in this case. Please note that this makes the interrupt
+		 * handling unreliable.
+		 */
+		if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
+			*type = IRQ_TYPE_EDGE_RISING;
 	}
 
-	*hwirq = fwspec->param[1];
 	if (*hwirq >= ICU_MAX_IRQS) {
 		dev_err(icu->dev, "invalid interrupt number %ld\n", *hwirq);
 		return -EINVAL;
 	}
 
-	/* Mask the type to prevent wrong DT configuration */
-	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
-
 	return 0;
 }
 
@@ -142,8 +199,10 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int err;
 	unsigned long hwirq;
 	struct irq_fwspec *fwspec = args;
-	struct mvebu_icu *icu = platform_msi_get_host_data(domain);
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(domain);
+	struct mvebu_icu *icu = msi_data->icu;
 	struct mvebu_icu_irq_data *icu_irqd;
+	struct irq_chip *chip = &mvebu_icu_nsr_chip;
 
 	icu_irqd = kmalloc(sizeof(*icu_irqd), GFP_KERNEL);
 	if (!icu_irqd)
@@ -156,7 +215,10 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		goto free_irqd;
 	}
 
-	icu_irqd->icu_group = fwspec->param[0];
+	if (static_branch_unlikely(&legacy_bindings))
+		icu_irqd->icu_group = fwspec->param[0];
+	else
+		icu_irqd->icu_group = msi_data->subset_data->icu_group;
 	icu_irqd->icu = icu;
 
 	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
@@ -170,8 +232,11 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (err)
 		goto free_msi;
 
+	if (icu_irqd->icu_group == ICU_GRP_SEI)
+		chip = &mvebu_icu_sei_chip;
+
 	err = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					    &icu->irq_chip, icu_irqd);
+					    chip, icu_irqd);
 	if (err) {
 		dev_err(icu->dev, "failed to set the data to IRQ domain\n");
 		goto free_msi;
@@ -204,11 +269,84 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
 	.free      = mvebu_icu_irq_domain_free,
 };
 
+static const struct mvebu_icu_subset_data mvebu_icu_nsr_subset_data = {
+	.icu_group = ICU_GRP_NSR,
+	.offset_set_ah = ICU_SETSPI_NSR_AH,
+	.offset_set_al = ICU_SETSPI_NSR_AL,
+	.offset_clr_ah = ICU_CLRSPI_NSR_AH,
+	.offset_clr_al = ICU_CLRSPI_NSR_AL,
+};
+
+static const struct mvebu_icu_subset_data mvebu_icu_sei_subset_data = {
+	.icu_group = ICU_GRP_SEI,
+	.offset_set_ah = ICU_SET_SEI_AH,
+	.offset_set_al = ICU_SET_SEI_AL,
+};
+
+static const struct of_device_id mvebu_icu_subset_of_match[] = {
+	{
+		.compatible = "marvell,cp110-icu-nsr",
+		.data = &mvebu_icu_nsr_subset_data,
+	},
+	{
+		.compatible = "marvell,cp110-icu-sei",
+		.data = &mvebu_icu_sei_subset_data,
+	},
+	{},
+};
+
+static int mvebu_icu_subset_probe(struct platform_device *pdev)
+{
+	struct mvebu_icu_msi_data *msi_data;
+	struct device_node *msi_parent_dn;
+	struct device *dev = &pdev->dev;
+	struct irq_domain *irq_domain;
+
+	msi_data = devm_kzalloc(dev, sizeof(*msi_data), GFP_KERNEL);
+	if (!msi_data)
+		return -ENOMEM;
+
+	if (static_branch_unlikely(&legacy_bindings)) {
+		msi_data->icu = dev_get_drvdata(dev);
+		msi_data->subset_data = &mvebu_icu_nsr_subset_data;
+	} else {
+		msi_data->icu = dev_get_drvdata(dev->parent);
+		msi_data->subset_data = of_device_get_match_data(dev);
+	}
+
+	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
+					    DOMAIN_BUS_PLATFORM_MSI);
+	if (!dev->msi_domain)
+		return -EPROBE_DEFER;
+
+	msi_parent_dn = irq_domain_get_of_node(dev->msi_domain);
+	if (!msi_parent_dn)
+		return -ENODEV;
+
+	irq_domain = platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
+							    mvebu_icu_write_msg,
+							    &mvebu_icu_domain_ops,
+							    msi_data);
+	if (!irq_domain) {
+		dev_err(dev, "Failed to create ICU MSI domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static struct platform_driver mvebu_icu_subset_driver = {
+	.probe  = mvebu_icu_subset_probe,
+	.driver = {
+		.name = "mvebu-icu-subset",
+		.of_match_table = mvebu_icu_subset_of_match,
+	},
+};
+builtin_platform_driver(mvebu_icu_subset_driver);
+
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
-	struct device_node *node = pdev->dev.of_node;
-	struct device_node *gicp_dn;
 	struct resource *res;
 	int i;
 
@@ -226,53 +364,38 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 		return PTR_ERR(icu->base);
 	}
 
-	icu->irq_chip.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-					    "ICU.%x",
-					    (unsigned int)res->start);
-	if (!icu->irq_chip.name)
-		return -ENOMEM;
-
-	icu->irq_chip.irq_mask = irq_chip_mask_parent;
-	icu->irq_chip.irq_unmask = irq_chip_unmask_parent;
-	icu->irq_chip.irq_eoi = irq_chip_eoi_parent;
-	icu->irq_chip.irq_set_type = irq_chip_set_type_parent;
-#ifdef CONFIG_SMP
-	icu->irq_chip.irq_set_affinity = irq_chip_set_affinity_parent;
-#endif
-
 	/*
-	 * We're probed after MSI domains have been resolved, so force
-	 * resolution here.
+	 * Legacy bindings: ICU is one node with one MSI parent: force manually
+	 *                  the probe of the NSR interrupts side.
+	 * New bindings: ICU node has children, one per interrupt controller
+	 *               having its own MSI parent: call platform_populate().
+	 * All ICU instances should use the same bindings.
 	 */
-	pdev->dev.msi_domain = of_msi_get_domain(&pdev->dev, node,
-						 DOMAIN_BUS_PLATFORM_MSI);
-	if (!pdev->dev.msi_domain)
-		return -EPROBE_DEFER;
-
-	gicp_dn = irq_domain_get_of_node(pdev->dev.msi_domain);
-	if (!gicp_dn)
-		return -ENODEV;
+	if (!of_get_child_count(pdev->dev.of_node))
+		static_branch_enable(&legacy_bindings);
 
 	/*
-	 * Clean all ICU interrupts with type SPI_NSR, required to
+	 * Clean all ICU interrupts of type NSR and SEI, required to
 	 * avoid unpredictable SPI assignments done by firmware.
 	 */
 	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
-		u32 icu_int = readl_relaxed(icu->base + ICU_INT_CFG(i));
-		if ((icu_int >> ICU_GROUP_SHIFT) == ICU_GRP_NSR)
+		u32 icu_int, icu_grp;
+
+		icu_int = readl_relaxed(icu->base + ICU_INT_CFG(i));
+		icu_grp = icu_int >> ICU_GROUP_SHIFT;
+
+		if (icu_grp == ICU_GRP_NSR ||
+		    (icu_grp == ICU_GRP_SEI &&
+		     !static_branch_unlikely(&legacy_bindings)))
 			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
 	}
 
-	icu->domain =
-		platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
-						  mvebu_icu_write_msg,
-						  &mvebu_icu_domain_ops, icu);
-	if (!icu->domain) {
-		dev_err(&pdev->dev, "Failed to create ICU domain\n");
-		return -ENOMEM;
-	}
+	platform_set_drvdata(pdev, icu);
 
-	return 0;
+	if (static_branch_unlikely(&legacy_bindings))
+		return mvebu_icu_subset_probe(pdev);
+	else
+		return devm_of_platform_populate(&pdev->dev);
 }
 
 static const struct of_device_id mvebu_icu_of_match[] = {
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
new file mode 100644
index 000000000000..566d69a2edbc
--- /dev/null
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "mvebu-sei: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+/* Cause register */
+#define GICP_SECR(idx)		(0x0  + ((idx) * 0x4))
+/* Mask register */
+#define GICP_SEMR(idx)		(0x20 + ((idx) * 0x4))
+#define GICP_SET_SEI_OFFSET	0x30
+
+#define SEI_IRQ_COUNT_PER_REG	32
+#define SEI_IRQ_REG_COUNT	2
+#define SEI_IRQ_COUNT		(SEI_IRQ_COUNT_PER_REG * SEI_IRQ_REG_COUNT)
+#define SEI_IRQ_REG_IDX(irq_id)	((irq_id) / SEI_IRQ_COUNT_PER_REG)
+#define SEI_IRQ_REG_BIT(irq_id)	((irq_id) % SEI_IRQ_COUNT_PER_REG)
+
+struct mvebu_sei_interrupt_range {
+	u32 first;
+	u32 size;
+};
+
+struct mvebu_sei_caps {
+	struct mvebu_sei_interrupt_range ap_range;
+	struct mvebu_sei_interrupt_range cp_range;
+};
+
+struct mvebu_sei {
+	struct device *dev;
+	void __iomem *base;
+	struct resource *res;
+	struct irq_domain *sei_domain;
+	struct irq_domain *ap_domain;
+	struct irq_domain *cp_domain;
+	const struct mvebu_sei_caps *caps;
+
+	/* Lock on MSI allocations/releases */
+	struct mutex cp_msi_lock;
+	DECLARE_BITMAP(cp_msi_bitmap, SEI_IRQ_COUNT);
+
+	/* Lock on IRQ masking register */
+	raw_spinlock_t mask_lock;
+};
+
+static void mvebu_sei_ack_irq(struct irq_data *d)
+{
+	struct mvebu_sei *sei = irq_data_get_irq_chip_data(d);
+	u32 reg_idx = SEI_IRQ_REG_IDX(d->hwirq);
+
+	writel_relaxed(BIT(SEI_IRQ_REG_BIT(d->hwirq)),
+		       sei->base + GICP_SECR(reg_idx));
+}
+
+static void mvebu_sei_mask_irq(struct irq_data *d)
+{
+	struct mvebu_sei *sei = irq_data_get_irq_chip_data(d);
+	u32 reg, reg_idx = SEI_IRQ_REG_IDX(d->hwirq);
+	unsigned long flags;
+
+	/* 1 disables the interrupt */
+	raw_spin_lock_irqsave(&sei->mask_lock, flags);
+	reg = readl_relaxed(sei->base + GICP_SEMR(reg_idx));
+	reg |= BIT(SEI_IRQ_REG_BIT(d->hwirq));
+	writel_relaxed(reg, sei->base + GICP_SEMR(reg_idx));
+	raw_spin_unlock_irqrestore(&sei->mask_lock, flags);
+}
+
+static void mvebu_sei_unmask_irq(struct irq_data *d)
+{
+	struct mvebu_sei *sei = irq_data_get_irq_chip_data(d);
+	u32 reg, reg_idx = SEI_IRQ_REG_IDX(d->hwirq);
+	unsigned long flags;
+
+	/* 0 enables the interrupt */
+	raw_spin_lock_irqsave(&sei->mask_lock, flags);
+	reg = readl_relaxed(sei->base + GICP_SEMR(reg_idx));
+	reg &= ~BIT(SEI_IRQ_REG_BIT(d->hwirq));
+	writel_relaxed(reg, sei->base + GICP_SEMR(reg_idx));
+	raw_spin_unlock_irqrestore(&sei->mask_lock, flags);
+}
+
+static int mvebu_sei_set_affinity(struct irq_data *d,
+				  const struct cpumask *mask_val,
+				  bool force)
+{
+	return -EINVAL;
+}
+
+static int mvebu_sei_set_irqchip_state(struct irq_data *d,
+				       enum irqchip_irq_state which,
+				       bool state)
+{
+	/* We can only clear the pending state by acking the interrupt */
+	if (which != IRQCHIP_STATE_PENDING || state)
+		return -EINVAL;
+
+	mvebu_sei_ack_irq(d);
+	return 0;
+}
+
+static struct irq_chip mvebu_sei_irq_chip = {
+	.name			= "SEI",
+	.irq_ack		= mvebu_sei_ack_irq,
+	.irq_mask		= mvebu_sei_mask_irq,
+	.irq_unmask		= mvebu_sei_unmask_irq,
+	.irq_set_affinity       = mvebu_sei_set_affinity,
+	.irq_set_irqchip_state	= mvebu_sei_set_irqchip_state,
+};
+
+static int mvebu_sei_ap_set_type(struct irq_data *data, unsigned int type)
+{
+	if ((type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_LEVEL_HIGH)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct irq_chip mvebu_sei_ap_irq_chip = {
+	.name			= "AP SEI",
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_set_affinity       = irq_chip_set_affinity_parent,
+	.irq_set_type		= mvebu_sei_ap_set_type,
+};
+
+static void mvebu_sei_cp_compose_msi_msg(struct irq_data *data,
+					 struct msi_msg *msg)
+{
+	struct mvebu_sei *sei = data->chip_data;
+	phys_addr_t set = sei->res->start + GICP_SET_SEI_OFFSET;
+
+	msg->data = data->hwirq + sei->caps->cp_range.first;
+	msg->address_lo = lower_32_bits(set);
+	msg->address_hi = upper_32_bits(set);
+}
+
+static int mvebu_sei_cp_set_type(struct irq_data *data, unsigned int type)
+{
+	if ((type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct irq_chip mvebu_sei_cp_irq_chip = {
+	.name			= "CP SEI",
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_set_affinity       = irq_chip_set_affinity_parent,
+	.irq_set_type		= mvebu_sei_cp_set_type,
+	.irq_compose_msi_msg	= mvebu_sei_cp_compose_msi_msg,
+};
+
+static int mvebu_sei_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *arg)
+{
+	struct mvebu_sei *sei = domain->host_data;
+	struct irq_fwspec *fwspec = arg;
+
+	/* Not much to do, just setup the irqdata */
+	irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[0],
+				      &mvebu_sei_irq_chip, sei);
+
+	return 0;
+}
+
+static void mvebu_sei_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
+		irq_set_handler(virq + i, NULL);
+		irq_domain_reset_irq_data(d);
+	}
+}
+
+static const struct irq_domain_ops mvebu_sei_domain_ops = {
+	.alloc	= mvebu_sei_domain_alloc,
+	.free	= mvebu_sei_domain_free,
+};
+
+static int mvebu_sei_ap_translate(struct irq_domain *domain,
+				  struct irq_fwspec *fwspec,
+				  unsigned long *hwirq,
+				  unsigned int *type)
+{
+	*hwirq = fwspec->param[0];
+	*type  = IRQ_TYPE_LEVEL_HIGH;
+
+	return 0;
+}
+
+static int mvebu_sei_ap_alloc(struct irq_domain *domain, unsigned int virq,
+			      unsigned int nr_irqs, void *arg)
+{
+	struct mvebu_sei *sei = domain->host_data;
+	struct irq_fwspec fwspec;
+	unsigned long hwirq;
+	unsigned int type;
+	int err;
+
+	mvebu_sei_ap_translate(domain, arg, &hwirq, &type);
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 1;
+	fwspec.param[0] = hwirq + sei->caps->ap_range.first;
+
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (err)
+		return err;
+
+	irq_domain_set_info(domain, virq, hwirq,
+			    &mvebu_sei_ap_irq_chip, sei,
+			    handle_level_irq, NULL, NULL);
+	irq_set_probe(virq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops mvebu_sei_ap_domain_ops = {
+	.translate	= mvebu_sei_ap_translate,
+	.alloc		= mvebu_sei_ap_alloc,
+	.free		= irq_domain_free_irqs_parent,
+};
+
+static void mvebu_sei_cp_release_irq(struct mvebu_sei *sei, unsigned long hwirq)
+{
+	mutex_lock(&sei->cp_msi_lock);
+	clear_bit(hwirq, sei->cp_msi_bitmap);
+	mutex_unlock(&sei->cp_msi_lock);
+}
+
+static int mvebu_sei_cp_domain_alloc(struct irq_domain *domain,
+				     unsigned int virq, unsigned int nr_irqs,
+				     void *args)
+{
+	struct mvebu_sei *sei = domain->host_data;
+	struct irq_fwspec fwspec;
+	unsigned long hwirq;
+	int ret;
+
+	/* The software only supports single allocations for now */
+	if (nr_irqs != 1)
+		return -ENOTSUPP;
+
+	mutex_lock(&sei->cp_msi_lock);
+	hwirq = find_first_zero_bit(sei->cp_msi_bitmap,
+				    sei->caps->cp_range.size);
+	if (hwirq < sei->caps->cp_range.size)
+		set_bit(hwirq, sei->cp_msi_bitmap);
+	mutex_unlock(&sei->cp_msi_lock);
+
+	if (hwirq == sei->caps->cp_range.size)
+		return -ENOSPC;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 1;
+	fwspec.param[0] = hwirq + sei->caps->cp_range.first;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (ret)
+		goto free_irq;
+
+	irq_domain_set_info(domain, virq, hwirq,
+			    &mvebu_sei_cp_irq_chip, sei,
+			    handle_edge_irq, NULL, NULL);
+
+	return 0;
+
+free_irq:
+	mvebu_sei_cp_release_irq(sei, hwirq);
+	return ret;
+}
+
+static void mvebu_sei_cp_domain_free(struct irq_domain *domain,
+				     unsigned int virq, unsigned int nr_irqs)
+{
+	struct mvebu_sei *sei = domain->host_data;
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+
+	if (nr_irqs != 1 || d->hwirq >= sei->caps->cp_range.size) {
+		dev_err(sei->dev, "Invalid hwirq %lu\n", d->hwirq);
+		return;
+	}
+
+	mvebu_sei_cp_release_irq(sei, d->hwirq);
+	irq_domain_free_irqs_parent(domain, virq, 1);
+}
+
+static const struct irq_domain_ops mvebu_sei_cp_domain_ops = {
+	.alloc	= mvebu_sei_cp_domain_alloc,
+	.free	= mvebu_sei_cp_domain_free,
+};
+
+static struct irq_chip mvebu_sei_msi_irq_chip = {
+	.name		= "SEI pMSI",
+	.irq_ack	= irq_chip_ack_parent,
+	.irq_set_type	= irq_chip_set_type_parent,
+};
+
+static struct msi_domain_ops mvebu_sei_msi_ops = {
+};
+
+static struct msi_domain_info mvebu_sei_msi_domain_info = {
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
+	.ops	= &mvebu_sei_msi_ops,
+	.chip	= &mvebu_sei_msi_irq_chip,
+};
+
+static void mvebu_sei_handle_cascade_irq(struct irq_desc *desc)
+{
+	struct mvebu_sei *sei = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 idx;
+
+	chained_irq_enter(chip, desc);
+
+	for (idx = 0; idx < SEI_IRQ_REG_COUNT; idx++) {
+		unsigned long irqmap;
+		int bit;
+
+		irqmap = readl_relaxed(sei->base + GICP_SECR(idx));
+		for_each_set_bit(bit, &irqmap, SEI_IRQ_COUNT_PER_REG) {
+			unsigned long hwirq;
+			unsigned int virq;
+
+			hwirq = idx * SEI_IRQ_COUNT_PER_REG + bit;
+			virq = irq_find_mapping(sei->sei_domain, hwirq);
+			if (likely(virq)) {
+				generic_handle_irq(virq);
+				continue;
+			}
+
+			dev_warn(sei->dev,
+				 "Spurious IRQ detected (hwirq %lu)\n", hwirq);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void mvebu_sei_reset(struct mvebu_sei *sei)
+{
+	u32 reg_idx;
+
+	/* Clear IRQ cause registers, mask all interrupts */
+	for (reg_idx = 0; reg_idx < SEI_IRQ_REG_COUNT; reg_idx++) {
+		writel_relaxed(0xFFFFFFFF, sei->base + GICP_SECR(reg_idx));
+		writel_relaxed(0xFFFFFFFF, sei->base + GICP_SEMR(reg_idx));
+	}
+}
+
+static int mvebu_sei_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct irq_domain *plat_domain;
+	struct mvebu_sei *sei;
+	u32 parent_irq;
+	int ret;
+
+	sei = devm_kzalloc(&pdev->dev, sizeof(*sei), GFP_KERNEL);
+	if (!sei)
+		return -ENOMEM;
+
+	sei->dev = &pdev->dev;
+
+	mutex_init(&sei->cp_msi_lock);
+	raw_spin_lock_init(&sei->mask_lock);
+
+	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sei->base = devm_ioremap_resource(sei->dev, sei->res);
+	if (!sei->base) {
+		dev_err(sei->dev, "Failed to remap SEI resource\n");
+		return -ENODEV;
+	}
+
+	/* Retrieve the SEI capabilities with the interrupt ranges */
+	sei->caps = of_device_get_match_data(&pdev->dev);
+	if (!sei->caps) {
+		dev_err(sei->dev,
+			"Could not retrieve controller capabilities\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Reserve the single (top-level) parent SPI IRQ from which all the
+	 * interrupts handled by this driver will be signaled.
+	 */
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (parent_irq <= 0) {
+		dev_err(sei->dev, "Failed to retrieve top-level SPI IRQ\n");
+		return -ENODEV;
+	}
+
+	/* Create the root SEI domain */
+	sei->sei_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+						   (sei->caps->ap_range.size +
+						    sei->caps->cp_range.size),
+						   &mvebu_sei_domain_ops,
+						   sei);
+	if (!sei->sei_domain) {
+		dev_err(sei->dev, "Failed to create SEI IRQ domain\n");
+		ret = -ENOMEM;
+		goto dispose_irq;
+	}
+
+	irq_domain_update_bus_token(sei->sei_domain, DOMAIN_BUS_NEXUS);
+
+	/* Create the 'wired' domain */
+	sei->ap_domain = irq_domain_create_hierarchy(sei->sei_domain, 0,
+						     sei->caps->ap_range.size,
+						     of_node_to_fwnode(node),
+						     &mvebu_sei_ap_domain_ops,
+						     sei);
+	if (!sei->ap_domain) {
+		dev_err(sei->dev, "Failed to create AP IRQ domain\n");
+		ret = -ENOMEM;
+		goto remove_sei_domain;
+	}
+
+	irq_domain_update_bus_token(sei->ap_domain, DOMAIN_BUS_WIRED);
+
+	/* Create the 'MSI' domain */
+	sei->cp_domain = irq_domain_create_hierarchy(sei->sei_domain, 0,
+						     sei->caps->cp_range.size,
+						     of_node_to_fwnode(node),
+						     &mvebu_sei_cp_domain_ops,
+						     sei);
+	if (!sei->cp_domain) {
+		pr_err("Failed to create CPs IRQ domain\n");
+		ret = -ENOMEM;
+		goto remove_ap_domain;
+	}
+
+	irq_domain_update_bus_token(sei->cp_domain, DOMAIN_BUS_GENERIC_MSI);
+
+	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
+						     &mvebu_sei_msi_domain_info,
+						     sei->cp_domain);
+	if (!plat_domain) {
+		pr_err("Failed to create CPs MSI domain\n");
+		ret = -ENOMEM;
+		goto remove_cp_domain;
+	}
+
+	mvebu_sei_reset(sei);
+
+	irq_set_chained_handler_and_data(parent_irq,
+					 mvebu_sei_handle_cascade_irq,
+					 sei);
+
+	return 0;
+
+remove_cp_domain:
+	irq_domain_remove(sei->cp_domain);
+remove_ap_domain:
+	irq_domain_remove(sei->ap_domain);
+remove_sei_domain:
+	irq_domain_remove(sei->sei_domain);
+dispose_irq:
+	irq_dispose_mapping(parent_irq);
+
+	return ret;
+}
+
+struct mvebu_sei_caps mvebu_sei_ap806_caps = {
+	.ap_range = {
+		.first = 0,
+		.size = 21,
+	},
+	.cp_range = {
+		.first = 21,
+		.size = 43,
+	},
+};
+
+static const struct of_device_id mvebu_sei_of_match[] = {
+	{
+		.compatible = "marvell,ap806-sei",
+		.data = &mvebu_sei_ap806_caps,
+	},
+	{},
+};
+
+static struct platform_driver mvebu_sei_driver = {
+	.probe  = mvebu_sei_probe,
+	.driver = {
+		.name = "mvebu-sei",
+		.of_match_table = mvebu_sei_of_match,
+	},
+};
+builtin_platform_driver(mvebu_sei_driver);
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index b1b47a40a278..faa7d61b9d6c 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -124,6 +124,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
 		pdc_type = PDC_EDGE_DUAL;
+		type = IRQ_TYPE_EDGE_RISING;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 		pdc_type = PDC_LEVEL_HIGH;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 401e4b254e30..22e4de9d3700 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -672,6 +672,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
+#define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 
 typedef struct {
 	efi_guid_t guid;
@@ -957,6 +958,7 @@ extern struct efi {
 	unsigned long mem_attr_table;	/* memory attributes table */
 	unsigned long rng_seed;		/* UEFI firmware random seed */
 	unsigned long tpm_log;		/* TPM2 Event Log table */
+	unsigned long mem_reserve;	/* Linux EFI memreserve table */
 	efi_get_time_t *get_time;
 	efi_set_time_t *set_time;
 	efi_get_wakeup_time_t *get_wakeup_time;
@@ -1041,6 +1043,7 @@ extern int __init efi_uart_console_only (void);
 extern u64 efi_mem_desc_end(efi_memory_desc_t *md);
 extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md);
 extern void efi_mem_reserve(phys_addr_t addr, u64 size);
+extern int efi_mem_reserve_persistent(phys_addr_t addr, u64 size);
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
 		struct resource *data_resource, struct resource *bss_resource);
 extern void efi_reserve_boot_services(void);
@@ -1662,4 +1665,10 @@ extern int efi_tpm_eventlog_init(void);
 /* Workqueue to queue EFI Runtime Services */
 extern struct workqueue_struct *efi_rts_wq;
 
+struct linux_efi_memreserve {
+	phys_addr_t	next;
+	phys_addr_t	base;
+	phys_addr_t	size;
+};
+
 #endif /* _LINUX_EFI_H */
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index eeceac3376fc..1d6711c28271 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -45,7 +45,7 @@
  * IRQF_PERCPU - Interrupt is per cpu
  * IRQF_NOBALANCING - Flag to exclude this interrupt from irq balancing
  * IRQF_IRQPOLL - Interrupt is used for polling (only the interrupt that is
- *                registered first in an shared interrupt is considered for
+ *                registered first in a shared interrupt is considered for
  *                performance reasons)
  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
  *                Used by threaded interrupts which need to keep the
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 0a83b4379f34..9a1a479a2bf4 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -13,6 +13,12 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 
+#define GICD_INT_DEF_PRI		0xa0
+#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
+					(GICD_INT_DEF_PRI << 16) |\
+					(GICD_INT_DEF_PRI << 8) |\
+					GICD_INT_DEF_PRI)
+
 enum gic_type {
 	GIC_V2,
 	GIC_V3,
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 8bdbb5f29494..c2a7b863fc2e 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -585,8 +585,10 @@ struct rdists {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
+		bool		lpi_enabled;
 	} __percpu		*rdist;
-	struct page		*prop_page;
+	phys_addr_t		prop_table_pa;
+	void			*prop_table_va;
 	u64			flags;
 	u32			gicd_typer;
 	bool			has_vlpis;
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 6c4aaf04046c..626179077bb0 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -65,11 +65,6 @@
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
 #define GICD_INT_EN_CLR_PPI		0xffff0000
-#define GICD_INT_DEF_PRI		0xa0
-#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
-					(GICD_INT_DEF_PRI << 16) |\
-					(GICD_INT_DEF_PRI << 8) |\
-					GICD_INT_DEF_PRI)
 
 #define GICD_IIDR_IMPLEMENTER_SHIFT	0
 #define GICD_IIDR_IMPLEMENTER_MASK	(0xfff << GICD_IIDR_IMPLEMENTER_SHIFT)
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index dccfa65aee96..068aa46f0d55 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -75,6 +75,7 @@ struct irq_fwspec {
 enum irq_domain_bus_token {
 	DOMAIN_BUS_ANY		= 0,
 	DOMAIN_BUS_WIRED,
+	DOMAIN_BUS_GENERIC_MSI,
 	DOMAIN_BUS_PCI_MSI,
 	DOMAIN_BUS_PLATFORM_MSI,
 	DOMAIN_BUS_NEXUS,
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 5839d8062dfc..0e9c50052ff3 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -317,11 +317,18 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
 struct irq_domain *
-platform_msi_create_device_domain(struct device *dev,
-				  unsigned int nvec,
-				  irq_write_msi_msg_t write_msi_msg,
-				  const struct irq_domain_ops *ops,
-				  void *host_data);
+__platform_msi_create_device_domain(struct device *dev,
+				    unsigned int nvec,
+				    bool is_tree,
+				    irq_write_msi_msg_t write_msi_msg,
+				    const struct irq_domain_ops *ops,
+				    void *host_data);
+
+#define platform_msi_create_device_domain(dev, nvec, write, ops, data)	\
+	__platform_msi_create_device_domain(dev, nvec, false, write, ops, data)
+#define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
+	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
+
 int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nr_irqs);
 void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5d9fc01b60a6..3366d11c3e02 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -183,7 +183,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name = kstrdup(of_node_full_name(of_node), GFP_KERNEL);
+		name = kasprintf(GFP_KERNEL, "%pOF", of_node);
 		if (!name) {
 			kfree(domain);
 			return NULL;
@@ -867,7 +867,7 @@ void irq_dispose_mapping(unsigned int virq)
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
 /**
- * irq_find_mapping() - Find a linux irq from an hw irq number.
+ * irq_find_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
  */
@@ -1741,6 +1741,7 @@ static void debugfs_add_domain_dir(struct irq_domain *d)
 static void debugfs_remove_domain_dir(struct irq_domain *d)
 {
 	debugfs_remove(d->debugfs_file);
+	d->debugfs_file = NULL;
 }
 
 void __init irq_domain_debugfs_init(struct dentry *root)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fb86146037a7..9dbdccab3b6a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -927,6 +927,9 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 
 	local_bh_disable();
 	ret = action->thread_fn(action->irq, action->dev_id);
+	if (ret == IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	local_bh_enable();
 	return ret;
@@ -943,6 +946,9 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 	irqreturn_t ret;
 
 	ret = action->thread_fn(action->irq, action->dev_id);
+	if (ret == IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	return ret;
 }
@@ -1020,8 +1026,6 @@ static int irq_thread(void *data)
 		irq_thread_check_affinity(desc, action);
 
 		action_ret = handler_fn(desc, action);
-		if (action_ret == IRQ_HANDLED)
-			atomic_inc(&desc->threads_handled);
 		if (action_ret == IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 6f584861d329..9526895fe4ac 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -257,9 +257,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	int softirq_bit;
 
 	/*
-	 * Mask out PF_MEMALLOC s current task context is borrowed for the
-	 * softirq. A softirq handled such as network RX might set PF_MEMALLOC
-	 * again if the socket is related to swap
+	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
+	 * softirq. A softirq handled, such as network RX, might set PF_MEMALLOC
+	 * again if the socket is related to swapping.
 	 */
 	current->flags &= ~PF_MEMALLOC;
 
