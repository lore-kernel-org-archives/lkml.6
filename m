Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226HLZQDY7ucvIhgnWmzjjZjXhkDc6JvFkeCLVY7KxqJNP4zPYmvflxMkQogQDMWZ4myJYIf
ARC-Seal: i=1; a=rsa-sha256; t=1518708627; cv=none;
        d=google.com; s=arc-20160816;
        b=WvxIkNpL0M6xECmia46X3OCF9GNdKiyfD6vzPuf03xI6vIxfBHWLOdBdBiG+FK/9qM
         5RUlOIkg/Y9fggiepT3xAUkaLAGOWn9q+uEX+Ztp32XtFvKf2uptVAQRUodLtgbCsT04
         WM7M9GSb++1OIXkTAKXNetGMKpw7baoumMISxKzoUaPN8CW6bKJwcdeeNYYt+3cefoGi
         yXVink6ck79KqcwPCYClk1NHY8et8zN/t0lrJ41E7Q4ET37lqH23JfXoK/JpZYXiOAET
         T0QbKKMpi9S1Venc0x281tb5LF8Xx+F8qMldb/kZLy0NaKRQThh1MbUhibN+XR8ETw7z
         Bz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fo8oTYBm9RvshqtZw0BhIVvFqLlYOEa+mwgfHXrc1pQ=;
        b=CgC/MVlWElj82Q+OQ0L6zWLUsqFaMmLy+Kwp7ycndEKy5mI5JWsH2zuhQt8IxDQ321
         x7EoU8ximzQZKymG8XoUJQpbSATMlQqiiKq/2apXgAOZu1t7/4g3QRsQMgulg9SSANLi
         cuh4alJgs35NJdrolyYeF5vsKd1gWEs0di3TNzScRpVtJ8C9zMNgpUF0d6g0Sj8Tjdu2
         dRuQwOxpN3GPMcl+JHqJILtKZgnQ5VXGwcAgCYF3emSlAUoeHuts77fSjL4pgCqjAoOZ
         kaCMSEa31ROtcvmSvAVDEvz/NiaMmTpXDFbP09IdjAy1H5G4mN5Xhsj6sU+owZ6HESdp
         fQLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 4.14 022/195] arm64: move TASK_* definitions to <asm/processor.h>
Date: Thu, 15 Feb 2018 16:15:13 +0100
Message-Id: <20180215151706.863934153@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481417775775971?=
X-GMAIL-MSGID: =?utf-8?q?1592481417775775971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yury Norov <ynorov@caviumnetworks.com>


Commit eef94a3d09aa upstream.

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
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/memory.h    |   15 ---------------
 arch/arm64/include/asm/processor.h |   21 +++++++++++++++++++++
 arch/arm64/kernel/entry.S          |    2 +-
 3 files changed, 22 insertions(+), 16 deletions(-)

--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -61,8 +61,6 @@
  * KIMAGE_VADDR - the virtual address of the start of the kernel image
  * VA_BITS - the maximum number of bits for virtual addresses.
  * VA_START - the first kernel virtual address.
- * TASK_SIZE - the maximum size of a user space task.
- * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
 #define VA_START		(UL(0xffffffffffffffff) - \
@@ -77,19 +75,6 @@
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
@@ -194,4 +214,5 @@ static inline void spin_lock_prefetch(co
 int cpu_enable_pan(void *__unused);
 int cpu_enable_cache_maint_trap(void *__unused);
 
+#endif /* __ASSEMBLY__ */
 #endif /* __ASM_PROCESSOR_H */
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -28,7 +28,7 @@
 #include <asm/errno.h>
 #include <asm/esr.h>
 #include <asm/irq.h>
-#include <asm/memory.h>
+#include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 #include <asm/asm-uaccess.h>
