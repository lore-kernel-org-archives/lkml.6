Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7223C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E332089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="KSUBKvLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E332089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeJBAnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:43:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35734 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeJBAnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:43:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so9814732pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiIGQCmGtALrXwsBG8zSqpjHC9E+lsH1ZMYz/Tcb/9o=;
        b=KSUBKvLxsj68k0Si0J4ZR79pL0sEeAxw19tZFkj8bmO8cwrgukdO7fSTH0Trjfamzu
         nzdqvr78u9mIb+cE4sexVRirTM1ono+O/YnveR57mLO6kDMF1pKH8kDl+M8z8R7kMc9N
         3+YEBCTxd19rMX0rMJygiJcoFysYtHoWDx+YYQR7k+agXXNxPhb2/IvLIoA6oWnxx7LN
         hbXAoKA0T9DbY9sCKOfU7gqDaM097KeBKMspLn7pjde8AA6ZIb6svxzG/YPSJCAAcYxy
         BYSi/7sZSoniP5oJr2VSSnCNBGE+UNrQt51mv9s4fa4xHStZ/TmvEC2xVWSP7z9p2tay
         DXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiIGQCmGtALrXwsBG8zSqpjHC9E+lsH1ZMYz/Tcb/9o=;
        b=XjeYDGbAgahH0JqNVVFaXtjKYBrqavJ946wI+wOvZ92PeP1nGoKUXgxx/aHY8go44Q
         cDfNauIItmPOpBA9Guvn6gEpFCsNZQBN+wPVAjQen8CabQqPbeG97ehKeftOYrmG5Qfo
         NkwblT38rTub0D3ZncNZ3CWn8Ij4VzMwu3y0TX9siwGFYltZROXkTSZivCSTZDM+CSCf
         V4r8WdzP4ae5z3MrowNqSvXmVV92Y8Vj9tHtoizAKtQ9q/E5jJvUhi/KD4ZUx9cNf5fl
         bLOiWOGdlFYMDoMYYzuTiauTmGgmVkrLjYuh0w0FMsOsQ0bFwWdHJMHDKeSuL0Yu/sEu
         xRpQ==
X-Gm-Message-State: ABuFfohfa2GcBCdDM5+WtxrbY2MgPeRZyvZaJEUFR/klDwiB1u40UAmM
        h8M6UR1jwHsHUxFbtTYSmcbR1pqE8Sg=
X-Google-Smtp-Source: ACcGV61FylkwMpjFO9AFBbrygEHvfEKfXQfB/69kZ7FS9w7P3QWvHl9+wmuaFO+I6LLkZLsepvY5vw==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr12949742plp.18.1538417041389;
        Mon, 01 Oct 2018 11:04:01 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:04:00 -0700 (PDT)
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
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: RESEND [PATCH 1/6] arm64: compat: Use vDSO sigreturn trampolines if available
Date:   Mon,  1 Oct 2018 10:58:38 -0700
Message-Id: <20181001175845.168430-19-salyzyn@android.com>
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

If the compat vDSO is enabled, it replaces the sigreturn page.
Therefore, we use the sigreturn trampolines the vDSO provides instead.

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
---
 arch/arm64/include/asm/vdso.h |  3 +++
 arch/arm64/kernel/signal32.c  | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 839ce0031bd5..f2a952338f1e 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -28,6 +28,9 @@
 #ifndef __ASSEMBLY__
 
 #include <generated/vdso-offsets.h>
+#ifdef CONFIG_VDSO32
+#include <generated/vdso32-offsets.h>
+#endif
 
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 6b421666b5b8..c3d9a74e3945 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -29,6 +29,7 @@
 #include <asm/traps.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/vdso.h>
 
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
@@ -352,6 +353,19 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+#ifdef CONFIG_VDSO32
+		void *vdso_base = current->mm->context.vdso;
+		void *trampoline =
+			(ka->sa.sa_flags & SA_SIGINFO
+			 ? (thumb
+			    ? VDSO_SYMBOL(vdso_base, compat_rt_sigreturn_thumb)
+			    : VDSO_SYMBOL(vdso_base, compat_rt_sigreturn_arm))
+			 : (thumb
+			    ? VDSO_SYMBOL(vdso_base, compat_sigreturn_thumb)
+			    : VDSO_SYMBOL(vdso_base, compat_sigreturn_arm)));
+
+		retcode = ptr_to_compat(trampoline) + thumb;
+#else
 		void *sigreturn_base = current->mm->context.vdso;
 		unsigned int idx = thumb << 1;
 
@@ -359,6 +373,7 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 			idx += 3;
 
 		retcode = ptr_to_compat(sigreturn_base) + (idx << 2) + thumb;
+#endif
 	}
 
 	regs->regs[0]	= usig;
-- 
2.19.0.605.g01d371f741-goog

