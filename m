Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D6C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DB321526
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kR/WmW1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DB321526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeHBR7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:59:50 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37517 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeHBR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:59:49 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so2413751ioh.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+V+KFypuc0xper6p0cDtNGfFlUmrhcO6d8rfQ32mcg=;
        b=kR/WmW1zV0YRCN5mo85iOMgCXqanvCU4lh/v/qBSvivJDf6NfJg67Vhky5Vm5APMSN
         cTtxDeDOafV9Xm9MhSjSobEN2gOI0tS4nUzvhaf1EhhJwjUCc88tmJUhXSsUIBErSuif
         fxCYe4WjV4Qmdc5/a5Jr6eMXJRwz/zzUHfpFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+V+KFypuc0xper6p0cDtNGfFlUmrhcO6d8rfQ32mcg=;
        b=ekgQGViJMAC1Vcg8L+iaRnr7nyhzbZ2ok7nkGzwJk6WhkXWWdvQg6uIer0ljSyp9ga
         nuT4e4k8OFTeeG9t3H8wTAh/2IZ3Q9+w+nd0lPWUuT8jzGaUOgtsj9w9im7oplE+DXqf
         kQyjkaUmbQYWdE1HQqY/4r0NKMtFnU63g966IqHTBNDmN9xWjmI/BnsrVKOPXMYCtpls
         tUwlVspCF0Nw6JsW8H72eNMbBCmE5DBlLjbWQzBKncljuCoI76aecitoxTKmQX3KBN8W
         A2ZmwyWOEqvBIs+ehuv2AemRrTtF+TtLktAlZGql9kEtXa2JnfxYn3YRAEy978BKh5Oh
         +M6g==
X-Gm-Message-State: AOUpUlG9eIue72S94ikngyP6BZ0oqzmqb+Zay8VWEIxBviyJkRVy51hB
        Sq9wtAjIzA6+mDvW86Q4wNxbILL1UICeHqhHqIva8A==
X-Google-Smtp-Source: AAOMgpfDGi59GNRvrX9Rf146QKV5zw9sOdxL4qKBHSuOVdnj+lwC4OMGWMGB1XJAb/pfoxe6Kxpk6B1PmnEVA1+uctM=
X-Received: by 2002:a6b:ec08:: with SMTP id c8-v6mr3005168ioh.18.1533226080431;
 Thu, 02 Aug 2018 09:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180724122521.22109-10-quentin.perret@arm.com>
 <20180802122629.GU2476@hirez.programming.kicks-ass.net> <20180802130337.uf6tlac2hg4nkbwr@queper01-lin>
 <20180802130801.GL2494@hirez.programming.kicks-ass.net> <20180802131849.mqpt5lbtcqrxbwig@queper01-lin>
 <CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com>
 <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin> <CAKfTPtCzQZotmpt40X6uN9O0yAerq6c6bFgiFfqhhcbKsm7k4w@mail.gmail.com>
 <20180802153035.vjtmqwdwujvt7ojs@queper01-lin> <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
In-Reply-To: <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Aug 2018 18:07:49 +0200
Message-ID: <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
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

On Thu, 2 Aug 2018 at 18:00, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Thursday 02 Aug 2018 at 17:55:24 (+0200), Vincent Guittot wrote:
> > On Thu, 2 Aug 2018 at 17:30, Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > On Thursday 02 Aug 2018 at 17:14:15 (+0200), Vincent Guittot wrote:
> > > > On Thu, 2 Aug 2018 at 16:14, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > > Good point, setting the util_avg to 0 for new tasks should help
> > > > > filtering out those tiny tasks too. And that would match with the idea
> > > > > of letting tasks build their history before looking at their util_avg ...
> > > > >
> > > > > But there is one difference w.r.t frequency selection. The current code
> > > > > won't mark the system overutilized, but will let sugov raise the
> > > > > frequency when a new task is enqueued. So in case of a fork bomb, we
> > > >
> > > > If the initial value of util_avg is 0, we should not have any impact
> > > > on the util_avg of the cfs rq on which the task is attached, isn't it
> > > > ? so this should not impact both the over utilization state and the
> > > > frequency selected by sugov or I'm missing something ?
> > >
> > > What I tried to say is that setting util_avg to 0 for new tasks will
> > > prevent schedutil from raising the frequency in case of a fork bomb, and
> > > I think that could be an issue. And I think this isn't an issue with the
> > > patch as-is ...
> >
> > ok. So you also want to deal with fork bomb
> > Not sure that you don't have some problem with current proposal too
> > because select_task_rq_fair will always return prev_cpu because
> > util_avg and util_est are 0 at that time
>
> But find_idlest_cpu() should select a CPU using load in case of a forkee
> no ?

So you have to wait for the next tick that will set the overutilized
and disable the want_energy. Until this point, all new tasks will be
put on the current cpu

>
> Thanks,
> Quentin
