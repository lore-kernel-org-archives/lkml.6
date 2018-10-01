Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CD8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3642089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="bj/+0aZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3642089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJBAmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:42:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39931 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJBAmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:42:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so9805329pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hKeDyS7++2kPLhT6ee9TedPtguPWVHoNSg0EUEDYTo=;
        b=bj/+0aZQis38X7vMaKa1q1epw4H/mDhp+7DZ/2LLBaVPV7GMTS3288hT2MQafC3pFN
         FezI7BNXxmEGJshC99GRPvb65H6oIqcv0/ur/3Hx9rqfX01ogQlaiyKKNPr3rmfSybOv
         mW7oTId3mLTbQBTeG8N1ixPn6m5B6G2uC72/M4KHFqbBdjSrd8+Y7aIrbfXf9B/1kRN6
         +RQewISC9nEJETMCmo7wCw07JaEWJDFK8U5jp17tERv5LtGkpENuDDA9qlomjT3D6rhN
         pHbQ8AN4ApJCEpPVh7lpsQ+bK/4dtdzy3XmfXoUMLhcMtAUfF69bSHXz0v5HfEMqNM+C
         4EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hKeDyS7++2kPLhT6ee9TedPtguPWVHoNSg0EUEDYTo=;
        b=j65UREF6KptMMrFV6irBoTSCQDUmhJ6ckgGN5NPYjZGEZPcAkxqitANzP5Z4M+bUqv
         DChpkPiv76KiyEg4XJCVxRM3xFFzSjS7niGS0oR543VPAoQvEcV5P9xwudRDQ4+xZ4NU
         ard+O9C7m4Cpipai/oyLY5kym19W98vdfDK1XdL+3F2YjMYTkEqJfM4M28qGhHf5j/uf
         ADbpKkwxWNm8A1wUDvum0oHkpgk9HIZUGnpOI5TSUxay7MNOSEC1BTYlo2VHjmV9C0wz
         FFZ9C7WnqJcNHux49hkHA2ftdBa+BA0rjhOuKGuCnn2D3j2WZ8AER0sP8aBL4gWRIFxL
         D9dA==
X-Gm-Message-State: ABuFfoj5JcIfmWrTpa6nQCZsMR0yBwfeUfIfys6pGxaJYJ4qoB+sahVJ
        vBlBgh7WzoKUVJamgNjriY1bWV0RoPc=
X-Google-Smtp-Source: ACcGV63B/pJSvdD06HWIEEXmyh6QACgBQh+CzoBPwnCYSUPwaaYfNq8ul0BbibGqdUx5UrxoX7A0jA==
X-Received: by 2002:a63:1d62:: with SMTP id d34-v6mr1925726pgm.180.1538417032183;
        Mon, 01 Oct 2018 11:03:52 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:03:51 -0700 (PDT)
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
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>
Subject: RESEND [PATCH] arm64: compat: Expose offset to registers in sigframes
Date:   Mon,  1 Oct 2018 10:58:37 -0700
Message-Id: <20181001175845.168430-18-salyzyn@android.com>
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

This will be needed to provide unwinding information in compat
sigreturn trampolines, part of the future compat vDSO. There is no
obvious header the compat_sig* struct's should be moved to, so let's
put them in signal32.h.

Also fix minor style issues reported by checkpatch.

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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel@android.com

NB:
Basically unchanged as part of a vDSO32 effort through 4 revisions,
Resubmitted as a standalone change for quicker approval.
---
 arch/arm64/include/asm/signal32.h | 46 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c   | 13 +++++++++
 arch/arm64/kernel/signal32.c      | 46 -------------------------------
 3 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 58e288aaf0ba..bcd0e139ee4a 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -20,6 +20,52 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
+struct compat_sigcontext {
+	/* We always set these two fields to 0 */
+	compat_ulong_t			trap_no;
+	compat_ulong_t			error_code;
+
+	compat_ulong_t			oldmask;
+	compat_ulong_t			arm_r0;
+	compat_ulong_t			arm_r1;
+	compat_ulong_t			arm_r2;
+	compat_ulong_t			arm_r3;
+	compat_ulong_t			arm_r4;
+	compat_ulong_t			arm_r5;
+	compat_ulong_t			arm_r6;
+	compat_ulong_t			arm_r7;
+	compat_ulong_t			arm_r8;
+	compat_ulong_t			arm_r9;
+	compat_ulong_t			arm_r10;
+	compat_ulong_t			arm_fp;
+	compat_ulong_t			arm_ip;
+	compat_ulong_t			arm_sp;
+	compat_ulong_t			arm_lr;
+	compat_ulong_t			arm_pc;
+	compat_ulong_t			arm_cpsr;
+	compat_ulong_t			fault_address;
+};
+
+struct compat_ucontext {
+	compat_ulong_t			uc_flags;
+	compat_uptr_t			uc_link;
+	compat_stack_t			uc_stack;
+	struct compat_sigcontext	uc_mcontext;
+	compat_sigset_t			uc_sigmask;
+	int __unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
+	compat_ulong_t			uc_regspace[128] __aligned(8);
+};
+
+struct compat_sigframe {
+	struct compat_ucontext		uc;
+	compat_ulong_t			retcode[2];
+};
+
+struct compat_rt_sigframe {
+	struct compat_siginfo		info;
+	struct compat_sigframe		sig;
+};
+
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
 int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8938a4223690..a79507c5d845 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -29,6 +29,7 @@
 #include <asm/fixmap.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
+#include <asm/signal32.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/vdso_datapage.h>
@@ -81,6 +82,18 @@ int main(void)
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
+#ifdef CONFIG_COMPAT
+  DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,
+				offsetof(struct compat_sigframe, uc) +
+				offsetof(struct compat_ucontext, uc_mcontext) +
+				offsetof(struct compat_sigcontext, arm_r0));
+  DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,
+				offsetof(struct compat_rt_sigframe, sig) +
+				offsetof(struct compat_sigframe, uc) +
+				offsetof(struct compat_ucontext, uc_mcontext) +
+				offsetof(struct compat_sigcontext, arm_r0));
+  BLANK();
+#endif
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
   BLANK();
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 52f0d44417c8..6b421666b5b8 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -30,42 +30,6 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
-struct compat_sigcontext {
-	/* We always set these two fields to 0 */
-	compat_ulong_t			trap_no;
-	compat_ulong_t			error_code;
-
-	compat_ulong_t			oldmask;
-	compat_ulong_t			arm_r0;
-	compat_ulong_t			arm_r1;
-	compat_ulong_t			arm_r2;
-	compat_ulong_t			arm_r3;
-	compat_ulong_t			arm_r4;
-	compat_ulong_t			arm_r5;
-	compat_ulong_t			arm_r6;
-	compat_ulong_t			arm_r7;
-	compat_ulong_t			arm_r8;
-	compat_ulong_t			arm_r9;
-	compat_ulong_t			arm_r10;
-	compat_ulong_t			arm_fp;
-	compat_ulong_t			arm_ip;
-	compat_ulong_t			arm_sp;
-	compat_ulong_t			arm_lr;
-	compat_ulong_t			arm_pc;
-	compat_ulong_t			arm_cpsr;
-	compat_ulong_t			fault_address;
-};
-
-struct compat_ucontext {
-	compat_ulong_t			uc_flags;
-	compat_uptr_t			uc_link;
-	compat_stack_t			uc_stack;
-	struct compat_sigcontext	uc_mcontext;
-	compat_sigset_t			uc_sigmask;
-	int		__unused[32 - (sizeof (compat_sigset_t) / sizeof (int))];
-	compat_ulong_t	uc_regspace[128] __attribute__((__aligned__(8)));
-};
-
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
 	compat_ulong_t	size;
@@ -92,16 +56,6 @@ struct compat_aux_sigframe {
 	unsigned long			end_magic;
 } __attribute__((__aligned__(8)));
 
-struct compat_sigframe {
-	struct compat_ucontext	uc;
-	compat_ulong_t		retcode[2];
-};
-
-struct compat_rt_sigframe {
-	struct compat_siginfo info;
-	struct compat_sigframe sig;
-};
-
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
-- 
2.19.0.605.g01d371f741-goog

