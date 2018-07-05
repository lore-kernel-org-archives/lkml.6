Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E89C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A5E20C0D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A5E20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754499AbeGEQ3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:29:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8787 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753660AbeGEQY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:24:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41M39K5xH3z9ttS7;
        Thu,  5 Jul 2018 18:24:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id niIhMhEqh1ot; Thu,  5 Jul 2018 18:24:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41M39K5Rtgz9ttRm;
        Thu,  5 Jul 2018 18:24:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 96A4A8B8CF;
        Thu,  5 Jul 2018 18:24:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rTGSDgHtv0Ft; Thu,  5 Jul 2018 18:24:55 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 702378B8BC;
        Thu,  5 Jul 2018 18:24:55 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 656C9711E2; Thu,  5 Jul 2018 16:24:55 +0000 (UTC)
Message-Id: <a22c869eab31ae38320f2e803833b0708b147d7c.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 03/16] powerpc/405: move PPC405_ERR77 in asm-405.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 16:24:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/asm-405.h           | 19 +++++++++++++++++++
 arch/powerpc/include/asm/asm-compat.h        | 13 -------------
 arch/powerpc/include/asm/atomic.h            |  1 +
 arch/powerpc/include/asm/bitops.h            |  1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 --
 arch/powerpc/include/asm/cmpxchg.h           |  1 +
 arch/powerpc/include/asm/futex.h             |  1 +
 arch/powerpc/include/asm/nohash/32/pgtable.h |  1 +
 arch/powerpc/include/asm/spinlock.h          |  1 +
 arch/powerpc/kernel/entry_32.S               |  1 +
 arch/powerpc/kernel/head_40x.S               |  1 +
 11 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100644 arch/powerpc/include/asm/asm-405.h

diff --git a/arch/powerpc/include/asm/asm-405.h b/arch/powerpc/include/asm/asm-405.h
new file mode 100644
index 000000000000..7270d3ae7c8e
--- /dev/null
+++ b/arch/powerpc/include/asm/asm-405.h
@@ -0,0 +1,19 @@
+#ifndef _ASM_POWERPC_ASM_405_H
+#define _ASM_POWERPC_ASM_405_H
+
+#include <asm/asm-const.h>
+
+#ifdef __KERNEL__
+#ifdef CONFIG_IBM405_ERR77
+/* Erratum #77 on the 405 means we need a sync or dcbt before every
+ * stwcx.  The old ATOMIC_SYNC_FIX covered some but not all of this.
+ */
+#define PPC405_ERR77(ra,rb)	stringify_in_c(dcbt	ra, rb;)
+#define	PPC405_ERR77_SYNC	stringify_in_c(sync;)
+#else
+#define PPC405_ERR77(ra,rb)
+#define PPC405_ERR77_SYNC
+#endif
+#endif
+
+#endif /* _ASM_POWERPC_ASM_405_H */
diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 7f2a7702596c..d2cf3593e987 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -70,17 +70,4 @@
 
 #endif
 
-#ifdef __KERNEL__
-#ifdef CONFIG_IBM405_ERR77
-/* Erratum #77 on the 405 means we need a sync or dcbt before every
- * stwcx.  The old ATOMIC_SYNC_FIX covered some but not all of this.
- */
-#define PPC405_ERR77(ra,rb)	stringify_in_c(dcbt	ra, rb;)
-#define	PPC405_ERR77_SYNC	stringify_in_c(sync;)
-#else
-#define PPC405_ERR77(ra,rb)
-#define PPC405_ERR77_SYNC
-#endif
-#endif
-
 #endif /* _ASM_POWERPC_ASM_COMPAT_H */
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 682b3e6a1e21..cbdb0b7e60a3 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
+#include <asm/asm-405.h>
 
 #define ATOMIC_INIT(i)		{ (i) }
 
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index b750ffef83c7..ff71566dadee 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -45,6 +45,7 @@
 #include <linux/compiler.h>
 #include <asm/asm-compat.h>
 #include <asm/synch.h>
+#include <asm/asm-405.h>
 
 /* PPC bit number conversion */
 #define PPC_BITLSHIFT(be)	(BITS_PER_LONG - 1 - (be))
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 02f5acd7ccc4..3c3e34240628 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -164,7 +164,6 @@ static inline unsigned long pte_update(pte_t *p,
 1:	lwarx	%0,0,%3\n\
 	andc	%1,%0,%4\n\
 	or	%1,%1,%5\n"
-	PPC405_ERR77(0,%3)
 "	stwcx.	%1,0,%3\n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
@@ -186,7 +185,6 @@ static inline unsigned long long pte_update(pte_t *p,
 	lwzx	%0,0,%3\n\
 	andc	%1,%L0,%5\n\
 	or	%1,%1,%6\n"
-	PPC405_ERR77(0,%3)
 "	stwcx.	%1,0,%4\n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 9b001f1f6b32..67ec1073ac97 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -7,6 +7,7 @@
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
 #include <linux/bug.h>
+#include <asm/asm-405.h>
 
 #ifdef __BIG_ENDIAN
 #define BITOFF_CAL(size, off)	((sizeof(u32) - size - off) * BITS_PER_BYTE)
diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 1a944c18c539..76c8648d0fa8 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -9,6 +9,7 @@
 #include <asm/errno.h>
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
+#include <asm/asm-405.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
   __asm__ __volatile ( \
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 7c46a98cc7f4..7df2f3a66cc5 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/threads.h>
 #include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
+#include <asm/asm-405.h>
 
 extern unsigned long ioremap_bot;
 
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 72dc4ddc2972..7ec38f4ee927 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -27,6 +27,7 @@
 #include <asm/asm-compat.h>
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
+#include <asm/asm-405.h>
 
 #ifdef CONFIG_PPC64
 /* use 0x800000yy when locked, where yy == CPU number */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 973577f2141c..7642cb984d3a 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -33,6 +33,7 @@
 #include <asm/unistd.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/asm-405.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 41374a468d1c..b19d78410511 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -42,6 +42,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/asm-405.h>
 
 /* As with the other PowerPC ports, it is expected that when code
  * execution begins here, the following registers contain valid, yet
-- 
2.13.3

