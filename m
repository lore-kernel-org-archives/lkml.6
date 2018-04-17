Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48epA92mCTPPnZ3OglWQ42D/zUmuWFlqUwwSpaV8eT9S92XHmt8T4p8lhr+udOtS0YWquFR
ARC-Seal: i=1; a=rsa-sha256; t=1523981291; cv=none;
        d=google.com; s=arc-20160816;
        b=0tkBpYSFo70F8Li5YWQoH9pYv+HGmcBiBvG2F112fZumf8rEmTh++YjklrZgx7v4pb
         9hKAXo/hzvJ/A4AUt56erymv1JU2A35f8KjGX2eWq7dBpwCe4OMoO+ULvmNa3bK5AjHT
         rVZNlRInve1sZkEO4MznzlHq5Mp3zkYvhf9paHwEUtF7/2WmLLl1ertzLuzSWGS0TCG6
         hvei8H/Csnss9I0NSvwYZW9lPLLwNvr/rMrhVhqRAXEAl59dzKu1ngdkwudyZufd+COu
         UIulA4FfLZFTQB6xj84DGrd2HIGGfWaUs1n492KiHf7QY0HKQ5eecpfsfn12U82J3HGU
         GYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=to+N4Z+WMTgT9w2enqD8ruaYYFPJou3dxX4Z7iDh56Y=;
        b=vfxOV42zuxq8pHQcKNqutXfsLJrgRw7qDJO9xZGL7k8GNU5rq53DugupyxtWeRBI5f
         c+KyJrEZD7DzFo36QxR1ucuieXfNL7mbp3jb7FBr11ueBxiJzkJ/xWtVuXb4HNSNmcCz
         mH0k7tU2YXUVKVHfiZYJnRlk50XK26cA0kNkYZF06wp4qxuty/J4KWsNr6OKWjPQ+/a1
         hOmPGIq6B+i9vMMSVF3WxPuw6FpROYll/haFMJEvIMwV6NQhWnbd+AerzR6gPsimgnt8
         yZdBZ4TcIwdrmU1rL52G7n3PvWWYRn7mLr0hxFTobOB1iQHx3BumcsH+CrrkcaElDngQ
         YX3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 12/66] arm64: move TASK_* definitions to <asm/processor.h>
Date: Tue, 17 Apr 2018 17:58:45 +0200
Message-Id: <20180417155646.373034049@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010207134440576?=
X-GMAIL-MSGID: =?utf-8?q?1598010207134440576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Yury Norov <ynorov@caviumnetworks.com>

commit eef94a3d09aab437c8c254de942d8b1aa76455e2 upstream.

ILP32 series [1] introduces the dependency on <asm/is_compat.h> for
TASK_SIZE macro. Which in turn requires <asm/thread_info.h>, and
<asm/thread_info.h> include <asm/memory.h>, giving a circular dependency,
because TASK_SIZE is currently located in <asm/memory.h>.

In other architectures, TASK_SIZE is defined in <asm/processor.h>, and
moving TASK_SIZE there fixes the problem.

Discussion: https://patchwork.kernel.org/patch/9929107/

[1] https://github.com/norov/linux/tree/ilp32-next

CC: Will Deacon <will.deacon@arm.com>
CC: Laura Abbott <labbott@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[v4.9: necessary for making USER_DS an inclusive limit]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/memory.h    |   15 ---------------
 arch/arm64/include/asm/processor.h |   21 +++++++++++++++++++++
 arch/arm64/kernel/entry.S          |    1 +
 3 files changed, 22 insertions(+), 15 deletions(-)

--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -60,8 +60,6 @@
  * KIMAGE_VADDR - the virtual address of the start of the kernel image
  * VA_BITS - the maximum number of bits for virtual addresses.
  * VA_START - the first kernel virtual address.
- * TASK_SIZE - the maximum size of a user space task.
- * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
 #define VA_START		(UL(0xffffffffffffffff) - \
@@ -76,19 +74,6 @@
 #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
-#define TASK_SIZE_64		(UL(1) << VA_BITS)
-
-#ifdef CONFIG_COMPAT
-#define TASK_SIZE_32		UL(0x100000000)
-#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
-				TASK_SIZE_32 : TASK_SIZE_64)
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
-				TASK_SIZE_32 : TASK_SIZE_64)
-#else
-#define TASK_SIZE		TASK_SIZE_64
-#endif /* CONFIG_COMPAT */
-
-#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
 
 #define KERNEL_START      _text
 #define KERNEL_END        _end
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -19,6 +19,10 @@
 #ifndef __ASM_PROCESSOR_H
 #define __ASM_PROCESSOR_H
 
+#define TASK_SIZE_64		(UL(1) << VA_BITS)
+
+#ifndef __ASSEMBLY__
+
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
@@ -37,6 +41,22 @@
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
+/*
+ * TASK_SIZE - the maximum size of a user space task.
+ * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
+ */
+#ifdef CONFIG_COMPAT
+#define TASK_SIZE_32		UL(0x100000000)
+#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
+				TASK_SIZE_32 : TASK_SIZE_64)
+#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
+				TASK_SIZE_32 : TASK_SIZE_64)
+#else
+#define TASK_SIZE		TASK_SIZE_64
+#endif /* CONFIG_COMPAT */
+
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
+
 #define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
@@ -192,4 +212,5 @@ int cpu_enable_pan(void *__unused);
 int cpu_enable_uao(void *__unused);
 int cpu_enable_cache_maint_trap(void *__unused);
 
+#endif /* __ASSEMBLY__ */
 #endif /* __ASM_PROCESSOR_H */
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -30,6 +30,7 @@
 #include <asm/irq.h>
 #include <asm/memory.h>
 #include <asm/mmu.h>
+#include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
