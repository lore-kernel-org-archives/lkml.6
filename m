Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2296094-1521051150-2-9100007022255031655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521051145; b=O2IassN1Id4/s3Vwps30+dg4yP7ooCDvM8nGCeebN1iaZcA
    vYN6lA7Kkv8SBdepcHF11fV5TGO4YtlQ+/a/pm0Wy8r0I3e6FUmztvRVn0SVSzpr
    XG1P3mnYpxVGtzUawuLpZbeZE/Ks9ttdRfTUuDogMR3D0VJY1ab0ZEqxAI+o+umz
    MVeT5l2LWlztpakeF/UQtrBGGqFSa4AGviGMBaKHgNEx3yC+q3E/iDPOlKtmhLBQ
    edb4uGtMqeVot2LTcJS1Tj/C/hpY8m3WUCGleLvnRXljC6hUKAbmZkk5dlHiU/Zj
    +89FDdnzybVIxkcBawU8Ga/uTrMBDz8ftSZYbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521051145;
    bh=Re/ef8SaoH27mGPcNH59OoYU4FDsZVWQJSaa+hngX7E=; b=lN21hB1ecpOd
    Ni3yAVrnHb9kisC9xyAELmtIf+4q+G7eI5L4Yx7psisn0QrSeuFY9Yfx5ogAPoTN
    m66oXSwf55QsUjjX3CcMU92Uy/2rQEdVq/QCAa+gJYirViyzzConKiH40RGyGmHv
    YjIqxrp5F+JcXFps0AORkkc+cCj0omUVTgN1dwcHzS50yS/QmsV56jxgx7uGNszp
    nxXTVk6d7188ybo8VdC8VnHQrdYlGHM/D7tMrQdFPQMmTtwjDyiNeI/PyhzD0b/E
    PVS7BXJcD9HQ1BPY9rB29lDdXlwRRhnFTeFJbsFnipqoqFyi/TeknOei4SdanchE
    BfFr+hUMZA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeCNSL3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 14:11:29 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:53466 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeCNSL2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 14:11:28 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        catalin.marinas@arm.com
Cc: guohanjun@huawei.com, will.deacon@arm.com, wxf.wang@hisilicon.com,
        willy@infradead.org, cpandya@codeaurora.org, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] mm/vmalloc: Add interfaces to free unmapped page table
Date: Wed, 14 Mar 2018 12:01:54 -0600
Message-Id: <20180314180155.19492-2-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180314180155.19492-1-toshi.kani@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap()
may create pud/pmd mappings.  Kernel panic was observed on arm64
systems with Cortex-A75 in the following steps as described by
Hanjun Guo.

 1. ioremap a 4K size, valid page table will build,
 2. iounmap it, pte0 will set to 0;
 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
    then set the a new value for pmd;
 4. pte0 is leaked;
 5. CPU may meet exception because the old pmd is still in TLB,
    which will lead to kernel panic.

This panic is not reproducible on x86.  INVLPG, called from iounmap,
purges all levels of entries associated with purged address on x86.
x86 still has memory leak.

The patch changes the ioremap path to free unmapped page table(s) since
doing so in the unmap path has the following issues:

 - The iounmap() path is shared with vunmap().  Since vmap() only
   supports pte mappings, making vunmap() to free a pte page is an
   overhead for regular vmap users as they do not need a pte page
   freed up.
 - Checking if all entries in a pte page are cleared in the unmap path
   is racy, and serializing this check is expensive.
 - The unmap path calls free_vmap_area_noflush() to do lazy TLB purges.
   Clearing a pud/pmd entry before the lazy TLB purges needs extra TLB
   purge.

Add two interfaces, pud_free_pmd_page() and pmd_free_pte_page(),
which clear a given pud/pmd entry and free up a page for the lower
level entries.

This patch implements their stub functions on x86 and arm64, which
work as workaround.

Reported-by: Lei Li <lious.lilei@hisilicon.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Wang Xuefeng <wxf.wang@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: <stable@vger.kernel.org>
---
 arch/arm64/mm/mmu.c           |   10 ++++++++++
 arch/x86/mm/pgtable.c         |   24 ++++++++++++++++++++++++
 include/asm-generic/pgtable.h |   10 ++++++++++
 lib/ioremap.c                 |    6 ++++--
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8c704f1e53c2..2dbb2c9f1ec1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -972,3 +972,13 @@ int pmd_clear_huge(pmd_t *pmdp)
 	pmd_clear(pmdp);
 	return 1;
 }
+
+int pud_free_pmd_page(pud_t *pud)
+{
+	return pud_none(*pud);
+}
+
+int pmd_free_pte_page(pmd_t *pmd)
+{
+	return pmd_none(*pmd);
+}
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 004abf9ebf12..1eed7ed518e6 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -702,4 +702,28 @@ int pmd_clear_huge(pmd_t *pmd)
 
 	return 0;
 }
+
+/**
+ * pud_free_pmd_page - Clear pud entry and free pmd page.
+ * @pud: Pointer to a PUD.
+ *
+ * Context: The pud range has been unmaped and TLB purged.
+ * Return: 1 if clearing the entry succeeded. 0 otherwise.
+ */
+int pud_free_pmd_page(pud_t *pud)
+{
+	return pud_none(*pud);
+}
+
+/**
+ * pmd_free_pte_page - Clear pmd entry and free pte page.
+ * @pmd: Pointer to a PMD.
+ *
+ * Context: The pmd range has been unmaped and TLB purged.
+ * Return: 1 if clearing the entry succeeded. 0 otherwise.
+ */
+int pmd_free_pte_page(pmd_t *pmd)
+{
+	return pmd_none(*pmd);
+}
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 2cfa3075d148..2490800f7c5a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -983,6 +983,8 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
+int pud_free_pmd_page(pud_t *pud);
+int pmd_free_pte_page(pmd_t *pmd);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 {
@@ -1008,6 +1010,14 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 {
 	return 0;
 }
+static inline int pud_free_pmd_page(pud_t *pud)
+{
+	return 0;
+}
+static inline int pmd_free_pte_page(pud_t *pmd)
+{
+	return 0;
+}
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 #ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
diff --git a/lib/ioremap.c b/lib/ioremap.c
index b808a390e4c3..54e5bbaa3200 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -91,7 +91,8 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 
 		if (ioremap_pmd_enabled() &&
 		    ((next - addr) == PMD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
+		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
+		    pmd_free_pte_page(pmd)) {
 			if (pmd_set_huge(pmd, phys_addr + addr, prot))
 				continue;
 		}
@@ -117,7 +118,8 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 
 		if (ioremap_pud_enabled() &&
 		    ((next - addr) == PUD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
+		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
+		    pud_free_pmd_page(pud)) {
 			if (pud_set_huge(pud, phys_addr + addr, prot))
 				continue;
 		}
