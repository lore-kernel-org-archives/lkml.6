Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA255C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BDE208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="GshEb5qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BDE208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeJBAmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:42:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBAmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:42:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id b7-v6so9802765pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijUdNdbgwzalLKcfY2p5LLIba6a37k6wFwoZbX38RZY=;
        b=GshEb5qYf0a3DJm1Erm6SE3myXILl5hYsKhYDizWVJqBfGqtByl/nM+U7KLYOxVnYl
         lCIUdffTPGC2rC/EF9WhcW1smqOr49cepA6aI/JtM1zSQBvJHskvV70PoMtYcNkqE99z
         rdpxFpqKoSUzrN27SE/Rnr7DwUgpliOLdBIDSlDSOuwxECaxCiZnUu1qYA6MMdv4LTtB
         uaxFSXxEJ7jpgGU59OVvXvH7FX2HxWyXwL1q1uTaAX4Pp7OAdzLzjKLq3mmbfjn1Ra7P
         TB9DxjGVJeOBbYBgepCLrtxOYSpXy+gNOh/jqNhPEnqnTjjTWE6p6d1RAQDo3jTfTLTs
         bymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijUdNdbgwzalLKcfY2p5LLIba6a37k6wFwoZbX38RZY=;
        b=FDPuIVmAgX51njNL0EUrElDeSSOLj2YCq47fix0Z0S/d5CO4oSVabx2+4Biy0qIpCs
         d32rZci+GHa6kL0eHBfw8hz6sGrDfqrBm5qcWv6Ox9XHRhjJzC1fPArfZ3wxIw/TorLs
         1PD/sBmkFSYnAYYW6SidzLIM/KpoKAnsyz75q/3xgK2/bUImZWj7/9e3B+PmZtKemG4f
         00i6UZgWKORRe9xsAvkZws7GCchcRx0K7NO3w8DxArTsHVh4CEVthrll28Huzh/VwFjV
         4o0tIIP1U2w/6sprP06xfUmARktw5jNpRp6TY8z0px0KwilOid7DnuAK2/71DpNL/9Z3
         X2mA==
X-Gm-Message-State: ABuFfoi6bAUpfEeFHWqKIugNl9zByzU9LLcrVT7dbMZNkJS73wsOzjmR
        xYHM8C6z8m1dEoKpv16mUTNU4yPaW7M=
X-Google-Smtp-Source: ACcGV625ibJ8slOq/3lsjQXMrnuiIKhRtiQufCv62/Qb4cAhiWmdzcSFVTwxy2dMEVW5PhVqfGtN+A==
X-Received: by 2002:a62:db46:: with SMTP id f67-v6mr12503273pfg.1.1538416999547;
        Mon, 01 Oct 2018 11:03:19 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:03:18 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com, Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: RESEND [PATCH v3 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
Date:   Mon,  1 Oct 2018 10:58:34 -0700
Message-Id: <20181001175845.168430-15-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

AArch32 processes are currently installed a special [vectors] page that
contains the sigreturn trampolines and the kuser helpers, at the fixed
address mandated by the kuser helpers ABI.

Having both functionalities in the same page has become problematic,
because:

* It makes it impossible to disable the kuser helpers (the sigreturn
  trampolines cannot be removed), which is possible on arm.

* A future 32-bit vDSO would provide the sigreturn trampolines itself,
  making those in [vectors] redundant.

This patch addresses the problem by moving the sigreturn trampolines to
a separate [sigpage] page, mirroring [sigpage] on arm.

Even though [vectors] has always been a misnomer on arm64/compat, as
there is no AArch32 vector there (and now only the kuser helpers),
its name has been left unchanged, for compatibility with arm (there
are reports of software relying on [vectors] being there as the last
mapping in /proc/maps).

mm->context.vdso used to point to the [vectors] page, which is
unnecessary (as its address is fixed). It now points to the [sigpage]
page (whose address is randomized like a vDSO).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel@android.com

v2:
- reduce churniness (and defer later to vDSO patches)
- vectors_page and compat_vdso_spec as array of 2
- free sigpage if vectors allocation failed

v3:
- rebase
---
 arch/arm64/include/asm/processor.h |  4 +-
 arch/arm64/include/asm/signal32.h  |  2 -
 arch/arm64/kernel/signal32.c       |  5 +-
 arch/arm64/kernel/vdso.c           | 82 ++++++++++++++++++++----------
 4 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 79657ad91397..bc6bb256ea4c 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -66,9 +66,9 @@
 
 #define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
-#define AARCH32_VECTORS_BASE	0xffff0000
+#define AARCH32_KUSER_HELPERS_BASE 0xffff0000
 #define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
-				AARCH32_VECTORS_BASE : STACK_TOP_MAX)
+				AARCH32_KUSER_HELPERS_BASE : STACK_TOP_MAX)
 #else
 #define STACK_TOP		STACK_TOP_MAX
 #endif /* CONFIG_COMPAT */
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 81abea0b7650..58e288aaf0ba 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -20,8 +20,6 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
-#define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
-
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
 int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 24b09003f821..52f0d44417c8 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -398,14 +398,13 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+		void *sigreturn_base = current->mm->context.vdso;
 		unsigned int idx = thumb << 1;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
 			idx += 3;
 
-		retcode = AARCH32_VECTORS_BASE +
-			  AARCH32_KERN_SIGRET_CODE_OFFSET +
-			  (idx << 2) + thumb;
+		retcode = ptr_to_compat(sigreturn_base) + (idx << 2) + thumb;
 	}
 
 	regs->regs[0]	= usig;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 8dd2ad220a0f..5398f6454ce1 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -1,5 +1,7 @@
 /*
- * VDSO implementation for AArch64 and vector page setup for AArch32.
+ * Additional userspace pages setup for AArch64 and AArch32.
+ *  - AArch64: vDSO pages setup, vDSO data page update.
+ *  - AArch32: sigreturn and kuser helpers pages setup.
  *
  * Copyright (C) 2012 ARM Limited
  *
@@ -53,32 +55,51 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
-static struct page *vectors_page[1] __ro_after_init;
+static struct page *vectors_page[] __ro_after_init;
+static const struct vm_special_mapping compat_vdso_spec[] = {
+	{
+		/* Must be named [sigpage] for compatibility with arm. */
+		.name	= "[sigpage]",
+		.pages	= &vectors_page[0],
+	},
+	{
+		.name	= "[kuserhelpers]",
+		.pages	= &vectors_page[1],
+	},
+};
+static struct page *vectors_page[ARRAY_SIZE(compat_vdso_spec)] __ro_after_init;
 
 static int __init alloc_vectors_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
-	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
+	size_t kuser_sz = __kuser_helper_end - __kuser_helper_start;
+	unsigned long kuser_vpage;
 
-	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
-	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
-	unsigned long vpage;
-
-	vpage = get_zeroed_page(GFP_ATOMIC);
+	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
+	size_t sigret_sz =
+		__aarch32_sigret_code_end - __aarch32_sigret_code_start;
+	unsigned long sigret_vpage;
 
-	if (!vpage)
+	sigret_vpage = get_zeroed_page(GFP_ATOMIC);
+	if (!sigret_vpage)
 		return -ENOMEM;
 
-	/* kuser helpers */
-	memcpy((void *)vpage + 0x1000 - kuser_sz, __kuser_helper_start,
-		kuser_sz);
+	kuser_vpage = get_zeroed_page(GFP_ATOMIC);
+	if (!kuser_vpage) {
+		free_page(sigret_vpage);
+		return -ENOMEM;
+	}
 
 	/* sigreturn code */
-	memcpy((void *)vpage + AARCH32_KERN_SIGRET_CODE_OFFSET,
-               __aarch32_sigret_code_start, sigret_sz);
+	memcpy((void *)sigret_vpage, __aarch32_sigret_code_start, sigret_sz);
+	flush_icache_range(sigret_vpage, sigret_vpage + PAGE_SIZE);
+	vectors_page[0] = virt_to_page(sigret_vpage);
 
-	flush_icache_range(vpage, vpage + PAGE_SIZE);
-	vectors_page[0] = virt_to_page(vpage);
+	/* kuser helpers */
+	memcpy((void *)kuser_vpage + 0x1000 - kuser_sz, __kuser_helper_start,
+		kuser_sz);
+	flush_icache_range(kuser_vpage, kuser_vpage + PAGE_SIZE);
+	vectors_page[1] = virt_to_page(kuser_vpage);
 
 	return 0;
 }
@@ -87,23 +108,32 @@ arch_initcall(alloc_vectors_page);
 int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long addr = AARCH32_VECTORS_BASE;
-	static const struct vm_special_mapping spec = {
-		.name	= "[vectors]",
-		.pages	= vectors_page,
-
-	};
+	unsigned long addr;
 	void *ret;
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
-	current->mm->context.vdso = (void *)addr;
+	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = ERR_PTR(addr);
+		goto out;
+	}
 
-	/* Map vectors page at the high address. */
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
-				       &spec);
+				       VM_READ|VM_EXEC|
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       &compat_vdso_spec[0]);
+	if (IS_ERR(ret))
+		goto out;
 
+	current->mm->context.vdso = (void *)addr;
+
+	/* Map the kuser helpers at the ABI-defined high address. */
+	ret = _install_special_mapping(mm, AARCH32_KUSER_HELPERS_BASE,
+				       PAGE_SIZE,
+				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
+				       &compat_vdso_spec[1]);
+out:
 	up_write(&mm->mmap_sem);
 
 	return PTR_ERR_OR_ZERO(ret);
-- 
2.19.0.605.g01d371f741-goog

