Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93843C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAE120832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCjqlyZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAE120832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeK2B5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:57:13 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46418 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeK2B5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:57:13 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so14539906ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 06:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqYwKSq8Ktp6JoUf6WD4NLTREQDC4vb89JEXNRtGWmo=;
        b=ZCjqlyZQGHzvFP1gQWdttkJYSoRy7kUxnor2ZvaxS5Il26X+tq28oDz2Ckn58g/MEb
         HU2ROJ0sInT3CQPB4TFAzdUvLw+ZUjdKHIH2s+83J26SigVaHW/TLeaQfMj4CCq0MfEN
         G4BAbwcAwFKcO10fqSQlbg3NjkAwzCBbrTDjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqYwKSq8Ktp6JoUf6WD4NLTREQDC4vb89JEXNRtGWmo=;
        b=pWTEiALnB9oYqFhuVgIo3zh3Q4CGnQEjwEPd0V5qTIgYvYLXNqyrgTFo0emMRLk2Vm
         3u5OaqG6LOOeOIGE+ufBu8wkZnJEMSxnl/5s3JI3Z3tWaE8M4L5ryjsEB/xCEX/hNxQS
         pgODepoWfKa+h9QAKErs4aBBsQGgqj0AhEgGjF47+JYaUywEVpsao3Okcbmsy66a70+z
         2HpAmrza14IFMuGRy7k7g1yU0TfurWZGnLaYgu8lnhs01oWDxREhabVBe+wf/TvlbdmJ
         j/QupEdjsKNMWrMw1BszNZVv4e8tDYIKvPS/oL756IUG6NhHh5nsP+NHdIWmjsNKpVcx
         1jmA==
X-Gm-Message-State: AA+aEWY2umbzcNOayBrgweqs4tgv23jKWDccJ2ajM4roHc3SgYKDZCWl
        fVNB/dIvKGh6+iwhlYXK5Zeqbdxyvx66W4MSO0OyMw==
X-Google-Smtp-Source: AFSGD/W+BtA3b02cVfQrgEZItMpqe5ruprENFa02jAN5DbUFeFVv3Qb6fUIVPJUJEskW+Me4BT4LZz51knsPIwa4CNk=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr27534227ioh.294.1543416916554;
 Wed, 28 Nov 2018 06:55:16 -0800 (PST)
MIME-Version: 1.0
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net> <20181128115336.GB23094@e110439-lin>
 <CAKfTPtBsKc7v5gc=XUrzO-_4kahGfdNteo=t9W5fLv0Ee8co_w@mail.gmail.com> <20181128144039.GC23094@e110439-lin>
In-Reply-To: <20181128144039.GC23094@e110439-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Nov 2018 15:55:05 +0100
Message-ID: <CAKfTPtAR7otTTwKYbg5OWbgrUYNKBNsUnOcMS9CfQtbYspvO5A@mail.gmail.com>
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

On Wed, 28 Nov 2018 at 15:40, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 28-Nov 14:33, Vincent Guittot wrote:
> > On Wed, 28 Nov 2018 at 12:53, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > >
> > > On 28-Nov 11:02, Peter Zijlstra wrote:
> > > > On Wed, Nov 28, 2018 at 10:54:13AM +0100, Vincent Guittot wrote:
> > > >
> > > > > Is there anything else that I should do for these patches ?
> > > >
> > > > IIRC, Morten mention they break util_est; Patrick was going to explain.
> > >
> > > I guess the problem is that, once we cross the current capacity,
> > > strictly speaking util_avg does not represent anymore a utilization.
> > >
> > > With the new signal this could happen and we end up storing estimated
> > > utilization samples which will overestimate the task requirements.
> > >
> > > We will have a spike in estimated utilization at next wakeup, since we
> > > use MAX(util_avg@dequeue_time, ewma). Potentially we also inflate the EWMA in
> > > case we collect multiple samples above the current capacity.
> >
> > TBH I don't see how it's different from current implementation with a
> > task that was scheduled on big core and now wakes up on little core.
> > The util_est is overestimated as well.
>
> While running below the capacity of a CPU, either big or LITTLE, we
> can still measure the actual used bandwidth as long as we have idle
> time. If the task is then moved into a lower capacity core, I think
> it's still safe to assume that, likely, it would need more capacity.
>
> Why do you say it's the same ?

In the example of a task that runs 39ms in period of 80ms that we used
during previous version,
the utilization on the big core will reach 709 so will util_est too
When the task migrates on little core (512), util_est is higher than
current cpu capacity

>
> With your new signal instead, once we cross the current capacity,
> utilization is just not anymore utilization. Thus, IMHO it make sense
> avoid to accumulate a sample for what we call "estimated utilization".
>
> I would also say that, with the current implementation which caps
> utilization to the current capacity, we get better estimation in
> general. At least we can say with absolute precision:
>
>    "the task needs _at least_ that amount of capacity".
>
> Potentially we can also flag the task as being under-provisioned, in
> case there was not idle time, and _let a policy_ decide what to do
> with it and the granted information we have.
>
> While, with your new signal, once we are over the current capacity,
> the "utilization" is just a sort of "random" number at best useful to
> drive some conclusions about how long the task has been delayed.
>
> IOW, I fear that we are embedding a policy within a signal which is
> currently representing something very well defined: how much cpu
> bandwidth a task used. While, latency/under-provisioning policies
> perhaps should be better placed somewhere else.
>
> Perhaps I've missed it in some of the previous discussions:
> have we have considered/discussed this signal-vs-policy aspect ?
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
