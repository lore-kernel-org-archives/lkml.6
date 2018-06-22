Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C54FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF37C241A9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3sU4N6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF37C241A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeFVMOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:14:48 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51865 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeFVMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:14:42 -0400
Received: by mail-it0-f65.google.com with SMTP id n7-v6so2567682itn.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LesqUQ/2PaFjuqbsyrPFETyH1qIwlVeWO4B5FSk4mrI=;
        b=D3sU4N6LKc0ANOtnwEntXYK6iyyMKNbtzkrJLE74q/y5DbzbyVvqoFDFjpd8o2Ga8w
         VHFadmgF8vjOp30IZT1eaNeVuW+5ycBEigPl2+9N1KrnsKKhAgMXYx8hLhmes5GGpnal
         MnhSg8KT/hCqM44vEkuoAgb6rGYVDWdBUj8HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LesqUQ/2PaFjuqbsyrPFETyH1qIwlVeWO4B5FSk4mrI=;
        b=YwVEBsYlb5P7CNqciUqBNldPvqFoCbTB1lE5JbnoCvBCFsA6dKU5ymAIEIOl6tmEbs
         WNP0wgI8IXlbGYYx1IDJADVsA5FEEp6Pr4NUVpraSaycyNw5X7fu571TuugkzZ6FR+pT
         xZmyTGYtp0r/UWNyHkl41/sim4rHeAm/qU0pFqeYV1FkKQvhVB4yJE6XpZZPy1LLfrH4
         uyaz9AoRLhyLIRS1k2Vyry4R2SaxmSby7FmKRMAv/2YuIRuC19VoRk0ke8locVM2g3hx
         LzUCVwZT4b7ZAIx6vHNIl3CUjl4gCwarbedi1VSd0kE9weoUT//WKvcKs07B5Pl5SjLO
         EyMw==
X-Gm-Message-State: APt69E2efnWjmsEvlnNCucPhETXA5x2yJScinCuI0XjbJvCUzKJSM0Ce
        XoWGNoUIE/IYCUH8hBa2hRF6iPY5+dMQvFGLNJKrdA==
X-Google-Smtp-Source: ADUXVKLwlra9v4ys19pkAB9yrp/3OADgAt7rSoMgnWhkD4wL1myc+vr3wDsqsSLuMwu4eEtWb68datd7MlDXLU0TRFA=
X-Received: by 2002:a24:1ad7:: with SMTP id 206-v6mr1285744iti.148.1529669682079;
 Fri, 22 Jun 2018 05:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net> <20180621185706.GA4900@worktop.programming.kicks-ass.net>
 <CAKfTPtA=iWQc3RB2dgJf2LT2e0XezLzGKbQNx=w1xYEPFDEsQQ@mail.gmail.com> <20180622114138.GK2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180622114138.GK2494@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jun 2018 14:14:30 +0200
Message-ID: <CAKfTPtCRvQy7u=7ykY78YQqM_G1X391ePJ=gkGkE_QGT7_Xc7g@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 at 13:41, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 22, 2018 at 10:10:32AM +0200, Vincent Guittot wrote:
> > On Thu, 21 Jun 2018 at 20:57, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > > So this (and the dl etc. equivalents) result in exactly the problems
> > > > complained about last time, no?
> > > >
> > > > What I proposed was something along the lines of:
> > > >
> > > >       util = 1024 * sg_cpu->util_cfs;
> > > >       util /= (1024 - (sg_cpu->util_rt + sg_cpu->util_dl + ...));
> > > >
> > > >       return min(sg_cpu->max, util + sg_cpu->bw_dl);
> >
> > I see that you use sg_cpu->util_dl and sg_cpu->bw_dl in your equation
> > above but this patch 04 only adds rt util_avg and the dl util_avg has
> > not been added yet.
> >  dl util_avg is added in patch 6
> > So for this patch, we are only using sg_cpu->bw_dl
>
> Yeah, not the point really.
>
> It is about how we're going to use the (rt,dl,irq etc..) util values,
> more than which particular one was introduced here.

ok

>
> I'm just not a big fan of the whole: freq := cfs_util + rt_util thing
> (as would be obvious by now).

so I'm not sure to catch what you don't like with the sum ? Is it the
special case for dl and how we switch between dl_bw and dl util_avg
which can generate a drop in frequency
Because the increase is linear regarding rt and cfs
