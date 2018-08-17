Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A1DC04ABB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E202124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E202124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeHQNfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:35:37 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:35:36 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MIe3k-1fsotc3lQO-002Dcj; Fri, 17 Aug 2018 12:27:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 14/15] PCI: make pcibios_root_bridge_prepare a callback
Date:   Fri, 17 Aug 2018 12:26:44 +0200
Message-Id: <20180817102645.3839621-15-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:vZ1tUwmaDYGgBzDuu0lrWWtkxQnlkXj5dtYX8zCbAbjMLPhmXwP
 t9LwpfD9mkpXEZveH7+fB8uk6X4OjdFYNyOnA1ey8wm+8CsZSfl/mDsjXOrb7MOd2PtYpje
 OlpTlmfI8HEz2MmVEtEV3Ua7aljIba3990heu2dTAIP1yUOKAYEcf+hRy1ZnQhsCmKw51jI
 +C4qufrNzYmzj/M0BHZrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dxliqE4bdUU=:3wNTq0x8GVJJDBiQ3AXqXs
 G1qv2M9EJ/R9gkV1bKMYZCs8sWmMSWUClGEIkfFaJ2W2G0STrO3wSkWADrlKtkCc9PfdTAoup
 3zxFFpGjrFC3KfzxAbZML6rOtKnoEb5e3CksJj+aa1fm6aeQMQTvedb371xxPgfGWKva598XF
 PUSLvS6C3LcfmUQxzp0qZhcq8yppA5YYztqdY4TGZalE1Y8SY+nXhfKO6wlKvVk8gBAw8bicO
 EVd+BdFeloh0voA6J06gKNEZYjc6N7/m2U+JDcnX3Ypj9EGMwtWwQMC/6iRinDdnA0fgkwqW4
 veqzwD45anZ44l+bkcdHI139spogAFCokqTAoS3lNwGdDFgnCrnv5wpnz92x18JhrHZFSK46h
 1ooUzAs76v4ReXOyxEaBYCIkZfLExQcmeFHG/69ANMAnxIAA7Yx8NyY+vmE5/VThcDYmgZXGe
 1jKXIZH/4ZFYKwPKIieTXdvXbmbnn+iTnmgndrm+wqozHbn1r61w/IAcy+XYfVEqj5uzXRSMJ
 1QxFviL9Dt34LjlL5KMfIJTwrsc9uYg7id2Spp2jrfngo0HnfwR71KrBA6ZNY7a0IAEr+OX4X
 030RsyIZnKMH2VTlrWfZhEjRisjQ8d9DdbWD9684DeNYA34N2KYNUgsazhi7hJGNV8xjU9sY+
 IW1+wFwF4nHlkdCh9SPWlrphoEsYEnEVQAW5fgWeSJm3dqoevlxFhDJCnasD5iu58MTk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcibios_root_bridge_prepare() is always used as a per host bridge
function, not per architecture.

Making it a callback in the pci_host_bridge instead lets the host
bridge implementation easily override it, and avoids the checks
in the architecture for which host bridge implementation is being
used.

Alternatively, we could probably just call the pcibios_root_bridge_prepare
after alloc_pci_host_bridge() here and get rid of it as a generic
interface altogether, but doing that has a slightly higher chance
of breaking something subtle.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/pci.c          | 18 ++++++++----------
 arch/ia64/pci/pci.c              | 15 ++++-----------
 arch/powerpc/kernel/pci-common.c |  9 +--------
 arch/x86/pci/acpi.c              | 15 ++++-----------
 drivers/acpi/pci_root.c          |  1 +
 drivers/pci/probe.c              | 28 ++++++++++++++++------------
 include/linux/acpi.h             |  2 ++
 include/linux/pci.h              |  3 +--
 8 files changed, 37 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 3d196c68e362..8958a7c32a9f 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -71,19 +71,17 @@ int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 	return root->segment;
 }
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+int acpi_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	if (!acpi_disabled) {
-		struct pci_config_window *cfg = bridge->bus->sysdata;
-		struct acpi_device *adev = to_acpi_device(cfg->parent);
-		struct device *bus_dev = &bridge->bus->dev;
+	struct pci_config_window *cfg = bridge->bus->sysdata;
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct device *bus_dev = &bridge->bus->dev;
 
-		ACPI_COMPANION_SET(&bridge->dev, adev);
-		set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
+	ACPI_COMPANION_SET(&bridge->dev, adev);
+	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
 
-		/* Try to assign the IRQ number when probing a new device */
-		bridge->alloc_irq = acpi_pci_irq_enable;
-	}
+	/* Try to assign the IRQ number when probing a new device */
+	bridge->alloc_irq = acpi_pci_irq_enable;
 
 	return 0;
 }
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 7ccc64d5fe3e..511b8a058d80 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -308,18 +308,11 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 				    &info->common, &info->controller);
 }
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+int acpi_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	/*
-	 * We pass NULL as parent to pci_create_root_bus(), so if it is not NULL
-	 * here, pci_create_root_bus() has been called by someone else and
-	 * sysdata is likely to be different from what we expect.  Let it go in
-	 * that case.
-	 */
-	if (!bridge->dev.parent) {
-		struct pci_controller *controller = bridge->bus->sysdata;
-		ACPI_COMPANION_SET(&bridge->dev, controller->companion);
-	}
+	struct pci_controller *controller = bridge->bus->sysdata;
+	ACPI_COMPANION_SET(&bridge->dev, controller->companion);
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index afc9598e4349..5e5c6dd7ebe8 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -771,14 +771,6 @@ int pci_proc_domain(struct pci_bus *bus)
 	return 1;
 }
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	if (ppc_md.pcibios_root_bridge_prepare)
-		return ppc_md.pcibios_root_bridge_prepare(bridge);
-
-	return 0;
-}
-
 /* This header fixup will do the resource fixup for all devices as they are
  * probed, but not for bridge ranges
  */
@@ -1612,6 +1604,7 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	pci_add_resource(&bridge->windows, &hose->busn);
 
 	bridge->bus_add_device = ppc_md->pcibios_bus_add_device;
+	bridge->prepare = ppc_md->pcibios_root_bridge_prepare;
 	bridge->dev.parent = hose->parent;
 	bridge->sysdata = hose;
 	bridge->busnr = hose->first_busno;
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 5559dcaddd5e..041b2003707c 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -382,18 +382,11 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	return bus;
 }
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+int acpi_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	/*
-	 * We pass NULL as parent to pci_create_root_bus(), so if it is not NULL
-	 * here, pci_create_root_bus() has been called by someone else and
-	 * sysdata is likely to be different from what we expect.  Let it go in
-	 * that case.
-	 */
-	if (!bridge->dev.parent) {
-		struct pci_sysdata *sd = bridge->bus->sysdata;
-		ACPI_COMPANION_SET(&bridge->dev, sd->companion);
-	}
+	struct pci_sysdata *sd = bridge->bus->sysdata;
+	ACPI_COMPANION_SET(&bridge->dev, sd->companion);
+
 	return 0;
 }
 
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 5f73de3b67c8..5da0f70c4e65 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -910,6 +910,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	bridge->sysdata = sysdata;
 	bridge->busnr = busnum;
 	bridge->ops = ops->pci_ops;
+	bridge->prepare = acpi_pci_root_bridge_prepare;
 	pci_set_host_bridge_release(bridge, acpi_pci_root_release_info,
 				    info);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index eaedb4fe143a..f493d7e299e6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -762,6 +762,22 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
+/**
+ * pcibios_root_bridge_prepare - Platform-specific host bridge setup
+ * @bridge: Host bridge to set up
+ *
+ * Host bridge drivers can do some last minute fixups on the bridge
+ * here. Usually this should be done before calling pci_register_host_bridge
+ * though, so this hook can be removed.
+ */
+static int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	if (bridge->prepare)
+		return bridge->prepare(bridge);
+
+	return 0;
+}
+
 /*
  * pci_register_host_bridge() - Register a host bridge without scanning
  *
@@ -2889,18 +2905,6 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
 
-/**
- * pcibios_root_bridge_prepare - Platform-specific host bridge setup
- * @bridge: Host bridge to set up
- *
- * Default empty implementation.  Replace with an architecture-specific setup
- * routine, if necessary.
- */
-int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	return 0;
-}
-
 void __weak pcibios_add_bus(struct pci_bus *bus)
 {
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9967ba2e0b31..62c0278a7614 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -336,12 +336,14 @@ extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 void acpi_unregister_gsi (u32 gsi);
 
 struct pci_dev;
+struct pci_host_bridge;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
 void acpi_penalize_sci_irq(int irq, int trigger, int polarity);
 void acpi_pci_irq_disable (struct pci_dev *dev);
+int acpi_pci_root_bridge_prepare(struct pci_host_bridge *bridge);
 
 extern int ec_read(u8 addr, u8 *val);
 extern int ec_write(u8 addr, u8 val);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1296d9fcc5da..24216daef6f8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -472,6 +472,7 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
+	int (*prepare)(struct pci_host_bridge *bridge);
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
@@ -518,8 +519,6 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data);
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
-
 /*
  * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
  * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
-- 
2.18.0

