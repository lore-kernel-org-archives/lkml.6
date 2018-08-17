Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A369C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44802208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44802208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeHQNag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:30:36 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeHQNae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:30:34 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LnjcV-1gM7mA1Qsh-00hrda; Fri, 17 Aug 2018 12:27:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 15/15] PCI: make pcibios_add_bus/remove_bus callbacks
Date:   Fri, 17 Aug 2018 12:26:45 +0200
Message-Id: <20180817102645.3839621-16-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:rGoCCDOtdTx0VIyssezT4pFtEqNhxuve6iKaXwJBHf+4WU+8faw
 Dpu9wq8RQiguXqn4V5akgwPWXgaOy5cgDTJiHcHLT3xv/oOaMtG54uC8vvLQSdW///4q0nw
 I5RKZeCd07/18v074X+Gqwju9Ri5zhyU1Epl7WlCft+LD22RQMCW/zNHZIYUSLUK+qnJWcB
 s4jqjjsW1kamBVSX4DlSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YniJy3MqZc4=:nm3kiV+WQhPrhRGL9FUae4
 i9umo/rybRlnAwRBDrn0Sy3HDXlVnfDLSzZOxABcc41K/uvEt/E68HLmwCmngDQ6OcM+2GNfd
 8nnlmOFxxtqtwHEzgVUkPB1fIDgojYiFYkK5qN4pJ6IayqWWxNen8/weDzNMc+qNOYKEBhrfq
 soau4uR6N3N+Xb1x6JECyrI9/ISINZ9G8yIgpAwed+3qbjZknFJVWrZ7V60urdilBY21F3Qt9
 pAr9l0vTc0+QkNtXxB+M/iVR9UgZ2yBhlZkkt5HQnB8NwazdTnh0qN2t5LQtqpL2L9hHypKpA
 +t/m5IyTJ9YzdRa+uMSX5qW5lv3m9F4ZVeI9fEvlmSRIt2+QzAJdoI99j6UnwvfgE8eSs1eyM
 ZTao4rMwDbxh2LQ4EpQqOwPxMPlTi+0IRKoGHG6O4AKxrLqiSnnvZseksx43Kn61k9BVDx1Ma
 ET7i6/K4sTPxQ1AXOAoM7ICrkL8j+hJuCPYMAgaAWZUeDi8fL+fpc25XRHVb/ysqeD2Q9A8mW
 8bcQvko0r7dsZGkIPuwyk9EEFPJu+I10wbaZa6GUEdw8HT0zpBa+zUc2ndEZTwlysp6t4h1Fv
 gshhS1OCrYReZLvwuaXZb11++WnFla0gulPGVHpXg6K4nlAbrbQIAkmTatn3WZC5VP+OL7Wm4
 xcoO4RnkSDCOS68WDbU/eGt0VezXnwrW1XiPIAvcYkjf7ZhcwV5SWPWDfCKOHJR3jiO0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are mostly not architecture specific but are meant for particular
PCI host bridge implementations, in particular for the ACPI version.

Turn them both into callback functions that are implemented by the
APCI PCI implementation as well as the one architecture that overrides
pcibios_remove_bus.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/pci.c | 10 ----------
 arch/ia64/pci/pci.c     | 10 ----------
 arch/s390/pci/pci.c     |  3 ++-
 arch/x86/pci/common.c   | 10 ----------
 drivers/acpi/pci_root.c |  2 ++
 drivers/pci/probe.c     | 12 ++++++++++--
 include/linux/pci.h     |  2 ++
 7 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 8958a7c32a9f..99fac25efe88 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -191,14 +191,4 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	return bus;
 }
 
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	acpi_pci_add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	acpi_pci_remove_bus(bus);
-}
-
 #endif
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 511b8a058d80..f47e0920d308 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -367,16 +367,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
 	platform_pci_fixup_bus(b);
 }
 
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	acpi_pci_add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	acpi_pci_remove_bus(bus);
-}
-
 void pcibios_set_master (struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index b21205f131ce..120beb83b6a5 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -769,7 +769,7 @@ static void zpci_free_domain(struct zpci_dev *zdev)
 	spin_unlock(&zpci_domain_lock);
 }
 
-void pcibios_remove_bus(struct pci_bus *bus)
+static void zpci_remove_bus(struct pci_bus *bus)
 {
 	struct zpci_dev *zdev = get_zdev_by_bus(bus);
 
@@ -801,6 +801,7 @@ static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 	bridge->sysdata = sysdata;
 	bridge->busnr = bus;
 	bridge->ops = ops;
+	bridge->remove_bus = zpci_remove_bus;
 
 	error = pci_scan_root_bus_bridge(bridge);
 	if (error < 0)
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 920d0885434c..987e6fefd5d3 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -168,16 +168,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
 		pcibios_fixup_device_resources(dev);
 }
 
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	acpi_pci_add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	acpi_pci_remove_bus(bus);
-}
-
 /*
  * Only use DMI information to set this if nothing was passed
  * on the kernel command line (which was parsed earlier).
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 5da0f70c4e65..cf7a9a7bf1e7 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -911,6 +911,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	bridge->busnr = busnum;
 	bridge->ops = ops->pci_ops;
 	bridge->prepare = acpi_pci_root_bridge_prepare;
+	bridge->add_bus = acpi_pci_add_bus;
+	bridge->remove_bus = acpi_pci_remove_bus;
 	pci_set_host_bridge_release(bridge, acpi_pci_root_release_info,
 				    info);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f493d7e299e6..86a678fa8c13 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2905,12 +2905,20 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
 
-void __weak pcibios_add_bus(struct pci_bus *bus)
+void pcibios_add_bus(struct pci_bus *bus)
 {
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+
+	if (bridge->add_bus)
+		bridge->add_bus(bus);
 }
 
-void __weak pcibios_remove_bus(struct pci_bus *bus)
+void pcibios_remove_bus(struct pci_bus *bus)
 {
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
+
+	if (bridge->remove_bus)
+		bridge->remove_bus(bus);
 }
 
 int pci_host_probe(struct pci_host_bridge *bridge)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 24216daef6f8..bc9635313747 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -479,6 +479,8 @@ struct pci_host_bridge {
 	void (*bus_add_device)(struct pci_dev *pdev);
 	int (*alloc_irq)(struct pci_dev *);
 	int (*free_irq)(struct pci_dev *);
+	void (*add_bus)(struct pci_bus *);
+	void (*remove_bus)(struct pci_bus *);
 	void		*release_data;
 	struct msi_controller *msi;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
-- 
2.18.0

