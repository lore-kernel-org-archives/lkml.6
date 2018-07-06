Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76CBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D26B23F73
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZjALGOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D26B23F73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeGFJWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:22:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34390 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeGFJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:22:02 -0400
Received: by mail-it0-f68.google.com with SMTP id d191-v6so4717976ite.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1f+PgkBtW/YzSKnDviQQApvrh9gaDTcnBFYiCyiykQ0=;
        b=XZjALGOVW/eoOxMmOb8H7Mkw9veqLQtj6DHy4MV3whpWxYR+5GuSrdlJkEnOPIdWL1
         jPINkhWmTqO8qd8bbm3EG+GY/7pS3VscOqMlA4l1hl/z3OEpfDuNPBZSYdIxJ1u9QlWI
         3v3Bxo9cSz2Kae5d88MJaM6m3xjykux2/4qWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1f+PgkBtW/YzSKnDviQQApvrh9gaDTcnBFYiCyiykQ0=;
        b=Z9v4S/xNrZ5+V8KGIjlsUPJ0TQRlXFk4HPewR0SD3t2GuzjCauzBHmMqLDCyyjK5pZ
         ODV4jcFL6Skn4isU9ki4iVY0ADaCd+/KQX9zu/beIEM3ao153v0ppZnnjvI+YPu4lr1E
         6GzZT8dBhqchYqFvSJ2Zl+4Z1GCL0IikfuHdMVGVVEhMqz7HC6UjXYVCAnm6UVew/sa/
         t74TrbGhkRoVIxqbQ/iwcIEQQSUhQkG7ZwdGV+3LRP/89RfVCWmuaxLYFbdpU7RncwVQ
         ceRliu7wmZn56cZ+MtYegOqOKAGJFEvXW69247d+MJdM/Lu+CcVV1qQ33/eaCQhsRY1r
         CIDQ==
X-Gm-Message-State: APt69E2jq5FmVNf7TzqJXC0YjxMmg2g3YuDOPn43M9hiOxq+AH0IubtS
        j9iJr132eHtKLW+NSD2dHI5XcgoZ2bh6QhcIraEQ9Q==
X-Google-Smtp-Source: AAOMgpfCGKarqcqNsxj/D1rViUGCWwCiRbt3XcgxbTHPVJyrPB9U8p/PRjeqkgidoc2eBUDO+2l6aRlSDd7N3kERx1A=
X-Received: by 2002:a24:99c4:: with SMTP id a187-v6mr7337627ite.148.1530868922111;
 Fri, 06 Jul 2018 02:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-8-git-send-email-vincent.guittot@linaro.org>
 <20180706060033.rcgzfs6pouqssiqh@vireshk-i7> <20180706091429.GJ2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180706091429.GJ2494@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Jul 2018 11:21:50 +0200
Message-ID: <CAKfTPtDFKsZ7jhoRhjoyqAXe_qDQxja0Kc0P48MJtzSxTOpMnQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] cpufreq/schedutil: take into account interrupt
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     viresh kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 at 11:14, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 06, 2018 at 11:30:33AM +0530, Viresh Kumar wrote:
> > On 28-06-18, 17:45, Vincent Guittot wrote:
> > > The time spent under interrupt can be significant but it is not reflected
> > > in the utilization of CPU when deciding to choose an OPP. Now that we have
> > > access to this metric, schedutil can take it into account when selecting
> > > the OPP for a CPU.
> > > rqs utilization don't see the time spend under interrupt context and report
> > > their value in the normal context time window. We need to compensate this when
> > > adding interrupt utilization
> > >
> > > The CPU utilization is :
> > >   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
> > >
> > > A test with iperf on hikey (octo arm64) gives:
> > > iperf -c server_address -r -t 5
> > >
> > > w/o patch           w/ patch
> > > Tx 276 Mbits/sec        304 Mbits/sec +10%
> > > Rx 299 Mbits/sec        328 Mbits/sec +09%
> > >
> > > 8 iterations
> > > stdev is lower than 1%
> > > Only WFI idle state is enable (shallowest diel state)
>
> Also s/diel/idle/
>
> > > +   /*
> > > +    * Interrupt time is not seen by rqs utilization nso we can compare
> >
> >                                                          nso ?
> >
> > > +    * them with the CPU capacity
> > > +    */
>
> Already fixed ;-)

Thanks
