Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeEMT22 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 15:28:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36577 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeEMT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 15:28:27 -0400
Date: Sun, 13 May 2018 12:28:20 -0700
From: tip-bot for Joe Perches <tipbot@zytor.com>
Message-ID: <tip-e6d8c84a58380030457759ad6085f3792a76b2ce@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        joe@perches.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, joe@perches.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <ae1fa81a0d1fad87571967b91ea90f70f486e853.1525964384.git.joe@perches.com>
References: <ae1fa81a0d1fad87571967b91ea90f70f486e853.1525964384.git.joe@perches.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/mtrr: Rename main.c to mtrr.c and remove
 duplicate prefixes
Git-Commit-ID: e6d8c84a58380030457759ad6085f3792a76b2ce
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e6d8c84a58380030457759ad6085f3792a76b2ce
Gitweb:     https://git.kernel.org/tip/e6d8c84a58380030457759ad6085f3792a76b2ce
Author:     Joe Perches <joe@perches.com>
AuthorDate: Thu, 10 May 2018 08:45:31 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 21:25:18 +0200

x86/mtrr: Rename main.c to mtrr.c and remove duplicate prefixes

Kbuild uses the first file as the name for KBUILD_MODNAME.
mtrr uses main.c as its first file, so rename that file to mtrr.c
and fixup the Makefile.

Remove the now duplicate "mtrr: " prefixes from the logging calls.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/ae1fa81a0d1fad87571967b91ea90f70f486e853.1525964384.git.joe@perches.com

---
 arch/x86/kernel/cpu/mtrr/Makefile           |  2 +-
 arch/x86/kernel/cpu/mtrr/{main.c => mtrr.c} | 33 ++++++++++++++---------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/Makefile b/arch/x86/kernel/cpu/mtrr/Makefile
index ad9e5ed81181..2ad9107ee980 100644
--- a/arch/x86/kernel/cpu/mtrr/Makefile
+++ b/arch/x86/kernel/cpu/mtrr/Makefile
@@ -1,3 +1,3 @@
-obj-y		:= main.o if.o generic.o cleanup.o
+obj-y		:= mtrr.o if.o generic.o cleanup.o
 obj-$(CONFIG_X86_32) += amd.o cyrix.o centaur.o
 
diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
similarity index 96%
rename from arch/x86/kernel/cpu/mtrr/main.c
rename to arch/x86/kernel/cpu/mtrr/mtrr.c
index 7468de429087..0c4f4fba9ec1 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -100,7 +100,7 @@ static int have_wrcomb(void)
 		if (dev->vendor == PCI_VENDOR_ID_SERVERWORKS &&
 		    dev->device == PCI_DEVICE_ID_SERVERWORKS_LE &&
 		    dev->revision <= 5) {
-			pr_info("mtrr: Serverworks LE rev < 6 detected. Write-combining disabled.\n");
+			pr_info("Serverworks LE rev < 6 detected. Write-combining disabled.\n");
 			pci_dev_put(dev);
 			return 0;
 		}
@@ -110,7 +110,7 @@ static int have_wrcomb(void)
 		 */
 		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
 		    dev->device == PCI_DEVICE_ID_INTEL_82451NX) {
-			pr_info("mtrr: Intel 450NX MMC detected. Write-combining disabled.\n");
+			pr_info("Intel 450NX MMC detected. Write-combining disabled.\n");
 			pci_dev_put(dev);
 			return 0;
 		}
@@ -312,24 +312,24 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 		return error;
 
 	if (type >= MTRR_NUM_TYPES) {
-		pr_warn("mtrr: type: %u invalid\n", type);
+		pr_warn("type: %u invalid\n", type);
 		return -EINVAL;
 	}
 
 	/* If the type is WC, check that this processor supports it */
 	if ((type == MTRR_TYPE_WRCOMB) && !have_wrcomb()) {
-		pr_warn("mtrr: your processor doesn't support write-combining\n");
+		pr_warn("your processor doesn't support write-combining\n");
 		return -ENOSYS;
 	}
 
 	if (!size) {
-		pr_warn("mtrr: zero sized request\n");
+		pr_warn("zero sized request\n");
 		return -EINVAL;
 	}
 
 	if ((base | (base + size - 1)) >>
 	    (boot_cpu_data.x86_phys_bits - PAGE_SHIFT)) {
-		pr_warn("mtrr: base or size exceeds the MTRR width\n");
+		pr_warn("base or size exceeds the MTRR width\n");
 		return -EINVAL;
 	}
 
@@ -360,8 +360,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 				} else if (types_compatible(type, ltype))
 					continue;
 			}
-			pr_warn("mtrr: 0x%lx000,0x%lx000 overlaps existing"
-				" 0x%lx000,0x%lx000\n", base, size, lbase,
+			pr_warn("0x%lx000,0x%lx000 overlaps existing 0x%lx000,0x%lx000\n", base, size, lbase,
 				lsize);
 			goto out;
 		}
@@ -369,7 +368,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 		if (ltype != type) {
 			if (types_compatible(type, ltype))
 				continue;
-			pr_warn("mtrr: type mismatch for %lx000,%lx000 old: %s new: %s\n",
+			pr_warn("type mismatch for %lx000,%lx000 old: %s new: %s\n",
 				base, size, mtrr_attrib_to_str(ltype),
 				mtrr_attrib_to_str(type));
 			goto out;
@@ -395,7 +394,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 			}
 		}
 	} else {
-		pr_info("mtrr: no more MTRRs available\n");
+		pr_info("no more MTRRs available\n");
 	}
 	error = i;
  out:
@@ -407,8 +406,8 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 static int mtrr_check(unsigned long base, unsigned long size)
 {
 	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
-		pr_warn("mtrr: size and base must be multiples of 4 kiB\n");
-		pr_debug("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+		pr_warn("size and base must be multiples of 4 kiB\n");
+		pr_debug("size: 0x%lx  base: 0x%lx\n", size, base);
 		dump_stack();
 		return -1;
 	}
@@ -499,22 +498,22 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 			}
 		}
 		if (reg < 0) {
-			pr_debug("mtrr: no MTRR for %lx000,%lx000 found\n",
+			pr_debug("no MTRR for %lx000,%lx000 found\n",
 				 base, size);
 			goto out;
 		}
 	}
 	if (reg >= max) {
-		pr_warn("mtrr: register: %d too big\n", reg);
+		pr_warn("register: %d too big\n", reg);
 		goto out;
 	}
 	mtrr_if->get(reg, &lbase, &lsize, &ltype);
 	if (lsize < 1) {
-		pr_warn("mtrr: MTRR %d not used\n", reg);
+		pr_warn("MTRR %d not used\n", reg);
 		goto out;
 	}
 	if (mtrr_usage_table[reg] < 1) {
-		pr_warn("mtrr: reg: %d has count=0\n", reg);
+		pr_warn("reg: %d has count=0\n", reg);
 		goto out;
 	}
 	if (--mtrr_usage_table[reg] < 1)
@@ -775,7 +774,7 @@ void __init mtrr_bp_init(void)
 	}
 
 	if (!mtrr_enabled()) {
-		pr_info("MTRR: Disabled\n");
+		pr_info("Disabled\n");
 
 		/*
 		 * PAT initialization relies on MTRR's rendezvous handler.
