Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D36C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38F721501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVu9/nwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38F721501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbeHBRrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:47:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37135 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387632AbeHBRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:47:22 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so2358083ioh.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvzpHx4Y1+1jkoOdPTlcFX2PLolB5iT7+OdxjVHUXWw=;
        b=JVu9/nwuWWI80aaFJd09VulaJhzTBRbazNRkrS0oAEe75HcsQ1E+tHLDPxqwxfsPMa
         a1q9qnKEkkhD8DKdbYoPohX0tRmrETbmMuhuR3SR9Ovr9AioVk0tihCabgWFTVjThPjx
         Nf40UTUpDhBOuvfWQm82JsjUdbwJn2IZP7s/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvzpHx4Y1+1jkoOdPTlcFX2PLolB5iT7+OdxjVHUXWw=;
        b=I/bmeL9ReBCSBi1jbELN0YbSE+RG1x9kjIyeP2b/fdTLOJWbM3rRy3vxygx8GfJJ9b
         DK91NyQllauoey9qFJL98gJbMxwEumdafLClTLNt/LQMDI3T1wc52MXegYpZxrKC3IWh
         DZVOJay9PY+h0ekip7H60G7ss3qXCoqLXJ/JCc2EobT5Cczemw4PWNogfjZzgOdHD6rm
         SeddLQ2+ReCXanHFD1QvB/ZKugNyuLPWV948kq7PkgbrWWis4rScyPQBwgQD1o3UQh7k
         ZDP7tHcdyM5+7TJyzOtIDfXK0JFR417BReOT8IU3iG1YVvgd0pFmomRALuGjrV4cdl/o
         foxQ==
X-Gm-Message-State: AOUpUlHNCtT1YxNxx1mNwFZQKRDRI9WRCglmeqQa28ExrJDQIJXkuQFB
        rBYzSd9o6fEHp9c6WhVC7ZAcbYvs/XkMe2mPs832Hg==
X-Google-Smtp-Source: AA+uWPx/ZX1Gj8ebXdCRibXlPWMDoLt9gQfB/URChlh5Zsznkmj71S67oK5V9S1uvbgfYKIsTuZ/7ymCeH8gj8uqxIo=
X-Received: by 2002:a6b:3e46:: with SMTP id l67-v6mr2801363ioa.294.1533225335772;
 Thu, 02 Aug 2018 08:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com> <20180802122629.GU2476@hirez.programming.kicks-ass.net>
 <20180802130337.uf6tlac2hg4nkbwr@queper01-lin> <20180802130801.GL2494@hirez.programming.kicks-ass.net>
 <20180802131849.mqpt5lbtcqrxbwig@queper01-lin> <CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com>
 <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin> <CAKfTPtCzQZotmpt40X6uN9O0yAerq6c6bFgiFfqhhcbKsm7k4w@mail.gmail.com>
 <20180802153035.vjtmqwdwujvt7ojs@queper01-lin>
In-Reply-To: <20180802153035.vjtmqwdwujvt7ojs@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Aug 2018 17:55:24 +0200
Message-ID: <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
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

On Thu, 2 Aug 2018 at 17:30, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Thursday 02 Aug 2018 at 17:14:15 (+0200), Vincent Guittot wrote:
> > On Thu, 2 Aug 2018 at 16:14, Quentin Perret <quentin.perret@arm.com> wrote:
> > > Good point, setting the util_avg to 0 for new tasks should help
> > > filtering out those tiny tasks too. And that would match with the idea
> > > of letting tasks build their history before looking at their util_avg ...
> > >
> > > But there is one difference w.r.t frequency selection. The current code
> > > won't mark the system overutilized, but will let sugov raise the
> > > frequency when a new task is enqueued. So in case of a fork bomb, we
> >
> > If the initial value of util_avg is 0, we should not have any impact
> > on the util_avg of the cfs rq on which the task is attached, isn't it
> > ? so this should not impact both the over utilization state and the
> > frequency selected by sugov or I'm missing something ?
>
> What I tried to say is that setting util_avg to 0 for new tasks will
> prevent schedutil from raising the frequency in case of a fork bomb, and
> I think that could be an issue. And I think this isn't an issue with the
> patch as-is ...

ok. So you also want to deal with fork bomb
Not sure that you don't have some problem with current proposal too
because select_task_rq_fair will always return prev_cpu because
util_avg and util_est are 0 at that time

>
> Sorry if that wasn't clear
>
> > Then, select_task_rq_fair is called for a new task but util_avg is
> > still 0 at that time in the current code so you will have consistent
> > util_avg of the new task before and after calling
> > find_energy_efficient_cpu
>
> New tasks don't go in find_energy_efficient_cpu(), because, as you said,
> they have no consistent util_avg yet when select_task_rq_fair() is called
> for the first time.
>
> Thanks,
> Quentin
