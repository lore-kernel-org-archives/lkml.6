Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF46BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC4A2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFcj0djA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbfBOOer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:34:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52467 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfBOOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:34:46 -0500
Received: by mail-it1-f196.google.com with SMTP id r11so24500340itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 06:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojihXwYJZXpueZiM1yAaMkX88J1QXCnqKd3YiH6Zt2k=;
        b=RFcj0djAEfAfndouItnBtiHQcA1dN4Bsdwjt+GPvXcp0EfV16VSmVUOhiLJ5djfJvF
         mnOIfyvFYdk6gdLhV22bNR9AILesB6BetNQPbXNfg2zR6h/BeXQ3piJGPahfCFX5/9nb
         gD9Pchbg3NXYATK36PvMhgnUxpUSQd7B/VuOr5zj9QLMmZtX8feDNOkavBF3a3Ie1Fez
         3DZXh8U41DaWfqdO5B2tll7WugP9QcIuKpiHVHMEMJfL9O3OWzCaX4NCi1g4EQBTK6Th
         QVNt7xW+abdAJk5Yw8y/Ix5aIjmby0tKCyGsLAwH0DJ4a11WHptaZaiTR5VVMkQoCeNF
         SQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojihXwYJZXpueZiM1yAaMkX88J1QXCnqKd3YiH6Zt2k=;
        b=I/8Cxcz5CwyZFuBq6TfH1Msb6+eE9aGoPrtgsOg/vw0TmHY4db6Gct4fqYOHx41Ihg
         li89xo3tMvOi+gPchZzFyevFaf11nLDxfJxkKW9fOnyoJSFjeU5uUdGB2CQs5C8GKfgb
         beKTp/wLNdFwmTd5AY3dxnIN5uo+vDnSJ/CSKgXmTPxtsHpZhJ2GiGTOEp5ua3xmJ1PD
         15KYZe56eGryx+eAIDmT7aIh+pzOprUo42vluKVWDULn3f1pNAIL6rdofHxqwx/SAPWn
         Gl5OzOF3gWcnrHgdvWCkIA1rMtGk/S8/9q+FXEHh6teI+zWDlQSHI7A5tIJToAq3UK9l
         l+jA==
X-Gm-Message-State: AHQUAubj+5uF54lrcpZxqaXAAw2aeXzzHFEYFVzdhU8h7pN/xBEVk+sh
        FhYijNBzppVu7x68v/kmxtu4mgSAo1Jet4yWPzXwjrg=
X-Google-Smtp-Source: AHgI3IZX7unmXPPynnlAgBjT/+QOx8cWc93xL81cnkXDLfw5dwo3J4DGawrMlTaIW/zu9QPFpeKPelbKZl4OxU2LicQ=
X-Received: by 2002:a24:d04:: with SMTP id 4mr4823672itx.19.1550241285756;
 Fri, 15 Feb 2019 06:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20190213140025.GB6346@brain-police> <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com> <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net> <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190214193432.GR32477@hirez.programming.kicks-ass.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 15 Feb 2019 09:34:33 -0500
Message-ID: <CAMzpN2g54zWYOAzmJdUm+1ziivkciLEeSDp4+b89KHkO4Lem+A@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, valentin.schneider@arm.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 2:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 14, 2019 at 11:18:01AM -0500, Brian Gerst wrote:
>
> > > --- a/arch/x86/include/asm/switch_to.h
> > > +++ b/arch/x86/include/asm/switch_to.h
> > > @@ -40,6 +40,7 @@ asmlinkage void ret_from_fork(void);
> > >   * order of the fields must match the code in __switch_to_asm().
> > >   */
> > >  struct inactive_task_frame {
> > > +       unsigned long flags;
> > >  #ifdef CONFIG_X86_64
> > >         unsigned long r15;
> > >         unsigned long r14;
> >
> > flags should be initialized in copy_thread_tls().  I think the new
> > stack is zeroed already, but it would be better to explicitly set it.
>
> Ah indeed. I somehow misread that code and thought we got initialized
> with a copy of current.
>
> Something like the below, right?
>
> ---
>
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -127,6 +127,7 @@ int copy_thread_tls(unsigned long clone_
>         struct task_struct *tsk;
>         int err;
>
> +       frame->flags = 0;
>         frame->bp = 0;
>         frame->ret_addr = (unsigned long) ret_from_fork;
>         p->thread.sp = (unsigned long) fork_frame;
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -392,6 +392,7 @@ int copy_thread_tls(unsigned long clone_
>         childregs = task_pt_regs(p);
>         fork_frame = container_of(childregs, struct fork_frame, regs);
>         frame = &fork_frame->frame;
> +       frame->flags = 0;
>         frame->bp = 0;
>         frame->ret_addr = (unsigned long) ret_from_fork;
>         p->thread.sp = (unsigned long) fork_frame;

Yes, this looks good.

--
Brian Gerst
