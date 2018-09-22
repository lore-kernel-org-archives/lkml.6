Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76268ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CA52150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbHFKOhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CA52150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeIVR1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 13:27:11 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38520 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIVR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 13:27:11 -0400
Received: by mail-yb1-f193.google.com with SMTP id e190-v6so6516327ybb.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndm8L3AdSTYifie8wUxQs4Eh1zw0lRPpstlEqJmGqjE=;
        b=cbHFKOhe27mHcoTFP3aFTJP8t/zInP5HXAx+DJOtcTpUaEi05svP2puY+u65tW8GP1
         BH4Ib/eNk/Fz/l8+jWp78DVDej5R+OmYih4CxL5xgbapcmTuNxigo8ytHY7mmYVsj7sR
         fOUkKMjexSYccyIwXZm/ySOmg+JLFbkXZONKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndm8L3AdSTYifie8wUxQs4Eh1zw0lRPpstlEqJmGqjE=;
        b=NvY9D88J1HXRhL2A0pYyCNMhgppvz6eUMI1QIpKednVTQqAE4Tb7I+pcuWWZ2FG0DA
         vIqNituC3LNH+QUEa/9lcwfaA7Ze3qQDNF+Z1eHd2kXXdkUVtb+dO1UCIYaWpRbv58m3
         dsWAvk5o49Eirwjz2gHjTCAOGf4b8ZV4ZpgZJLNbEoLHTAn6j8GeDHTmwgK9qRxyuYPE
         pHWjB45v2v44K40+XbHIPyoV2nxJmSZ+NsGRjMjvOejnzRu8wQ2AcgBGBlX/NnoS8ZzI
         JQxK42G0oBoKlMFcVp5P9t9YhIGMtz8YAB83C7523smZc5n4ZfeGFPlCvJ0ejARecFSB
         Yhtw==
X-Gm-Message-State: ABuFfoic+mm6caukfV8Hd6I+2uDWkPoxD7U6qb0rUCtCFnqebnmAjJRm
        H8XfG1hLNSThpPD2qo0nJRvUSK3GUaD/ELHWQH5Dvw==
X-Google-Smtp-Source: ACcGV60wshbZ814y9z0MlsowteA/BMs7oO1w9teRRbk+Rubbx4yKodyXE4U+e9qT/CFqnRj9zpoko6Y7j95FMdLzwSY=
X-Received: by 2002:a25:e548:: with SMTP id c69-v6mr732998ybh.393.1537616035237;
 Sat, 22 Sep 2018 04:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
 <1533791723-3882-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
 <CALxhOnheD75br1X_A7h5cNYWdjrDn4ciPc++mYd-_oZJApJyZg@mail.gmail.com>
 <CAMuHMdUcg-73DNNGuG3Kn9oQ9R+LpYxpWYV_1tmzN-EzBFUXVQ@mail.gmail.com>
 <CALxhOnjLKU8BCHFoc35P_tTh=6+NRbCrO6oB3Gar=uBMqYU4iw@mail.gmail.com> <CAMuHMdWMxEfVKkohmv6ZAUPKYdZiFK6YoE6Y_L40j7YU-OtY0A@mail.gmail.com>
In-Reply-To: <CAMuHMdWMxEfVKkohmv6ZAUPKYdZiFK6YoE6Y_L40j7YU-OtY0A@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Sat, 22 Sep 2018 17:03:43 +0530
Message-ID: <CALxhOnjR2M1Xd_M4BkhD0qLiRvGVCBipQE77mDn0N8O7k6iwPA@mail.gmail.com>
Subject: Re: [PATCH 2/4] m68k: Replace NR_syscalls macro from asm/unistd.h
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, 20 Sep 2018 at 14:54, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On Thu, Sep 20, 2018 at 10:12 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On 18 September 2018 at 15:34, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Sep 18, 2018 at 9:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > >> On 9 August 2018 at 13:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> > One first comment below...
> > >> >
> > >> > On Thu, Aug 9, 2018 at 7:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > >> >> NR_syscalls macro holds the number of system call exist in m68k
> > >> >> architecture. This macro is currently the part of asm/unistd.h file.
> > >> >> We have to change the value of NR_syscalls, if we add or delete a
> > >> >> system call.
> > >> >>
> > >> >> One of patch in this patch series has a script which will generate
> > >> >> a uapi header based on syscall.tbl file. The syscall.tbl file
> > >> >> contains the number of system call information. So we have two
> > >> >> option to update NR_syscalls value.
> > >> >>
> > >> >> 1. Update NR_syscalls in asm/unistd.h manually by counting the
> > >> >>    no.of system calls. No need to update NR_syscalls untill
> > >> >>    we either add a new system call or delete an existing system
> > >> >>    call.
> > >> >>
> > >> >> 2. We can keep this feature it above mentioned script, that'll
> > >> >>    count the number of syscalls and keep it in a generated file.
> > >> >>    In this case we don't need to explicitly update NR_syscalls
> > >> >>    in asm/unistd.h file.
> > >> >>
> > >> >> The 2nd option will be the recommended one. For that, I moved the
> > >> >> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
> > >> >> name also changed form NR_syscalls to __NR_syscalls for making the
> > >> >> name convention same across all architecture. While __NR_syscalls
> > >> >> isn't strictly part of the uapi, having it as part of the generated
> > >> >> header to simplifies the implementation.
> > >> >
> > >> > It can indeed not be part of the UAPI, as UAPI definitions can never change,
> > >> > while new syscalls will be added in the future, increasing the number ;-)
> > >>
> > >> Thanks for your reply :)
> > >> Sorry for the delayed response :(
> > >>
> > >> I would like to keep __NR_syscalls macro to uapi header in order to simplify
> > >> the system call table generation script. Otherwise the __NR_syscalls
> > >> macro need to update manually. That become a problem.
> > >>
> > >> Please check the below implementation in uapi file make sense?
> > >> It is an easy workaround to leave __NR_syscalls macro in uapi/asm/unistd.h
> > >> and enclose it in #ifdef __KERNEL__
> > >>
> > >> ...
> > >> ...
> > >> #define __NR_pwritev2  378
> > >> #define __NR_statx      379
> > >>
> > >> #ifdef __KERNEL__
> > >> #define __NR_syscalls   380
> > >> #endif
> > >> ...
> > >> ...
> > >
> > > #ifdef __KERNEL__ sounds fine to me.
> >
> > I posted similar script for 10 different architectures. I got few good review
> > from the maintainers and it will be applicable for all the
> > architectures including
> > m68k. There are few area which I identified need to improve. This will take
> > couple of days.
> >
> > But it will be very helpful if you can perform the boot test on the
> > actual platform
> > and share the result.
>
> Builds and boots fine on ARAnyM (virtual Atari).

Thanks for the support :)

>
> So for the full series:
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> However, I noticed the following effective difference between the old
> arch/m68k/include/uapi/asm/unistd.h and the new generated
> arch/m68k/include/generated/uapi/asm/unistd_32.h:
>
> -/*#define __NR_break            17*/
> -/*#define __NR_stty             31*/
> -/*#define __NR_gtty             32*/
> -/*#define __NR_ftime            35*/
> -/*#define __NR_prof             44*/
> -/*#define __NR_lock             53*/
> -/*#define __NR_mpx              56*/
> -/*#define __NR_ulimit           58*/
> -/*#define __NR_oldolduname      59*/
> -/*#define __NR_profil           98*/
> -/*#define __NR_ioperm          101*/
> -/*#define __NR_olduname                109*/
> -/*#define __NR_iopl            110*/ /* not supported */
> -/*#define __NR_idle            112*/ /* Obsolete */
> -/*#define __NR_vm86            113*/ /* not supported */
> -/*#define __NR_afs_syscall     137*/ /* Syscall for Andrew File System */
> -/*#define __NR_vserver         278*/
> +#define __NR_break     17
> +#define __NR_stty      31
> +#define __NR_gtty      32
> +#define __NR_ftime     35
> +#define __NR_prof      44
> +#define __NR_lock      53
> +#define __NR_mpx       56
> +#define __NR_ulimit    58
> +#define __NR_oldolduname       59
> +#define __NR_profil    98
> +#define __NR_ioperm    101
> +#define __NR_olduname  109
> +#define __NR_iopl      110
> +#define __NR_idle      112
> +#define __NR_vm86      113
> +#define __NR_afs_syscall       137
> +#define __NR_vserver   278
>
> Given userspace code may contain checks for the presence of these
> defines, I think they should not be present.

My patch series had some different way to handle the above one. Some
how the plan got changed and missed it :(

I posted v2 patch series Thursday evening. This contain some modi-
fications suggested by different architecture maintainers including
you.

Please help us to review the patch series and please perform boot
test on the actual platform.

Thanks
Firoz

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
