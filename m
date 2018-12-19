Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FFCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBECF2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOnaqwp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbeLSVfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:35:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37815 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730530AbeLSVeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:34:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so6690698ljd.4;
        Wed, 19 Dec 2018 13:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=yHB4k0lvmhU4nXv0IUtjgNRdUGapAYzZQcu+eQuvDdA=;
        b=kOnaqwp5GBEPCU0a21wgkz/EG5Ts/3mLyDdMp2Mo/NK9HQoGQ8NjvOhrJz+z5RPlwM
         T3QOLqQzntFpKjHk3dHoLVRsqc2EWGa9YtNeI4cU0zgXLyzfHZhUK8yaDT2ruKWD1LRU
         KMRBn6v5H2PL0wB2hxA1fqq2DmdHU4ical+SkVHpj5UTMBZHMB+zEleQP1z8EanXyix0
         qlv3x63u3GHJt7IKyNKSmuEGyqRdc8eUtV5+ala5HgnVpVM03uQ1OaKjeCJE8KK6dFJ/
         oXN2McI5XOKo5TOxG5hc0y2/hAi9i+p/IVDfegOJ2LWqyEzTTUFoZ96howTd3QfExt8H
         aVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=yHB4k0lvmhU4nXv0IUtjgNRdUGapAYzZQcu+eQuvDdA=;
        b=CbGyTZGlE+3SAxijxbozt1+5tSVHU83xCdhhRZ7BpA+V8iGduyS6SFwzOvDLxGy/82
         cJs7/kKeDec19K8FrCrVE1ZewTwAix+2MHIJWAIO3i8IefrAK3Qk6hzcqcpq1sIcPYb3
         vdvCYIu1Q9JP+yes6/xFd01GZYTeq2dNCA8B2pmKquvanFoYOIexh0GFZCkWcCqPYvwc
         LJgJNQAfjXs9eyu9NK7eTBRkKW0A8fVwdoGTVidU5etTObIFlavyGVmDGRiL4bWglw8H
         u0vRh0c8AeRWhRxpx2CYO1FcZ/zM6RBf4u1FX9QfufgtNrA7gH0qFydvf5IMRcjK1FUc
         0HeA==
X-Gm-Message-State: AA+aEWYFMSSgPq2AmfDkegguSfL2DSpGkT2b3Kayb+QxA7Wwrg4axps0
        6F8zsk1u0G4mgBlKzXr0e0Q=
X-Google-Smtp-Source: AFSGD/Uo61rA/JVaTfVFoo4LkxPpQtbW+kf75l1G+fg6IG3iNHxg6ZllSWLW1R02pnii+GSEQCqSOA==
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr13490729ljw.75.1545255251599;
        Wed, 19 Dec 2018 13:34:11 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v64sm3996867lfa.48.2018.12.19.13.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:34:11 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] __wr_after_init: x86_64: __wr_op
Date:   Wed, 19 Dec 2018 23:33:30 +0200
Message-Id: <20181219213338.26619-5-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181219213338.26619-1-igor.stoppa@huawei.com>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architecture-specific implementation of the core write rare
operation.

The implementation is based on code from Andy Lutomirski and Nadav Amit
for patching the text on x86 [here goes reference to commits, once merged]

The modification of write protected data is done through an alternate
mapping of the same pages, as writable.
This mapping is persistent, but active only for a core that is
performing a write rare operation. And only for the duration of said
operation.
Local interrupts are disabled, while the alternate mapping is active.

In theory, it could introduce a non-predictable delay, in a preemptible
system, however the amount of data to be altered is likely to be far
smaller than a page.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 arch/x86/Kconfig     |   1 +
 arch/x86/mm/Makefile |   2 +
 arch/x86/mm/prmem.c  | 120 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 arch/x86/mm/prmem.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8689e794a43c..e5e4fc4fa5c2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -32,6 +32,7 @@ config X86_64
 	select SWIOTLB
 	select X86_DEV_DMA_OPS
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select ARCH_HAS_PRMEM
 
 #
 # Arch settings
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 4b101dd6e52f..66652de1e2c7 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_PRMEM)		+= prmem.o
diff --git a/arch/x86/mm/prmem.c b/arch/x86/mm/prmem.c
new file mode 100644
index 000000000000..fc367551e736
--- /dev/null
+++ b/arch/x86/mm/prmem.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * prmem.c: Memory Protection Library
+ *
+ * (C) Copyright 2017-2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/string.h>
+#include <linux/compiler.h>
+#include <linux/slab.h>
+#include <linux/mmu_context.h>
+#include <linux/rcupdate.h>
+#include <linux/prmem.h>
+
+static __ro_after_init bool wr_ready;
+static __ro_after_init struct mm_struct *wr_poking_mm;
+static __ro_after_init unsigned long wr_poking_base;
+
+/*
+ * The following two variables are statically allocated by the linker
+ * script at the the boundaries of the memory region (rounded up to
+ * multiples of PAGE_SIZE) reserved for __wr_after_init.
+ */
+extern long __start_wr_after_init;
+extern long __end_wr_after_init;
+
+static inline bool is_wr_after_init(unsigned long ptr, __kernel_size_t size)
+{
+	unsigned long start = (unsigned long)&__start_wr_after_init;
+	unsigned long end = (unsigned long)&__end_wr_after_init;
+	unsigned long low = ptr;
+	unsigned long high = ptr + size;
+
+	return likely(start <= low && low <= high && high <= end);
+}
+
+void *__wr_op(unsigned long dst, unsigned long src, __kernel_size_t len,
+	      enum wr_op_type op)
+{
+	temporary_mm_state_t prev;
+	unsigned long offset;
+	unsigned long wr_poking_addr;
+
+	/* Confirm that the writable mapping exists. */
+	if (WARN_ONCE(!wr_ready, "No writable mapping available"))
+		return (void *)dst;
+
+	if (WARN_ONCE(op >= WR_OPS_NUMBER, "Invalid WR operation.") ||
+	    WARN_ONCE(!is_wr_after_init(dst, len), "Invalid WR range."))
+		return (void *)dst;
+
+	offset = dst - (unsigned long)&__start_wr_after_init;
+	wr_poking_addr = wr_poking_base + offset;
+	local_irq_disable();
+	prev = use_temporary_mm(wr_poking_mm);
+
+	if (op == WR_MEMCPY)
+		copy_to_user((void __user *)wr_poking_addr, (void *)src, len);
+	else if (op == WR_MEMSET)
+		memset_user((void __user *)wr_poking_addr, (u8)src, len);
+
+	unuse_temporary_mm(prev);
+	local_irq_enable();
+	return (void *)dst;
+}
+
+#define TB (1UL << 40)
+
+struct mm_struct *copy_init_mm(void);
+void __init wr_poking_init(void)
+{
+	unsigned long start = (unsigned long)&__start_wr_after_init;
+	unsigned long end = (unsigned long)&__end_wr_after_init;
+	unsigned long i;
+	unsigned long wr_range;
+
+	wr_poking_mm = copy_init_mm();
+	if (WARN_ONCE(!wr_poking_mm, "No alternate mapping available."))
+		return;
+
+	wr_range = round_up(end - start, PAGE_SIZE);
+
+	/* Randomize the poking address base*/
+	wr_poking_base = TASK_UNMAPPED_BASE +
+		(kaslr_get_random_long("Write Rare Poking") & PAGE_MASK) %
+		(TASK_SIZE - (TASK_UNMAPPED_BASE + wr_range));
+
+	/*
+	 * Place 64TB of kernel address space within 128TB of user address
+	 * space, at a random page aligned offset.
+	 */
+	wr_poking_base = (((unsigned long)kaslr_get_random_long("WR Poke")) &
+			  PAGE_MASK) % (64 * _BITUL(40));
+
+	/* Create alternate mapping for the entire wr_after_init range. */
+	for (i = start; i < end; i += PAGE_SIZE) {
+		struct page *page;
+		spinlock_t *ptl;
+		pte_t pte;
+		pte_t *ptep;
+		unsigned long wr_poking_addr;
+
+		page = virt_to_page(i);
+		if (WARN_ONCE(!page, "WR memory without physical page"))
+			return;
+		wr_poking_addr = i - start + wr_poking_base;
+
+		/* The lock is not needed, but avoids open-coding. */
+		ptep = get_locked_pte(wr_poking_mm, wr_poking_addr, &ptl);
+		if (WARN_ONCE(!ptep, "No pte for writable mapping"))
+			return;
+
+		pte = mk_pte(page, PAGE_KERNEL);
+		set_pte_at(wr_poking_mm, wr_poking_addr, ptep, pte);
+		spin_unlock(ptl);
+	}
+	wr_ready = true;
+}
-- 
2.19.1

