Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326515-2-8076401605413984676
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326514; b=a9bz2xjSBIDnNVXJSHgyTVG/2Rxy/egih9PFWooKuH37N2C
    jeR8kvoDCx69OSWWbuHeWm92I2u5F/Er3Z1+x6iTr6GEjYWCgGgdZsasWaMWpshZ
    eBbxmpWDocRW/Wjy6u1SdKK64WqpGD+Lj8FsE+9AQG9+/7JrIP2wrN7bZMvtaT0c
    /vaxtlOIflHThsakzRekDiafChYFNly5DBDynNG7utWJer5ASpI4hYuLNtGb/luI
    PYUUvk6esu1eudC7ms4WCQbVDruEkvjjQ7EbGUn/4I9PeKHqQ1lJb4CaSudFdyLm
    LwHIPWWHkoYJqtQHBcUHKVoENoOpMD/nFB+XYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326514; bh=T4H8RVeIAfvsIIWrBds
    FEEPU6sr6SpzcHztbR/Wnhvw=; b=bbqHT0+tosDJTiEREvlvWAXQK0M9xT2e/Sq
    2Yg0DVXP4+5Rnp9/kXuHh+RUuYWiwH3DwJNRLTgmx0c38U42haPdkQesdZSxrX5Y
    y++DyR0LoF+mT4bCu9VRKMyqj2lWQALBHtuxMuksZQ6zaG9ZkW41TCPyGmyP4OGA
    lNOES1wi9S0GvAWwDPb5HsX7cMaoAPaw6QmVA/DJN7qE/cyIjGUBfp98ZoAZtVX9
    jZCa9Og++w3nHTNVgppxGIoqkSKdgHGlyzD+ANCnrmQNELKkDvELAPynq6Iv3EtD
    XQcQuxZwqhl2dwkQj7hNdKBPzK13X/sKOGrf53TmDYPTnXAbr7g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeBKFSE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:18:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753873AbeBKFSD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:03 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tyler Baicar" <tbaicar@codeaurora.org>,
        "Ingo Molnar" <mingo@kernel.org>, "Borislav Petkov" <bp@suse.de>,
        "Fengguang Wu" <fengguang.wu@intel.com>,
        "James Morse" <james.morse@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Toshi Kani" <toshi.kani@hpe.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.107345651@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 060/136] ACPI / APEI: Replace ioremap_page_range()
 with fixmap
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit 4f89fa286f6729312e227e7c2d764e8e7b9d340e upstream.

Replace ghes_io{re,un}map_pfn_{nmi,irq}()s use of ioremap_page_range()
with __set_fixmap() as ioremap_page_range() may sleep to allocate a new
level of page-table, even if its passed an existing final-address to
use in the mapping.

The GHES driver can only be enabled for architectures that select
HAVE_ACPI_APEI: Add fixmap entries to both x86 and arm64.

clear_fixmap() does the TLB invalidation in __set_fixmap() for arm64
and __set_pte_vaddr() for x86. In each case its the same as the
respective arch_apei_flush_tlb_one().

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
Tested-by: Toshi Kani <toshi.kani@hpe.com>
[ For the arm64 bits: ]
Acked-by: Will Deacon <will.deacon@arm.com>
[ For the x86 bits: ]
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[bwh: Backported to 3.16:
 - Drop arm64 changes; ghes is x86-only here
 - Don't use page or prot variables in ghes_ioremap_fn_{nmi,irq}()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -103,6 +103,12 @@ enum fixed_addresses {
 #ifdef	CONFIG_X86_INTEL_MID
 	FIX_LNW_VRTC,
 #endif
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+	FIX_APEI_GHES_NMI,
+#endif
+
 	__end_of_permanent_fixed_addresses,
 
 	/*
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -49,6 +49,7 @@
 #include <linux/aer.h>
 
 #include <acpi/ghes.h>
+#include <asm/fixmap.h>
 #include <asm/mce.h>
 #include <asm/tlbflush.h>
 #include <asm/nmi.h>
@@ -110,7 +111,7 @@ static DEFINE_RAW_SPINLOCK(ghes_nmi_lock
  * Because the memory area used to transfer hardware error information
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
  * handler, but general ioremap can not be used in atomic context, so
- * a special version of atomic ioremap is implemented for that.
+ * the fixmap is used instead.
  */
 
 /*
@@ -124,8 +125,8 @@ static DEFINE_RAW_SPINLOCK(ghes_nmi_lock
 /* virtual memory area for atomic ioremap */
 static struct vm_struct *ghes_ioremap_area;
 /*
- * These 2 spinlock is used to prevent atomic ioremap virtual memory
- * area from being mapped simultaneously.
+ * These 2 spinlocks are used to prevent the fixmap entries from being used
+ * simultaneously.
  */
 static DEFINE_RAW_SPINLOCK(ghes_ioremap_lock_nmi);
 static DEFINE_SPINLOCK(ghes_ioremap_lock_irq);
@@ -165,44 +166,26 @@ static void ghes_ioremap_exit(void)
 
 static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
 {
-	unsigned long vaddr;
+	__set_fixmap(FIX_APEI_GHES_NMI, pfn << PAGE_SHIFT, PAGE_KERNEL);
 
-	vaddr = (unsigned long)GHES_IOREMAP_NMI_PAGE(ghes_ioremap_area->addr);
-	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
-			   pfn << PAGE_SHIFT, PAGE_KERNEL);
-
-	return (void __iomem *)vaddr;
+	return (void __iomem *) fix_to_virt(FIX_APEI_GHES_NMI);
 }
 
 static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
 {
-	unsigned long vaddr;
-
-	vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
-	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
-			   pfn << PAGE_SHIFT, PAGE_KERNEL);
+	__set_fixmap(FIX_APEI_GHES_IRQ, pfn << PAGE_SHIFT, PAGE_KERNEL);
 
-	return (void __iomem *)vaddr;
+	return (void __iomem *) fix_to_virt(FIX_APEI_GHES_IRQ);
 }
 
-static void ghes_iounmap_nmi(void __iomem *vaddr_ptr)
+static void ghes_iounmap_nmi(void)
 {
-	unsigned long vaddr = (unsigned long __force)vaddr_ptr;
-	void *base = ghes_ioremap_area->addr;
-
-	BUG_ON(vaddr != (unsigned long)GHES_IOREMAP_NMI_PAGE(base));
-	unmap_kernel_range_noflush(vaddr, PAGE_SIZE);
-	__flush_tlb_one(vaddr);
+	clear_fixmap(FIX_APEI_GHES_NMI);
 }
 
-static void ghes_iounmap_irq(void __iomem *vaddr_ptr)
+static void ghes_iounmap_irq(void)
 {
-	unsigned long vaddr = (unsigned long __force)vaddr_ptr;
-	void *base = ghes_ioremap_area->addr;
-
-	BUG_ON(vaddr != (unsigned long)GHES_IOREMAP_IRQ_PAGE(base));
-	unmap_kernel_range_noflush(vaddr, PAGE_SIZE);
-	__flush_tlb_one(vaddr);
+	clear_fixmap(FIX_APEI_GHES_IRQ);
 }
 
 static int ghes_estatus_pool_init(void)
@@ -341,10 +324,10 @@ static void ghes_copy_tofrom_phys(void *
 		paddr += trunk;
 		buffer += trunk;
 		if (in_nmi) {
-			ghes_iounmap_nmi(vaddr);
+			ghes_iounmap_nmi();
 			raw_spin_unlock(&ghes_ioremap_lock_nmi);
 		} else {
-			ghes_iounmap_irq(vaddr);
+			ghes_iounmap_irq();
 			spin_unlock_irqrestore(&ghes_ioremap_lock_irq, flags);
 		}
 	}
