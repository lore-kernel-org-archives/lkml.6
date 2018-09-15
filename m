Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EDEECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EEC208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fj1opwCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EEC208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeIOTyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:54:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36532 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeIOTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:54:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id x207-v6so10167191lff.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YhePIp9Ho7oAemH9C7Q79VOpJansucSF/dMXxL/tjrg=;
        b=fj1opwCkMWaUJFhbh6b/kBqFhf7+W7izrqy0No95tSkD1dXP48eoS9OQyt5Q3nVixb
         M/MJoRz1NOkknszFStQSUlQwAntolOiRq5i9EzcD8EcuRt25pKxL/d7I5Eb9x/ikO+Vw
         3mnuoKUqGV6lWmR9O52YpBo77L+PQyIKLvIlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhePIp9Ho7oAemH9C7Q79VOpJansucSF/dMXxL/tjrg=;
        b=ZCfPfyIgOnb8GUx0Ja9PMNpJWGGXZaQkF/oCfeRnbgozVQeGL+PxewVuKM+/LawZQM
         8NGfbd0qTHeigRH5yKMfWUuwnLDM6CcMOsSLj+L0l+U7g8cEitVkVAOFTywrVWVxBWjk
         kk0Uc5adfEcJ2Gyp0cc7Z3ahlswlYnwgMeLtb7QNuTsIDS0y4KJq3KBwKqJlLmvXBSHs
         RNTUiFzbaSpKAF60E6LY7OtS5wjTLeMGZ1yTlUbxAJSp/T/qTMakeYEOCQ80rV/06929
         WJ0vEgSnti+ayiXy7yCFu8Hv/gkEpMdGtDA3Lbo98esuiJGlPsZKBDdSpEOGkNVGnIml
         uRVw==
X-Gm-Message-State: APzg51C8wLE+9Ymk5Pf12Otx9U/enoX3K1md6YJMkT4dyGOamuJegZOF
        sJ1rOzI/cNtwg+tTb0HXD77I9JEUeoheYXJaSdWSQA==
X-Google-Smtp-Source: ANB0VdbyTdp5Vd32Id1kQ5PYVkjVsJl7d/dScZOJjuJIaLyHljXCrdMP0ig48YwaaAdaLnsPvsSgRNc28zwL4BSoF+8=
X-Received: by 2002:a19:7706:: with SMTP id s6-v6mr10928447lfc.84.1537022124112;
 Sat, 15 Sep 2018 07:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
 <tip-2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a@git.kernel.org>
 <20180915114657.GA63704@gmail.com> <CAKfTPtD-vAw9=aDS83eEB56JOPV74R-oG1LAKKPXkDfxPDt1vw@mail.gmail.com>
 <20180915122956.GA12378@gmail.com>
In-Reply-To: <20180915122956.GA12378@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 15 Sep 2018 16:35:11 +0200
Message-ID: <CAKfTPtCSJLRjmLDHAOTBjOPg8HQyGhmwsk71bNSnz0tOqbwkyw@mail.gmail.com>
Subject: Re: [tip:sched/core] sched/fair: Remove #ifdefs from scale_rt_capacity()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org, douly.fnst@cn.fujitsu.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018 at 14:30, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > Hi Ingo,
> >
> > On Sat, 15 Sep 2018 at 13:47, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * tip-bot for Vincent Guittot <tipbot@zytor.com> wrote:
> > >
> > > > Commit-ID:  2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
> > > > Gitweb:     https://git.kernel.org/tip/2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
> > > > Author:     Vincent Guittot <vincent.guittot@linaro.org>
> > > > AuthorDate: Thu, 19 Jul 2018 14:00:06 +0200
> > > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > > CommitDate: Wed, 25 Jul 2018 11:41:05 +0200
> > > >
> > > > sched/fair: Remove #ifdefs from scale_rt_capacity()
> > > >
> > > > Reuse cpu_util_irq() that has been defined for schedutil and set irq util
> > > > to 0 when !CONFIG_IRQ_TIME_ACCOUNTING.
> > > >
> > > > But the compiler is not able to optimize the sequence (at least with
> > > > aarch64 GCC 7.2.1):
> > > >
> > > >       free *= (max - irq);
> > > >       free /= max;
> > > >
> > > > when irq is fixed to 0
> > > >
> > > > Add a new inline function scale_irq_capacity() that will scale utilization
> > > > when irq is accounted. Reuse this funciton in schedutil which applies
> > > > similar formula.
> > > >
> > > > Suggested-by: Ingo Molnar <mingo@redhat.com>
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: rjw@rjwysocki.net
> > > > Link: http://lkml.kernel.org/r/1532001606-6689-1-git-send-email-vincent.guittot@linaro.org
> > > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > > ---
> > > >  kernel/sched/core.c              |  2 +-
> > > >  kernel/sched/cpufreq_schedutil.c |  3 +--
> > > >  kernel/sched/fair.c              | 13 +++----------
> > > >  kernel/sched/sched.h             | 20 ++++++++++++++++++--
> > > >  4 files changed, 23 insertions(+), 15 deletions(-)
> > >
> > > This commit introduced a build warning in the SMP=n case, could we please fix that? (Probably
> > > the best to maintain variant would be to mark it as __maybe_unused.)
> >
> > Dou sent a fix for this warning
> > https://lkml.org/lkml/2018/8/10/22
> > This one remove one HAVE_SCHED_AVG_IRQ which is at the opposite of
> > what yyou propose below
>
> Yeah, that's a bad patch because it moves one step back, beyond also having an obvious typo in
> the title and overall atrocious spelling that shows that not much thought must have gone into
> the patch - yet you acked it, which makes me unhappy as a maintainer: please don't ack
> obviously triple-flawed patches!

sorry about that

>
> > and Miguel also made a proposal:
> > https://lkml.org/lkml/2018/9/8/215
> > based on __maybe_unused
>
> That solution is probably better, but:
>
> > >
> > > Also, while at it, there's a number of other places that use this pattern:
> > >
> > > > -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> > > > +#ifdef HAVE_SCHED_AVG_IRQ
> > >
> > > Could we convert those to HAVE_SCHED_AVG_IRQ as well?
> >
> > I'm not sure that we can convert all to HAVE_SCHED_AVG_IRQ
> >
> > >
> > > dagon:~/tip> git grep 'defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)' kernel/sched/
> > > kernel/sched/core.c:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> >
> > we can't replace one because the variables can be used when
> > HAVE_SCHED_AVG_IRQ is undefined
>
> Well, firstly, why is HAVE_SCHED_AVG_IRQ defined in a header and not in the Kconfig space as I
> originally suggested?
>
> Secondly, HAVE_SCHED_AVG_IRQ is defined poorly AFAICS, it should be 0/1 so it can be used as a
> replacement pattern in #if sequences - not in #ifdef sequences as your patch did.
>
> I.e. this needs to be sorted out and done properly, the concerns you voice are simply a side
> effect of this having been done badly.


Ok. I'm going to prepare a patchset to fix all these points.

Regards,
Vincent

>
> Thanks,
>
>         Ingo
