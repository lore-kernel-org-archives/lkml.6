Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084986-1526513661-2-9200984302962107663
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526513660; b=gEcz28qM5JMj5VEgvKWvNthTaWtM91cuMdVjmKWqxhsECtz+Jc
    y39EZ9WrHJPHsEkSrHxdw87J8tlCX+6KVTlWL5RZ30qr4TuLIyaihUfsTBmj7N4Q
    65X0ZLN/mpRTNr8LHDkzRQoWWWQKroXoOcii4jOCDxrxRRtibv4gpydFtHE8iTO3
    QcJHn6Z42bghNCZeiRU0irIZEXFnjoWlF8ho+ajKlJjiH8paxpvLTpRMKmxAVPYm
    Jwt8sd5y+oFFfxRMC/UX7ev1lau99s6I5pEtJ+Ewl0th+LSC4bhx9L+RlO2vSaph
    cjF8hzZGAKPxC6lGDD1XzEFicVySnU7OZBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526513660; bh=
    o8sgoZjOxvubH3vqlI10o5Q7nh1e1mqbGOKF/LOEVSM=; b=Wt0T4VesUcwFiEtV
    RV9xX6JfEdB+ZaxlF2z6RYlFnGooLOXc4Y3XPm1CbDpIVDXl9D+8O2t1uMAv5K2K
    QGEIFnTQmihF2qyyxrKc5gcRBBqR6ccEvjkPRdmtS+ShRN4A0+K2PS/kgHVhYiP+
    IRZygba99EMPF/zkX8eg/8m6IaO7boKti8OwijgvcEBkZh1yuHhl+kqrA+91iynz
    fVOg3lRX6avtv8fwH+bP4Y+Ufq7EpcAknjP2pO1L5yfbaMWEk0/2RfuUpHJkPGo3
    OP66JjKn8WJaHrrvq6Osiqs3Fneqsj6jjOxmNNu3eNMQ+uJg9UDklmrXRaAC2JZB
    kS2y4Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfJY9cTT5p71h9XEZzfGpUoLJXyXokgAnGDbUNn2JWSDqKi6n5n6ilws8EgKbeAz0B87jGTxgrEOjp6S269uX/bzzXOYk73yH/9d3y5I9sJJtqxTI7A7E
    H+hxKvgIPUvuWVw6uNcDO2XPsm/AAesBXonSFCQGpi1KZb2NiHI6ye261JCywK3RhNsI0vS/xhQBtbbwNC/Fjf9c3MvTkTYy06i/UvkTaKMgBqBFiyTom/Eq
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=MvuuwTCpAAAA:8
    a=Z4Rwk6OoAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8
    a=tA7aZXjiAAAA:8 a=VwQbUJbxAAAA:8 a=ICxiNaJX4HUcj9YNticA:9
    a=LVWB1rp2qefrMUUt:21 a=29AgWrWh4-N4p5Ih:21 a=dVHiktpip_riXrfdqayU:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=kIIFJ0VLUOy1gFZzwZHL:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeEPXeH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 19:34:07 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:35818 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeEPXd1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 19:33:27 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc: cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>,
        Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org
Subject: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page interfaces
Date: Wed, 16 May 2018 17:32:07 -0600
Message-Id: <20180516233207.1580-4-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516233207.1580-1-toshi.kani@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ioremap() calls pud_free_pmd_page() / pmd_free_pte_page() when it creates
a pud / pmd map.  The following preconditions are met at their entry.
 - All pte entries for a target pud/pmd address range have been cleared.
 - System-wide TLB purges have been peformed for a target pud/pmd address
   range.

The preconditions assure that there is no stale TLB entry for the range.
Speculation may not cache TLB entries since it requires all levels of page
entries, including ptes, to have P & A-bits set for an associated address.
However, speculation may cache pud/pmd entries (paging-structure caches)
when they have P-bit set.

Add a system-wide TLB purge (INVLPG) to a single page after clearing
pud/pmd entry's P-bit.

SDM 4.10.4.1, Operation that Invalidate TLBs and Paging-Structure Caches,
states that:
  INVLPG invalidates all paging-structure caches associated with the
  current PCID regardless of the liner addresses to which they correspond.

Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page interfaces")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: <stable@vger.kernel.org>
---
 arch/x86/mm/pgtable.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f60fdf411103..7e96594c7e97 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -721,24 +721,42 @@ int pmd_clear_huge(pmd_t *pmd)
  * @pud: Pointer to a PUD.
  * @addr: Virtual address associated with pud.
  *
- * Context: The pud range has been unmaped and TLB purged.
+ * Context: The pud range has been unmapped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
 int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
-	pmd_t *pmd;
+	pmd_t *pmd, *pmd_sv;
+	pte_t *pte;
 	int i;
 
 	if (pud_none(*pud))
 		return 1;
 
 	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
+	if (!pmd_sv)
+		return 0;
 
-	for (i = 0; i < PTRS_PER_PMD; i++)
-		if (!pmd_free_pte_page(&pmd[i], addr + (i * PMD_SIZE)))
-			return 0;
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd_sv[i] = pmd[i];
+		if (!pmd_none(pmd[i]))
+			pmd_clear(&pmd[i]);
+	}
 
 	pud_clear(pud);
+
+	/* INVLPG to clear all paging-structure caches */
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (!pmd_none(pmd_sv[i])) {
+			pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
+			free_page((unsigned long)pte);
+		}
+	}
+
+	free_page((unsigned long)pmd_sv);
 	free_page((unsigned long)pmd);
 
 	return 1;
@@ -749,7 +767,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
  * @pmd: Pointer to a PMD.
  * @addr: Virtual address associated with pmd.
  *
- * Context: The pmd range has been unmaped and TLB purged.
+ * Context: The pmd range has been unmapped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
@@ -761,6 +779,10 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 	pte = (pte_t *)pmd_page_vaddr(*pmd);
 	pmd_clear(pmd);
+
+	/* INVLPG to clear all paging-structure caches */
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
+
 	free_page((unsigned long)pte);
 
 	return 1;
