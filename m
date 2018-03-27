Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174169-2-1676801967579986101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174167; b=gIPApRA6oL+0IDheibLshmFI6BHSi8M4cwFqPUZk+jrry/m
    meJKSHd1CaM/PUt+LMI/Kqz1QM2SJG1GNqufcDm5aYkIxJTxZd5W/H8GVfJeN/30
    Tl/dqSqTIPYV9SPRmXaWVX+fEetXVxCB9sLHPONi2rS67hiDo4B1fO/t1PbNF/fo
    Bnggt+8+VQ1Azpy19VHnHnX/ROq5l9pe95+l1u4ycnPm+HrCUFKWKZAqC0ZfJ39x
    6D4ZG6oKdnls2aOf+gY71aC5Zo+MhRrQp1deR/ZWq8B9/QNg5yonQYC2hBtgVErT
    mDtgRI3Wb/1KVpQHtDa4P3a6o830jJIIJ7qRshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522174167; bh=sOQMNW26SLEvEt1lPtBen33s2e
    cl611S7d+7b0wgX3k=; b=jDY7MbbEWvzBkVQaix+ebWtO5Ou+unQ8K17qVMs0lM
    74YfId8Bnjbv6RmnKeTSs9PPS8XGcpeDPIvzOoJKKxegDJJGqSLeD8ufQPXNfRVi
    xI0fts6erB6H2/hMHMnzTNe+8v/txGtnDmgOewQdpdz4bwBGP0Lookr9DAG6xEzR
    9+LyS4xKGpaoUk03zLwm5EmzVufMyT/nuntVYXP0Rb1Gb1MQ/OalqP4Vfg7UMUr6
    visOfiw40DyD01lTlu8Uxh99KHWOfVsXdWQxCHLgJo1v/vx9OMgP+Ly13I+rZsYZ
    3ZMk1QX1pCHpyWgfXUtjfYVf9XSb9kKdWaOuV7t2en6A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFHLlMmEfwoXz68bHHwRdlx2Eav5OZ3GSQi949vq9chkp3JEY/6qGCSnrL8DFY52+7yBU1wiipSqIj6KE7ZAqAd9vVpIdhZZjpnbWCSKMpBIVG0Xw4cO
    NgQGjox+QZ8/0bOl4xwgVKNnMY/TktYfshU5e8qLDfD6hBjP5U7e68iTB8zIXO278c3212tH9hxJ3di9FtG/5KKwtzAtEKpeCuACi6T+GNnlVuoSZVWrO9FF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=MvuuwTCpAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=BTeA3XvPAAAA:8
    a=7CQSdrXTAAAA:8 a=i0EeH86SAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=JfrnYn6hAAAA:8 a=LpQP-O61AAAA:8 a=ag1SF4gXAAAA:8
    a=hzx1AeV23mwXoDteJjYA:9 a=rlQ06D75UDDalarp:21 a=zS1tmL_f6C6oHaaK:21
    a=QEXdDO2ut3YA:10 a=dVHiktpip_riXrfdqayU:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22 a=tafbbOV3vt1XuEhzTjGK:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbeC0SJK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:09:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeC0Q3J (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lei Li <lious.lilei@hisilicon.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wang Xuefeng <wxf.wang@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 20/43] mm/vmalloc: add interfaces to free unmapped page table
Date: Tue, 27 Mar 2018 18:27:24 +0200
Message-Id: <20180327162717.580646019@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit b6bdb7517c3d3f41f20e5c2948d6bc3f8897394e upstream.

On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap() may
create pud/pmd mappings.  A kernel panic was observed on arm64 systems
with Cortex-A75 in the following steps as described by Hanjun Guo.

 1. ioremap a 4K size, valid page table will build,
 2. iounmap it, pte0 will set to 0;
 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
    then set the a new value for pmd;
 4. pte0 is leaked;
 5. CPU may meet exception because the old pmd is still in TLB,
    which will lead to kernel panic.

This panic is not reproducible on x86.  INVLPG, called from iounmap,
purges all levels of entries associated with purged address on x86.  x86
still has memory leak.

The patch changes the ioremap path to free unmapped page table(s) since
doing so in the unmap path has the following issues:

 - The iounmap() path is shared with vunmap(). Since vmap() only
   supports pte mappings, making vunmap() to free a pte page is an
   overhead for regular vmap users as they do not need a pte page freed
   up.

 - Checking if all entries in a pte page are cleared in the unmap path
   is racy, and serializing this check is expensive.

 - The unmap path calls free_vmap_area_noflush() to do lazy TLB purges.
   Clearing a pud/pmd entry before the lazy TLB purges needs extra TLB
   purge.

Add two interfaces, pud_free_pmd_page() and pmd_free_pte_page(), which
clear a given pud/pmd entry and free up a page for the lower level
entries.

This patch implements their stub functions on x86 and arm64, which work
as workaround.

[akpm@linux-foundation.org: fix typo in pmd_free_pte_page() stub]
Link: http://lkml.kernel.org/r/20180314180155.19492-2-toshi.kani@hpe.com
Fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")
Reported-by: Lei Li <lious.lilei@hisilicon.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Wang Xuefeng <wxf.wang@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/mmu.c           |   10 ++++++++++
 arch/x86/mm/pgtable.c         |   24 ++++++++++++++++++++++++
 include/asm-generic/pgtable.h |   10 ++++++++++
 lib/ioremap.c                 |    6 ++++--
 4 files changed, 48 insertions(+), 2 deletions(-)

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -697,3 +697,13 @@ void *__init fixmap_remap_fdt(phys_addr_
 
 	return dt_virt;
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
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -666,4 +666,28 @@ int pmd_clear_huge(pmd_t *pmd)
 
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
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -755,6 +755,8 @@ int pud_set_huge(pud_t *pud, phys_addr_t
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
+int pud_free_pmd_page(pud_t *pud);
+int pmd_free_pte_page(pmd_t *pmd);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static inline int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 {
@@ -772,6 +774,14 @@ static inline int pmd_clear_huge(pmd_t *
 {
 	return 0;
 }
+static inline int pud_free_pmd_page(pud_t *pud)
+{
+	return 0;
+}
+static inline int pmd_free_pte_page(pmd_t *pmd)
+{
+	return 0;
+}
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 #endif /* !__ASSEMBLY__ */
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -83,7 +83,8 @@ static inline int ioremap_pmd_range(pud_
 
 		if (ioremap_pmd_enabled() &&
 		    ((next - addr) == PMD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
+		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
+		    pmd_free_pte_page(pmd)) {
 			if (pmd_set_huge(pmd, phys_addr + addr, prot))
 				continue;
 		}
@@ -109,7 +110,8 @@ static inline int ioremap_pud_range(pgd_
 
 		if (ioremap_pud_enabled() &&
 		    ((next - addr) == PUD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
+		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
+		    pud_free_pmd_page(pud)) {
 			if (pud_set_huge(pud, phys_addr + addr, prot))
 				continue;
 		}
