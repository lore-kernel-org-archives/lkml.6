Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF5DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76982081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nvxgtcY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfBEOtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:49:20 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45941 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:49:19 -0500
Received: by mail-vs1-f65.google.com with SMTP id x28so2268938vsh.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUQnfBDz1iv78tTgPJq+6P41NKz+ysREoyiFsinO41s=;
        b=nvxgtcY6FX2LCVjOrWBL1a03XwWq/JJpl4Lc8ZyPU9YM2+UsT6oG9mq8Fyk0xhP5hI
         yu/A1hIX11rMqtLoeUPG2zCbYHGcCHpE3RWabqR02s3KkrY0EHMz5ZOgbcKqmaKFEkHj
         5S3KgUKHQfucpkGDPHjj8NzlWcly+rbOUQG0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUQnfBDz1iv78tTgPJq+6P41NKz+ysREoyiFsinO41s=;
        b=m6ak1ipi0EvKSG55sMpWTT7ng2kQjfaZHPsJoBM+pzcW/j0StOxe6rrjWlhJuQ/Pa/
         3Hk7lOH/KfxwaLoeo0z3csf4OGgqWaHpPrlfOV0Y2xDd7Y5TbWbkJq0CnXQENFunHdmn
         3gwDgGwSr/hBAiui4RtX6geyf//ErOEQY2loOVAjL2XcjwPVym8xBAiicsj9liMJL7zg
         0FRXveVbdem5/2oIoP/+2PDdEbjHmbGuEeivZdc92PA5wjFFOhx1cVUj4flgCmwj2jlE
         yd60Mba0E5oq1Creml5IrGPuy/hjSPRoNUw+yhAU85ulDMHc8zXiF/BRatMgo3RBj5Wm
         0yGA==
X-Gm-Message-State: AHQUAubpx/cuQNyT7KcGUAPYRB8/14el2og8LU+q8h6zY+oKfsFfYOFA
        IWGn7ajJMoYPlr33s8APfLlFFx4d+lg=
X-Google-Smtp-Source: AHgI3IaNMk6Wx+cveEcS5PEpPVVWqpS3i258X+ug2IWyInQROsqLVn+lW27ebjBm832jg0cpy7rqUw==
X-Received: by 2002:a67:9853:: with SMTP id a80mr2299290vse.157.1549378158305;
        Tue, 05 Feb 2019 06:49:18 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id y195sm24849244vkd.0.2019.02.05.06.49.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 06:49:15 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id u19so1189948uae.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:49:14 -0800 (PST)
X-Received: by 2002:ab0:645:: with SMTP id f63mr1952663uaf.106.1549378154378;
 Tue, 05 Feb 2019 06:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20190203074939.7261-1-jackoalan@gmail.com> <20190203083933.ee4a6j4mdecesbn2@brauner.io>
 <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
 <87r2cn7y9g.fsf@xmission.com> <CAHk-=wjFUCjvFzTGNt2hNO-Q5TaQHYSD_5NDDiS+zxwf3qQPwQ@mail.gmail.com>
 <8736p24trv.fsf@xmission.com> <87ftt22ud1.fsf_-_@xmission.com>
In-Reply-To: <87ftt22ud1.fsf_-_@xmission.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 5 Feb 2019 14:49:02 +0000
X-Gmail-Original-Message-ID: <CAGXu5j+N24SU1FGdqZA8De+MKaEeJuB5kQmSpXsSN0FSXXR_9g@mail.gmail.com>
Message-ID: <CAGXu5j+N24SU1FGdqZA8De+MKaEeJuB5kQmSpXsSN0FSXXR_9g@mail.gmail.com>
Subject: Re: [PATCH] signal: Always attempt to allocate siginfo for SIGSTOP
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Jack Andersen <jackoalan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 2:17 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> Since 2.5.34 the code has had the potential to not allocate siginfo
> for SIGSTOP signals.  Except for ptrace this is perfectly fine as only
> ptrace can use PTRACE_PEEK_SIGINFO and see what the contents of
> the delivered siginfo are.
>
> Users of PTRACE_PEEK_SIGINFO that care about the contents siginfo
> for SIGSTOP are rare, but they do exist.  A seccomp self test
> has cared and lldb cares.
>
> Jack Andersen <jackoalan@gmail.com> writes:
>
> > The patch titled
> > `signal: Never allocate siginfo for SIGKILL or SIGSTOP`
> > created a regression for users of PTRACE_GETSIGINFO needing to
> > discern signals that were raised via the tgkill syscall.
> >
> > A notable user of this tgkill+ptrace combination is lldb while
> > debugging a multithreaded program. Without the ability to detect a
> > SIGSTOP originating from tgkill, lldb does not have a way to
> > synchronize on a per-thread basis and falls back to SIGSTOP-ing the
> > entire process.
>
> Everyone affected by this please note.  The kernel can still fail to
> allocate a siginfo structure.  The allocation is with GFP_KERNEL and
> is best effort only.  If memory is tight when the signal allocation
> comes in this will fail to allocate a siginfo.
>
> So I strongly recommend looking at more robust solutions for
> synchronizing with a single thread such as PTRACE_INTERRUPT.  Or if
> that does not work persuading your friendly local kernel developer to
> build the interface you need.
>
> Reported-by: Tycho Andersen <tycho@tycho.ws>
> Reported-by: Kees Cook <keescook@chromium.org>
> Reported-by: Jack Andersen <jackoalan@gmail.com>
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: Christian Brauner <christian@brauner.io>
> Fixes: f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
> Fixes: 6dfc88977e42 ("[PATCH] shared thread signals")
> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Cc: stable too?

In your -next tree (and the pull), can you also revert 2bd61abead58
("selftests/seccomp: Remove SIGSTOP si_pid check") too?

Thanks for getting this in!

-Kees

> ---
>
> Unless someone objects I will drop this in my tree for linux-next and
> send Linus a pull request in a couple of days.
>
>  kernel/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e1d7ad8e6ab1..45298b3a8ffc 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1057,10 +1057,10 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
>
>         result = TRACE_SIGNAL_DELIVERED;
>         /*
> -        * Skip useless siginfo allocation for SIGKILL SIGSTOP,
> +        * Skip useless siginfo allocation for SIGKILL,
>          * and kernel threads.
>          */
> -       if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
> +       if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
>                 goto out_set;
>
>         /*
> --
> 2.17.1
>


-- 
Kees Cook
