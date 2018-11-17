Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB35C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7D020817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7D020817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeKQUlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 15:41:16 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9499 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbeKQUlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 15:41:15 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42xrnk2N5gz9tyD5;
        Sat, 17 Nov 2018 11:24:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FiCg7vbvDS1E; Sat, 17 Nov 2018 11:24:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42xrnk1mBgz9ty07;
        Sat, 17 Nov 2018 11:24:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F7838B78A;
        Sat, 17 Nov 2018 11:25:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ie4xxC9fwOkz; Sat, 17 Nov 2018 11:25:01 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 273BE8B74B;
        Sat, 17 Nov 2018 11:25:01 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E79D869A6C; Sat, 17 Nov 2018 10:25:00 +0000 (UTC)
Message-Id: <dd270cafe06cc37079d4924cac8030823d4b7610.1542395798.git.christophe.leroy@c-s.fr>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/7] powerpc/32: Remove #ifdef CONFIG_PPC_STD_MMU_32 in
 asm/book3s/32/pgtable.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Date:   Sat, 17 Nov 2018 10:25:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/book3s/32/pgtable.h is only included when CONFIG_PPC_BOOK3S_32 is set.
Whenever CONFIG_PPC_BOOK3S_32 is set, CONFIG_PPC_STD_MMU_32 is set as well.

This patch removes useless CONFIG_PPC_STD_MMU_32 #ifdefs

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c21d33704633..b849b45429d5 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -524,7 +524,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, int percpu)
 {
-#if defined(CONFIG_PPC_STD_MMU_32) && defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
+#if defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
 	/* First case is 32-bit Hash MMU in SMP mode with 32-bit PTEs. We use the
 	 * helper pte_update() which does an atomic update. We need to do that
 	 * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
@@ -537,7 +537,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	else
 		pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte));
 
-#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
+#elif defined(CONFIG_PTE_64BIT)
 	/* Second case is 32-bit with 64-bit PTE.  In this case, we
 	 * can just store as long as we do the two halves in the right order
 	 * with a barrier in between. This is possible because we take care,
@@ -560,7 +560,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
 	: "r" (pte) : "memory");
 
-#elif defined(CONFIG_PPC_STD_MMU_32)
+#else
 	/* Third case is 32-bit hash table in UP mode, we need to preserve
 	 * the _PAGE_HASHPTE bit since we may not have invalidated the previous
 	 * translation in the hash yet (done in a subsequent flush_tlb_xxx())
@@ -568,9 +568,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 */
 	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
 		      | (pte_val(pte) & ~_PAGE_HASHPTE));
-
-#else
-#error "Not supported "
 #endif
 }
 
-- 
2.13.3

