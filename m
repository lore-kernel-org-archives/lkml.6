Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78AEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFF020850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6f3xHN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFF020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLCVMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:12:32 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40110 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeLCVMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:12:32 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so10909751ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yhIoV1dlJMenFm8edG2JD4Ef45e8aCymQaFOXM0M0dE=;
        b=c6f3xHN64JNAu4OHg/gLyl2qOK/TyxhK5AoPdT8JT95w4+yCIEe4lDyPPdt1sO90Za
         cv4m2Kb0E52NPtiVkgWSQ32NW+9TaiIl2HMvc5JGpfkHrggS9lAkq1h9D7eKAndtP4aY
         T0UGAyBmnNVj2BsWAghwV2wrDMauz7DgGwBuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yhIoV1dlJMenFm8edG2JD4Ef45e8aCymQaFOXM0M0dE=;
        b=MlyhvrjFX51+LFjMjQnH64cpwrKO4lLXVPsbniiLApNASTrqQ7CUwaK8UELf8vtSnB
         kaE7kYE+CF6PlIAMRbmbgKlFkaALkp3JOkWZ9Vw2Q4eImdfhNgW9I3dLXCzjLsl5SESL
         g3wvS9zZGGO8xoMyTQ1qugVmBLVjVBbJwr0RputEOP9nN89MWmWV4kEZN8Px66TDdiPx
         N8/0EGwsGAXm2S+qDZfY4SOm0skapp2W9jzDpkqDDSw5voo4fY10KObLSzUP3Z8qE39u
         P9d61vSFdOt+HRCMmx03wzPhj3OrJcMD5J0TPE8rHSwgC8j3s/dX3KwfLq0JwB+6vmd2
         ZNYQ==
X-Gm-Message-State: AA+aEWYZ8wAtXhNmAIcWQ8PiWu/6U8iv2kNpWttYJfOYhsa7zBHsORka
        9LW3jaDhh3BkT9ABmtSUO501VNahzz/c+mOYMElSAw==
X-Google-Smtp-Source: AFSGD/VQLpPaJ+9uZg/2zjeSkDRwFa2atwtXr9CPUbBf9cO8rWtrInzY/vzT/qbZWuzlCj2nEsb/S2LZqJyXBzLo/Js=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr10260248ith.158.1543871550657;
 Mon, 03 Dec 2018 13:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20181129150210.2k4mawt37ow6c2vq@linutronix.de> <tip-7d79adb87fa79e4a4c59424fd5b5a922861fc5f6@git.kernel.org>
In-Reply-To: <tip-7d79adb87fa79e4a4c59424fd5b5a922861fc5f6@git.kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 3 Dec 2018 22:12:19 +0100
Message-ID: <CAKv+Gu-s59fSWrMevmbJWyBtNVYLkF7FATALGBD470CWsN9C1Q@mail.gmail.com>
Subject: Re: [tip:x86/fpu] x86/fpu: Don't export __kernel_fpu_{begin,end}()
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, nstange@suse.de,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        KVM devel mailing list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018 at 22:04, tip-bot for Sebastian Andrzej Siewior
<tipbot@zytor.com> wrote:
>
> Commit-ID:  7d79adb87fa79e4a4c59424fd5b5a922861fc5f6
> Gitweb:     https://git.kernel.org/tip/7d79adb87fa79e4a4c59424fd5b5a92286=
1fc5f6
> Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate: Thu, 29 Nov 2018 16:02:10 +0100
> Committer:  Borislav Petkov <bp@suse.de>
> CommitDate: Mon, 3 Dec 2018 19:37:27 +0100
>
> x86/fpu: Don't export __kernel_fpu_{begin,end}()
>
> There is one user of __kernel_fpu_begin() and before invoking it,
> it invokes preempt_disable(). So it could invoke kernel_fpu_begin()
> right away. The 32bit version of arch_efi_call_virt_setup() and
> arch_efi_call_virt_teardown() does this already.
>
> The comment above *kernel_fpu*() claims that before invoking
> __kernel_fpu_begin() preemption should be disabled and that KVM is a
> good example of doing it. Well, KVM doesn't do that since commit
>
>   f775b13eedee2 ("x86,kvm: move qemu/guest FPU switching out to vcpu_run"=
)
>
> so it is not an example anymore.
>
> With EFI gone as the last user of __kernel_fpu_{begin|end}(), both can
> be made static and not exported anymore.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kvm ML <kvm@vger.kernel.org>
> Cc: linux-efi <linux-efi@vger.kernel.org>
> Cc: x86-ml <x86@kernel.org>
> Link: https://lkml.kernel.org/r/20181129150210.2k4mawt37ow6c2vq@linutroni=
x.de
> ---
>  arch/x86/include/asm/efi.h     |  6 ++----
>  arch/x86/include/asm/fpu/api.h | 16 ++++++----------
>  arch/x86/kernel/fpu/core.c     |  6 ++----
>  3 files changed, 10 insertions(+), 18 deletions(-)
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
> index a9caac9d4a72..e368d8d94ca6 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -12,17 +12,13 @@
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
> + * Using the FPU in hardirq is not allowed.

According to the documentation in x86/kernel/fpu/core.c, this is not
true. So which one is accurate?

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
