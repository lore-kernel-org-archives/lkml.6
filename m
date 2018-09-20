Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA7CECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA18921525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA18921525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeITPH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:07:29 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37844 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeITPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:07:28 -0400
Received: by mail-ua1-f65.google.com with SMTP id y10-v6so4205854uao.4;
        Thu, 20 Sep 2018 02:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahIXtgAN0+/9cIv49MGD/59SWZIyZq4dbp7h1UzbCXM=;
        b=hSjABS+Km1KSd3CWxlpdWTCdTe+ciShU7iwBTwKelp9ok3ycas1RZNcyeLpDp831Hi
         sQyLQnw38SgY9z3ZA6Qv90JOo7XO+1f/7URHn026O/5aDlcNSTSI86BDsmUPuGegIVO+
         ombQ+k0PmUlgXIxvX1Qh0rwEFNV7ucr3CLTXHGsodLGC8k8UoNE8nX5cHcLBnGJfpveL
         PGYsFJQQgJCLx4UMtSZciz5Fpz1MPaHzsAdQxd4jE2tXhN8GJbWFsY3yv8NbhQ6SOFCZ
         p5T2nCKxITlt+1pYmg1y7flSvlNyIdW2kfOYRuAOHYkaRN1vJhVNwezKb81A65C42diG
         u66g==
X-Gm-Message-State: APzg51BXn8Uv9569I5/7FRht8TcmkdHALfs+bGrZXUAZ8UHCUmSGjsO7
        vG8TWJQw/wHFVHQx5sAV+1c94cdmuNDxG7Jb5IU=
X-Google-Smtp-Source: ANB0VdZUp+fXo/AfULu/LPu581CTSrCasWP4ftmuTiQrWznEC+eRgoJz4R3aRdQbpany206TIQRxEOflpdQgtB5xBs8=
X-Received: by 2002:ab0:60ae:: with SMTP id f14-v6mr11288313uam.153.1537435495639;
 Thu, 20 Sep 2018 02:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
 <1533791723-3882-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
 <CALxhOnheD75br1X_A7h5cNYWdjrDn4ciPc++mYd-_oZJApJyZg@mail.gmail.com>
 <CAMuHMdUcg-73DNNGuG3Kn9oQ9R+LpYxpWYV_1tmzN-EzBFUXVQ@mail.gmail.com> <CALxhOnjLKU8BCHFoc35P_tTh=6+NRbCrO6oB3Gar=uBMqYU4iw@mail.gmail.com>
In-Reply-To: <CALxhOnjLKU8BCHFoc35P_tTh=6+NRbCrO6oB3Gar=uBMqYU4iw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Sep 2018 11:24:44 +0200
Message-ID: <CAMuHMdWMxEfVKkohmv6ZAUPKYdZiFK6YoE6Y_L40j7YU-OtY0A@mail.gmail.com>
Subject: Re: [PATCH 2/4] m68k: Replace NR_syscalls macro from asm/unistd.h
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Thu, Sep 20, 2018 at 10:12 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On 18 September 2018 at 15:34, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Sep 18, 2018 at 9:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >> On 9 August 2018 at 13:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> > One first comment below...
> >> >
> >> > On Thu, Aug 9, 2018 at 7:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >> >> NR_syscalls macro holds the number of system call exist in m68k
> >> >> architecture. This macro is currently the part of asm/unistd.h file.
> >> >> We have to change the value of NR_syscalls, if we add or delete a
> >> >> system call.
> >> >>
> >> >> One of patch in this patch series has a script which will generate
> >> >> a uapi header based on syscall.tbl file. The syscall.tbl file
> >> >> contains the number of system call information. So we have two
> >> >> option to update NR_syscalls value.
> >> >>
> >> >> 1. Update NR_syscalls in asm/unistd.h manually by counting the
> >> >>    no.of system calls. No need to update NR_syscalls untill
> >> >>    we either add a new system call or delete an existing system
> >> >>    call.
> >> >>
> >> >> 2. We can keep this feature it above mentioned script, that'll
> >> >>    count the number of syscalls and keep it in a generated file.
> >> >>    In this case we don't need to explicitly update NR_syscalls
> >> >>    in asm/unistd.h file.
> >> >>
> >> >> The 2nd option will be the recommended one. For that, I moved the
> >> >> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
> >> >> name also changed form NR_syscalls to __NR_syscalls for making the
> >> >> name convention same across all architecture. While __NR_syscalls
> >> >> isn't strictly part of the uapi, having it as part of the generated
> >> >> header to simplifies the implementation.
> >> >
> >> > It can indeed not be part of the UAPI, as UAPI definitions can never change,
> >> > while new syscalls will be added in the future, increasing the number ;-)
> >>
> >> Thanks for your reply :)
> >> Sorry for the delayed response :(
> >>
> >> I would like to keep __NR_syscalls macro to uapi header in order to simplify
> >> the system call table generation script. Otherwise the __NR_syscalls
> >> macro need to update manually. That become a problem.
> >>
> >> Please check the below implementation in uapi file make sense?
> >> It is an easy workaround to leave __NR_syscalls macro in uapi/asm/unistd.h
> >> and enclose it in #ifdef __KERNEL__
> >>
> >> ...
> >> ...
> >> #define __NR_pwritev2  378
> >> #define __NR_statx      379
> >>
> >> #ifdef __KERNEL__
> >> #define __NR_syscalls   380
> >> #endif
> >> ...
> >> ...
> >
> > #ifdef __KERNEL__ sounds fine to me.
>
> I posted similar script for 10 different architectures. I got few good review
> from the maintainers and it will be applicable for all the
> architectures including
> m68k. There are few area which I identified need to improve. This will take
> couple of days.
>
> But it will be very helpful if you can perform the boot test on the
> actual platform
> and share the result.

Builds and boots fine on ARAnyM (virtual Atari).

So for the full series:
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

However, I noticed the following effective difference between the old
arch/m68k/include/uapi/asm/unistd.h and the new generated
arch/m68k/include/generated/uapi/asm/unistd_32.h:

-/*#define __NR_break            17*/
-/*#define __NR_stty             31*/
-/*#define __NR_gtty             32*/
-/*#define __NR_ftime            35*/
-/*#define __NR_prof             44*/
-/*#define __NR_lock             53*/
-/*#define __NR_mpx              56*/
-/*#define __NR_ulimit           58*/
-/*#define __NR_oldolduname      59*/
-/*#define __NR_profil           98*/
-/*#define __NR_ioperm          101*/
-/*#define __NR_olduname                109*/
-/*#define __NR_iopl            110*/ /* not supported */
-/*#define __NR_idle            112*/ /* Obsolete */
-/*#define __NR_vm86            113*/ /* not supported */
-/*#define __NR_afs_syscall     137*/ /* Syscall for Andrew File System */
-/*#define __NR_vserver         278*/
+#define __NR_break     17
+#define __NR_stty      31
+#define __NR_gtty      32
+#define __NR_ftime     35
+#define __NR_prof      44
+#define __NR_lock      53
+#define __NR_mpx       56
+#define __NR_ulimit    58
+#define __NR_oldolduname       59
+#define __NR_profil    98
+#define __NR_ioperm    101
+#define __NR_olduname  109
+#define __NR_iopl      110
+#define __NR_idle      112
+#define __NR_vm86      113
+#define __NR_afs_syscall       137
+#define __NR_vserver   278

Given userspace code may contain checks for the presence of these
defines, I think they should not be present.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
