Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2328400-1526572733-2-18256256961561133038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526572732; b=Ct45Q6dxyIChlyjpazIJ2YOGYzEEXugjUrY4IAKalL9mT2AFbm
    d/tkA86/h338dkuMWcGHML0Tf9LlUsmNxW+KRi+fOv5peDVSWmPHRNoNaDp1W9eC
    ZE13vOb3iDnCvr0xQIEgJSLZfLAkqzUdjDL2GdOEL978xdrXrJuwFBDe0Z8EfXQX
    aM6cNjO9xjDC1oBDbvLNb9JhWeRL8ACd072BZJEuhp+8/NNT/YjN/+gA5nP7NkXi
    A9fM5RhMnMtza1Av/AS40F/rF+8PnlNptxl0JBZ5zXapGgRVNaTzySVOkYu2sME+
    Bt0rQo3ll6RRacXo/J3zA7InVHn6dh8vUn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526572732; bh=eA9XC4GL9QyE/JjcjSeskYtUDMfA17
    SuRQnmyHfab6I=; b=AWQ2lnoZ+rzyiWM60mBmDqvgQBh+pqVgRGU7U2uh2kZTnA
    H0Ha98InDL+OOqj3Ed5Qaqrl4Gcd59o4Yptlf4CgRHs6Z6d5sO7gVRNvhzGI0BZY
    05vh2GttFG7CADq0K6/KMFBc2luMHFEqjbFU5dCb6iux+fawoQoRNQ9g/OsB43zv
    o9KGFs02Krxkx21cJAptN62iE/DHvEasU4OmANNmWkoxCZywJ/7P4UMcOb3MArfA
    EI41YmxhZ03mr9zZVK9PIh+BW11YFchbVKA9jRuQ+Fr2HTrLg4Sl8gJosoKS4mzm
    DdYv+72wdWhzZOm8gFcKCXJpALj4BQ4yTAZFtKcA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIo9wHPHwAUOrK+f3MLnw0nKXZnYMP91QL8kx9jYj8CopGebJi1Df2qYNA2nImMi4uKExxdhWd54oQo6xp6+K2Ir5N1eY3zrRhdYDWDnAoFcuyBdHHvW
    Ew2axHCAkjNezklQXtz932RH8ATUh7R6EEerNBFYPhX3rEMtEksT5MWxuRrd3n/kW++h6m4CSfN19VdxP1xH1WUmYq5v2nSRvQwBpT+Ge0GWTHB8/GZEbR7f
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=MvuuwTCpAAAA:8 a=Z4Rwk6OoAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=7CQSdrXTAAAA:8 a=tA7aZXjiAAAA:8 a=VwQbUJbxAAAA:8
    a=makQc_6JeJeb0pz4v7kA:9 a=K3Kd6E5QBK2T_F5b:21 a=8FtZ8bfDZIf1VPYJ:21
    a=pioyyrs4ZptJ924tMmac:22 a=dVHiktpip_riXrfdqayU:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=kIIFJ0VLUOy1gFZzwZHL:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeEQP6u (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 11:58:50 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:48352 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEQP6u (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 11:58:50 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, will.deacon@arm.com
Cc: cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>,
        Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org
Subject: [PATCH v3-UPADATE 2/3] ioremap: Update pgtable free interfaces with addr
Date: Thu, 17 May 2018 09:57:34 -0600
Message-Id: <20180517155734.1700-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chintan Pandya <cpandya@codeaurora.org>

The following kernel panic was observed on ARM64 platform due to a stale
TLB entry.

 1. ioremap with 4K size, a valid pte page table is set.
 2. iounmap it, its pte entry is set to 0.
 3. ioremap the same address with 2M size, update its pmd entry with
    a new value.
 4. CPU may hit an exception because the old pmd entry is still in TLB,
    which leads to a kernel panic.

Commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
table") has addressed this panic by falling to pte mappings in the above
case on ARM64.

To support pmd mappings in all cases, TLB purge needs to be performed
in this case on ARM64.

Add a new arg, 'addr', to pud_free_pmd_page() and pmd_free_pte_page()
so that TLB purge can be added later in seprate patches.

[toshi@hpe.com: merge changes, rewrite patch description]
Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: <stable@vger.kernel.org>
---
v3-UPDATE - Rewrite patch description
---
 arch/arm64/mm/mmu.c           |    4 ++--
 arch/x86/mm/pgtable.c         |   12 +++++++-----
 include/asm-generic/pgtable.h |    8 ++++----
 lib/ioremap.c                 |    4 ++--
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9f1ec1..da98828609a1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -973,12 +973,12 @@ int pmd_clear_huge(pmd_t *pmdp)
 	return 1;
 }
 
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return pud_none(*pud);
 }
 
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return pmd_none(*pmd);
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3f7180bc5f52..f60fdf411103 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -719,11 +719,12 @@ int pmd_clear_huge(pmd_t *pmd)
 /**
  * pud_free_pmd_page - Clear pud entry and free pmd page.
  * @pud: Pointer to a PUD.
+ * @addr: Virtual address associated with pud.
  *
  * Context: The pud range has been unmaped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	pmd_t *pmd;
 	int i;
@@ -734,7 +735,7 @@ int pud_free_pmd_page(pud_t *pud)
 	pmd = (pmd_t *)pud_page_vaddr(*pud);
 
 	for (i = 0; i < PTRS_PER_PMD; i++)
-		if (!pmd_free_pte_page(&pmd[i]))
+		if (!pmd_free_pte_page(&pmd[i], addr + (i * PMD_SIZE)))
 			return 0;
 
 	pud_clear(pud);
@@ -746,11 +747,12 @@ int pud_free_pmd_page(pud_t *pud)
 /**
  * pmd_free_pte_page - Clear pmd entry and free pte page.
  * @pmd: Pointer to a PMD.
+ * @addr: Virtual address associated with pmd.
  *
  * Context: The pmd range has been unmaped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	pte_t *pte;
 
@@ -766,7 +768,7 @@ int pmd_free_pte_page(pmd_t *pmd)
 
 #else /* !CONFIG_X86_64 */
 
-int pud_free_pmd_page(pud_t *pud)
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return pud_none(*pud);
 }
@@ -775,7 +777,7 @@ int pud_free_pmd_page(pud_t *pud)
  * Disable free page handling on x86-PAE. This assures that ioremap()
  * does not update sync'd pmd entries. See vmalloc_sync_one().
  */
-int pmd_free_pte_page(pmd_t *pmd)
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return pmd_none(*pmd);
 }
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index f59639afaa39..b081794ba135 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1019,8 +1019,8 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot);
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
-int pud_free_pmd_page(pud_t *pud);
-int pmd_free_pte_page(pmd_t *pmd);
+int pud_free_pmd_page(pud_t *pud, unsigned long addr);
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 {
@@ -1046,11 +1046,11 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 {
 	return 0;
 }
-static inline int pud_free_pmd_page(pud_t *pud)
+static inline int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	return 0;
 }
-static inline int pmd_free_pte_page(pmd_t *pmd)
+static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	return 0;
 }
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 54e5bbaa3200..517f5853ffed 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -92,7 +92,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 		if (ioremap_pmd_enabled() &&
 		    ((next - addr) == PMD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
-		    pmd_free_pte_page(pmd)) {
+		    pmd_free_pte_page(pmd, addr)) {
 			if (pmd_set_huge(pmd, phys_addr + addr, prot))
 				continue;
 		}
@@ -119,7 +119,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 		if (ioremap_pud_enabled() &&
 		    ((next - addr) == PUD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
-		    pud_free_pmd_page(pud)) {
+		    pud_free_pmd_page(pud, addr)) {
 			if (pud_set_huge(pud, phys_addr + addr, prot))
 				continue;
 		}
