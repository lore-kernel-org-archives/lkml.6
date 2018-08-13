Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F52CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5188821745
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5188821745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeHMQJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:09:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23355 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeHMQJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:09:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41pxNY5WZFz9tvRL;
        Mon, 13 Aug 2018 15:27:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id p9b9vaNHpnN7; Mon, 13 Aug 2018 15:27:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41pxNY4v5pz9tvRJ;
        Mon, 13 Aug 2018 15:27:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F3D888B7A7;
        Mon, 13 Aug 2018 15:27:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NhIlzUvyQkxF; Mon, 13 Aug 2018 15:27:25 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA8E58B752;
        Mon, 13 Aug 2018 15:27:25 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D9F5A7125F; Mon, 13 Aug 2018 13:27:25 +0000 (UTC)
Message-Id: <a0f9af0f829952b48669619282e3780509235b85.1534166756.git.christophe.leroy@c-s.fr>
In-Reply-To: <1cbc8dba537393edbb6384b67cbb123431ba6a32.1534166756.git.christophe.leroy@c-s.fr>
References: <1cbc8dba537393edbb6384b67cbb123431ba6a32.1534166756.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3] powerpc/mm: remove ctor argument to pgtable_cache_add()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 13 Aug 2018 13:27:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As previous patch has removed all pgtable cache constructors,
lets remove it completely.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pgtable.h |  2 +-
 arch/powerpc/mm/hugetlbpage.c      |  2 +-
 arch/powerpc/mm/init-common.c      | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 14c79a7dc855..d3195ac00a0b 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -72,7 +72,7 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 /* can we use this in kvm */
 unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
+void pgtable_cache_add(unsigned shift);
 void pgtable_cache_init(void);
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7296a42eb62e..72f31fc70b8e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -701,7 +701,7 @@ static int __init hugetlbpage_init(void)
 		 * use pgt cache for hugepd.
 		 */
 		if (pdshift > shift)
-			pgtable_cache_add(pdshift - shift, NULL);
+			pgtable_cache_add(pdshift - shift);
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		else if (!hugepte_cache) {
 			/*
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2ae15ff8f76f..8fb182aaf87d 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -35,7 +35,7 @@ EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
  * everything else.  Caches created by this function are used for all
  * the higher level pagetables, and for hugepage pagetables.
  */
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
+void pgtable_cache_add(unsigned shift)
 {
 	char *name;
 	unsigned long table_size = sizeof(void *) << shift;
@@ -63,7 +63,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
-	new = kmem_cache_create(name, table_size, align, 0, ctor);
+	new = kmem_cache_create(name, table_size, align, 0, NULL);
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 
@@ -76,15 +76,15 @@ EXPORT_SYMBOL_GPL(pgtable_cache_add);	/* used by kvm_hv module */
 
 void pgtable_cache_init(void)
 {
-	pgtable_cache_add(PGD_INDEX_SIZE, NULL);
+	pgtable_cache_add(PGD_INDEX_SIZE);
 
 	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
-		pgtable_cache_add(PMD_CACHE_INDEX, NULL);
+		pgtable_cache_add(PMD_CACHE_INDEX);
 	/*
 	 * In all current configs, when the PUD index exists it's the
 	 * same size as either the pgd or pmd index except with THP enabled
 	 * on book3s 64
 	 */
 	if (PUD_CACHE_INDEX && !PGT_CACHE(PUD_CACHE_INDEX))
-		pgtable_cache_add(PUD_CACHE_INDEX, NULL);
+		pgtable_cache_add(PUD_CACHE_INDEX);
 }
-- 
2.13.3

