Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeE3Qmk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:42:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31356 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932090AbeE3Ql7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:41:59 -0400
Message-Id: <ca10c993b7c7f0ed670548c1a9051832c7acbc08.1527697995.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527697995.git.christophe.leroy@c-s.fr>
References: <cover.1527697995.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 7/8] powerpc/book3s: Remove PPC_PIN_SIZE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 16:41:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC_PIN_SIZE is specific to the 44x and is defined in mmu.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 5 -----
 arch/powerpc/include/asm/nohash/32/pgtable.h | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c615abdce119..0603479d04c3 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -84,17 +84,12 @@
  * of RAM.  -- Cort
  */
 #define VMALLOC_OFFSET (0x1000000) /* 16M */
-#ifdef PPC_PIN_SIZE
-#define VMALLOC_START (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
-#else
 #define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
-#endif
 #define VMALLOC_END	ioremap_bot
 
 #ifndef __ASSEMBLY__
 #include <linux/sched.h>
 #include <linux/threads.h>
-#include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
 
 extern unsigned long ioremap_bot;
 
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 987a658b18e1..35fa43c20b6e 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -8,7 +8,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/sched.h>
 #include <linux/threads.h>
-#include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
+#include <asm/mmu.h>			/* For sub-arch specific PPC_PIN_SIZE */
 
 extern unsigned long ioremap_bot;
 
-- 
2.13.3
