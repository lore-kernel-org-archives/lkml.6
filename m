Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751EAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDE82077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDE82077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIERHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:07:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26354 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbeIERHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:07:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4253BD2vcMz9tvSc;
        Wed,  5 Sep 2018 14:37:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZCQFZJiNrsTt; Wed,  5 Sep 2018 14:37:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4253BD2S6Nz9tvSC;
        Wed,  5 Sep 2018 14:37:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 77A308B82B;
        Wed,  5 Sep 2018 14:37:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PVIfikEF8nsq; Wed,  5 Sep 2018 14:37:24 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 471D18B762;
        Wed,  5 Sep 2018 14:37:24 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0F57E7159B; Wed,  5 Sep 2018 12:37:24 +0000 (UTC)
Message-Id: <67421dcc38afc4f916c74d098a8be283a4e3af88.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 16/17] powerpc/mm: Get rid of pte-common.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  5 Sep 2018 12:37:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not include pte-common.h in nohash/32/pgtable.h

As that was the last includer, get rid of pte-common.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 23 +++++++++++++++++++++--
 arch/powerpc/include/asm/pte-common.h        | 25 -------------------------
 2 files changed, 21 insertions(+), 27 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/pte-common.h

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 1577260641c9..562659b2f62b 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -128,8 +128,27 @@ extern int icache_44x_need_flush;
 #include <asm/nohash/32/pte-8xx.h>
 #endif
 
-/* And here we include common definitions */
-#include <asm/pte-common.h>
+/* Location of the PFN in the PTE. Most 32-bit platforms use the same
+ * as _PAGE_SHIFT here (ie, naturally aligned).
+ * Platform who don't just pre-define the value so we don't override it here
+ */
+#ifndef PTE_RPN_SHIFT
+#define PTE_RPN_SHIFT	(PAGE_SHIFT)
+#endif
+
+/* The mask covered by the RPN must be a ULL on 32-bit platforms with
+ * 64-bit PTEs
+ */
+#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
+#define PTE_RPN_MASK	(~((1ULL << PTE_RPN_SHIFT) - 1))
+#else
+#define PTE_RPN_MASK	(~((1UL << PTE_RPN_SHIFT) - 1))
+#endif
+
+/* _PAGE_CHG_MASK masks of bits that are to be preserved across
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPECIAL)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
deleted file mode 100644
index ff01368a175a..000000000000
--- a/arch/powerpc/include/asm/pte-common.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Included from asm/pgtable-*.h only ! */
-
-/* Location of the PFN in the PTE. Most 32-bit platforms use the same
- * as _PAGE_SHIFT here (ie, naturally aligned).
- * Platform who don't just pre-define the value so we don't override it here
- */
-#ifndef PTE_RPN_SHIFT
-#define PTE_RPN_SHIFT	(PAGE_SHIFT)
-#endif
-
-/* The mask covered by the RPN must be a ULL on 32-bit platforms with
- * 64-bit PTEs
- */
-#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
-#define PTE_RPN_MASK	(~((1ULL<<PTE_RPN_SHIFT)-1))
-#else
-#define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
-#endif
-
-/* _PAGE_CHG_MASK masks of bits that are to be preserved across
- * pgprot changes
- */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | \
-                         _PAGE_ACCESSED | _PAGE_SPECIAL)
-- 
2.13.3

