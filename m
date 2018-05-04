Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeEDMeQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:34:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23270 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751612AbeEDMeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:34:13 -0400
Message-Id: <4fd69cf9e9a7ce45e7bf1c64de4272d519944a80.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  10/17] powerpc: use _ALIGN macro
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:34:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index b413abcd5a09..93dc22dbe964 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -99,9 +99,9 @@ extern int icache_44x_need_flush;
  */
 #define VMALLOC_OFFSET (0x1000000) /* 16M */
 #ifdef PPC_PIN_SIZE
-#define VMALLOC_BASE (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#define VMALLOC_BASE _ALIGN_DOWN(_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET, VMALLOC_OFFSET)
 #else
-#define VMALLOC_BASE ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#define VMALLOC_BASE _ALIGN_DOWN((long)high_memory + VMALLOC_OFFSET, VMALLOC_OFFSET)
 #endif
 #define VMALLOC_START	ioremap_bot
 #define VMALLOC_END	IOREMAP_END
-- 
2.13.3
