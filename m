Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeEDUBl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:01:41 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:41293 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbeEDUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:01:39 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>
Cc: Jean Delvare <jdelvare@suse.com>, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 1/2] x86/amd_nb: Add support for Raven Ridge CPUs
Date: Fri,  4 May 2018 13:01:32 -0700
Message-Id: <1525464093-20280-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Raven Ridge root bridge and data fabric PCI IDs.
This is required for amd_pci_dev_to_node_id() and amd_smn_read().

Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: No change.
v2: Use naming scheme suggested by Borislav Petkov.

 arch/x86/kernel/amd_nb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index c88e0b127810..b481b95bd8f6 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -14,8 +14,11 @@
 #include <asm/amd_nb.h>
 
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
+#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
@@ -24,6 +27,7 @@ static u32 *flush_words;
 
 static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
 	{}
 };
 
@@ -39,6 +43,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{}
 };
@@ -51,6 +56,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
-- 
2.7.4
