Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EB12081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hujK7Uf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EB12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeK2Agx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:36:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46423 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2Agx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:36:53 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so14325213ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=13S8GW6ail1pyySMV3j2ahSI/y8rsQwLofFeF4iD3KM=;
        b=hujK7Uf4lkDxVfIZJQEiPwyLyPUNcisAuntI6KMIp7tg5xgro/LKDjvj9TroXYvr7o
         Z2DSmngix4lNK6xRozWB4JisEfQd0+JGCEPB+keKfy8eOtlS1U+D0hAG0miV1xfZLd0K
         1KkqAP5SIF4H/nEMvMCTs5yu/N82fwS5AvBTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13S8GW6ail1pyySMV3j2ahSI/y8rsQwLofFeF4iD3KM=;
        b=kGMmDQnANE9uboPqRinWcSnhAxK/OJ40hNBpw3PqLBkz8DsO6FuEeoTpdJObTmzjgW
         GnicFGQYQrFQ5QB8Kbo7WUeHjXnH09lH+gSHsb8H2v3AG59swStAyxVYrmrh231qD4jZ
         z0qinKQXblPPwrdIj8tvhJblKEseaJ5dYZiDg2eNVPLxCwOu9YQEbxnTJbA4n+xb1mUa
         PiKd42Y3wVpMTHCF4FCMS2QleV10HzdqW9PdtFYhZW4HuXs8WFCfaDUyhlGzeUpiAn4k
         eaC3tn8CWL3wfXnaELKZKSSomQtD/k91zlCRWYQb/XO/2nlcZrAJZUE1/BGF5PgQgIEU
         m1+g==
X-Gm-Message-State: AA+aEWb3Yk9+WJhQmPxvuhvWMoPlgfxBbrchEFaUttlZO23e3W3DDTlV
        aHBCEEuAT4m8SL6hB2KB3V4bHcul2Py+GxocE8GkIg==
X-Google-Smtp-Source: AFSGD/UAurFDNXqjf5yzdm39+9IA2KqOVQtXoJAB8UczKFiZYbHKwf4kTHWl9O4633xEmzCJu0Nz3t7yfst3DxTpG3w=
X-Received: by 2002:a6b:6b0d:: with SMTP id g13mr27228207ioc.18.1543412111911;
 Wed, 28 Nov 2018 05:35:11 -0800 (PST)
MIME-Version: 1.0
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net> <20181128115336.GB23094@e110439-lin>
 <CAKfTPtBsKc7v5gc=XUrzO-_4kahGfdNteo=t9W5fLv0Ee8co_w@mail.gmail.com>
In-Reply-To: <CAKfTPtBsKc7v5gc=XUrzO-_4kahGfdNteo=t9W5fLv0Ee8co_w@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Nov 2018 14:35:00 +0100
Message-ID: <CAKfTPtBS7=C-O4ydz2LLpLG4VfrXoypLD44+C+tp=CyygjiDAQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 at 14:33, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 28 Nov 2018 at 12:53, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> >
> > On 28-Nov 11:02, Peter Zijlstra wrote:
> > > On Wed, Nov 28, 2018 at 10:54:13AM +0100, Vincent Guittot wrote:
> > >
> > > > Is there anything else that I should do for these patches ?
> > >
> > > IIRC, Morten mention they break util_est; Patrick was going to explain.
> >
> > I guess the problem is that, once we cross the current capacity,
> > strictly speaking util_avg does not represent anymore a utilization.
> >
> > With the new signal this could happen and we end up storing estimated
> > utilization samples which will overestimate the task requirements.
> >
> > We will have a spike in estimated utilization at next wakeup, since we
> > use MAX(util_avg@dequeue_time, ewma). Potentially we also inflate the EWMA in
> > case we collect multiple samples above the current capacity.
>
> TBH I don't see how it's different from current implementation with a
> task that was scheduled on big core and now wakes up on little core.
> The util_est is overestimated as well.
>
> But I'm fine with adding your proposal on to on the patchset
s/on to on/on top of/

>
> >
> > So, a possible fix could be to avoid storing util_est samples if we
> > end up with a utilization above the current capacity.
> >
> > Something like:
> >
> > ----8<---
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ac855b2f4774..93e0cf5d8a76 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3661,6 +3661,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> >         if (!task_sleep)
> >                 return;
> >
> > +       /* Skip samples which do not represent an actual utilization */
> > +       if (unlikely(task_util(p) > capacity_of(task_cpu(p))))
> > +               return;
> > +
> >         /*
> >          * If the PELT values haven't changed since enqueue time,
> >          * skip the util_est update.
> > ---8<---
> >
> > Could that work ?
> >
> > Maybe using a new utility function to wrap the new check.
> >
> > --
> > #include <best/regards.h>
> >
> > Patrick Bellasi
