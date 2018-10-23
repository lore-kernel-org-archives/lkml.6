Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1668EC7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7122075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5HssUtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7122075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeJXGBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45448 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbeJXGBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id c24-v6so2318620lfi.12;
        Tue, 23 Oct 2018 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=lWr5dc2eNvTcJb+c+uRTUJwhKcPYmmWV6t14BAAM0+g=;
        b=K5HssUtWyqhs3CTyKNXHpefeYDtWkJbXaAX1XLxON4iECRSRB6QjMc5RCzYk0y3yfd
         3c1iOvdGFcidkqsyYIElslGkPelZCRE/JLn4hSqqkZH2OH3h57NZu/YFoNNNAjmaYHMg
         36urDvGuUDvpjx00WQrlW9VtHoMHr8CdHjsfQij3WvBYK3waVusZpw/gnqTE7YAg+T8z
         SO7hquz3XCCU2aYUVW1L7jBQGaZliOW0tEQjX97ZIN9jZwLllZqgweeeNE0Lm7lP2AZN
         mpclQP5Np4932IIJTLzPM1PMBsppoxoRMBjfYYZLQ0qprQKK8NxeH80SI6RaTIOohnqU
         wQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=lWr5dc2eNvTcJb+c+uRTUJwhKcPYmmWV6t14BAAM0+g=;
        b=WPLtZ6+dSBRgU7Xdy1o1wlvP5n+6YYAS3MAyUifrDw27kGrndsjTPXMbT7Bokcdri2
         naXQRGzE3xuXjnGDC3FvZxLiUI0mpg8MYuL9q17pfuULGFyh2pBgp7JMLPwYIkIN033R
         QP6Q34sULd+yl2R4QVyy5hpPVC3wxj1lwLPAT0fXNORfFndkNEppg6bngJO2d2yeO8tF
         Shv5CtX8GkD0QuJ/YMZXPk6l6CBiaMmUqUU+YuU/v+L4V6WAlC6PueBHUa4JL3WUSGsw
         1cd46dgeyLVKqRk42YEF08MNb3ugXKUMVbi3Wwi3Spqe6o7QwF7euvcNc+gefxbTJiOX
         Zl9w==
X-Gm-Message-State: ABuFfogJ7zsGuh0V2DQSKEHYzbq8l1a8zufI1z0Zpl7XL7Bij/FjfB0V
        rI07j1pgsamhSSwiBUaWQ1s=
X-Google-Smtp-Source: ACcGV63HspKtXzSwNphXjTw4U5KnYFl/LeBjRKri4bDR8FgHFnbdnJMdM8PgkfyEiZhsocjgUN4K2w==
X-Received: by 2002:a19:2648:: with SMTP id m69-v6mr12821527lfm.78.1540330559911;
        Tue, 23 Oct 2018 14:35:59 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:35:59 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] prmem: write rare for static allocation
Date:   Wed, 24 Oct 2018 00:34:49 +0300
Message-Id: <20181023213504.28905-3-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of write rare for statically allocated data, located in a
specific memory section through the use of the __write_rare label.

The basic functions are wr_memcpy() and wr_memset(): the write rare
counterparts of memcpy() and memset() respectively.

To minimize chances of attacks, this implementation does not unprotect
existing memory pages.
Instead, it remaps them, one by one, at random free locations, as writable.
Each page is mapped as writable strictly for the time needed to perform
changes in said page.
While a page is remapped, interrupts are disabled on the core performing
the write rare operation, to avoid being frozen mid-air by an attack
using interrupts for stretching the duration of the alternate mapping.
OTOH, to avoid introducing unpredictable delays, the interrupts are
re-enabled inbetween page remapping, when write operations are either
completed or not yet started, and there is not alternate, writable
mapping to exploit.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Michal Hocko <mhocko@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Pavel Tatashin <pasha.tatashin@oracle.com>
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 MAINTAINERS           |   7 ++
 include/linux/prmem.h | 213 ++++++++++++++++++++++++++++++++++++++++++
 mm/Makefile           |   1 +
 mm/prmem.c            |  10 ++
 4 files changed, 231 insertions(+)
 create mode 100644 include/linux/prmem.h
 create mode 100644 mm/prmem.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b2f710eee67a..e566c5d09faf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9454,6 +9454,13 @@ F:	kernel/sched/membarrier.c
 F:	include/uapi/linux/membarrier.h
 F:	arch/powerpc/include/asm/membarrier.h
 
+MEMORY HARDENING
+M:	Igor Stoppa <igor.stoppa@gmail.com>
+L:	kernel-hardening@lists.openwall.com
+S:	Maintained
+F:	include/linux/prmem.h
+F:	mm/prmem.c
+
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
diff --git a/include/linux/prmem.h b/include/linux/prmem.h
new file mode 100644
index 000000000000..3ba41d76a582
--- /dev/null
+++ b/include/linux/prmem.h
@@ -0,0 +1,213 @@
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
+#ifndef _LINUX_PRMEM_H
+#define _LINUX_PRMEM_H
+
+#include <linux/set_memory.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/compiler.h>
+#include <linux/irqflags.h>
+#include <linux/set_memory.h>
+
+/* ============================ Write Rare ============================ */
+
+extern const char WR_ERR_RANGE_MSG[];
+extern const char WR_ERR_PAGE_MSG[];
+
+/*
+ * The following two variables are statically allocated by the linker
+ * script at the the boundaries of the memory region (rounded up to
+ * multiples of PAGE_SIZE) reserved for __wr_after_init.
+ */
+extern long __start_wr_after_init;
+extern long __end_wr_after_init;
+
+static __always_inline bool __is_wr_after_init(const void *ptr, size_t size)
+{
+	size_t start = (size_t)&__start_wr_after_init;
+	size_t end = (size_t)&__end_wr_after_init;
+	size_t low = (size_t)ptr;
+	size_t high = (size_t)ptr + size;
+
+	return likely(start <= low && low < high && high <= end);
+}
+
+/**
+ * wr_memset() - sets n bytes of the destination to the c value
+ * @dst: beginning of the memory to write to
+ * @c: byte to replicate
+ * @size: amount of bytes to copy
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_memset(const void *dst, const int c, size_t n_bytes)
+{
+	size_t size;
+	unsigned long flags;
+	uintptr_t d = (uintptr_t)dst;
+
+	if (WARN(!__is_wr_after_init(dst, n_bytes), WR_ERR_RANGE_MSG))
+		return false;
+	while (n_bytes) {
+		struct page *page;
+		uintptr_t base;
+		uintptr_t offset;
+		uintptr_t offset_complement;
+
+		local_irq_save(flags);
+		page = virt_to_page(d);
+		offset = d & ~PAGE_MASK;
+		offset_complement = PAGE_SIZE - offset;
+		size = min(n_bytes, offset_complement);
+		base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
+		if (WARN(!base, WR_ERR_PAGE_MSG)) {
+			local_irq_restore(flags);
+			return false;
+		}
+		memset((void *)(base + offset), c, size);
+		vunmap((void *)base);
+		d += size;
+		n_bytes -= size;
+		local_irq_restore(flags);
+	}
+	return true;
+}
+
+/**
+ * wr_memcpy() - copyes n bytes from source to destination
+ * @dst: beginning of the memory to write to
+ * @src: beginning of the memory to read from
+ * @n_bytes: amount of bytes to copy
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_memcpy(const void *dst, const void *src, size_t n_bytes)
+{
+	size_t size;
+	unsigned long flags;
+	uintptr_t d = (uintptr_t)dst;
+	uintptr_t s = (uintptr_t)src;
+
+	if (WARN(!__is_wr_after_init(dst, n_bytes), WR_ERR_RANGE_MSG))
+		return false;
+	while (n_bytes) {
+		struct page *page;
+		uintptr_t base;
+		uintptr_t offset;
+		uintptr_t offset_complement;
+
+		local_irq_save(flags);
+		page = virt_to_page(d);
+		offset = d & ~PAGE_MASK;
+		offset_complement = PAGE_SIZE - offset;
+		size = (size_t)min(n_bytes, offset_complement);
+		base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
+		if (WARN(!base, WR_ERR_PAGE_MSG)) {
+			local_irq_restore(flags);
+			return false;
+		}
+		__write_once_size((void *)(base + offset), (void *)s, size);
+		vunmap((void *)base);
+		d += size;
+		s += size;
+		n_bytes -= size;
+		local_irq_restore(flags);
+	}
+	return true;
+}
+
+/*
+ * rcu_assign_pointer is a macro, which takes advantage of being able to
+ * take the address of the destination parameter "p", so that it can be
+ * passed to WRITE_ONCE(), which is called in one of the branches of
+ * rcu_assign_pointer() and also, being a macro, can rely on the
+ * preprocessor for taking the address of its parameter.
+ * For the sake of staying compatible with the API, also
+ * wr_rcu_assign_pointer() is a macro that accepts a pointer as parameter,
+ * instead of the address of said pointer.
+ * However it is simply a wrapper to __wr_rcu_ptr(), which receives the
+ * address of the pointer.
+ */
+static __always_inline
+uintptr_t __wr_rcu_ptr(const void *dst_p_p, const void *src_p)
+{
+	unsigned long flags;
+	struct page *page;
+	void *base;
+	uintptr_t offset;
+	const size_t size = sizeof(void *);
+
+	if (WARN(!__is_wr_after_init(dst_p_p, size), WR_ERR_RANGE_MSG))
+		return (uintptr_t)NULL;
+	local_irq_save(flags);
+	page = virt_to_page(dst_p_p);
+	offset = (uintptr_t)dst_p_p & ~PAGE_MASK;
+	base = vmap(&page, 1, VM_MAP, PAGE_KERNEL);
+	if (WARN(!base, WR_ERR_PAGE_MSG)) {
+		local_irq_restore(flags);
+		return (uintptr_t)NULL;
+	}
+	rcu_assign_pointer((*(void **)(offset + (uintptr_t)base)), src_p);
+	vunmap(base);
+	local_irq_restore(flags);
+	return (uintptr_t)src_p;
+}
+
+#define wr_rcu_assign_pointer(p, v)	__wr_rcu_ptr(&p, v)
+
+#define __wr_simple(dst_ptr, src_ptr)					\
+	wr_memcpy(dst_ptr, src_ptr, sizeof(*(src_ptr)))
+
+#define __wr_safe(dst_ptr, src_ptr,					\
+		  unique_dst_ptr, unique_src_ptr)			\
+({									\
+	typeof(dst_ptr) unique_dst_ptr = (dst_ptr);			\
+	typeof(src_ptr) unique_src_ptr = (src_ptr);			\
+									\
+	wr_memcpy(unique_dst_ptr, unique_src_ptr,			\
+		  sizeof(*(unique_src_ptr)));				\
+})
+
+#define __safe_ops(dst, src)	\
+	(__typecheck(dst, src) && __no_side_effects(dst, src))
+
+/**
+ * wr - copies an object over another of same type and size
+ * @dst_ptr: address of the destination object
+ * @src_ptr: address of the source object
+ */
+#define wr(dst_ptr, src_ptr)						\
+	__builtin_choose_expr(__safe_ops(dst_ptr, src_ptr),		\
+			      __wr_simple(dst_ptr, src_ptr),		\
+			      __wr_safe(dst_ptr, src_ptr,		\
+						__UNIQUE_ID(__dst_ptr),	\
+						__UNIQUE_ID(__src_ptr)))
+
+/**
+ * wr_ptr() - alters a pointer in write rare memory
+ * @dst: target for write
+ * @val: new value
+ *
+ * Returns true on success, false otherwise.
+ */
+static __always_inline
+bool wr_ptr(const void *dst, const void *val)
+{
+	return wr_memcpy(dst, &val, sizeof(val));
+}
+#endif
diff --git a/mm/Makefile b/mm/Makefile
index 26ef77a3883b..215c6a6d7304 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
+obj-$(CONFIG_PRMEM) += prmem.o
 obj-$(CONFIG_KSM) += ksm.o
 obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_SLAB) += slab.o
diff --git a/mm/prmem.c b/mm/prmem.c
new file mode 100644
index 000000000000..de9258f5f29a
--- /dev/null
+++ b/mm/prmem.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * prmem.c: Memory Protection Library
+ *
+ * (C) Copyright 2017-2018 Huawei Technologies Co. Ltd.
+ * Author: Igor Stoppa <igor.stoppa@huawei.com>
+ */
+
+const char WR_ERR_RANGE_MSG[] = "Write rare on invalid memory range.";
+const char WR_ERR_PAGE_MSG[] = "Failed to remap write rare page.";
-- 
2.17.1

