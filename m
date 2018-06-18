Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EADC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B41208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ucIjn0++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B41208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935752AbeFRPLG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:11:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33198 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935443AbeFRPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:09:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so8329958pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j63H2XWAfgc4+hZRNrwJ9sRmE0jBwvbE9xZcldKpKjY=;
        b=ucIjn0++CH4OhaJHuDa+OZmC0pCQ06dC+GAEZUn44AVJf0BAQ4xX5W9+Z5Nk4PPcKr
         2q7g6DV+CThuuuVAcBtFP9OfiGZepMrfMRVDTOwx1l8QVNjks6Oji4VNlPrLN+HabGtT
         JQJFdigpH8CG9JkDKHG2mLbd270KF6mqtnUh7PBly1jE75WxxUVO6qZe6ab9SyqrQUzY
         Vww9J0R+IsauWXMT5rzL7WInwAF4nq6q3RU5eUxE8bjORlF6FrkJTNxzIM5LiJnjIeDY
         ik/BoYzZfOzmDGk8PMYuV7TMXtOBM3nMhpS9Xqv0owxr3OfObVbAyfpeibPeOp6W/NKM
         epFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j63H2XWAfgc4+hZRNrwJ9sRmE0jBwvbE9xZcldKpKjY=;
        b=o5DX6BNp0F/5+jmYG+SojmqRBfZ7P188txlIgEDBlhgRCrk4DfICKv6AqP+QXE+el7
         +9RMV6b02RInmAGRvSf9cKRLSIwCIVHK2alghCLaJJfiIMD3KlM/1FDzt5T7XwZL3nCk
         NKLON/tMIfergpjGPMdmMK3csa1/yW+9oRLySAqLMnzbxN8QI6mYRGfB0F9tcK7O/hFN
         MUGYyYYADLfNChM+SDg5jtGUQWlBOqDIpaEKajsgaMyaPmTBmJdmkGpS0upXR8hBRxGK
         fx84wSx8H8lyphcbfc/TxdTnw3PwJUqbPuZeurmswzJ89nYzZzy9ygu9Mh3OAetMOxVY
         BuCA==
X-Gm-Message-State: APt69E1ySdT8m2UmjSdgwHaWoDQP3zmnNPdSX4A5mfZR0JDn5VX/2X5p
        x5V8bwLG3GbHa2EZqnHr3+N5Sj3+ick=
X-Google-Smtp-Source: ADUXVKJYlc0eu5sZ/nHjwg49lDyx8cQpAQfJGnjHKg1f8SFuos2UKntDa/IDY8mdYqypxbPJii59iA==
X-Received: by 2002:a63:a05d:: with SMTP id u29-v6mr11230935pgn.80.1529334585815;
        Mon, 18 Jun 2018 08:09:45 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:09:45 -0700 (PDT)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: RESEND [PATCH 2/6] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
Date:   Mon, 18 Jun 2018 08:06:05 -0700
Message-Id: <20180618150613.10322-20-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618150613.10322-1-salyzyn@android.com>
References: <20180618150613.10322-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

If the compat vDSO is enabled, we need to set AT_SYSINFO_EHDR in the
auxiliary vector of compat processes to the address of the vDSO code
page, so that the dynamic linker can find it (just like the regular vDSO).

Note that we cast context.vdso to Elf64_Off, instead of elf_addr_t,
because elf_addr_t is Elf32_Off in compat_binfmt_elf.c, and casting
context.vdso to u32 would trigger a pointer narrowing warning.

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
---
 arch/arm64/include/asm/elf.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 433b9554c6a1..bf4672a0491b 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -147,10 +147,10 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 })
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO							\
+#define _SET_AUX_ENT_VDSO						\
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
-		    (elf_addr_t)current->mm->context.vdso);		\
+		    (Elf64_Off)current->mm->context.vdso);		\
 									\
 	/*								\
 	 * Should always be nonzero unless there's a kernel bug.	\
@@ -162,6 +162,7 @@ do {									\
 	else								\
 		NEW_AUX_ENT(AT_IGNORE, 0);				\
 } while (0)
+#define ARCH_DLINFO _SET_AUX_ENT_VDSO
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
@@ -209,7 +210,11 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 ({									\
 	set_thread_flag(TIF_32BIT);					\
  })
+#ifdef CONFIG_VDSO32
+#define COMPAT_ARCH_DLINFO	_SET_AUX_ENT_VDSO
+#else
 #define COMPAT_ARCH_DLINFO
+#endif
 extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 				      int uses_interp);
 #define compat_arch_setup_additional_pages \
-- 
2.18.0.rc1.244.gcf134e6275-goog

