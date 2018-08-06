Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF44C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAC621A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ev+Jw2LZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAC621A0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbeHFOqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:46:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42042 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeHFOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:46:07 -0400
Received: by mail-io0-f195.google.com with SMTP id n18-v6so1336339ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2Wk8ZGLcSoBq1+86H8cJhDiQdO13qDKO2uKaV/GYSI=;
        b=ev+Jw2LZChz4Hk3XQM5qslxRJqYRzhV4PwXTeQqJYvwDAXTOsKyaQVrK0cV2CA3v6z
         p6KnmoRwDIGZg9341+SFBAReKizfrbKOtvS4nBpEqKB/pJbYjA9UE1HG5w5cQAQpr1bx
         N4zaLuHTQMC0htB60rOLFi0Jz+OBkN4osU3d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2Wk8ZGLcSoBq1+86H8cJhDiQdO13qDKO2uKaV/GYSI=;
        b=DKqBaf4MoST2Fm6gzKmVTLvgrx2zEWYikndU0wy5xUNYrPwdgPDNCCxPmNmBQF2lzR
         4I6D4YwTYOnqN/+uEXbP2oCMqs2VM0nIghMockfcjUMRMVAEA/r5YCkE2hMmil8MpIWc
         dEjJc16cgYvvMP8ESY5udZ/iFccb72yvRPhNovK26JBk0SUZtkeedog+7MEuPokkmI9r
         WpEf9Z2mcT1gtmGkG+GIwWqxLWRPl+SS2dtnB9RDqqvc1wCr1dFCYyntBDd5migrm8tB
         B9iVM/LjY4WTJx9ttvl16uAKNgfgaHOW1xa6VUFcIk0VlNKp/UUm4osHs4Vc6B2tBWCg
         Dguw==
X-Gm-Message-State: AOUpUlEmXxGJzHZoPpGOxSzeEw2mmEb5Ldk8qI3/ZlrQwM/HTJqV18KG
        Ww0FX+BxZUKKE91WGElxgmXNFmbFO+CQgxHUeYcsaA==
X-Google-Smtp-Source: AAOMgpdYkhuxLCVV3M6xjvJo04gxfPu21XoSZdeSr47KjxZXbykMM81Ox52IWaV2PlWcbcMyj849QldBjnbAGudsLXg=
X-Received: by 2002:a5e:8341:: with SMTP id y1-v6mr14001798iom.183.1533559031571;
 Mon, 06 Aug 2018 05:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180802153035.vjtmqwdwujvt7ojs@queper01-lin> <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin> <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin> <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin> <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin> <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
 <20180803155547.sxlhxpmhwcoappit@queper01-lin> <CAKfTPtBT-p-Z0EneirfOTwUw=5jEeDGa+4_EE4ogi2Ht7GU9Bg@mail.gmail.com>
 <68689fcb-3cb8-4685-58ef-0bec84be2047@arm.com> <CAKfTPtADSDJJaPr17zD8ZNtS7CQGBwfU6JDGRwssLN20zyW7Nw@mail.gmail.com>
 <1cac0d16-9f50-ed30-2460-340b077faa57@arm.com>
In-Reply-To: <1cac0d16-9f50-ed30-2460-340b077faa57@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Aug 2018 14:37:00 +0200
Message-ID: <CAKfTPtDZs2_4skbGFJkrtq1Z+G_MWue7xC3tcoLs5xcpsBkNUw@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point indicator
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Mon, 6 Aug 2018 at 14:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 08/06/2018 12:33 PM, Vincent Guittot wrote:
> > On Mon, 6 Aug 2018 at 12:08, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 08/06/2018 10:40 AM, Vincent Guittot wrote:
> >>> On Fri, 3 Aug 2018 at 17:55, Quentin Perret <quentin.perret@arm.com> wrote:
> >>>>
> >>>> On Friday 03 Aug 2018 at 15:49:24 (+0200), Vincent Guittot wrote:
> >>>>> On Fri, 3 Aug 2018 at 10:18, Quentin Perret <quentin.perret@arm.com> wrote:
> >>>>>>
> >>>>>> On Friday 03 Aug 2018 at 09:48:47 (+0200), Vincent Guittot wrote:
> >>>>>>> On Thu, 2 Aug 2018 at 18:59, Quentin Perret <quentin.perret@arm.com> wrote:
> >>
> >> [...]
> >>
> >>>> I think we're discussing two different things right now:
> >>>>       1. Should forkees go in find_energy_efficient_cpu() ?
> >>>>       2. Should forkees have 0 of initial util_avg when EAS is enabled ?
> >>>
> >>> It's the same topic: How EAS should consider a newly created task ?
> >>>
> >>> For now, we let the "performance" mode selects a CPU. This CPU will
> >>> most probably be worst CPU from a EAS pov because it's the idlest CPU
> >>> in the idlest group which is the opposite of what EAS tries to do
> >>>
> >>> The current behavior is :
> >>> For every new task, the cpu selection is done assuming it's a heavy
> >>> task with the max possible load_avg,  and it looks for the idlest cpu.
> >>> This means that if the system is lightly loaded, scheduler will select
> >>> most probably a idle big core.
> >>
> >> AFAICS, task load doesn't seem to be used for find_idlest_cpu() (
> >> find_idlest_group() and find_idlest_group_cpu()). So the forkee
> >> (SD_BALANCE_FORK) is placed independently of his task load.
> >
> > hmm ... so what is used if load or runnable load are not used ?
> > find_idlest_group() uses load and runnable load but skip spare
> > capacity in case of fork
>
> Yes, runnable load and load are used, but from the cpus, not from the task.

yes that's right, I have skipped the "task" word when reading.
So scheduler looks for the idlest CPU taking into account only CPU
loads. Then the task load starts to highest value until it get a
chance to reduce and stabilize to its final value

>
> [...]
