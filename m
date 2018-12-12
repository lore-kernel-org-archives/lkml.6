Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C778C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B142084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B142084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeLLJns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:43:48 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45647 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbeLLJns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:43:48 -0500
Received: by mail-vk1-f195.google.com with SMTP id n126so4060737vke.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdLHCAfRE+sBCvf6vaPC8sAhl9WaqSS5fAni2sVkOYM=;
        b=frSES10eEKr/GXu7xLmiVd5vI4+dEtHEZiOW2VRQSBl/+xVgHkpcyg/rOGz4jJAEHC
         TTvT97nG/6/NeNC6xm9Uv4rNJT+FVD8uRVIT6Z9yRAYDJfosHt62txGt6WjhpbkTIhtW
         UwKMmghqhaonX3cImzRlBAeGwKKPulYH6rrInFzgflQBToDUGenvDdPD1YWkUugIJnhI
         iUE8dQnMd20eUrxitcqjPojE8P2XvEgumuXeI1KVagXYYAM1yjVQijBUsIKCl3UT/HHq
         bYjQ05CM2kzZJpWwMHFnmEppzafTn6frazwPe2yPD3GoijXrgBPHBTCxGJ+JxjexqSac
         HNjA==
X-Gm-Message-State: AA+aEWbSzCCPR9gf80XR9T0SwdoklU74rFHzkWxaI+X3q2Ds4c0+a/hs
        pINUUaDKXm3BCFRT0g9kK4rM30UWteDPUrv37xk=
X-Google-Smtp-Source: AFSGD/X8BaH7lXw0EhQHt2TQ4veBmGn3fNAEg7Wq9M4Sirq6zDOMYnwn3SZ0mAiGZpR4Yzd11X7B4D3JuNfTajMJ5a4=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr8930719vkd.74.1544607826192;
 Wed, 12 Dec 2018 01:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20181210042352.GA6092@altlinux.org> <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org> <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org> <20181212085516.GA13288@altlinux.org>
 <CAMuHMdXwX57AZuVPdcEt_HZw1LT7tFpczJsqjW6C0VgHkhJ7dw@mail.gmail.com> <20181212092712.GD13288@altlinux.org>
In-Reply-To: <20181212092712.GD13288@altlinux.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Dec 2018 10:43:33 +0100
Message-ID: <CAMuHMdVvw3_3rm3v8J8u6ic6Wy3o70mOP1qaWQ=Ltf1XU=nnVQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/25] m68k: add asm/syscall.h
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Dec 12, 2018 at 10:27 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Wed, Dec 12, 2018 at 10:01:29AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 12, 2018 at 9:55 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin wrote:
> > > > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven wrote:
> > > > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrote:
> > > > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > > > > > syscall_get_* functions are required to be implemented on all
> > > > > > > > architectures in order to extend the generic ptrace API with
> > > > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > > > >
> > > > > > > > This introduces asm/syscall.h on m68k implementing all 5 syscall_get_*
> > > > > > > > functions as documented in asm-generic/syscall.h: syscall_get_nr,
> > > > > > > > syscall_get_arguments, syscall_get_error, syscall_get_return_value,
> > > > > > > > and syscall_get_arch.
> > > > > > > >
> > > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Notes:
> > > > > > > >     v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
> > > > > > > >         and syscall_get_return_value
> > > > > > > >     v1: added syscall_get_arch
> > > > > > >
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > > > @@ -0,0 +1,39 @@
> > > > > > >
> > > > > > > > +static inline void
> > > > > > > > +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> > > > > > > > +                     unsigned int i, unsigned int n, unsigned long *args)
> > > > > > > > +{
> > > > > > > > +       BUG_ON(i + n > 6);
> > > > > > >
> > > > > > > Does this have to crash the kernel?
> > > > > >
> > > > > > This is what most of other architectures do, but we could choose
> > > > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > > > >
> > > > > > > Perhaps you can return an error code instead?
> > > > > >
> > > > > > That would be problematic given the signature of this function
> > > > > > and the nature of the potential bug which would most likely be a usage error.
> > > > >
> > > > > Of course to handle that, the function's signature need to be changed.
> > > > > Changing it has the advantage that the error handling can be done at the
> > > > > caller, in common code, instead of duplicating it for all
> > > > > architectures, possibly
> > > > > leading to different semantics.
> > > >
> > > > Given that *all* current users of syscall_get_arguments specify i == 0
> > > > (and there is an architecture that has BUG_ON(i)),
> > > > it should be really a usage error to get into situation where i + n > 6,
> > > > I wish a BUILD_BUG_ON could be used here instead.
> > > >
> > > > I don't think it worths pushing the change of API just to convert
> > > > a "cannot happen" assertion into an error that would have to be dealt with
> > > > on the caller side.
> > >
> > > I suggest the following BUG_ON replacement for syscall_get_arguments:
> > >
> > > #define SYSCALL_MAX_ARGS 6
> > >
> > > static inline void
> > > syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> > >                       unsigned int i, unsigned int n, unsigned long *args)
> > > {
> > >         /*
> > >          * Ideally there should have been
> > >          * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
> > >          * instead of these checks.
> > >          */
> > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > >                 return;
> >
> > Does this have security implications, as args is an output parameter?
> > I.e. if you don't fill the array, the caller will use whatever is on the stack.
> > Can this ever be passed to userspace, leaking data?
>
> In the current kernel code n is always less or equal to 6,
> but in theory future changes can potentially break the assertion
> and this could lead to leaking data to userspace.

OK.

> Do you think we should rather be defensive and add some memsets, e.g.
>
>         if (unlikely(i > SYSCALL_MAX_ARGS)) {
>                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
>                 memset(args, 0, n * sizeof(args[0]));
>                 return;
>         }
>         if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
>                 unsigned int extra = n - (SYSCALL_MAX_ARGS - i);
>
>                 WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
>                 n = SYSCALL_MAX_ARGS - i;
>                 memset(&args[n], 0, extra * sizeof(args[0]));
>         }
> ?

Yes please.

But please handle all of that in the generic code, so it doesn't have to be
replicated across all architectures.

E.g. make syscall_get_arguments() a wrapper in generic code, calling
__syscall_get_arguments() in architecture-specific code.

And make the latter return int, so it can indicate other failures.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
