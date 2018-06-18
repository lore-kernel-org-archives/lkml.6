Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E0CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8921208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="J5TALy07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8921208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935782AbeFRPJj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:09:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40400 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935310AbeFRPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:09:35 -0400
Received: by mail-pg0-f65.google.com with SMTP id w8-v6so4638290pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YE/jYytYSn2pNCWpT5sfab90T2GfMqcfvGW9tA9CHqQ=;
        b=J5TALy07TugtJU2uwHPqDZXcyPMmH30arYlCEzbQaLkx7A183Z6wWC93qpMJkNjpGE
         m896OL+TPnKLNfzDFvKCVXIygzt/t3f9++G6yzgLul8JHzp0UbhmcNtDYRgplYuShk4V
         WSzI7Nj3rTrhBJac0d4FP6hh9is2jxt0B37Hlt0FsL3AqYZf758nWEyU8n9Oe3cVsnOP
         0KTmvoIRPSe7F3aw0DbYQLYlk1o7xNeW5JftcyQbqKdDczVbt1Bk5MWl3pS77CmJPsqk
         VYpiJZ1T6noiWqH+TZLnww2oGdy5IFPL+LXa0EV03HjT6g3LlSbuZWaHnuC6gFfz4G8c
         R//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YE/jYytYSn2pNCWpT5sfab90T2GfMqcfvGW9tA9CHqQ=;
        b=VmqoQ2u1srN2lWs4OkU+/uQqU3PUmoQos52srcv+c8AuWLJhhqXdBf3R+ATRBEDZDU
         EZssHHGv41sZZzT3kmPabB65heBwZGrO6IaEqEHD72NRKxpVwo5ZI5CmsR8xdRgqSlz/
         Ix350tb1uzhD3SoiBcqnYBzfYm2kSXIUcOeqSVdGmG7rRSIGfVgeEw96C3CinuE8oAyw
         HCKBT87ov+Rw2p+PtucxTaWBpmH7CL5K/h5X+8lH0TsT53LfX1iloScm1M5INPFqXsU2
         byvjB1+/Ph+xTXNBDkLGqoLJ4YTPg2weM1v+NkR4O3syfz6E10nTGB2fIlf1+pqfXDkC
         RxjA==
X-Gm-Message-State: APt69E2Kz8piAw7eRYUVvBxAP9w0E95V2zydt1KM/jalBiesZ3VSSvG7
        N9qR4TZDNqKxzTLfw8kt3hMgPvUoHCw=
X-Google-Smtp-Source: ADUXVKKb1QsMLUqlPIpGPKPK9LkNVzH0M+v4xSlVoHfVjFTeLU7nH3gHc9Rhr0CNNhnW4eIV2WnQpg==
X-Received: by 2002:a62:aa18:: with SMTP id e24-v6mr13893392pff.72.1529334575044;
        Mon, 18 Jun 2018 08:09:35 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:09:34 -0700 (PDT)
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
        Marc Zyngier <marc.zyngier@arm.com>
Subject: RESEND [PATCH] arm64: compat: Expose offset to registers in sigframes
Date:   Mon, 18 Jun 2018 08:06:03 -0700
Message-Id: <20180618150613.10322-18-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618150613.10322-1-salyzyn@android.com>
References: <20180618150613.10322-1-salyzyn@android.com>
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

NB:
Basically unchanged as part of a vDSO32 effort through 4 revisions,
Resubmitted as a standalone change for quciker approval.
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
index 9c018878056b..096c88731c56 100644
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
2.18.0.rc1.244.gcf134e6275-goog

