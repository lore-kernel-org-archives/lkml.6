Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C68C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD4B2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD4B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJIVJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:09:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64181 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbeJIVJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:09:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42TzDc1ngdz9ttgH;
        Tue,  9 Oct 2018 15:52:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hNE_nhzX-OvC; Tue,  9 Oct 2018 15:52:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42TzDc130nz9ttfw;
        Tue,  9 Oct 2018 15:52:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A8F078B80C;
        Tue,  9 Oct 2018 15:52:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wgmbqJRf80gK; Tue,  9 Oct 2018 15:52:11 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 193558B80A;
        Tue,  9 Oct 2018 15:52:11 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 60C9B6F444; Tue,  9 Oct 2018 13:52:10 +0000 (UTC)
Message-Id: <f442fba83ab8488ec73c4f060fdb134f425b7598.1539092112.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 19/24] powerpc/nohash/64: do not include pte-common.h
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date:   Tue,  9 Oct 2018 13:52:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nohash/64 only uses book3e PTE flags, so it doesn't need pte-common.h

This also allows to drop PAGE_SAO and H_PAGE_4K_PFN from pte_common.h
as they are only used by PPC64

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/64/pgtable.h | 16 ++++++++++++-
 arch/powerpc/include/asm/nohash/pgtable.h    | 27 +++++++++++++++++++++
 arch/powerpc/include/asm/pte-common.h        | 35 ----------------------------
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index b7d65d4b61be..9ccea94b3d4e 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -89,7 +89,21 @@
  * Include the PTE bits definitions
  */
 #include <asm/nohash/pte-book3e.h>
-#include <asm/pte-common.h>
+
+#define _PAGE_HWWRITE	0
+#define _PAGE_SAO	0
+#define _PAGE_RO 0
+#define _PAGE_NA 0
+#define _PAGE_HUGE 0
+
+#define PTE_RPN_MASK	(~((1UL << PTE_RPN_SHIFT) - 1))
+
+/* _PAGE_CHG_MASK masks of bits that are to be preserved across
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPECIAL)
+
+#define H_PAGE_4K_PFN 0
 
 #ifndef __ASSEMBLY__
 /* pte_clear moved to later in this file */
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 8de3b7eb88b0..d3feeac19467 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -8,6 +8,33 @@
 #include <asm/nohash/32/pgtable.h>
 #endif
 
+/* Permission masks used for kernel mappings */
+#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
+#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | _PAGE_NO_CACHE)
+#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NO_CACHE | _PAGE_GUARDED)
+#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
+#define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
+#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
+
+/* Protection used for kernel text. We want the debuggers to be able to
+ * set breakpoints anywhere, so don't write protect the kernel text
+ * on platforms where such control is possible.
+ */
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
+	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
+#else
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
+#endif
+
+/* Make modules code happy. We don't set RO yet */
+#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
+
+/* Advertise special mapping type for AGP */
+#define PAGE_AGP		(PAGE_KERNEL_NC)
+#define HAVE_PAGE_AGP
+
 #ifndef __ASSEMBLY__
 
 /* Generic accessors to PTE bits */
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index cce60b3ba7d4..4d594039bca5 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -14,9 +14,6 @@
 #ifndef _PAGE_WRITETHRU
 #define _PAGE_WRITETHRU	0
 #endif
-#ifndef _PAGE_SAO
-#define _PAGE_SAO	0
-#endif
 /* _PAGE_RO and _PAGE_RW shall not be defined at the same time */
 #ifndef _PAGE_RO
 #define _PAGE_RO 0
@@ -61,35 +58,3 @@
  */
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | \
                          _PAGE_ACCESSED | _PAGE_SPECIAL)
-
-/* Permission masks used for kernel mappings */
-#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
-#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_NO_CACHE)
-#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_NO_CACHE | _PAGE_GUARDED)
-#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX)
-#define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
-#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_ROX)
-
-/* Protection used for kernel text. We want the debuggers to be able to
- * set breakpoints anywhere, so don't write protect the kernel text
- * on platforms where such control is possible.
- */
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
-#else
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
-#endif
-
-/* Make modules code happy. We don't set RO yet */
-#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
-
-/* Advertise special mapping type for AGP */
-#define PAGE_AGP		(PAGE_KERNEL_NC)
-#define HAVE_PAGE_AGP
-
-#ifndef H_PAGE_4K_PFN
-#define H_PAGE_4K_PFN 0
-#endif
-- 
2.13.3

