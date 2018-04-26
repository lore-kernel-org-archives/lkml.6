Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2746918-1524755656-2-2551644403771699827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524755655; b=QpeRDBFifAPOEf9vPcLYv6iEYcwaNDowO8ZRkJ1OrfRoVeMBr9
    jSbgAKmk8Li4MNcKVJHYzB9+onPW2qMNRDmM+FMkzLP6g44Z0nZvd0jitz7MuyKf
    ji4dyA+UosuADJ2SK/ixNgj3k9/0OlzQ2/2O7jNovpQ6A/zHPTvW5NUd18WZnRmk
    L6JYHNhZE2Aa9p8aDuJsgTL3uD8vLTVcJ08ExuxB0IkWto6njwV0tZvZ+fEOKDm7
    MFbQ1nAnQ2F8cfGTZrVnwuq6jxt/7SzSF6+3SkC4NG3VOYQ9bJQ7VU/tBDYBmHUc
    N62x0sRBm3NSZPcJscIgMdm8ERNEiY5ONDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524755655; bh=ENJElcTPK01UT912b/AMuAxcbndDfV
    bvixRsQ0Xc+9s=; b=o5nx1D/TIocugCbaty3I2rMow5e64umy/FYZA5fokPptWc
    gUkoPQf2ML1NR22wWHyncJbEfRp0f2ojZUZTrk0CU4A2M8vpF/LEb4ed/by0d0Fc
    eomH7Ip9kbgoxmr8zOph3OpmqjaE6avtGBsATs5uhIq/5L/kKfoYuH6R/VoCA71i
    mmshxGKodkTSXcUM8PhT++eG74pZ2Wc2MOJ+0l8ggM3qVv7taN+4fsk4N+Cafb9E
    RKjUKgv0V9DwpjkrwVLpGlOcnmwcqJhCZ/QOtzxIXrTFv69o8c27nDo3XkotezAq
    +zjL6NQ7mZFcU99ydJNLHClNP5SZ3+s+qz+jdjUA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=h7RMp+P4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=8bytes.org header.i=@8bytes.org header.b=h7RMp+P4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGaaSsizF3wr99ONpBbQ8BRgzw7FUMl1kJ26Wmgsi0aXNT3VXnRM6jSndAurIIOoNadb9rySVuu5HK2CexEAjhCd4MZb5/DS4POJ8WbZO7/x4lU3aVul
    cg2JP7psZyu8p16M1wsGmFilE0MzfGcoOR+WL85fJpD9X2ywxXNsGmoCgQFw9P7gBL0QE02ry9BP5MUx1wFR5TjCBSmD5AjkZrZQ/GJVFgUtuNDGjAT9LehA
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=H-sLcIpQUprhFyUn1E8A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756519AbeDZPOM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 11:14:12 -0400
Received: from 8bytes.org ([81.169.241.247]:52400 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755698AbeDZPOM (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 11:14:12 -0400
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc: hpa@zytor.com, Michal Hocko <mhocko@suse.com>,
        Borislav Petkov <bp@suse.de>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Toshi Kani <toshi.kani@hpe.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] Revert "x86/mm: implement free pmd/pte page interfaces"
Date: Thu, 26 Apr 2018 17:14:07 +0200
Message-Id: <1524755647-18695-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

This reverts commit 28ee90fe6048fa7b7ceaeb8831c0e4e454a4cf89.

This commit is broken for x86, as it unmaps the PTE and PMD
pages and immediatly frees them without doing a TLB flush.

Further this lacks synchronization with other page-tables in
the system when the PMD pages are not shared between
mm_structs.

On x86-32 with PAE and PTI patches on-top this patch
triggers the BUG_ON in vmalloc_sync_one() because the kernel
and the process page-table were not synchronized.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pgtable.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ae98d4c5e32a..fd02a537a80f 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -787,22 +787,7 @@ int pmd_clear_huge(pmd_t *pmd)
  */
 int pud_free_pmd_page(pud_t *pud)
 {
-	pmd_t *pmd;
-	int i;
-
-	if (pud_none(*pud))
-		return 1;
-
-	pmd = (pmd_t *)pud_page_vaddr(*pud);
-
-	for (i = 0; i < PTRS_PER_PMD; i++)
-		if (!pmd_free_pte_page(&pmd[i]))
-			return 0;
-
-	pud_clear(pud);
-	free_page((unsigned long)pmd);
-
-	return 1;
+	return pud_none(*pud);
 }
 
 /**
@@ -814,15 +799,6 @@ int pud_free_pmd_page(pud_t *pud)
  */
 int pmd_free_pte_page(pmd_t *pmd)
 {
-	pte_t *pte;
-
-	if (pmd_none(*pmd))
-		return 1;
-
-	pte = (pte_t *)pmd_page_vaddr(*pmd);
-	pmd_clear(pmd);
-	free_page((unsigned long)pte);
-
-	return 1;
+	return pmd_none(*pmd);
 }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
-- 
2.13.6
