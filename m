Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835DA214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbYzbvwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835DA214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJJRgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:36:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40042 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeJJRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:36:12 -0400
Received: by mail-io1-f68.google.com with SMTP id w16-v6so3436809iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDbLix6E4zGm8ztBoDBEuXfpaANAhua1pwSayu5SJPY=;
        b=AbYzbvwSgSUvQti3NJxqN4gVptBpJ3ONUrGFaq/QGK4oCxd4tjYQo9JqKeOIAKZ5G9
         EiOwyF8ruwm5ftu1HUpO78tsSdkNc+KyXXjXCMO+qMSUgIkymEmrjDvxJ4Mqu8lDbUk1
         aNsShjihZ8ounyZ6/8X1spy1rP0djLbnqd7x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDbLix6E4zGm8ztBoDBEuXfpaANAhua1pwSayu5SJPY=;
        b=oIyqeZiVDznQzPYbQu8Mgduhn2wv2H0AsrCitnVTMN6tuFr+lR1VKwbARWv7Wj3fTo
         1WKqsQVkPLupWDlFHDXRbJQQny4xc7PMnTwCi7A6T32L+fKi2CBfnArDwOS7COM+Gkxc
         ZSc6ko4dDQv8LSVqPPbWMHrZX2ZdrlE/P0U1xZjaiX44/5izq4X/RRynpT7jEK2355Ib
         cbGg2pSpaRwjxlp0brJ7oeB7CKn/dZDW8/dmdJU5HkhealQXG1LtwtgFWLZJcMQGb1rW
         fed6SF8wOmukupinD07/DTVWfihPMf5PtpQIfEPMxqdKlRUgBIJeJrPGj02fCEZ+9COJ
         w+9w==
X-Gm-Message-State: ABuFfojepfMHJFGFL8nCwQhVWhIBJFC9NVLmYEXqGwtW6E4GKEonPyYn
        bisRFCHeAy6iwtGw0uiPLeIiSUG+y5iGQ7eefv6RyA==
X-Google-Smtp-Source: ACcGV63gVj9kD4qJOkwxkvaOOuy6h09EIzuZ7cCMib4/msT3KIKgyVMkGJ9R36BXxnjp2k7K+EgNbaDgf/9ISd2p9Eo=
X-Received: by 2002:a6b:254:: with SMTP id 81-v6mr16276487ioc.183.1539166483957;
 Wed, 10 Oct 2018 03:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com> <20181010095459.orw2gse75klpwosx@queper01-lin>
In-Reply-To: <20181010095459.orw2gse75klpwosx@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 10 Oct 2018 12:14:32 +0200
Message-ID: <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 at 11:55, Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Vincent,
>
> On Wednesday 10 Oct 2018 at 10:50:05 (+0200), Vincent Guittot wrote:
> > The problem with reflecting directly the capping is that it happens
> > far more often than the pace at which cpu_capacity_orig is updated in
> > the scheduler.
>
> Hmm, how can you be so sure ? That most likely depends on the workload,
> the platform and the thermal governor. Some platforms heat up slowly,
> some quickly. The pace at which the thermal governor will change things
> should depend on that I assume.
>
> > This means that at the moment when scheduler uses the
> > value, it might not be correct anymore.
>
> And OTOH, when you remove a cap for example, it will take time before
> the scheduler can see the newly available capacity if you need to wait
> for the signal to decay. So you are using a wrong information too in
> that scenario.

But we stay consistant with all other metrics. The same happen when a
task decide to stay idle for a long time after some activity... You
will have to wait for the signal to decay

>
> > Then, this value are also used
> > when building the sched_domain and setting max_cpu_capacity which
> > would also implies the rebuilt the sched_domain topology ...
>
> Wait what ? I thought the thermal cap was reflected in capacity_of, not
> capacity_orig_of ... You need to rebuild the sched_domain in case of
> thermal pressure ?
>
> Hmm, let me have a closer look at the patches, I must have missed
> something ...
>
> > The pace of changing the capping is to fast to reflect that in the
> > whole scheduler topology
>
> That's probably true in some cases, but it'd be cool to have numbers to
> back up that statement, I think.
>
> Now, if you do need to rebuild the sched domain topology every time you
> update the thermal pressure, I think the PELT HL is _way_ too short for
> that ... You can't rebuild the whole thing every 32ms or so. Or am I
> misunderstanding something ?
>
> > > Thara, have you tried to experiment with a simpler implementation as
> > > suggested by Ingo ?
> > >
> > > Also, assuming that we do want to average things, do we actually want to
> > > tie the thermal ramp-up time to the PELT half life ? That provides
> > > nice maths properties wrt the other signals, but it's not obvious to me
> > > that this thermal 'constant' should be the same on all platforms. Or
> > > maybe it should ?
> >
> > The main interest of using PELT signal is that thermal pressure will
> > evolve at the same pace as other signals used in the scheduler.
>
> Right, I think this is a nice property too (assuming that we actually
> want to average things out).
>
> > With
> > thermal pressure, we have the exact same problem as with RT tasks. The
> > thermal will cap the max frequency which will cap the utilization of
> > the tasks running on the CPU
>
> Well, the nature of the signal is slightly different IMO. Yes it's
> capacity, but you're no actually measuring time spent on the CPU. All
> other PELT signals are based on time, this thermal thing isn't, so it is
> kinda different in a way. And I'm still wondering if it could be helpful

hmmm ... it is based on time too.
Both signals (current ones and thermal one) are really close. The main
difference with other utilization signal is that instead of providing
a running/not running boolean that is then weighted by the current
capacity, the signal uses direclty the capped max capacity to reflect
the amount of cycle that is stolen by thermal mitigation.

> to be able to have a different HL for that thermal signal. That would
> 'break' the nice maths properties we have, yes, but is it a problem or is
> it actually helpful to cope with the thermal characteristics of
> different platforms ?

If you don't use the sign kind of signal with the same responsiveness,
you will start to see some OPP toggles as an example when the thermal
state change because one metrics will change faster than the other one
and you can't have a correct view of the system. Same problem was
happening with rt task.

I take the example of RT task because it quite similar in the effect
except that RT task steal all cycles when it runs whereas thermal
mitigation steal only some by capping the frequency
>
> Thanks,
> Quentin
