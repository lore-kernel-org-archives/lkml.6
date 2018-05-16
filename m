Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084986-1526513663-2-3161630240977785181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526513663; b=KB0HaqkYM6umcQOJPYhZ0nI23EuH7ppr2lXkiaMuG3Ejr38U4H
    zfrtj5GfuOXyL+h4aDCyGAtow24S/udjvdBJZ1cvs253RKSXpCneh3vkfSUEWDib
    c9/OpiyWQueEGz0/zOrms/Bwty+dKz2EmSX6HL+9driNzU8zdSlMs0+dQAmz2ozP
    orblVj07tBIFAQvA4meJgmOBHbJMFFDTanKNqEuwAc4OYSr+Ci3th7MIwZhZ9RSH
    LyAQGs5+xd5EVk8UJmeyq5zUU9/0mp/9/eTaXyOffs4F/ba3MA9iXl1jSob8yeM5
    9AT5zDa/mr73Xs91AImoRCRDAlsRSNd95KQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526513663; bh=
    qi563sCPL5Gqbe7rtw5JgQQMp2mZkMu2cvUaPYTWOks=; b=InRl1+VTZes/YOdk
    CRRLNiTfn1m1ovIas4Ri5M3C6Utf5fAT1WLEJGvSipLpRS67UirbTwMzfA1W66YF
    /fBC4OcDo5gOPx6GDdL5+S3qIOj3pQVpsp85LXgpxVFEyuYIFx489XC4ZpiszhDe
    CjKPP6Rre9UkZ2OdxV9C/Ks6xkyHga+nXOBMG594ysWXsZcgoQK7R2FquOXQ+EpT
    7cuySyvtNzXI1x3YpBOgJNZy9QbcSUGrZwP/OWDcPj2r+nlfRLKiWml60bRnumbI
    EqwuzIurTUiH1xlw/uqh6G3t2nWfBk+Wict5n245mKqqmk9PNWJF07VXfzAeblk6
    yukBKA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJVzkUizICbc/DTi4apy5hKMZOx+P4HaL+tBsslcT1F+I0zOZ4UxMwcg2vPcghlYHNIb2LRw4S73APOddAiHCj3eD90mHmYQDfoGAidN/enb5b5Fcf18
    xnC2Dh4I8H7rgfzqn3Y87PEDFxTQLzSOcvB2T5dYv0v4mWvsrjyhs4soB7ep333gZRdhcXah5YUcJ/7aPMxsPtcdM5bQjqNlreS1amH+us02K4DTgxyewO6l
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=makQc_6JeJeb0pz4v7kA:9
    a=1WTHo_SXNcDlSQWG:21 a=7p8vbkwTPS6x6ma9:21 a=pioyyrs4ZptJ924tMmac:22
    a=AjGcO6oz07-iQ99wixmX:22 a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeEPXd1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 19:33:27 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:43823 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEPXdZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 19:33:25 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc: cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>, stable@vger.kernel.org
Subject: [PATCH v3 2/3] ioremap: Update pgtable free interfaces with addr
Date: Wed, 16 May 2018 17:32:06 -0600
Message-Id: <20180516233207.1580-3-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516233207.1580-1-toshi.kani@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chintan Pandya <cpandya@codeaurora.org>

This patch ("mm/vmalloc: Add interfaces to free unmapped
page table") adds following 2 interfaces to free the page
table in case we implement huge mapping.

pud_free_pmd_page() and pmd_free_pte_page()

Some architectures (like arm64) needs to do proper TLB
maintanance after updating pagetable entry even in map.
Why ? Read this,
https://patchwork.kernel.org/patch/10134581/

Pass 'addr' in these interfaces so that proper TLB ops
can be performed.

[toshi@hpe.com: merge changes]
Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: <stable@vger.kernel.org>
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
