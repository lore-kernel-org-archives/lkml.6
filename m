Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074CEECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9273C21486
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 12:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bA0gnBuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9273C21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeIORgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 13:36:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34843 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIORgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 13:36:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so9584053ljg.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmKAN3g8UFJUKVPhLnvzfzNVWpI7XwK1TTWXhqvDdVw=;
        b=bA0gnBuOE9ZiAfBsjNlsJOqPHoQ+5XcuX2tQNHdnhO7OiYdES40ujv4vdggQAh31zO
         iQrXaVkNIXOpdsOsC73ZLWiNziNkm0r7uMMQJirEllB7juZjevOz7uc5yB2v8+G/rRTc
         RnoiKYbEo//DZjFnZs4w4u/uFcuZbrcsmMLEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmKAN3g8UFJUKVPhLnvzfzNVWpI7XwK1TTWXhqvDdVw=;
        b=FYcKyIzWVj/LJCogRgeJK8Wb/GqHJxAkOAdL8R6SKOX/d7aLQmQFO9ctffZop1usCt
         EKZpy+D1C6roWiOoBHW+NVRnOf9wQB37r73nUZOcaeN9qAiqcPuZ45yB5hK8aVjNohu5
         7wiByQ6unKmyfXRqj2gjEifIRqxNFKSlCCXGAwivKtABd308a7xPiPBH9lZWwX6JNjjH
         8JBGP201CSMh3o+2yeKenNijHQm0jilhi6pTShdGqNaeyS4H0JzKdo+xBX5/PxRUnKFl
         zEiwAb1ljZE1QCTsZTZfblmsXsI5m+N5Ag21RjBsYS+AHL0NVVbzBegkZ9YN7MD5YTQ8
         J16A==
X-Gm-Message-State: APzg51CRb0y1+Gc47pl/8E0H3eb5VQVqMRpNXsubnf3yDr1avKcmwKtv
        RtvS3o9PkodyQkj2OIjnBqs3ieZ5/cZCOlTfphBJTQ==
X-Google-Smtp-Source: ANB0VdYNZczoS2AVUVQJzAGn5SvdbKCasRzFVdR6UX5aIwGwH5rVv278aS8z85hpAScBtphOI8l8hc1+8b1BFQc+yBY=
X-Received: by 2002:a2e:5614:: with SMTP id k20-v6mr11094587ljb.48.1537013842653;
 Sat, 15 Sep 2018 05:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
 <tip-2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a@git.kernel.org> <20180915114657.GA63704@gmail.com>
In-Reply-To: <20180915114657.GA63704@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 15 Sep 2018 14:17:09 +0200
Message-ID: <CAKfTPtD-vAw9=aDS83eEB56JOPV74R-oG1LAKKPXkDfxPDt1vw@mail.gmail.com>
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

Hi Ingo,

On Sat, 15 Sep 2018 at 13:47, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * tip-bot for Vincent Guittot <tipbot@zytor.com> wrote:
>
> > Commit-ID:  2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
> > Gitweb:     https://git.kernel.org/tip/2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
> > Author:     Vincent Guittot <vincent.guittot@linaro.org>
> > AuthorDate: Thu, 19 Jul 2018 14:00:06 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Wed, 25 Jul 2018 11:41:05 +0200
> >
> > sched/fair: Remove #ifdefs from scale_rt_capacity()
> >
> > Reuse cpu_util_irq() that has been defined for schedutil and set irq util
> > to 0 when !CONFIG_IRQ_TIME_ACCOUNTING.
> >
> > But the compiler is not able to optimize the sequence (at least with
> > aarch64 GCC 7.2.1):
> >
> >       free *= (max - irq);
> >       free /= max;
> >
> > when irq is fixed to 0
> >
> > Add a new inline function scale_irq_capacity() that will scale utilization
> > when irq is accounted. Reuse this funciton in schedutil which applies
> > similar formula.
> >
> > Suggested-by: Ingo Molnar <mingo@redhat.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: rjw@rjwysocki.net
> > Link: http://lkml.kernel.org/r/1532001606-6689-1-git-send-email-vincent.guittot@linaro.org
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  kernel/sched/core.c              |  2 +-
> >  kernel/sched/cpufreq_schedutil.c |  3 +--
> >  kernel/sched/fair.c              | 13 +++----------
> >  kernel/sched/sched.h             | 20 ++++++++++++++++++--
> >  4 files changed, 23 insertions(+), 15 deletions(-)
>
> This commit introduced a build warning in the SMP=n case, could we please fix that? (Probably
> the best to maintain variant would be to mark it as __maybe_unused.)

Dou sent a fix for this warning
https://lkml.org/lkml/2018/8/10/22
This one remove one HAVE_SCHED_AVG_IRQ which is at the opposite of
what yyou propose below

and Miguel also made a proposal:
https://lkml.org/lkml/2018/9/8/215
based on __maybe_unused

>
> Also, while at it, there's a number of other places that use this pattern:
>
> > -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> > +#ifdef HAVE_SCHED_AVG_IRQ
>
> Could we convert those to HAVE_SCHED_AVG_IRQ as well?

I'm not sure that we can convert all to HAVE_SCHED_AVG_IRQ

>
> dagon:~/tip> git grep 'defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)' kernel/sched/
> kernel/sched/core.c:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)

we can't replace one because the variables can be used when
HAVE_SCHED_AVG_IRQ is undefined

> kernel/sched/fair.c:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)

This one can be replaced indeed

> kernel/sched/pelt.c:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)

This one can be replaced as well

> kernel/sched/pelt.h:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)

This one too

> kernel/sched/sched.h:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
This one is used to declare HAVE_SCHED_AVG_IRQ

>
> Thanks,
>
>         Ingo
