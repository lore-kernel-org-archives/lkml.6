Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEA9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146A02172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNbB8M2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146A02172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeHCJoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:44:03 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34145 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbeHCJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:44:03 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so4293567ioj.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jLOmB910Fh4BnIL5tQ9SLes4JmW//eSoZWgHhu00UE=;
        b=aNbB8M2Pti8Z7CH58Gi1R0Kyhi82gXpd/T31EAXO8LPTbi863l1NIYaBr5txti8EXk
         S7vUUDdUhRSXLxGh1C7ukGvY6KzA0SbCKkHYY+ccoJSD9JAz9wu0MwbJzcG+K3imbvNx
         S86uvGvIoR7jZHG5Mt+tgYoFOPKGN8drj55Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jLOmB910Fh4BnIL5tQ9SLes4JmW//eSoZWgHhu00UE=;
        b=BYYW/ubn94H5EFjkNuijGscc/I0aHPG2GuwPBwTmmpw4E3m7mSQ7JFB5dwLhhuCTyE
         0/r8Bd5UXhBAskAV8njtyYOzI0SAKWbXjBbC+u15JnR7xGkpu9gf9cQyn9Thhr+w7Uo4
         1q8cHGDHjSh9lDRZ2GJxg1WwcIsKQ1tteIjbCN8LzNIjusiZUOCp3CUy1Ao9qgaAbzR+
         ZnR0SgwlRWF5+L0/iJz2m+QPJ2M5H8Bw8ozItMyvjaH8PkeU8eAmz7DrWiTsJOK4IyoU
         6Vx4XjKEPc4/nGoViIurjBD233QQsKJIF0GT+pDgRmDgT6zatwGVtWgQhJ5SyAd75+dG
         KYPg==
X-Gm-Message-State: AOUpUlHEbFDip6YNd2h/FrIhM2UH5VBfhhO+RFPhdeCutL9amiTG4QpY
        9jFvqWrgLUk6INUbxL1AXdJ/0k9FNlEibds8JHpkJA==
X-Google-Smtp-Source: AA+uWPyH8/Jxu0AirwrHKY8wiVk2u36lgj94aSbWE5CzBaxYem53DHREqE668d1dzuifgYpC/9QR0R87/n+xp/6pBpk=
X-Received: by 2002:a6b:3e46:: with SMTP id l67-v6mr4996360ioa.294.1533282538471;
 Fri, 03 Aug 2018 00:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180802131849.mqpt5lbtcqrxbwig@queper01-lin> <CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com>
 <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin> <CAKfTPtCzQZotmpt40X6uN9O0yAerq6c6bFgiFfqhhcbKsm7k4w@mail.gmail.com>
 <20180802153035.vjtmqwdwujvt7ojs@queper01-lin> <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin> <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin> <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin>
In-Reply-To: <20180802165924.7ywgoxj2jwftxycz@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 3 Aug 2018 09:48:47 +0200
Message-ID: <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point indicator
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 at 18:59, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Thursday 02 Aug 2018 at 18:38:01 (+0200), Vincent Guittot wrote:
> > On Thu, 2 Aug 2018 at 18:10, Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > On Thursday 02 Aug 2018 at 18:07:49 (+0200), Vincent Guittot wrote:
> > > > On Thu, 2 Aug 2018 at 18:00, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > >
> > > > > On Thursday 02 Aug 2018 at 17:55:24 (+0200), Vincent Guittot wrote:
> > > > > > On Thu, 2 Aug 2018 at 17:30, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > > > >
> > > > > > > On Thursday 02 Aug 2018 at 17:14:15 (+0200), Vincent Guittot wrote:
> > > > > > > > On Thu, 2 Aug 2018 at 16:14, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > > > > > > Good point, setting the util_avg to 0 for new tasks should help
> > > > > > > > > filtering out those tiny tasks too. And that would match with the idea
> > > > > > > > > of letting tasks build their history before looking at their util_avg ...
> > > > > > > > >
> > > > > > > > > But there is one difference w.r.t frequency selection. The current code
> > > > > > > > > won't mark the system overutilized, but will let sugov raise the
> > > > > > > > > frequency when a new task is enqueued. So in case of a fork bomb, we
> > > > > > > >
> > > > > > > > If the initial value of util_avg is 0, we should not have any impact
> > > > > > > > on the util_avg of the cfs rq on which the task is attached, isn't it
> > > > > > > > ? so this should not impact both the over utilization state and the
> > > > > > > > frequency selected by sugov or I'm missing something ?
> > > > > > >
> > > > > > > What I tried to say is that setting util_avg to 0 for new tasks will
> > > > > > > prevent schedutil from raising the frequency in case of a fork bomb, and
> > > > > > > I think that could be an issue. And I think this isn't an issue with the
> > > > > > > patch as-is ...
> > > > > >
> > > > > > ok. So you also want to deal with fork bomb
> > > > > > Not sure that you don't have some problem with current proposal too
> > > > > > because select_task_rq_fair will always return prev_cpu because
> > > > > > util_avg and util_est are 0 at that time
> > > > >
> > > > > But find_idlest_cpu() should select a CPU using load in case of a forkee
> > > > > no ?
> > > >
> > > > So you have to wait for the next tick that will set the overutilized
> > > > and disable the want_energy. Until this point, all new tasks will be
> > > > put on the current cpu
> > >
> > > want_energy should always be false for forkees, because we set it only
> > > for SD_BALANCE_WAKE.
> >
> > Ah yes I forgot that point.
> > But doesn't this break the EAS policy ? I mean each time a new task is
> > created, we use the load to select the best CPU
>
> If you really keep spawning new tasks all the time, yes EAS won't help
> you, but there isn't a lot we can do :/. We need to have an idea of how

My point was more that it's also happen for every single new task and
not only with fork bomb

> big a task is for EAS, and we obviously don't know that for new tasks, so
> it's hard/dangerous to make assumptions.

But by not making any assumption, the new tasks are placed outside EAS
control and can easily break what EAS tries to achieve because it
looks for the idlest cpu which is unluckily most probably a CPU that
EAS doesn't want to use

>
> So the proposal here is that if you only have forkees once in a while,
> then those new tasks (and those new tasks only) will be placed using load
> the first time, and then they'll fall under EAS control has soon as they
> have at least a little bit of history. This _should_ happen without
> re-enabling load balance spuriously too often, and that _should_ prevent

I'm not really concerned about re-enabling load balance but more that
the effort of packing of tasks in few cpus/clusters that EAS tries to
do can be broken for every new task.
So I wonder what is better for EAS : Make sure to efficiently spread
newly created tasks in cas of fork bomb or  try to not break EAS task
placement with every newly created tasks

Vincent

> it from ruining the placement of existing tasks ...
>
> As Peter already mentioned, a better way of solving this issue would be
> to try to find the moment when the utilization signal has converged to
> something stable (assuming that it converges), but that, I think, isn't
> straightforward at all ...
>
> Does that make any sense ?
>
> Thanks,
> Quentin
