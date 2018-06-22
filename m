Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE01C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942F721A5E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KT+Nvdy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942F721A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeFVMXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:23:35 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38025 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeFVMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:23:34 -0400
Received: by mail-it0-f67.google.com with SMTP id v83-v6so2641965itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTeN8qG9maKJ+t1RoEZXFv5P6FKpdKvuLUNB72MUino=;
        b=KT+Nvdy1gPnPLxFssLVNu6KcpZriXAQY+2krIslvX0HU9zeo7+mtIOiC8K8IWB590G
         uXuOlEsRbT+WpWkgTQkFkEdrGaAcBabp2zcRSbh01c97VaLogjS5363AEWkZ6xS6yHNi
         1D1dDP4iG7hGaqbbJV569eB4el6JJEXLes0pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTeN8qG9maKJ+t1RoEZXFv5P6FKpdKvuLUNB72MUino=;
        b=WJC2Udful0FyFcOr8c/zp5x2koRJxbC9StxK0+rzYc5OxcVvYs9A7fYJmy9W37fQ9C
         a1bpVFNCznU3RfPskm+yuulIcly25X3ScTwGt978KUmt8rrNLnXSP1j/xcxqfv2gRoRk
         HLj2Qv/O6dyEqA85Ui/o51LzetigfNfWUY9HtPDZvEgTdcGfT3Uwz7vo5nCzQjr4PLuN
         l8zyDJfmDFN9FkuMkpU8HvZm8/E/loTxIUeCtpjeoinPHqp1CmtVt0QQE8Tz8fLB4u1b
         zYyUFOb3WeMFLb8qnSW4K4zzdYh8fuuA4g/X9J/ooojk55kkMIIpKGNPzF2ycueN/OSD
         v2Nw==
X-Gm-Message-State: APt69E3oSWY7syP+qYugTKJKTcAM+kY5TYn4h/bSuRA49ifhvO8zvrwM
        NYPqE+pIKazMhTzXzeIQ1Wi2pSXZ/t4DSkSBWyB2TTS7
X-Google-Smtp-Source: ADUXVKLiuWf2Td1acyVzUtMkMFcnPAbw0IMYbP6Z9JA7jRJlE+qdKJVCY4b7a4+UbynfzPJ4vYgAb/pLUjQ9ScvPVWM=
X-Received: by 2002:a02:8604:: with SMTP id e4-v6mr1154027jai.12.1529670213582;
 Fri, 22 Jun 2018 05:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net> <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jun 2018 14:23:22 +0200
Message-ID: <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
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
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 at 13:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 22, 2018 at 08:58:53AM +0100, Quentin Perret wrote:
> > Say we have 50% of the capacity stolen by RT, and a 25% CFS task
> > running. If we re-scale, we'll end up with a 50% request for CFS
> > (util==512 for your code above). But if we want to see a little bit
> > of idle time in the system, we should really request an OPP for 75%+ of
> > capacity no ? Or am I missing something ?
>
> That is true.. So we could limit the scaling to the case where there is
> no idle time, something like:
>
>         util = sg_cpu->util_cfs;
>
>         cap_cfs = (1024 - (sg_cpu->util_rt + ...));
>         if (util == cap_cfs)
>                 util = sg_cpu->max;
>
> That specifically handles the '0% idle -> 100% freq' case, but I don't
> realy like edge behaviour like that. If for some reason it all doesn't
> quite align you're left with bits.
>
> And the linear scaling is the next simplest thing that avoids the hard
> boundary case.
>
> I suppose we can make it more complicated, something like:
>
>              u           u
>   f := u + (--- - u) * (---)^n
>             1-r         1-r
>
> Where: u := cfs util
>        r := \Sum !cfs util
>        f := frequency request
>
> That would still satisfy all criteria I think:
>
>   r = 0      -> f := u
>   u = (1-r)  -> f := 1
>
> and in particular:
>
>   u << (1-r) -> f ~= u
>
> which casuses less inflation than the linear thing where there is idle
> time.
>
> In your specific example that ends up with:
>
>              .25           .25
>   f = .25 + (--- - .25) * (---)^n = .25 + .0625 (for n=2)
>              .5            .5     = .25 + .125  (for n=1)
>
> But is that needed complexity?

And we are not yet at the right value for quentin's example as we need
something around 0.75 for is example
The non linearity only comes from dl so if we want to use the equation
above, u should be (cfs + rt) and r = dl
But this also means that we will start to inflate the utilization to
get higher OPP even if there is idle time and lost the interest of
using dl bw
