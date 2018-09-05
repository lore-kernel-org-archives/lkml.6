Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0766AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B867020857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B867020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeIERHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:07:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30974 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbeIERHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:07:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42539w0mtpz9tvSl;
        Wed,  5 Sep 2018 14:37:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0jsjPnNtWXvK; Wed,  5 Sep 2018 14:37:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42539w0JDyz9tvSC;
        Wed,  5 Sep 2018 14:37:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C0C78B82C;
        Wed,  5 Sep 2018 14:37:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LgA__Zhblh-X; Wed,  5 Sep 2018 14:37:08 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D60F68B762;
        Wed,  5 Sep 2018 14:37:07 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B7F337159B; Wed,  5 Sep 2018 12:37:07 +0000 (UTC)
Message-Id: <d2087f591a815825bcc2bc7869cd95337d7d33cf.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 08/17] powerpc/mm: drop unused page flags
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  5 Sep 2018 12:37:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following page flags in pte-common.h can be dropped:

_PAGE_ENDIAN is only used in mm/fsl_booke_mmu.c and is defined in
asm/nohash/32/pte-fsl-booke.h

_PAGE_4K_PFN is nowhere defined nor used

_PAGE_READ, _PAGE_WRITE and _PAGE_PTE are only defined and used
in book3s/64

The following page flags in book3s/64/pgtable.h can be dropped as
they are not used on this platform nor by common code.

_PAGE_NA, _PAGE_RO, _PAGE_USER and _PAGE_PSIZE

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +---------
 arch/powerpc/include/asm/pte-common.h        | 17 +----------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index b8a88c6d34ff..23299e1a2c08 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -14,10 +14,6 @@
  */
 #define _PAGE_BIT_SWAP_TYPE	0
 
-#define _PAGE_NA		0
-#define _PAGE_RO		0
-#define _PAGE_USER		0
-
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_WRITE		0x00002 /* write access allowed */
 #define _PAGE_READ		0x00004	/* read access allowed */
@@ -123,10 +119,6 @@
 #define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY |	\
 				 _PAGE_RW | _PAGE_EXEC)
 /*
- * No page size encoding in the linux PTE
- */
-#define _PAGE_PSIZE		0
-/*
  * _PAGE_CHG_MASK masks of bits that are to be preserved across
  * pgprot changes
  */
@@ -149,7 +141,7 @@
  * pages. We always set _PAGE_COHERENT when SMP is enabled or
  * the processor might need it for DMA coherency.
  */
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
 #define _PAGE_BASE	(_PAGE_BASE_NC)
 
 /* Permission masks used to generate the __P and __S table,
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index bef56141a549..5a5ba43bdf98 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -14,18 +14,12 @@
 #ifndef _PAGE_EXEC
 #define _PAGE_EXEC	0
 #endif
-#ifndef _PAGE_ENDIAN
-#define _PAGE_ENDIAN	0
-#endif
 #ifndef _PAGE_COHERENT
 #define _PAGE_COHERENT	0
 #endif
 #ifndef _PAGE_WRITETHRU
 #define _PAGE_WRITETHRU	0
 #endif
-#ifndef _PAGE_4K_PFN
-#define _PAGE_4K_PFN		0
-#endif
 #ifndef _PAGE_SAO
 #define _PAGE_SAO	0
 #endif
@@ -39,9 +33,6 @@
 #define _PAGE_RW 0
 #endif
 
-#ifndef _PAGE_PTE
-#define _PAGE_PTE 0
-#endif
 /* At least one of _PAGE_PRIVILEGED or _PAGE_USER must be defined */
 #ifndef _PAGE_PRIVILEGED
 #define _PAGE_PRIVILEGED 0
@@ -122,7 +113,7 @@ static inline bool pte_user(pte_t pte)
 
 /* Mask of bits returned by pte_pgprot() */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | _PAGE_ENDIAN | _PAGE_4K_PFN | \
+			 _PAGE_WRITETHRU | \
 			 _PAGE_USER | _PAGE_ACCESSED | _PAGE_RO | _PAGE_NA | \
 			 _PAGE_PRIVILEGED | \
 			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
@@ -208,12 +199,6 @@ static inline bool pte_user(pte_t pte)
 #define PAGE_AGP		(PAGE_KERNEL_NC)
 #define HAVE_PAGE_AGP
 
-#ifndef _PAGE_READ
-/* if not defined, we should not find _PAGE_WRITE too */
-#define _PAGE_READ 0
-#define _PAGE_WRITE _PAGE_RW
-#endif
-
 #ifndef H_PAGE_4K_PFN
 #define H_PAGE_4K_PFN 0
 #endif
-- 
2.13.3

