Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB2AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACDD214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkK9Zk+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACDD214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJJWma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:42:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54491 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJWma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:42:30 -0400
Received: by mail-it1-f195.google.com with SMTP id l191-v6so8598652ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqZNGkJBI3w2FyVhG/oP0c9Bt8VrqtJEYeeYlT2jZkI=;
        b=CkK9Zk+5Mm5RbfCq8zrQzXzCQZst5P6xbK/cfM79t9TqnacRRSGm8uyzjdlDl//9ND
         Z7aPzJwLVmNGRcUafvUN9C51SGmbJOCqp/5/TPebPb57jpQkm6HcFc75C51Dofml+mZ6
         U3xFOq3GvJiRIFOCXmtt7rXFLgL37xtnwg0BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqZNGkJBI3w2FyVhG/oP0c9Bt8VrqtJEYeeYlT2jZkI=;
        b=Kpb4/6mndat4iWo2BY3ZUBnxUmumFoQiDFoObiRwszYB+/vR0ILLSK+4IVfStdwPdW
         VNij05eYEcHA07RT2Kx3jF7nEZwiJOoZmmvYeUsSycQVvWcdBFge9q8ixazjbqJpTQEb
         60vuW6upodED8efijCILrjHn2YeWkj2dBBdC72rZR0XIEqlu8exK6tcwpVsuj4n4Xv/S
         FcBTPsDMxrPbYito8YzEJnbscnIlHXXkCUVJCRZIWwmQ/TUFttxNa329yqfXovi2vDlf
         oi1YT0OM6fllB1AbD9Za5MUshjnmuWSZA1zoz+IumA/xxUFgzEnbmhIIc+D3zOIRtI3A
         EpTQ==
X-Gm-Message-State: ABuFfohuJWD8cZOpOwzLt1lVb+s4Q+JluOJ71WOOuttwXOc+hpkVZuIy
        WBKCqLxnhT9sQSx3sB0nqCZA+voISxn8nnfv4f2VKA==
X-Google-Smtp-Source: ACcGV61Mf/eTNqeuduefzXtoMC4U3GCO5MmBh769dP786MkRLk2yUoUyHFnB80cw+tqrZrIe/7Iv4AO6iXUpL/89+fQ=
X-Received: by 2002:a24:bd41:: with SMTP id x62-v6mr1153916ite.152.1539184790069;
 Wed, 10 Oct 2018 08:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
 <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
 <20181010095459.orw2gse75klpwosx@queper01-lin> <CAKfTPtA+FWrMnerQhrNQhvmvVSK_S86da=8shpdET-807zZgVg@mail.gmail.com>
 <20181010103623.ttjexasymdpi66lu@queper01-lin> <CAKfTPtBM24F99OhtjWU-cx4DdFFpvUMMDYuqZH_vaJg9HEpPTw@mail.gmail.com>
 <20181010130549.hzpkaskvlgifbdrp@queper01-lin> <CAKfTPtA=GYaiKcJ9N5zEnzxJTKBATG41c0xDjhbA21G-Cv6LvA@mail.gmail.com>
 <20181010134755.jrigtogbxwaz2izb@queper01-lin>
In-Reply-To: <20181010134755.jrigtogbxwaz2izb@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 10 Oct 2018 17:19:38 +0200
Message-ID: <CAKfTPtAjS+D7L9ckDw4bYayPf29EEkFLAzx1SeEa6Ue_V+iPyg@mail.gmail.com>
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

On Wed, 10 Oct 2018 at 15:48, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Wednesday 10 Oct 2018 at 15:27:57 (+0200), Vincent Guittot wrote:
> > On Wed, 10 Oct 2018 at 15:05, Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > On Wednesday 10 Oct 2018 at 14:04:40 (+0200), Vincent Guittot wrote:
> > > > This patchset doesn't touch cpu_capacity_orig and doesn't need to  as
> > > > it assume that the max capacity is unchanged but some capacity is
> > > > momentary stolen by thermal.
> > > >  If you want to reflect immediately all thermal capping change, you
> > > > have to update this field and all related fields and struct around
> > >
> > > I don't follow you here. I never said I wanted to change
> > > cpu_capacity_orig. I don't think we should do that actually. Changing
> > > capacity_of (which is updated during LB IIRC) is just fine. The question
> > > is about what you want to do there: reflect an averaged value or the
> > > instantaneous one.
> >
> > Sorry I though your were speaking about updating this cpu_capacity_orig.
>
> N/p, communication via email can easily become confusing :-)
>
> > With using instantaneous max  value in capacity_of(), we are back to
> > the problem raised by Thara that  the value will most probably not
> > reflect the current capping value when it is used in LB, because LB
> > period can quite long on busy CPU (default max value is 32*sd_weight
> > ms)
>
> But averaging the capping value over time doesn't make LB happen more
> often ... That will help you account for capping that happened in the

But you know what happens in average between 2 LB

> past, but it's not obvious this is actually a good thing. Probably not
> all the time anyway.
>
> Say a CPU was capped at 50% of it's capacity, then the cap is removed.
> At that point it'll take 100ms+ for the thermal signal to decay and let
> the scheduler know about the newly available capacity. That can probably

But the point is that you don't know:
- if the capping will not happen soon. If the pressure has reached the
50%,  it means that it already happened quite often in the past 100ms.
- if there is really available capacity as the current sum of
utilization reflects what was available for tasks and not what the
tasks really wants to use


> be a performance hit in some use cases ... And the other way around, it
> can also take forever for the scheduler to notice that a CPU has a

What do you mean by forever ?

> reduced capacity before reacting to it.
>
> If you want to filter out very short transient capping events to avoid
> over-reacting in the scheduler (is this actually happening ?), then
> maybe the average should be done on the cooling device side or something
> like that ?
>
> Thanks,
> Quentin
