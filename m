Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B2B20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B2B20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeLLMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:54:20 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35005 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeLLMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:54:20 -0500
Received: by mail-ua1-f68.google.com with SMTP id d2so6404329ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcTVrjv4NgMGmIe+Etq9yHJ+s3Tcd7QoaVhD9x40lp4=;
        b=dqdWJGA2ZSK1Cbe9+feoL9d7v5x5HtDLWDohUH30UxOusfBJ8cL92wORXzw+iWChAe
         n9t3pZyTBERXug4urRq9uSZji0k7Fhlh6cta5lED3CvRobNGp70hDbQn17+WKbnLQ/75
         +PZAT/+dGO2uGd3/BcNBOqy6RSAP8/f5SRqvuVWuzVANOV/oYBX0oKE4uwPGx3VNBjJz
         OKGgEfWqMzM3+3sY96Y1CmfM6BYHgydrue3I/gled6r9yJg0IPmq2wAngce/8RY47FRM
         +1K95XIlliy6/I7ImkE3+lnlwcFi+FlwrRrdd0RSwryeKaxc2PZLq5fVnvK9+e+dLA1b
         ZG8Q==
X-Gm-Message-State: AA+aEWbKbd5u0RpkH0KvmHIFxcEcyl02EA8ydQKB+TWXeng8AHWwM7T1
        pGkTa6tYdg5t9ATTxnLBUoPUbE2QilLjwdPniLQ=
X-Google-Smtp-Source: AFSGD/X7rkL4vk3K5qMwqDKd8/7mUKXEiPSO8SJ5erSQmq1lvn4CSIqddUyFilsTA2RqAA6IH8OfW6Ebo+080f/D1ts=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr9799281uap.0.1544619258682;
 Wed, 12 Dec 2018 04:54:18 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org> <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org> <20181212085516.GA13288@altlinux.org>
 <CAMuHMdXwX57AZuVPdcEt_HZw1LT7tFpczJsqjW6C0VgHkhJ7dw@mail.gmail.com>
 <20181212092712.GD13288@altlinux.org> <CAMuHMdVvw3_3rm3v8J8u6ic6Wy3o70mOP1qaWQ=Ltf1XU=nnVQ@mail.gmail.com>
 <20181212120417.GC15561@altlinux.org> <CAMuHMdXqJeH0C8FHy=G=ycArdkvjYPy48+3LmACnyS9RuqV30g@mail.gmail.com>
 <20181212123730.GA16479@altlinux.org>
In-Reply-To: <20181212123730.GA16479@altlinux.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Dec 2018 13:54:05 +0100
Message-ID: <CAMuHMdVJGpLYJp7CfvOYOmboRjFauWh1joqk=-kpLw212Oj7aA@mail.gmail.com>
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

On Wed, Dec 12, 2018 at 1:37 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Wed, Dec 12, 2018 at 01:27:14PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 12, 2018 at 1:04 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > On Wed, Dec 12, 2018 at 10:43:33AM +0100, Geert Uytterhoeven wrote:
> > > > On Wed, Dec 12, 2018 at 10:27 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > > On Wed, Dec 12, 2018 at 10:01:29AM +0100, Geert Uytterhoeven wrote:
> > > > > > On Wed, Dec 12, 2018 at 9:55 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > > > > On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin wrote:
> > > > > > > > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven wrote:
> > > > > > > > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > > > > > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrote:
> > > > > > > > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > > > > > > > > > syscall_get_* functions are required to be implemented on all
> > > > > > > > > > > > architectures in order to extend the generic ptrace API with
> > > > > > > > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > > > > > > > >
> > > > > > > > > > > > This introduces asm/syscall.h on m68k implementing all 5 syscall_get_*
> > > > > > > > > > > > functions as documented in asm-generic/syscall.h: syscall_get_nr,
> > > > > > > > > > > > syscall_get_arguments, syscall_get_error, syscall_get_return_value,
> > > > > > > > > > > > and syscall_get_arch.
> > > > > > > > > > > >
> > > > > > > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > > > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > > > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > > > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > Notes:
> > > > > > > > > > > >     v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
> > > > > > > > > > > >         and syscall_get_return_value
> > > > > > > > > > > >     v1: added syscall_get_arch
> > > > > > > > > > >
> > > > > > > > > > > > --- /dev/null
> > > > > > > > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > > > > > > > @@ -0,0 +1,39 @@
> > > > > > > > > > >
> > > > > > > > > > > > +static inline void
> > > > > > > > > > > > +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> > > > > > > > > > > > +                     unsigned int i, unsigned int n, unsigned long *args)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +       BUG_ON(i + n > 6);
> > > > > > > > > > >
> > > > > > > > > > > Does this have to crash the kernel?
> > > > > > > > > >
> > > > > > > > > > This is what most of other architectures do, but we could choose
> > > > > > > > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > > > > > > > >
> > > > > > > > > > > Perhaps you can return an error code instead?
> > > > > > > > > >
> > > > > > > > > > That would be problematic given the signature of this function
> > > > > > > > > > and the nature of the potential bug which would most likely be a usage error.
> > > > > > > > >
> > > > > > > > > Of course to handle that, the function's signature need to be changed.
> > > > > > > > > Changing it has the advantage that the error handling can be done at the
> > > > > > > > > caller, in common code, instead of duplicating it for all
> > > > > > > > > architectures, possibly
> > > > > > > > > leading to different semantics.
> > > > > > > >
> > > > > > > > Given that *all* current users of syscall_get_arguments specify i == 0
> > > > > > > > (and there is an architecture that has BUG_ON(i)),
> > > > > > > > it should be really a usage error to get into situation where i + n > 6,
> > > > > > > > I wish a BUILD_BUG_ON could be used here instead.
> > > > > > > >
> > > > > > > > I don't think it worths pushing the change of API just to convert
> > > > > > > > a "cannot happen" assertion into an error that would have to be dealt with
> > > > > > > > on the caller side.
> > > > > > >
> > > > > > > I suggest the following BUG_ON replacement for syscall_get_arguments:
> > > > > > >
> > > > > > > #define SYSCALL_MAX_ARGS 6
> > > > > > >
> > > > > > > static inline void
> > > > > > > syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> > > > > > >                       unsigned int i, unsigned int n, unsigned long *args)
> > > > > > > {
> > > > > > >         /*
> > > > > > >          * Ideally there should have been
> > > > > > >          * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
> > > > > > >          * instead of these checks.
> > > > > > >          */
> > > > > > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > > > > > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > > > > > >                 return;
> > > > > >
> > > > > > Does this have security implications, as args is an output parameter?
> > > > > > I.e. if you don't fill the array, the caller will use whatever is on the stack.
> > > > > > Can this ever be passed to userspace, leaking data?
> > > > >
> > > > > In the current kernel code n is always less or equal to 6,
> > > > > but in theory future changes can potentially break the assertion
> > > > > and this could lead to leaking data to userspace.
> > > >
> > > > OK.
> > > >
> > > > > Do you think we should rather be defensive and add some memsets, e.g.
> > > > >
> > > > >         if (unlikely(i > SYSCALL_MAX_ARGS)) {
> > > > >                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
> > > > >                 memset(args, 0, n * sizeof(args[0]));
> > > > >                 return;
> > > > >         }
> > > > >         if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
> > > > >                 unsigned int extra = n - (SYSCALL_MAX_ARGS - i);
> > > > >
> > > > >                 WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
> > > > >                 n = SYSCALL_MAX_ARGS - i;
> > > > >                 memset(&args[n], 0, extra * sizeof(args[0]));
> > > > >         }
> > > > > ?
> > > >
> > > > Yes please.
> > > >
> > > > But please handle all of that in the generic code, so it doesn't have to be
> > > > replicated across all architectures.
> > > >
> > > > E.g. make syscall_get_arguments() a wrapper in generic code, calling
> > > > __syscall_get_arguments() in architecture-specific code.
> > > >
> > > > And make the latter return int, so it can indicate other failures.
> > >
> > > Other failures?  What syscall_get_arguments is expected to do
> > > if __syscall_get_arguments returned, say, -1?
> >
> > Fail. Just like in case of other generic ill conditions it can detect itself.
>
> Sorry, I don't quite follow.  syscall_get_arguments() has no return code,

Which may be an indicator for a different problem.
What is e.g. populate_seccomp_data() supposed to do if
syscall_get_arguments() fails?

> so all it can possibly do is to zero out args[], e.g.
>
>         if (unlikely(__syscall_get_arguments(task, regs, i, n, args) < 0)) {
>                 memset(args, 0, n * sizeof(args[0]));
>                 return;
>         }
>
> Do you mean this?

Exactly.
And alternatively do the BUG() thing there.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
