Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B00C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202ED2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202ED2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeIYW7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:59:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36784 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeIYW7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:59:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KRsq2xt9z9ttFq;
        Tue, 25 Sep 2018 18:51:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DYO_yBGThK-q; Tue, 25 Sep 2018 18:51:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KRsq2SZfz9ttCN;
        Tue, 25 Sep 2018 18:51:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BFDA8B7E5;
        Tue, 25 Sep 2018 18:51:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tIycUsJzb0wb; Tue, 25 Sep 2018 18:51:11 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 24F7C8B7C8;
        Tue, 25 Sep 2018 18:51:11 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C0D7270AFE; Tue, 25 Sep 2018 16:51:10 +0000 (UTC)
Message-Id: <a866faa9455b0e59d7d7bca28cb06c09ab5f3589.1537892499.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537892498.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 16/22] powerpc/mm: move platform specific mmu-xxx.h in
 platform directories
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Sep 2018 16:51:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch is to move platform specific
mmu-xxx.h files in platform directories like pte-xxx.h files.

In the meantime this patch creates common nohash and
nohash/32 + nohash/64 mmu.h files for future common parts.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h                     | 14 ++------------
 arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h |  0
 arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h |  0
 arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h |  0
 arch/powerpc/include/asm/nohash/32/mmu.h           | 19 +++++++++++++++++++
 arch/powerpc/include/asm/nohash/64/mmu.h           |  8 ++++++++
 arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h |  0
 arch/powerpc/include/asm/nohash/mmu.h              | 11 +++++++++++
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |  2 +-
 arch/powerpc/kvm/e500.h                            |  2 +-
 10 files changed, 42 insertions(+), 14 deletions(-)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-40x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-44x.h (100%)
 rename arch/powerpc/include/asm/{ => nohash/32}/mmu-8xx.h (100%)
 create mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
 create mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h
 rename arch/powerpc/include/asm/{ => nohash}/mmu-book3e.h (100%)
 create mode 100644 arch/powerpc/include/asm/nohash/mmu.h

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 13ea441ac531..2b396de45e9e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -326,18 +326,8 @@ static inline void mmu_early_init_devtree(void) { }
 #if defined(CONFIG_PPC_STD_MMU_32)
 /* 32-bit classic hash table MMU */
 #include <asm/book3s/32/mmu-hash.h>
-#elif defined(CONFIG_40x)
-/* 40x-style software loaded TLB */
-#  include <asm/mmu-40x.h>
-#elif defined(CONFIG_44x)
-/* 44x-style software loaded TLB */
-#  include <asm/mmu-44x.h>
-#elif defined(CONFIG_PPC_BOOK3E_MMU)
-/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
-#  include <asm/mmu-book3e.h>
-#elif defined (CONFIG_PPC_8xx)
-/* Motorola/Freescale 8xx software loaded TLB */
-#  include <asm/mmu-8xx.h>
+#elif defined(CONFIG_PPC_MMU_NOHASH)
+#include <asm/nohash/mmu.h>
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-40x.h
rename to arch/powerpc/include/asm/nohash/32/mmu-40x.h
diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-44x.h
rename to arch/powerpc/include/asm/nohash/32/mmu-44x.h
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-8xx.h
rename to arch/powerpc/include/asm/nohash/32/mmu-8xx.h
diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
new file mode 100644
index 000000000000..af0e8b54876a
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/mmu.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
+#define _ASM_POWERPC_NOHASH_32_MMU_H_
+
+#if defined(CONFIG_40x)
+/* 40x-style software loaded TLB */
+#include <asm/nohash/32/mmu-40x.h>
+#elif defined(CONFIG_44x)
+/* 44x-style software loaded TLB */
+#include <asm/nohash/32/mmu-44x.h>
+#elif defined(CONFIG_PPC_BOOK3E_MMU)
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+#elif defined (CONFIG_PPC_8xx)
+/* Motorola/Freescale 8xx software loaded TLB */
+#include <asm/nohash/32/mmu-8xx.h>
+#endif
+
+#endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
new file mode 100644
index 000000000000..87871d027b75
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
+#define _ASM_POWERPC_NOHASH_64_MMU_H_
+
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+
+#endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
similarity index 100%
rename from arch/powerpc/include/asm/mmu-book3e.h
rename to arch/powerpc/include/asm/nohash/mmu-book3e.h
diff --git a/arch/powerpc/include/asm/nohash/mmu.h b/arch/powerpc/include/asm/nohash/mmu.h
new file mode 100644
index 000000000000..a037cb1efb57
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/mmu.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_MMU_H_
+#define _ASM_POWERPC_NOHASH_MMU_H_
+
+#ifdef CONFIG_PPC64
+#include <asm/nohash/64/mmu.h>
+#else
+#include <asm/nohash/32/mmu.h>
+#endif
+
+#endif /* _ASM_POWERPC_NOHASH_MMU_H_ */
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 8d142e5d84cd..5fbc890d1094 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -17,7 +17,7 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
-#include <asm/mmu-book3e.h>
+#include <asm/nohash/mmu-book3e.h>
 #include <asm/asm-offsets.h>
 #include <asm/mpc85xx.h>
 
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 94f04fcb373e..962ee90a0dfe 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -20,7 +20,7 @@
 #define KVM_E500_H
 
 #include <linux/kvm_host.h>
-#include <asm/mmu-book3e.h>
+#include <asm/nohash/mmu-book3e.h>
 #include <asm/tlb.h>
 #include <asm/cputhreads.h>
 
-- 
2.13.3

