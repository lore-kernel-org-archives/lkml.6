Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8337C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBF920852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="GkoudDNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBF920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935726AbeFRPJM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:09:12 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44928 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935277AbeFRPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:09:10 -0400
Received: by mail-pg0-f65.google.com with SMTP id p21-v6so7658059pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eTeIZTmYmYKvPLcDCJbZH3+ttUckw44y8vuGBqs85dw=;
        b=GkoudDNXtaMteyMf3t0NUNx/d3fwP6wdqPLL3BYEnmBLVwpO+B5iws4KdZ2lMVOvhW
         uyegxA4cDTsX6IbSscFAuYvnzDpWDWze7DTQRhSrAIzm5f85nnvWo8C4OCEoDbTDplOc
         np1X7rBHw2/kfiDA7SgieAH7ZFfUsQX6MciC59HvODRSh3BSFyGGPeLZjJI/k68IDs7w
         8+L/WTngH3TdhSQixu1xarn/Ll+lKzmYt67AHxAyRcI4RCcO2E3eXFuJFStllqEsVmFT
         Ns85KQ/qmwrb5OCayADBvmuwnGZMiobTU6R8V8jwGQ04kZDdMVDy4/1fxcqqIcjyoGnr
         hHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eTeIZTmYmYKvPLcDCJbZH3+ttUckw44y8vuGBqs85dw=;
        b=cpCHci+5NOGzwxjo1XJU6Ls6b5gvseQRwA8UWekFmU1D80Ft7W9zw49kwRepJJFGQa
         pRdG1cLxQeTmMWyD+LblyXk/iH8LoWqAGhgF28UhRvDhh7l0Ion3mbHEAlWikNzd/j0H
         MZPDgo+1pgVcRuiZVLMjNfaluCJH4mZdkaxQHLxbwBSb70UxyK9b78eLlllQJFrbSB7t
         bV3GL2bhiJNEhYssKEzmfuHKedr2RUTBUQ5dIBOcoyRc/aJ4jgmo8x0eQWZmkkCp6gYY
         F6x3AVkR5W4TDvie+BWHrSmX98uL8GQ+rpcsFyLT4Eq4aXaVSA1nh48dnFWf9ALtpkpx
         9xbA==
X-Gm-Message-State: APt69E3E+8EhZojkbK7JCSeqyDizmrAJaHbzbnyEjIMeiiToprHK6MHf
        URqONYMe1s08HM/v2PpOGck1Qyr8gTc=
X-Google-Smtp-Source: ADUXVKLLgU2MiXdvHgYu/XP/EX1XfRIFQ6iL08cIj09eRUdJw1badsECxwQHpiykLspCylkgJgLyFw==
X-Received: by 2002:a63:ba56:: with SMTP id l22-v6mr11404076pgu.161.1529334549370;
        Mon, 18 Jun 2018 08:09:09 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:09:08 -0700 (PDT)
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
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: RESEND [PATCH v2 1/3] arm64: compat: Split the sigreturn trampolines and kuser helpers (C sources)
Date:   Mon, 18 Jun 2018 08:06:00 -0700
Message-Id: <20180618150613.10322-15-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618150613.10322-1-salyzyn@android.com>
References: <20180618150613.10322-1-salyzyn@android.com>
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
index a73ae1e49200..3bcb897cb972 100644
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
index 77b91f478995..9c018878056b 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -393,14 +393,13 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
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
2.18.0.rc1.244.gcf134e6275-goog

