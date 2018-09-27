Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AACC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1D321582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1D321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeI0XYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:24:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeI0XYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:24:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH4x6T101795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:04:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH4xWv101792;
        Thu, 27 Sep 2018 10:04:59 -0700
Date:   Thu, 27 Sep 2018 10:04:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-c6babb5806b77c6ca7078c3487bb0a29704a4e38@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, puwen@hygon.cn
Reply-To: mingo@kernel.org, puwen@hygon.cn, bp@suse.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <5f8877bd413f2ea0833378dd5454df0720e1c0df.1537885177.git.puwen@hygon.cn>
References: <5f8877bd413f2ea0833378dd5454df0720e1c0df.1537885177.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/pci, x86/amd_nb: Add Hygon Dhyana support to PCI
 and northbridge
Git-Commit-ID: c6babb5806b77c6ca7078c3487bb0a29704a4e38
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c6babb5806b77c6ca7078c3487bb0a29704a4e38
Gitweb:     https://git.kernel.org/tip/c6babb5806b77c6ca7078c3487bb0a29704a4e38
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Tue, 25 Sep 2018 22:46:11 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:28:58 +0200

x86/pci, x86/amd_nb: Add Hygon Dhyana support to PCI and northbridge

Hygon's PCI vendor ID is 0x1d94, and there are PCI devices
0x1450/0x1463/0x1464 for the host bridge on the Hygon Dhyana platform.
Add Hygon Dhyana support to the PCI and northbridge subsystems by using
the code path of AMD family 17h.

 [ bp: Massage commit message, sort local vars into reverse xmas tree
   order and move the amd_northbridges.num check up. ]

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Cc: helgaas@kernel.org
Cc: linux-pci@vger.kernel.org
Link: https://lkml.kernel.org/r/5f8877bd413f2ea0833378dd5454df0720e1c0df.1537885177.git.puwen@hygon.cn
---
 arch/x86/kernel/amd_nb.c | 45 +++++++++++++++++++++++++++++++++++++--------
 arch/x86/pci/amd_bus.c   |  6 ++++--
 include/linux/pci_ids.h  |  2 ++
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b51c6b183a35..a6eca647bc76 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -61,6 +61,21 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{}
 };
 
+static const struct pci_device_id hygon_root_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
+	{}
+};
+
+const struct pci_device_id hygon_nb_misc_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
+	{}
+};
+
+static const struct pci_device_id hygon_nb_link_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F4) },
+	{}
+};
+
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -194,15 +209,24 @@ EXPORT_SYMBOL_GPL(amd_df_indirect_read);
 
 int amd_cache_northbridges(void)
 {
-	u16 i = 0;
-	struct amd_northbridge *nb;
+	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
+	const struct pci_device_id *link_ids = amd_nb_link_ids;
+	const struct pci_device_id *root_ids = amd_root_ids;
 	struct pci_dev *root, *misc, *link;
+	struct amd_northbridge *nb;
+	u16 i = 0;
 
 	if (amd_northbridges.num)
 		return 0;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		root_ids = hygon_root_ids;
+		misc_ids = hygon_nb_misc_ids;
+		link_ids = hygon_nb_link_ids;
+	}
+
 	misc = NULL;
-	while ((misc = next_northbridge(misc, amd_nb_misc_ids)) != NULL)
+	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
 		i++;
 
 	if (!i)
@@ -218,11 +242,11 @@ int amd_cache_northbridges(void)
 	link = misc = root = NULL;
 	for (i = 0; i != amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = root =
-			next_northbridge(root, amd_root_ids);
+			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
-			next_northbridge(misc, amd_nb_misc_ids);
+			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link = link =
-			next_northbridge(link, amd_nb_link_ids);
+			next_northbridge(link, link_ids);
 	}
 
 	if (amd_gart_present())
@@ -261,6 +285,7 @@ EXPORT_SYMBOL_GPL(amd_cache_northbridges);
  */
 bool __init early_is_amd_nb(u32 device)
 {
+	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
@@ -268,8 +293,11 @@ bool __init early_is_amd_nb(u32 device)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return false;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		misc_ids = hygon_nb_misc_ids;
+
 	device >>= 16;
-	for (id = amd_nb_misc_ids; id->vendor; id++)
+	for (id = misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
 			return true;
 	return false;
@@ -281,7 +309,8 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
 	/* assume all cpus from fam10h have mmconfig */
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index 649bdde63e32..bfa50e65ef6c 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -93,7 +93,8 @@ static int __init early_root_info_init(void)
 		vendor = id & 0xffff;
 		device = (id>>16) & 0xffff;
 
-		if (vendor != PCI_VENDOR_ID_AMD)
+		if (vendor != PCI_VENDOR_ID_AMD &&
+		    vendor != PCI_VENDOR_ID_HYGON)
 			continue;
 
 		if (hb_probes[i].device == device) {
@@ -390,7 +391,8 @@ static int __init pci_io_ecs_init(void)
 
 static int __init amd_postcore_init(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 
 	early_root_info_init();
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d157983b84cf..8a0841c73f81 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2561,6 +2561,8 @@
 
 #define PCI_VENDOR_ID_AMAZON		0x1d0f
 
+#define PCI_VENDOR_ID_HYGON		0x1d94
+
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
