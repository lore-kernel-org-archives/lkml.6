Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F366CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4552085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4552085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJJNF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:05:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38308 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeJJNF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:05:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so4173785wrt.5;
        Tue, 09 Oct 2018 22:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zedsi8hVTKvRzPsXTEkAbR83TTL9EzOiBaJEAe47GEI=;
        b=IOWaSYhc7pysxMQpiJhIegwECSwgzAhMZe/Ok166hDr592O7sNqO/hvz/BabsN37bh
         rsUX5yK7uYaxsCTLeS4x2IX66NtM/JbObtLE9iR1SFyD0JPdcKuCvfnzTFinfmQmOEW5
         1H3Kxf2QtQl490jkcjTR5l/tOjl9BqB4+T/+tPHSxXhrmz2iZj2xvJ3IgJoQXD2rthYB
         hT0qRyM6VIasaUP3+DtC8PDintW7IO2dBKhVI3MbCH/GBDjs1sb5nzBvkdiG2jvj9YUv
         RybZ3ZB0Gp9O1BK66oLjdefRXZDUlYrNDWS+BiW/chDy9pA5WG64rXsUYSNLcgCKcLi2
         YmxA==
X-Gm-Message-State: ABuFfoixTtGpNdl4VZvx8tmzHuVq5Wj7lVBEj+LZk3NS6S2JjZWU2qSR
        4IO+3Kj9INRzh2wKtXvpsw==
X-Google-Smtp-Source: ACcGV60l4syWhYApYdNQ/fVBAGqOoHfuqT+/Y37eESpLL1q23Biv3nXlG6JyO6H9Jt4YEWg8NpD7vA==
X-Received: by 2002:adf:9304:: with SMTP id 4-v6mr21337477wro.129.1539150296892;
        Tue, 09 Oct 2018 22:44:56 -0700 (PDT)
Received: from tesla ([2a02:c7d:8eb4:4100:11b0:632:fc1e:e2c7])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm11179353wmd.9.2018.10.09.22.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 22:44:55 -0700 (PDT)
Received: from javi by tesla with local (Exim 4.91)
        (envelope-from <javi@tesla>)
        id 1gA7If-0001Vg-8v; Wed, 10 Oct 2018 06:44:49 +0100
Date:   Wed, 10 Oct 2018 06:44:49 +0100
From:   Javi Merino <javi.merino@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, quentin.perret@arm.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Message-ID: <20181010054449.GC2768@tesla>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 12:24:55PM -0400, Thara Gopinath wrote:
> Thermal governors can respond to an overheat event for a cpu by
> capping the cpu's maximum possible frequency. This in turn
> means that the maximum available compute capacity of the
> cpu is restricted. But today in linux kernel, in event of maximum
> frequency capping of a cpu, the maximum available compute
> capacity of the cpu is not adjusted at all. In other words, scheduler
> is unware maximum cpu capacity restrictions placed due to thermal
> activity.

Interesting, I would have sworn that I tested this years ago by
lowering the maximum frequency of a cpufreq domain, and the scheduler
reacted accordingly to the new maximum capacities of the cpus.

>           This patch series attempts to address this issue.
> The benefits identified are better task placement among available
> cpus in event of overheating which in turn leads to better
> performance numbers.
> 
> The delta between the maximum possible capacity of a cpu and
> maximum available capacity of a cpu due to thermal event can
> be considered as thermal pressure. Instantaneous thermal pressure
> is hard to record and can sometime be erroneous as there can be mismatch
> between the actual capping of capacity and scheduler recording it.
> Thus solution is to have a weighted average per cpu value for thermal
> pressure over time. The weight reflects the amount of time the cpu has
> spent at a capped maximum frequency. To accumulate, average and
> appropriately decay thermal pressure, this patch series uses pelt
> signals and reuses the available framework that does a similar
> bookkeeping of rt/dl task utilization.
> 
> Regarding testing, basic build, boot and sanity testing have been
> performed on hikey960 mainline kernel with debian file system.
> Further aobench (An occlusion renderer for benchmarking realworld
> floating point performance) showed the following results on hikey960
> with debain.
> 
>                                         Result          Standard        Standard
>                                         (Time secs)     Error           Deviation
> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
> 
> Thara Gopinath (7):
>   sched/pelt: Add option to make load and util calculations frequency
>     invariant
>   sched/pelt.c: Add support to track thermal pressure
>   sched: Add infrastructure to store and update instantaneous thermal
>     pressure
>   sched: Initialize per cpu thermal pressure structure
>   sched/fair: Enable CFS periodic tick to update thermal pressure
>   sched/fair: update cpu_capcity to reflect thermal pressure
>   thermal/cpu-cooling: Update thermal pressure in case of a maximum
>     frequency capping
> 
>  drivers/base/arch_topology.c  |  1 +
>  drivers/thermal/cpu_cooling.c | 20 ++++++++++++-

thermal?  There are other ways in which the maximum frequency of a cpu
can be limited, for example from userspace via scaling_max_freq.

When something (anything) changes the maximum frequency of a cpufreq
policy, the scheduler should be notified.  I think this change should
be done in cpufreq instead to make it generic and not particular to
a given maximum frequency "capper".

Cheers,
Javi
