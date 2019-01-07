Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE38C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252792070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX3E4pvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfAGWIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:08:40 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33542 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfAGWIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:08:40 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so2402891eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tGqS5Ak6/r3zvAIevSmtgYjk+Hq2egFxx9BqcBNXpPI=;
        b=rX3E4pvgdfZ/GmpYH9TqvCKuaZWPoS3xV78T4SfQoukpfW4E2y/O+H1QZG0T9tN07p
         qN9dP4EtB08wwqVTLqcbPLMd6y+qxNfb6urcjRH2SXAAPD5mtgpiPpBobLCUg3bpH/8e
         ygGVux42oWENAoICeU+KdEpv209/ceoBCjnvo9h5SV6rkU6FcdUOoXf/OBp1u9UwPKli
         PY53DCWZmmxSQnMUrY6wfy7KYKURkcCm2nArloScJpQwj4C55YsjlHhyIDirXkJvWCRA
         k6fADFhZQIB1Ly/fac+5KEdfKjj9QTYotncMDmDJoXXS6Ym5ZAiXykG316iY+39lGrGb
         KFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tGqS5Ak6/r3zvAIevSmtgYjk+Hq2egFxx9BqcBNXpPI=;
        b=mP0hPJYdMMOkvZ6ojMnL36xzBXDfoB/AdPlK4RmCOf7ynV45XnHSRsKgrXCmhtcnPa
         1qg/FBpW0dq01o1eutFzfhjWeDQpBKDXubc50uuE7dLN+siNWL5EIZTuEd/qRlQxUHWE
         vTWjYr8LydX3fyc9aJn2NLWSNhEghNBTKXL4HqXfLTl7sHRA7cXXwQpADOoBJKzoQoFy
         wQOi6WuH/7VxsvuGe5n+i3xfG9h33JvoyqItASdP8Wqzeefm3yz1bV8djD3GF73zVGfL
         aV8m3v71HOaARxsqagg1QyCIsVsGTrmJILEwhnRcyzi3qZSpf0hkM9kxIuHaBMYzRrna
         Rb4A==
X-Gm-Message-State: AJcUukcoCAecIR7LM+UNMi1wpd0281o4ihYSuCwiPDDVmGajh5M5NHVa
        BrOfX3EyDxUEPIYyZDKDY2XdF3n7djEZ9rTJ8kXinA==
X-Google-Smtp-Source: ALg8bN6pzSxG6C5+k9NsttaM9o7yp2mSn823TmBYl06yw3yLGJFlooIRaxkMfJn9qO9xBvBjkBctDaE0SQoTZiJY8E4=
X-Received: by 2002:a50:d753:: with SMTP id i19mr16919054edj.75.1546898918303;
 Mon, 07 Jan 2019 14:08:38 -0800 (PST)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
In-Reply-To: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Mon, 7 Jan 2019 18:08:26 -0400
Message-ID: <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 11:20 AM Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
>
> Commit:     12209993e98c5fa1855c467f22a24e3d5b8be205
> Parent:     2f2fcc40a961ed04f0e130803fbaa868c2899310
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/12209993e98c5fa1855c467f22a=
24e3d5b8be205
> Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate: Thu Nov 29 16:02:10 2018 +0100
> Committer:  Borislav Petkov <bp@suse.de>
> CommitDate: Tue Dec 4 12:37:28 2018 +0100
>
>     x86/fpu: Don't export __kernel_fpu_{begin,end}()
>
>     There is one user of __kernel_fpu_begin() and before invoking it,
>     it invokes preempt_disable(). So it could invoke kernel_fpu_begin()
>     right away. The 32bit version of arch_efi_call_virt_setup() and
>     arch_efi_call_virt_teardown() does this already.
>
>     The comment above *kernel_fpu*() claims that before invoking
>     __kernel_fpu_begin() preemption should be disabled and that KVM is a
>     good example of doing it. Well, KVM doesn't do that since commit
>
>       f775b13eedee2 ("x86,kvm: move qemu/guest FPU switching out to vcpu_=
run")
>
>     so it is not an example anymore.
>
>     With EFI gone as the last user of __kernel_fpu_{begin|end}(), both ca=
n
>     be made static and not exported anymore.
>
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Signed-off-by: Borislav Petkov <bp@suse.de>
>     Reviewed-by: Rik van Riel <riel@surriel.com>
>     Cc: "H. Peter Anvin" <hpa@zytor.com>
>     Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
>     Cc: Andy Lutomirski <luto@kernel.org>
>     Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>     Cc: Dave Hansen <dave.hansen@linux.intel.com>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: Nicolai Stange <nstange@suse.de>
>     Cc: Paolo Bonzini <pbonzini@redhat.com>
>     Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: kvm ML <kvm@vger.kernel.org>
>     Cc: linux-efi <linux-efi@vger.kernel.org>
>     Cc: x86-ml <x86@kernel.org>
>     Link: https://lkml.kernel.org/r/20181129150210.2k4mawt37ow6c2vq@linut=
ronix.de
> ---
>  arch/x86/include/asm/efi.h     |  6 ++----
>  arch/x86/include/asm/fpu/api.h | 15 +++++----------
>  arch/x86/kernel/fpu/core.c     |  6 ++----
>  3 files changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index eea40d52ca78..45864898f7e5 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -82,8 +82,7 @@ struct efi_scratch {
>  #define arch_efi_call_virt_setup()                                     \
>  ({                                                                     \
>         efi_sync_low_kernel_mappings();                                 \
> -       preempt_disable();                                              \
> -       __kernel_fpu_begin();                                           \
> +       kernel_fpu_begin();                                             \
>         firmware_restrict_branch_speculation_start();                   \
>                                                                         \
>         if (!efi_enabled(EFI_OLD_MEMMAP))                               \
> @@ -99,8 +98,7 @@ struct efi_scratch {
>                 efi_switch_mm(efi_scratch.prev_mm);                     \
>                                                                         \
>         firmware_restrict_branch_speculation_end();                     \
> -       __kernel_fpu_end();                                             \
> -       preempt_enable();                                               \
> +       kernel_fpu_end();                                               \
>  })
>
>  extern void __iomem *__init efi_ioremap(unsigned long addr, unsigned lon=
g size,
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/ap=
i.h
> index a9caac9d4a72..b56d504af654 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -12,17 +12,12 @@
>  #define _ASM_X86_FPU_API_H
>
>  /*
> - * Careful: __kernel_fpu_begin/end() must be called with preempt disable=
d
> - * and they don't touch the preempt state on their own.
> - * If you enable preemption after __kernel_fpu_begin(), preempt notifier
> - * should call the __kernel_fpu_end() to prevent the kernel/user FPU
> - * state from getting corrupted. KVM for example uses this model.
> - *
> - * All other cases use kernel_fpu_begin/end() which disable preemption
> - * during kernel FPU usage.
> + * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context=
. It
> + * disables preemption so be careful if you intend to use it for long pe=
riods
> + * of time.
> + * If you intend to use the FPU in softirq you need to check first with
> + * irq_fpu_usable() if it is possible.
>   */
> -extern void __kernel_fpu_begin(void);
> -extern void __kernel_fpu_end(void);
>  extern void kernel_fpu_begin(void);
>  extern void kernel_fpu_end(void);
>  extern bool irq_fpu_usable(void);
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 2ea85b32421a..2e5003fef51a 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -93,7 +93,7 @@ bool irq_fpu_usable(void)
>  }
>  EXPORT_SYMBOL(irq_fpu_usable);
>
> -void __kernel_fpu_begin(void)
> +static void __kernel_fpu_begin(void)
>  {
>         struct fpu *fpu =3D &current->thread.fpu;
>
> @@ -111,9 +111,8 @@ void __kernel_fpu_begin(void)
>                 __cpu_invalidate_fpregs_state();
>         }
>  }
> -EXPORT_SYMBOL(__kernel_fpu_begin);
>
> -void __kernel_fpu_end(void)
> +static void __kernel_fpu_end(void)
>  {
>         struct fpu *fpu =3D &current->thread.fpu;
>
> @@ -122,7 +121,6 @@ void __kernel_fpu_end(void)
>
>         kernel_fpu_enable();
>  }
> -EXPORT_SYMBOL(__kernel_fpu_end);
>
>  void kernel_fpu_begin(void)
>  {

This commit removes an exported function pair that is currently used
by out of tree modules, while the replacement pair
(kernel_fpu_begin/end) is EXPORT_SYMBOL_GPL.  So this is making
existing functionality GPL only, which will probably be an issue for
several out of tree modules that use the fpu.

Could kernel_fpu_begin/end be made plain EXPORT_SYMBOL?

Marc
