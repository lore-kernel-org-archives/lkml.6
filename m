Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB86C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01FD2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01FD2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeLLJBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:01:43 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37385 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLLJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:01:43 -0500
Received: by mail-vs1-f65.google.com with SMTP id h18so10620859vsj.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOYAOA9H6eL4r+eT2Ntk0iqQdDumVJ4hBjMzIrEQBEg=;
        b=q4/JRnEC+dJFJEyXKqTDUBQaj5LDqiD/aSTbREFiD9R43nA3Zk/Hrqiqr9hFrDVZu/
         lE6zlkkNhTZltaWo5yZ/1zPDKG8/X9GHoJqFGxWy7/ozfiP/MWxNuIcZCIa3oeoljBL/
         jMQ5u+g6e5VNJO/PPdQy6fDhZZiaRaRMrOqYsPxmsKuEpVrobUnG6qyny4SMv7keXKX/
         /KLKeBStEKtoLpvDjYAdkgQptrGjH8TtLMmEkRQC1V0Hc6Mv2/b7xn54Bdza/XtHysPM
         5tL7g/sBquFsUH1h6DMlqlNmFLSlHIN7Cqq8MqQ7pz9xDa3NrjXKc9sUOq9iRzj2/1/Y
         x9iA==
X-Gm-Message-State: AA+aEWaUbDzYA1GXjilqqhOwTESjqxabazLWs5KwZYr4pKRp5wTEPLr8
        aMFdgG/lfwIZxGvJXCM6h6f5Qq/bept14igyBfGw7A==
X-Google-Smtp-Source: AFSGD/VCe/qkAt0AY2AejfrOt4VSrvXedQV5Kpe38p1HwLUyBG/aXvc1cD7icr/qKpAo2ZjKu3MJB16urGXDG9kX4Nc=
X-Received: by 2002:a67:d119:: with SMTP id u25mr8347080vsi.63.1544605301610;
 Wed, 12 Dec 2018 01:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20181210042352.GA6092@altlinux.org> <20181210043010.GM6131@altlinux.org>
 <CAMuHMdVYq_2P=gb_zbSGFkPWASTds6uSPTyyhyNAgp2Qm5+feQ@mail.gmail.com>
 <20181210124059.GA11942@altlinux.org> <CAMuHMdW8ejp4gm2Xh-8inSQngQ5zRQ9bfsg1SG+BAD8RFV8xcA@mail.gmail.com>
 <20181210133025.GG11942@altlinux.org> <20181212085516.GA13288@altlinux.org>
In-Reply-To: <20181212085516.GA13288@altlinux.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Dec 2018 10:01:29 +0100
Message-ID: <CAMuHMdXwX57AZuVPdcEt_HZw1LT7tFpczJsqjW6C0VgHkhJ7dw@mail.gmail.com>
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

On Wed, Dec 12, 2018 at 9:55 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Mon, Dec 10, 2018 at 04:30:25PM +0300, Dmitry V. Levin wrote:
> > On Mon, Dec 10, 2018 at 02:06:28PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Dec 10, 2018 at 1:41 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > On Mon, Dec 10, 2018 at 09:45:42AM +0100, Geert Uytterhoeven wrote:
> > > > > On Mon, Dec 10, 2018 at 5:30 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > > > > > syscall_get_* functions are required to be implemented on all
> > > > > > architectures in order to extend the generic ptrace API with
> > > > > > PTRACE_GET_SYSCALL_INFO request.
> > > > > >
> > > > > > This introduces asm/syscall.h on m68k implementing all 5 syscall_get_*
> > > > > > functions as documented in asm-generic/syscall.h: syscall_get_nr,
> > > > > > syscall_get_arguments, syscall_get_error, syscall_get_return_value,
> > > > > > and syscall_get_arch.
> > > > > >
> > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > > > > > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > > > > > Cc: linux-m68k@lists.linux-m68k.org
> > > > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > > > ---
> > > > > >
> > > > > > Notes:
> > > > > >     v5: added syscall_get_nr, syscall_get_arguments, syscall_get_error,
> > > > > >         and syscall_get_return_value
> > > > > >     v1: added syscall_get_arch
> > > > >
> > > > > > --- /dev/null
> > > > > > +++ b/arch/m68k/include/asm/syscall.h
> > > > > > @@ -0,0 +1,39 @@
> > > > >
> > > > > > +static inline void
> > > > > > +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> > > > > > +                     unsigned int i, unsigned int n, unsigned long *args)
> > > > > > +{
> > > > > > +       BUG_ON(i + n > 6);
> > > > >
> > > > > Does this have to crash the kernel?
> > > >
> > > > This is what most of other architectures do, but we could choose
> > > > a softer approach, e.g. use WARN_ON_ONCE instead.
> > > >
> > > > > Perhaps you can return an error code instead?
> > > >
> > > > That would be problematic given the signature of this function
> > > > and the nature of the potential bug which would most likely be a usage error.
> > >
> > > Of course to handle that, the function's signature need to be changed.
> > > Changing it has the advantage that the error handling can be done at the
> > > caller, in common code, instead of duplicating it for all
> > > architectures, possibly
> > > leading to different semantics.
> >
> > Given that *all* current users of syscall_get_arguments specify i == 0
> > (and there is an architecture that has BUG_ON(i)),
> > it should be really a usage error to get into situation where i + n > 6,
> > I wish a BUILD_BUG_ON could be used here instead.
> >
> > I don't think it worths pushing the change of API just to convert
> > a "cannot happen" assertion into an error that would have to be dealt with
> > on the caller side.
>
> I suggest the following BUG_ON replacement for syscall_get_arguments:
>
> #define SYSCALL_MAX_ARGS 6
>
> static inline void
> syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
>                       unsigned int i, unsigned int n, unsigned long *args)
> {
>         /*
>          * Ideally there should have been
>          * BUILD_BUG_ON(i + n > SYSCALL_MAX_ARGS);
>          * instead of these checks.
>          */
>         if (unlikely(i > SYSCALL_MAX_ARGS)) {
>                 WARN_ONCE(1, "i > SYSCALL_MAX_ARGS");
>                 return;

Does this have security implications, as args is an output parameter?
I.e. if you don't fill the array, the caller will use whatever is on the stack.
Can this ever be passed to userspace, leaking data?

>         }
>         if (unlikely(n > SYSCALL_MAX_ARGS - i)) {
>                 WARN_ONCE(1, "i + n > SYSCALL_MAX_ARGS");
>                 n = SYSCALL_MAX_ARGS - i;
>         }
>         BUILD_BUG_ON(sizeof(regs->d1) != sizeof(args[0]));
>         memcpy(args, &regs->d1 + i, n * sizeof(args[0]));
> }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
