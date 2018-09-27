Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471E2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4F0216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eweNoDYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4F0216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeI1FAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:00:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39239 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeI1FAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:00:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so3651488oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avE/9/ImKNZHQteep+wMipI13i8lprMcG+Ya//b9KSw=;
        b=eweNoDYlTV3XZEuzagJGMsboqfdNNdgoMIIdyd0BZdXOhjqS7w+mNqzweijOYj6Qu6
         QXvfeWxc+Y379y9qUmqaVsXt16UTbYtiEuCHgm27D3On0Nn4NaQR3MtvOT3PKm0szUg/
         L1mhn0GncVFSufnBYx5NEvJNOR8piVVhFx9bk1lGpbb+w5VAssOoaLHo4+NUpw4qh7Z1
         jySlkcv/C8fCwla2EnDIAoPvOWOg5n0Ke1LPnqdWXfX8QCp3gfxgFDms+Mz/WGDxGPte
         37CqcLAwW6V0fRgnoEsDNH6tV/tMgqOjY1AckLaOJCVt4v9UQvrYeyvze1lM2nrhUIw2
         F3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avE/9/ImKNZHQteep+wMipI13i8lprMcG+Ya//b9KSw=;
        b=gIW9R3DzP4fApiR6IYkrib9pvUn6259ZQuG5jOu0AYP6yOoSrQg3uBdjH7G2EiE3vs
         xzm9KM+Qv+2Gc2zAm4FDXoK1XzGU5MiP6B00Wy0GfEGTZsdosyeiU8LtPT7shRKpfW12
         FKKEeOm8Siuksyrxpa/Ip1HpcAC2sNkYygBUvM4IflrduJaBGb9rC3wS/ZieR2VWuMAu
         gR7XVO1XviQUHQbXEOsEcKeTtQ2Kpl2W05zgSpsLt9pXpG2Azam/0jypz96gZ3wUgZyD
         bCocYDa0c2ZUCW+zyhlfXGjLJtQKg6UQSG5RszgZxFgqImha7jXRCKZ+OU4TAgcgBYKT
         4Uxg==
X-Gm-Message-State: ABuFfojuj5tz8ksOe1CDg0aWQabit8rg/Tl5fq9pglJAGHxxaYrruNNa
        2BsntfT1To5/vgHppFUH5Eb8X1OwU1NQbRQdfrXmXg==
X-Google-Smtp-Source: ACcGV61sEmVo7/aKThII48MpF4GZK0l5C2NAvhh+6SNbbkji3TyY4POsYTRhZVwyTNVNMJVPvAxRQWfEvgt6j7fuAAM=
X-Received: by 2002:aca:3ad4:: with SMTP id h203-v6mr4485386oia.294.1538087983652;
 Thu, 27 Sep 2018 15:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180927153316.200286-1-jannh@google.com> <20180927152908.f5c9239d527380c582b1bcfa@linux-foundation.org>
In-Reply-To: <20180927152908.f5c9239d527380c582b1bcfa@linux-foundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 00:39:16 +0200
Message-ID: <CAG48ez3CSRuY3g+ug+PaM2ivc2n_fJQuP9U9VKv8JLELtBoLbA@mail.gmail.com>
Subject: Re: [PATCH resend] proc: restrict kernel stack dumps to root
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>, security@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:29 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 27 Sep 2018 17:33:16 +0200 Jann Horn <jannh@google.com> wrote:
>
> > Restrict the ability to inspect kernel stacks of arbitrary tasks to root
> > in order to prevent a local attacker from exploiting racy stack unwinding
> > to leak kernel task stack contents.
> > See the added comment for a longer rationale.
> >
> > There don't seem to be any users of this userspace API that can't
> > gracefully bail out if reading from the file fails. Therefore, I believe
> > that this change is unlikely to break things.
> > In the case that this patch does end up needing a revert, the next-best
> > solution might be to fake a single-entry stack based on wchan.
> >
> > Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> It's a bit worrisome cc'ing stable on a patch which might need a revert.
>
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
> >       unsigned long *entries;
> >       int err;
> >
> > +     /*
> > +      * The ability to racily run the kernel stack unwinder on a running task
> > +      * and then observe the unwinder output is scary; while it is useful for
> > +      * debugging kernel issues, it can also allow an attacker to leak kernel
> > +      * stack contents.
> > +      * Doing this in a manner that is at least safe from races would require
> > +      * some work to ensure that the remote task can not be scheduled; and
> > +      * even then, this would still expose the unwinder as local attack
> > +      * surface.
> > +      * Therefore, this interface is restricted to root.
> > +      */
>
> The /proc file is 0400 so the user can only read owned-by-self stacks,
> yes?  In what way could exposure of one's own kernel stack contents
> lead to plausible attacks?  I guess maybe post-setuid, perhaps?
>
> I do think we're owed considerably more explanation of the present risk
> before considering a somewhat dangerous -stable backport, please.

I sent a bug report to security@. The short version: Currently, you
can use /proc/self/task/*/stack to cause a stack walk on a task you
control while it is running on another CPU. That means that the stack
can change under the stack walker. The stack walker does have guards
against going completely off the rails and into random kernel memory,
but it can interpret random data from your kernel stack as instruction
pointers and stack pointers. This can cause exposure of kernel stack
contents to userspace.
