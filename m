Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F255C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2597120878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK6acA+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2597120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLFROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:14:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33973 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFROF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:14:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so1123721otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edg5vVlFXGfLGKF6ea0U9cQt+wxSKOvI8w0tmoAHM1g=;
        b=XK6acA+c97r6t2PkvrDoiP6rlFEF+Inn3e1uwpmWSKrEPJkLi3VJLJst+oJdwnKp7V
         YfsPWhfn8g6E5cGiXPi7YSEVJLr+ADjPrpGX0FHNpz1PeGj4B97KUWfQF/tskzI9TZJX
         +gcnTu+iIBmhVzKlGbuf9GFvIuTMndiCZD9XJnsZwSgNNqc3HUCiGL544hkoGdjI4Z6w
         RdBEX76mYiAsoAqqaqzX47UgaWZP+xo5AbGT+ADrK977KnP2fOIP0MD+Nik0umjU6NKf
         +c5bAc+B7qFmM+4IJeBJFIhrD8KlzprjMVUx1JZeDgs7dB1JgDnhJiI2kVfWovz6Ay5a
         VB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edg5vVlFXGfLGKF6ea0U9cQt+wxSKOvI8w0tmoAHM1g=;
        b=a5acqYZxnOlE99cDAKEDHpVzUGsRTcKEdcjhMU9U/0CecYstXHW48Q/I74mp2Dnxn9
         XuHSFQl51tvuaSamNEBfjR2OamUyH/I7RWnvc/NiW9ZyFcnfkYyYgSwIYOIC1IszqQJl
         Vzy+aBtpVVYFNYf4E5b4tfqh5gREhGO4TifOz0sveWB09AomzgK72gHOvyHxYpBZhGcR
         XELqQlmIt4Xz9HN5EWXFNDp7xcUMG9+1L4DaAEa2dSNU9CcWQW7kvuQyU9RS+hhXarTU
         7xnN0iZus6g7MJ/xOajYYHcx+ofJo95aRFOvxYluOew7Gpr4dOt8qhdxXuL7ynwpsxx1
         9ZpA==
X-Gm-Message-State: AA+aEWaNg3U9x91InteMY8QXcUUT9w0FR6pVZldgJDhldvQVDAhrMuOX
        xSZDSxPMK+MsWgzKLFsO+rbhQc27faYkZEiIC50=
X-Google-Smtp-Source: AFSGD/VGUYmVQLkXlFeZqsAwdBNVLQqh5v+cf1iRm0axt823IUKHD+7FP9De8x1GjUCcTsi1L52BHmhgh9DfHSfgYec=
X-Received: by 2002:a9d:8e4:: with SMTP id 91mr17941339otf.169.1544116444375;
 Thu, 06 Dec 2018 09:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20181206150156.28210-1-david.abdurachmanov@gmail.com>
 <20181206150156.28210-3-david.abdurachmanov@gmail.com> <CAGXu5jJT4wY9wgCF8gB+tjgH+YQps4eUDVwZoGY=GVmLMpLPxw@mail.gmail.com>
In-Reply-To: <CAGXu5jJT4wY9wgCF8gB+tjgH+YQps4eUDVwZoGY=GVmLMpLPxw@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Thu, 6 Dec 2018 18:13:52 +0100
Message-ID: <CAEn-LTqOvegggVV8tWO5WUBQ5=8s0Li5xFBwokENQBf6_RLuAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: fix syscall_{get,set}_arguments
To:     Kees Cook <keescook@chromium.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        luto@amacapital.net, Will Drewry <wad@chromium.org>,
        Green Hu <green.hu@gmail.com>, deanbo422@gmail.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 5:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Dec 6, 2018 at 7:02 AM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
> >
> > Testing with libseccomp master branch revealed that testcases with
> > filters on syscall arguments were failing due to wrong values. Seccomp
> > uses syscall_get_argumentsi() to copy syscall arguments, and there is a
> > bug in pointer arithmetics in memcpy() call.
> >
> > Two alternative implementation were tested: the one in this patch and
> > another one based on while-break loop. Both delivered the same results.
> >
> > This implementation is also used in arm, arm64 and nds32 arches.
>
> Minor nit: can you make this the first patch? That way seccomp works
> correctly from the point of introduction. :)

Ok. I will do it.

david

>
> -Kees
>
> >
> > Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> > ---
> >  arch/riscv/include/asm/syscall.h | 42 ++++++++++++++++++++++++--------
> >  1 file changed, 32 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
> > index bba3da6ef157..26ceb434a433 100644
> > --- a/arch/riscv/include/asm/syscall.h
> > +++ b/arch/riscv/include/asm/syscall.h
> > @@ -70,19 +70,32 @@ static inline void syscall_set_return_value(struct task_struct *task,
> >         regs->a0 = (long) error ?: val;
> >  }
> >
> > +#define SYSCALL_MAX_ARGS 6
> > +
> >  static inline void syscall_get_arguments(struct task_struct *task,
> >                                          struct pt_regs *regs,
> >                                          unsigned int i, unsigned int n,
> >                                          unsigned long *args)
> >  {
> > -       BUG_ON(i + n > 6);
> > +       if (n == 0)
> > +               return;
> > +
> > +       if (i + n > SYSCALL_MAX_ARGS) {
> > +               unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
> > +               unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
> > +               pr_warning("%s called with max args %d, handling only %d\n",
> > +                       __func__, i + n, SYSCALL_MAX_ARGS);
> > +               memset(args_bad, 0, n_bad * sizeof(args[0]));
> > +       }
> > +
> >         if (i == 0) {
> >                 args[0] = regs->orig_a0;
> >                 args++;
> >                 i++;
> >                 n--;
> >         }
> > -       memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
> > +
> > +       memcpy(args, &regs->a0 + i, n * sizeof(args[0]));
> >  }
> >
> >  static inline void syscall_set_arguments(struct task_struct *task,
> > @@ -90,14 +103,23 @@ static inline void syscall_set_arguments(struct task_struct *task,
> >                                          unsigned int i, unsigned int n,
> >                                          const unsigned long *args)
> >  {
> > -       BUG_ON(i + n > 6);
> > -        if (i == 0) {
> > -                regs->orig_a0 = args[0];
> > -                args++;
> > -                i++;
> > -                n--;
> > -        }
> > -       memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
> > +       if (n == 0)
> > +               return;
> > +
> > +       if (i + n > SYSCALL_MAX_ARGS) {
> > +               pr_warning("%s called with max args %d, handling only %d\n",
> > +                       __func__, i + n, SYSCALL_MAX_ARGS);
> > +               n = SYSCALL_MAX_ARGS - i;
> > +       }
> > +
> > +       if (i == 0) {
> > +               regs->orig_a0 = args[0];
> > +               args++;
> > +               i++;
> > +               n--;
> > +       }
> > +
> > +       memcpy(&regs->a0 + i, args, n * sizeof(args[0]));
> >  }
> >
> >  static inline int syscall_get_arch(void)
> > --
> > 2.19.2
> >
>
>
> --
> Kees Cook
