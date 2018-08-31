Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F1DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB842077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KE0f1wy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB842077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeHaTKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:10:03 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41597 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbeHaTKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:10:03 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so22180382oiw.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO1E65e+iHvRxpquck2xT3J8OTN9faM6zLPXFDpjCFE=;
        b=KE0f1wy7aQu3+/DiQRcjwRuwoAi5YWJrZYNr3MFH6SHlkv+qioQfX3RRTGV3NHKGNV
         ywYYDtYwPYcIuP3Ta8BdGFE/odkDMGmjurpeRXADQLak1AbZLbBFqkuz6+Itla2B3rYS
         QWX4c0NhXkebRkKTivKDLJ54Re9besWKF0kVSB1Q5K9SU5UwsakeP3AgvTMe1j8i0ZAT
         1FdYRHITy9tRZgRkseRHZcWD3dCcWvcsVuTlaq4IbLSZ82XL3DEcY/KkM8pXWUc0jGSC
         iFKYTFzT4LUqdjssoXQsQ+I7Co0of3/WUo1tPMUynTMz/RH7LBnl+cNPOUy9K4Fpnm5c
         iTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO1E65e+iHvRxpquck2xT3J8OTN9faM6zLPXFDpjCFE=;
        b=o9ydkD2fFOaErm97VdaziG2gCjj8gmHqWup2nlFNQbfT/4uYPRhI526Xmp5COHfYqo
         ZT638UbODZSAlnytYLH48gcGWWb++cu9hKuIl41pj2cC6W+uFVgHC9avQ2SFfZna7aOe
         jN0MTpxjbjxCzNQexoftFPjnPYFuiYli+GXdHHiaVozJQzAwoiYETf/GdN3FAp8RX55m
         IzMWZ4qbboL9boNTrb3xm0Bl844YrOBcDzIxcJIQkQy1lageQu+wgsC7z2/3foCmZrUr
         DGCMZmSPWx5LsdL8YOLWi+CTNx032gDyFo3FxmaFAHz8NyGMbV+0VOj4ch/hB95is0c6
         TMww==
X-Gm-Message-State: APzg51AyGNWvn/oA6LOwubHWXdjxRsSPnSq4zKkmp3aVpIFNHgEL8JLH
        r51C7pCyCYnWAtNfWsRqlTHLG9pbYYNx+VW9ekQU0g==
X-Google-Smtp-Source: ANB0Vdb1kP1C9qHD1EqBYR6Udetv/8kjc8hQgxiuv5REDY/mN+1HoCDAViwbzbvhZ79vZhl4MTnJVb01r8PyYDN9Gi8=
X-Received: by 2002:aca:dc55:: with SMTP id t82-v6mr6919903oig.159.1535727729152;
 Fri, 31 Aug 2018 08:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-7-yu-cheng.yu@intel.com>
In-Reply-To: <20180830143904.3168-7-yu-cheng.yu@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 31 Aug 2018 17:01:42 +0200
Message-ID: <CAG48ez0jvsDw189=YoCCa8tmJUENeUd_ypcP5bYJ+eLMPCYCOQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/24] x86/cet: Control protection exception handler
To:     yu-cheng.yu@intel.com
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 4:43 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> A control protection exception is triggered when a control flow transfer
> attempt violated shadow stack or indirect branch tracking constraints.
> For example, the return address for a RET instruction differs from the
> safe copy on the shadow stack; or a JMP instruction arrives at a non-
> ENDBR instruction.
>
> The control protection exception handler works in a similar way as the
> general protection fault handler.

Is there a reason why all the code in this patch isn't #ifdef'ed away
on builds that don't support CET? It looks like the CET handler is
hooked up to the IDT conditionally, but the handler code is always
built?

> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/entry/entry_64.S    |  2 +-
>  arch/x86/include/asm/traps.h |  3 ++
>  arch/x86/kernel/idt.c        |  4 +++
>  arch/x86/kernel/traps.c      | 58 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 957dfb693ecc..5f4914e988df 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1000,7 +1000,7 @@ idtentry spurious_interrupt_bug           do_spurious_interrupt_bug       has_error_code=0
>  idtentry coprocessor_error             do_coprocessor_error            has_error_code=0
>  idtentry alignment_check               do_alignment_check              has_error_code=1
>  idtentry simd_coprocessor_error                do_simd_coprocessor_error       has_error_code=0
> -
> +idtentry control_protection            do_control_protection           has_error_code=1
>
>         /*
>          * Reload gs selector with exception handling
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index 3de69330e6c5..5196050ff3d5 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -26,6 +26,7 @@ asmlinkage void invalid_TSS(void);
>  asmlinkage void segment_not_present(void);
>  asmlinkage void stack_segment(void);
>  asmlinkage void general_protection(void);
> +asmlinkage void control_protection(void);
>  asmlinkage void page_fault(void);
>  asmlinkage void async_page_fault(void);
>  asmlinkage void spurious_interrupt_bug(void);
> @@ -77,6 +78,7 @@ dotraplinkage void do_stack_segment(struct pt_regs *, long);
>  dotraplinkage void do_double_fault(struct pt_regs *, long);
>  #endif
>  dotraplinkage void do_general_protection(struct pt_regs *, long);
> +dotraplinkage void do_control_protection(struct pt_regs *, long);
>  dotraplinkage void do_page_fault(struct pt_regs *, unsigned long);
>  dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *, long);
>  dotraplinkage void do_coprocessor_error(struct pt_regs *, long);
> @@ -142,6 +144,7 @@ enum {
>         X86_TRAP_AC,            /* 17, Alignment Check */
>         X86_TRAP_MC,            /* 18, Machine Check */
>         X86_TRAP_XF,            /* 19, SIMD Floating-Point Exception */
> +       X86_TRAP_CP = 21,       /* 21 Control Protection Fault */
>         X86_TRAP_IRET = 32,     /* 32, IRET Exception */
>  };
>
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index 01adea278a71..2d02fdd599a2 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -104,6 +104,10 @@ static const __initconst struct idt_data def_idts[] = {
>  #elif defined(CONFIG_X86_32)
>         SYSG(IA32_SYSCALL_VECTOR,       entry_INT80_32),
>  #endif
> +
> +#ifdef CONFIG_X86_INTEL_CET
> +       INTG(X86_TRAP_CP,               control_protection),
> +#endif
>  };
>
>  /*
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index e6db475164ed..21a713b96148 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -578,6 +578,64 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  }
>  NOKPROBE_SYMBOL(do_general_protection);
>
> +static const char *control_protection_err[] =
> +{
> +       "unknown",
> +       "near-ret",
> +       "far-ret/iret",
> +       "endbranch",
> +       "rstorssp",
> +       "setssbsy",
> +};
> +
> +/*
> + * When a control protection exception occurs, send a signal
> + * to the responsible application.  Currently, control
> + * protection is only enabled for the user mode.  This
> + * exception should not come from the kernel mode.
> + */
> +dotraplinkage void
> +do_control_protection(struct pt_regs *regs, long error_code)
> +{
> +       struct task_struct *tsk;
> +
> +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +       if (notify_die(DIE_TRAP, "control protection fault", regs,
> +                      error_code, X86_TRAP_CP, SIGSEGV) == NOTIFY_STOP)
> +               return;
> +       cond_local_irq_enable(regs);
> +
> +       if (!user_mode(regs))
> +               die("kernel control protection fault", regs, error_code);
> +
> +       if (!static_cpu_has(X86_FEATURE_SHSTK) &&
> +           !static_cpu_has(X86_FEATURE_IBT))
> +               WARN_ONCE(1, "CET is disabled but got control "
> +                         "protection fault\n");
> +
> +       tsk = current;
> +       tsk->thread.error_code = error_code;
> +       tsk->thread.trap_nr = X86_TRAP_CP;
> +
> +       if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +           printk_ratelimit()) {
> +               unsigned int max_err;
> +
> +               max_err = ARRAY_SIZE(control_protection_err) - 1;
> +               if ((error_code < 0) || (error_code > max_err))
> +                       error_code = 0;
> +               pr_info("%s[%d] control protection ip:%lx sp:%lx error:%lx(%s)",
> +                       tsk->comm, task_pid_nr(tsk),
> +                       regs->ip, regs->sp, error_code,
> +                       control_protection_err[error_code]);
> +               print_vma_addr(" in ", regs->ip);

Shouldn't this be using KERN_CONT, like other callers of
print_vma_addr(), to get the desired output?

> +               pr_cont("\n");
> +       }
> +
> +       force_sig_info(SIGSEGV, SEND_SIG_PRIV, tsk);
