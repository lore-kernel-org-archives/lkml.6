Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FE/8AGl7GVtMQwAAmS7hNA
	; Thu, 07 Jun 2018 18:40:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 31E30606FA; Thu,  7 Jun 2018 18:40:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjgKWD32"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 25CAB601C3;
	Thu,  7 Jun 2018 18:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25CAB601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935073AbeFGSkC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:40:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33494 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933112AbeFGSj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:39:59 -0400
Received: by mail-pl0-f65.google.com with SMTP id n10-v6so6677347plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IKf4MrhqXAFQVORf3toCHGJxzJnztKzdcNNf/oJJ/s=;
        b=DjgKWD32tG4cjnCWCvw/QvuYzQB2grrxodq3OorDcZfZfLrGVyWKjSCrTPir3WNG8R
         BCh+SNO2EiPmk021B4IHOoQsDaMBVijpZs3T/kw07sXGdIlJI8wFpCFuFG8EvvbAPixk
         cwNHTMlkpl4gmyWf2bkc6PwO7MNUnXo/IQ0WblteP5PNKwOK6etQ8Igei6jA1EiYMZF8
         ZEXaAcpwr9vcZ2LBYn6pjS/bX5Jxm164YAHKk0fL6+hgglBfscL/V7tC2NRmdQGNqlzn
         kWx78FtyoFwBWivIr7Tjvm8IYOV9tBOri5xBb3vGUPErCs4Bh0ComMPC0LAf1hLw8Pdf
         NvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IKf4MrhqXAFQVORf3toCHGJxzJnztKzdcNNf/oJJ/s=;
        b=O6XLb5eewdjuCQKiHcR88apeqQNcM11s+i3YG6bBvuyoYeOVRGvJYxx6C/r5VF1Ssq
         60ocLeY7U25TuXVCuN+dmhUo/PsvqDXjO5WHcbqdtRgSaQJkvlVXrypcLF1HoW7cqt1t
         umLAwGE3TX8iPwxEPF9RY+wpUakEi3vHJNLw7b+sqOm3UqgBiVLsLFOjaIHhUFDoFLu0
         0+HuTQd0ggb8GmgplpWXtpKeOOARq9UnfoStTPb6ILU8T9cc+kwLx2qmxiS3T2G5dVC4
         hEJr4PhUA8zxi8TrtsU/fAKEBy/Pa59P9N2GnzLdXsFWxPavEpk+iAppQF/zWw0XOHfT
         Dbvg==
X-Gm-Message-State: APt69E2WDP3Hc/2zdWCIu6eMQknReScSPz+KykEx8BisAsFE46ECY+0s
        1T1j2htkqr1AhauuIKz6M5OrOUqy9PM5ThH7i+M3PA==
X-Google-Smtp-Source: ADUXVKJbHc2yWt2IqAwV2qYt8FKiwaRRNv4G4L+njQ+RDxnNevTMvqgtDl/r4qBQDuvlwHI1il3KzR7yXpCjYPfrd9A=
X-Received: by 2002:a17:902:5409:: with SMTP id d9-v6mr3247678pli.0.1528396798522;
 Thu, 07 Jun 2018 11:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180607183219.192973-1-ndesaulniers@google.com> <20180607183219.192973-4-ndesaulniers@google.com>
In-Reply-To: <20180607183219.192973-4-ndesaulniers@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Jun 2018 11:39:46 -0700
Message-ID: <CAKwvOdkoAwT2RiGzJ=dSfx9+SJ27gJimdtKQg2Aoi5+-SbA79g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] x86: paravirt: make native_save_fl extern inline
To: Andrew Morton <akpm@linux-foundation.org>, hpa@zytor.com,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>, acme@redhat.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        boris.ostrovsky@oracle.com, "J. Kiszka" <jan.kiszka@siemens.com>,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        akataria@vmware.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>, thomas.lendacky@amd.com,
        Thiebaud Weksteen <tweek@google.com>, mjg59@google.com,
        joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 11:32 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> native_save_fl() is marked static inline, but by using it as
> a function pointer in arch/x86/kernel/paravirt.c, it MUST be outlined.
>
> paravirt's use of native_save_fl() also requires that no GPRs other than
> %rax are clobbered.
>
> Compilers have different heuristics which they use to emit stack guard
> code, the emittance of which can break paravirt's callee saved assumption
> by clobbering %rcx.
>
> Marking a function definition extern inline means that if this version
> cannot be inlined, then the out-of-line version will be preferred. By
> having the out-of-line version be implemented in assembly, it cannot be
> instrumented with a stack protector, which might violate custom calling
> conventions that code like paravirt rely on.
>
> The semantics of extern inline has changed since gnu89. This means that
> folks using GCC versions >= 5.1 may see symbol redefinition errors at
> link time for subdirs that override KBUILD_CFLAGS (making the C standard
> used implicit) regardless of this patch. This has been cleaned up
> earlier in the patch set, but is left as a note in the commit message
> for future travelers.
>
> Reports:
> https://lkml.org/lkml/2018/5/7/534
> https://github.com/ClangBuiltLinux/linux/issues/16
>
> Discussion:
> https://bugs.llvm.org/show_bug.cgi?id=37512
> https://lkml.org/lkml/2018/5/24/1371
>
> Thanks to the many folks that participated in the discussion.
>
> Debugged-by: Alistair Strachan <astrachan@google.com>
> Debugged-by: Matthias Kaehlcke <mka@chromium.org>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Suggested-by: Tom Stellar <tstellar@redhat.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  arch/x86/include/asm/irqflags.h |  2 +-
>  arch/x86/kernel/Makefile        |  1 +
>  arch/x86/kernel/irqflags.S      | 26 ++++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/kernel/irqflags.S
>
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 89f08955fff7..c4fc17220df9 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -13,7 +13,7 @@
>   * Interrupt control:
>   */
>
> -static inline unsigned long native_save_fl(void)
> +extern inline unsigned long native_save_fl(void)
>  {
>         unsigned long flags;
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 02d6f5cf4e70..8824d01c0c35 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -61,6 +61,7 @@ obj-y                 += alternative.o i8253.o hw_breakpoint.o
>  obj-y                  += tsc.o tsc_msr.o io_delay.o rtc.o
>  obj-y                  += pci-iommu_table.o
>  obj-y                  += resource.o
> +obj-y                  += irqflags.o
>
>  obj-y                          += process.o
>  obj-y                          += fpu/
> diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
> new file mode 100644
> index 000000000000..ddeeaac8adda
> --- /dev/null
> +++ b/arch/x86/kernel/irqflags.S
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <asm/asm.h>
> +#include <asm/export.h>
> +#include <linux/linkage.h>
> +
> +/*
> + * unsigned long native_save_fl(void)
> + */
> +ENTRY(native_save_fl)
> +       pushf
> +       pop %_ASM_AX
> +       ret
> +ENDPROC(native_save_fl)
> +EXPORT_SYMBOL(native_save_fl)
> +
> +/*
> + * void native_restore_fl(unsigned long flags)
> + * %eax/%rdi: flags
> + */
> +ENTRY(native_restore_fl)
> +       push %_ASM_ARG1
> +       popf
> +       ret
> +ENDPROC(native_restore_fl)
> +EXPORT_SYMBOL(native_restore_fl)
> --
> 2.17.1.1185.g55be947832-goog
>

Probably should have mentioned in the notes/cover letter that this was
rebased on hpa's patch (2/3) in this series. As a change from v2.

-- 
Thanks,
~Nick Desaulniers
