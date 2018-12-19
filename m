Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63297C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1785521871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545218438;
	bh=nggMUv7v4jBGYB/FJ1VXxNhtNzfG77K9iXvPXoXHGNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mD72ITcFa+slFsrKXFIzKLaw1NSnWbUePjlTOih2YCGFG2XQfj89bl0tJSGeHBGck
	 dTs4AyOoIpVoHUslJPPQzUMxIGnv2jdLjpojhZSGXqJ6ennvWlmnEzw0AEMwK6b/Yb
	 1infqZIjNb9n/u7HhrSymiFfRv89WpbJbgiQkTZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeLSLUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:20:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39438 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeLSLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:20:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so19111279wra.6;
        Wed, 19 Dec 2018 03:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qzRDyJoDOTma597x2MZ7+yRPZMyKKu7YO8LIRpUFIls=;
        b=kPvGq5FDYfq/wnWALdG3Xxrs841VQkA65NdvVRRMDz29tYztvvqP0SUnXja7izMvjo
         YyaKfIX/SVyhhdxj7iDubac8bPkMdaB5zfbI+AlUl97NHCc7bnxjysrcXNHfjwrGcn54
         vbPrcLdoyIQmkJd8PiefSsLRVwkYDwZsmxJNTvRd1pEtVIDdpXsjhvf3vmNMkPHo2FHo
         YgHjLYj3himQf0dx2IKxRuUQBMWXAGeA4FBqDatE4N9sezcJwNyfq/PiICqc4ESlhaPl
         jryfNNk3nb2MqjxfVXZNz5YJE7w2vkHMKsz7Ey6X7REkNDXtWSaFn+dViEsEjZhI4dNK
         WSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qzRDyJoDOTma597x2MZ7+yRPZMyKKu7YO8LIRpUFIls=;
        b=q57gMbtzcpE/iAQs1BzCkrKuz0B6ADnBQah8qJvWPnSfGI8KF7TiVQ7Xtfh5n/UCYm
         yLFfuFCy/2ek7XvErxPKYLCOkxLtyJdD9jhhQU6dqt9+WCRLA/4lXv5iQ1lPH+jT8AWM
         eH9fIGrguatzHuYuT5toYDBkqcri5YyJntm0NKUmSTH/UkEMmxiQkp+lOiIOHL43MHfB
         Zpdjs7xylCXLnDpno8ia8lzXlgtHJuLO4t70UaGhvkN7PfS+6UdJ2bcPTmM3PUNVXiSh
         FBRCf+fcBLlOjYYob3AJsqFKwF375gxVHmcnaEJw5PH4OSk+keq4O11vEc5aH91Ilf79
         6j8g==
X-Gm-Message-State: AA+aEWbyESBpeZub1r2Y0uqx0tOgBMg8058w50v65Srh/txSKhnmExMf
        OLJBnmsbp5ig3Q9XNHgKsLY=
X-Google-Smtp-Source: AFSGD/XOXyHJhMkDXm6z6RSt+laLMMROGBXnA7Gpbz1VSVpSRCp4veJ6GFhHN56+P00M9Q116mm5Wg==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr19854124wrw.50.1545218432704;
        Wed, 19 Dec 2018 03:20:32 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j202sm13789844wmf.15.2018.12.19.03.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 03:20:31 -0800 (PST)
Date:   Wed, 19 Dec 2018 12:20:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Richard Biener <rguenther@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        virtualization@lists.linux-foundation.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Alok Kataria <akataria@vmware.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, linux-arch@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-sparse@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kbuild@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jan Beulich <JBeulich@suse.com>, Nadav Amit <namit@vmware.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] x86, kbuild: revert macrofying inline assembly
 code
Message-ID: <20181219112028.GA38175@gmail.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> This series reverts the in-kernel workarounds for inlining issues.
> 
> The commit description of 77b0bf55bc67 mentioned
> "We also hope that GCC will eventually get fixed,..."
> 
> Now, GCC provides a solution.
> 
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
> explains the new "asm inline" syntax.
> 
> The performance issue will be eventually solved.
> 
> [About Code cleanups]
> 
> I know Nadam Amit is opposed to the full revert.
> He also claims his motivation for macrofying was not only
> performance, but also cleanups.
> 
> IIUC, the criticism addresses the code duplication between C and ASM.
> 
> If so, I'd like to suggest a different approach for cleanups.
> Please see the last 3 patches.
> IMHO, preprocessor approach is more straight-forward, and readable.
> Basically, this idea should work because it is what we already do for
> __ASM_FORM() etc.
> 
> [Quick Test of "asm inline" of GCC 9]
> 
> If you want to try "asm inline" feature, the patch is available:
> https://lore.kernel.org/patchwork/patch/1024590/
> 
> The number of symbols for arch/x86/configs/x86_64_defconfig:
> 
>                             nr_symbols
>   [1]    v4.20-rc7       :   96502
>   [2]    [1]+full revert :   96705   (+203)
>   [3]    [2]+"asm inline":   96568   (-137)
> 
> [3]: apply my patch, then replace "asm" -> "asm_inline"
>     for _BUG_FLAGS(), refcount_add(), refcount_inc(), refcount_dec(),
>         annotate_reachable(), annotate_unreachable()
> 
> 
> Changes in v3:
>   - Split into per-commit revert (per Nadav Amit)
>   - Add some cleanups with preprocessor approach
> 
> Changes in v2:
>   - Revive clean-ups made by 5bdcd510c2ac (per Peter Zijlstra)
>   - Fix commit quoting style (per Peter Zijlstra)
> 
> Masahiro Yamada (12):
>   Revert "x86/jump-labels: Macrofy inline assembly code to work around
>     GCC inlining bugs"
>   Revert "x86/cpufeature: Macrofy inline assembly code to work around
>     GCC inlining bugs"
>   Revert "x86/extable: Macrofy inline assembly code to work around GCC
>     inlining bugs"
>   Revert "x86/paravirt: Work around GCC inlining bugs when compiling
>     paravirt ops"
>   Revert "x86/bug: Macrofy the BUG table section handling, to work
>     around GCC inlining bugs"
>   Revert "x86/alternatives: Macrofy lock prefixes to work around GCC
>     inlining bugs"
>   Revert "x86/refcount: Work around GCC inlining bug"
>   Revert "x86/objtool: Use asm macros to work around GCC inlining bugs"
>   Revert "kbuild/Makefile: Prepare for using macros in inline assembly
>     code to work around asm() related GCC inlining bugs"
>   linux/linkage: add ASM() macro to reduce duplication between C/ASM
>     code
>   x86/alternatives: consolidate LOCK_PREFIX macro
>   x86/asm: consolidate ASM_EXTABLE_* macros
> 
>  Makefile                                  |  9 +--
>  arch/x86/Makefile                         |  7 ---
>  arch/x86/include/asm/alternative-asm.h    | 22 +------
>  arch/x86/include/asm/alternative-common.h | 47 +++++++++++++++
>  arch/x86/include/asm/alternative.h        | 30 +---------
>  arch/x86/include/asm/asm.h                | 46 +++++----------
>  arch/x86/include/asm/bug.h                | 98 +++++++++++++------------------
>  arch/x86/include/asm/cpufeature.h         | 82 +++++++++++---------------
>  arch/x86/include/asm/jump_label.h         | 22 +++++--
>  arch/x86/include/asm/paravirt_types.h     | 56 +++++++++---------
>  arch/x86/include/asm/refcount.h           | 81 +++++++++++--------------
>  arch/x86/kernel/macros.S                  | 16 -----
>  include/asm-generic/bug.h                 |  8 +--
>  include/linux/compiler.h                  | 56 ++++--------------
>  include/linux/linkage.h                   |  8 +++
>  scripts/Kbuild.include                    |  4 +-
>  scripts/mod/Makefile                      |  2 -
>  17 files changed, 249 insertions(+), 345 deletions(-)
>  create mode 100644 arch/x86/include/asm/alternative-common.h
>  delete mode 100644 arch/x86/kernel/macros.S

I absolutely agree that this needs to be resolved in v4.20.

So I did the 1-9 reverts manually myself as well, because I think the 
first commit should be reverted fully to get as close to the starting 
point as possible (we are late in the cycle) - and came to the attached 
interdiff between your series and mine.

Does this approach look OK to you, or did I miss something?

Thanks,

	Ingo

=============>

 entry/calling.h          |    2 -
 include/asm/jump_label.h |   50 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 25e5a6bda8c3..20d0885b00fb 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -352,7 +352,7 @@ For 32-bit we have the following conventions - kernel is built with
 .macro CALL_enter_from_user_mode
 #ifdef CONFIG_CONTEXT_TRACKING
 #ifdef HAVE_JUMP_LABEL
-	STATIC_BRANCH_JMP l_yes=.Lafter_call_\@, key=context_tracking_enabled, branch=1
+	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_enabled, def=0
 #endif
 	call enter_from_user_mode
 .Lafter_call_\@:
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index cf88ebf9a4ca..21efc9d07ed9 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -2,6 +2,19 @@
 #ifndef _ASM_X86_JUMP_LABEL_H
 #define _ASM_X86_JUMP_LABEL_H
 
+#ifndef HAVE_JUMP_LABEL
+/*
+ * For better or for worse, if jump labels (the gcc extension) are missing,
+ * then the entire static branch patching infrastructure is compiled out.
+ * If that happens, the code in here will malfunction.  Raise a compiler
+ * error instead.
+ *
+ * In theory, jump labels and the static branch patching infrastructure
+ * could be decoupled to fix this.
+ */
+#error asm/jump_label.h included on a non-jump-label kernel
+#endif
+
 #define JUMP_LABEL_NOP_SIZE 5
 
 #ifdef CONFIG_X86_64
@@ -53,26 +66,37 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 
 #else	/* __ASSEMBLY__ */
 
-.macro STATIC_BRANCH_NOP l_yes:req key:req branch:req
-.Lstatic_branch_nop_\@:
-	.byte STATIC_KEY_INIT_NOP
-.Lstatic_branch_no_after_\@:
+.macro STATIC_JUMP_IF_TRUE target, key, def
+.Lstatic_jump_\@:
+	.if \def
+	/* Equivalent to "jmp.d32 \target" */
+	.byte		0xe9
+	.long		\target - .Lstatic_jump_after_\@
+.Lstatic_jump_after_\@:
+	.else
+	.byte		STATIC_KEY_INIT_NOP
+	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	.long		.Lstatic_branch_nop_\@ - ., \l_yes - .
-	_ASM_PTR        \key + \branch - .
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key - .
 	.popsection
 .endm
 
-.macro STATIC_BRANCH_JMP l_yes:req key:req branch:req
-.Lstatic_branch_jmp_\@:
-	.byte 0xe9
-	.long \l_yes - .Lstatic_branch_jmp_after_\@
-.Lstatic_branch_jmp_after_\@:
+.macro STATIC_JUMP_IF_FALSE target, key, def
+.Lstatic_jump_\@:
+	.if \def
+	.byte		STATIC_KEY_INIT_NOP
+	.else
+	/* Equivalent to "jmp.d32 \target" */
+	.byte		0xe9
+	.long		\target - .Lstatic_jump_after_\@
+.Lstatic_jump_after_\@:
+	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	.long		.Lstatic_branch_jmp_\@ - ., \l_yes - .
-	_ASM_PTR	\key + \branch - .
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key + 1 - .
 	.popsection
 .endm
 

