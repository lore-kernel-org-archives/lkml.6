Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B107321906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKdyKx/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404351AbeLUSPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:15:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45676 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404321AbeLUSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:14:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so5512010ljd.12;
        Fri, 21 Dec 2018 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=SN1YxRssqD/qbsJs6cWB56zoRuTrhLbtpCLtQvrTRuc=;
        b=TKdyKx/jrCPmAFRDV+JRiJANdImKAj933DMPS306pGi86XGkwj+0veYOqtcDmcyrjO
         vCfsX0EjPqV6JxEspMuCD7syOFu+fW7Ls0bgV1b4ZlTcTyIi5Oql5zNbSuc+80jK+/VX
         DM/4H8lprBVKz14tLSiADp5ICDkz9mVWmG/oMRH2xA0HOSQ6dNu953TqUVZjoQMNoDru
         8FUS4oIGexrnmUsUPtj5ID/wr0hQgkpGKK+v8UuNNqz65pIaMEGbkr9wNg/hB4jMcz59
         55PPj9akWYr8I0WhAzAG2xKK3oAvQD03wecwMctx3PGb9u8gNaL91wY0bxv5f9mXqxAo
         e80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=SN1YxRssqD/qbsJs6cWB56zoRuTrhLbtpCLtQvrTRuc=;
        b=Be4cQJkAqWx4oTdR6qmiYWqILp5n58RYvZAGwHu2RNFCTOpszc/CuP8JxAGm5F3DMR
         K5THdBnYqoHGR4nFhQNXrpOqmx5hDTSoYrQCNfsBRCIWsbM4Z9QgDql1cjKHZi/VtEm0
         hIbyJLBPBPksn4D+GQhY9r8auuU0D050UDltgE7xJKkDQ0qQ77sE8pgqAA+aH6fIqawX
         CXJ8FaOXlvqtn3F3oj+NrQBnwomI3fkVtpMTuhwD95PuRlAS/cMapEOPqes5CKaoRiJE
         gFxCOfRIOfm3UEU3c34EpiY/FeGrp5MtGwZCqsKKI3SumQJLYnrFB6lomDHl9oEwf3WA
         1/+Q==
X-Gm-Message-State: AJcUukfjPmpCgaS/eweNkpZb+dx62C8OF/RRUsszo4LF8aREk+1A0b78
        nN+tvOaCses/L++hDRP1K88=
X-Google-Smtp-Source: ALg8bN6yuIckmNbKpfr+n67Or7uaJ2oFluosJDTSIQkUgvEiIqLM5ThHxUlnxLGzEbhgxJM4/tnQfw==
X-Received: by 2002:a2e:98c9:: with SMTP id s9-v6mr1937913ljj.166.1545416094071;
        Fri, 21 Dec 2018 10:14:54 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:14:53 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] __wr_after_init: x86_64: __wr_op
Date:   Fri, 21 Dec 2018 20:14:16 +0200
Message-Id: <20181221181423.20455-6-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221181423.20455-1-igor.stoppa@huawei.com>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
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
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 arch/x86/Kconfig             |  1 +
 arch/x86/include/asm/prmem.h | 72 ++++++++++++++++++++++++++++++++++++
 arch/x86/mm/Makefile         |  2 +
 arch/x86/mm/prmem.c          | 69 ++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+)
 create mode 100644 arch/x86/include/asm/prmem.h
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
diff --git a/arch/x86/include/asm/prmem.h b/arch/x86/include/asm/prmem.h
new file mode 100644
index 000000000000..e1f09f881351
--- /dev/null
+++ b/arch/x86/include/asm/prmem.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * prmem.h: Header for memory protection library
+ *
+ * (C) Copyright 2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ *
+ * Support for:
+ * - statically allocated write rare data
+ */
+
+#ifndef _ASM_X86_PRMEM_H
+#define _ASM_X86_PRMEM_H
+
+#include <linux/set_memory.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/compiler.h>
+#include <linux/irqflags.h>
+#include <linux/mmu_context.h>
+
+typedef temporary_mm_state_t wr_state_t;
+
+extern __ro_after_init struct mm_struct *wr_poking_mm;
+extern __ro_after_init unsigned long wr_poking_base;
+
+static inline void *__wr_addr(void *addr)
+{
+	return (void *)(wr_poking_base + (unsigned long)addr);
+}
+
+static inline void __wr_enable(wr_state_t *state)
+{
+	*state = use_temporary_mm(wr_poking_mm);
+}
+
+static inline void __wr_disable(wr_state_t *state)
+{
+	unuse_temporary_mm(*state);
+}
+
+
+/**
+ * __wr_memset() - sets len bytes of the destination p to the c value
+ * @p: beginning of the memory to write to
+ * @c: byte to replicate
+ * @len: amount of bytes to copy
+ *
+ * Returns pointer to the destination
+ */
+static inline void *__wr_memset(void *p, int c, __kernel_size_t len)
+{
+	return (void *)memset_user((void __user *)p, (u8)c, len);
+}
+
+/**
+ * __wr_memcpy() - copyes size bytes from q to p
+ * @p: beginning of the memory to write to
+ * @q: beginning of the memory to read from
+ * @size: amount of bytes to copy
+ *
+ * Returns pointer to the destination
+ */
+static inline void *__wr_memcpy(void *p, const void *q, __kernel_size_t size)
+{
+	return (void *)copy_to_user((void __user *)p, q, size);
+}
+
+#endif
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
index 000000000000..f4b36baa2f19
--- /dev/null
+++ b/arch/x86/mm/prmem.c
@@ -0,0 +1,69 @@
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
+#include <linux/rcupdate.h>
+#include <linux/prmem.h>
+
+extern __ro_after_init bool wr_ready;
+__ro_after_init struct mm_struct *wr_poking_mm;
+__ro_after_init unsigned long wr_poking_base;
+
+/*
+ * The following two variables are statically allocated by the linker
+ * script at the the boundaries of the memory region (rounded up to
+ * multiples of PAGE_SIZE) reserved for __wr_after_init.
+ */
+extern long __start_wr_after_init;
+extern long __end_wr_after_init;
+
+struct mm_struct *copy_init_mm(void);
+void __init wr_poking_init(void)
+{
+	unsigned long start = (unsigned long)&__start_wr_after_init;
+	unsigned long end = (unsigned long)&__end_wr_after_init;
+	unsigned long i;
+
+	wr_poking_mm = copy_init_mm();
+	if (WARN_ONCE(!wr_poking_mm, "No alternate mapping available."))
+		return;
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
+		wr_poking_addr = i + wr_poking_base;
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

