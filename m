Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D271ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285FC20844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LlTDDUEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285FC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbeGXSTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:19:23 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34632 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbeGXSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:19:23 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so4041883ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GU92F4OTBoMC2haJ9enew6pJIwqBhp/7Wiyd72zRXgw=;
        b=LlTDDUEEbMA9HW0jZwHzh5wab8SI/TJjihGHWEVoL0HsdM84w/L7yEz0q2FCWHmLk3
         HE+vhMbZ5VjHcfGuaDN/w9s1gC3BeVW3AB95S8Y6bexdHAogoHfusjGyj4xTK89YOmYJ
         DkWJXeyVsvzJX8Q5zDv31ir0flkkClvubq3Q0lgKNEGtOcEoZtWKNFzTB0jHTJshJ0yZ
         f0BrriTHgwwr502lLLQ51JD8AiopigeoMR325D5GrgmB0/ZSlaupfkLK/HtjOjCK+K2d
         +MQgOvpB2EjoJ2pONY0ew4LCsJ6LBf6aJkbELWmHf/6PxuZKPfZgsKcPWWG/7fpQDdgH
         /k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GU92F4OTBoMC2haJ9enew6pJIwqBhp/7Wiyd72zRXgw=;
        b=UIeLlvxGj8sIAgoKQIIXOMESrbKH7vRJRuwAhy3FWnvqMlhIQAUYma8cU5OLVL4v7P
         hdl3jxRIJqRYU7coDzD+ST1oMFkYGiGsV2dSq8JP2IGKQYsgkZjaTiemsHqWm/W/hMJg
         HIdJZuZc+cu+ykrC/cHRvsBHV0mi3Fq5Bip3U27Uj3AG48Pd0MMI690hm7TQYgK9scBp
         ZS/tl7xkEWOf6FC0/ZN7KNmkZrz9yNSVJ+0i04AV+r1U9XaVGsjTCM8mWAnnT2DXdOWU
         7FxM4s5DX0IEgJ3cTg5OMLoc7t3MRFRq2H4WfLc35cG85g21lWO1w1Fe+UzgOVFuz4gW
         c+SQ==
X-Gm-Message-State: AOUpUlEJx3NoRh/Q5W80QJh8sEbmSEhJBk01Li9tBRDGkPuttBKgpebJ
        w6uleYsY4PrAJKyFTBB1s5W/fZRQbL25lWXY4Rdu5g==
X-Google-Smtp-Source: AAOMgpcTg2AyWS38CjV2wVLpGTnlIKrzzKfvbrfWVVzMmkbt4xD3ols1DtWl0a0KWwzsx6XC8Ib29EO2+ORzxDKnHSE=
X-Received: by 2002:a5e:8341:: with SMTP id y1-v6mr2181207iom.183.1532452315260;
 Tue, 24 Jul 2018 10:11:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:e445:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 10:11:54
 -0700 (PDT)
In-Reply-To: <20180724164303.GB3162@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-13-patrick.bellasi@arm.com> <CAJuCfpEwRtXoa_tnWTFP8CuyPMHsLAXky14K_jyphEeo2d32qg@mail.gmail.com>
 <20180724164303.GB3162@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 24 Jul 2018 10:11:54 -0700
Message-ID: <CAJuCfpHddNKXNVBs21sCADcHjW7zxxue8jg1B4KbPh-QLNe46g@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] sched/core: uclamp: use percentage clamp values
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:43 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 21-Jul 21:04, Suren Baghdasaryan wrote:
>> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>
> [...]
>
>> > +static inline unsigned int scale_from_percent(unsigned int pct)
>> > +{
>> > +       WARN_ON(pct > 100);
>> > +
>> > +       return ((SCHED_FIXEDPOINT_SCALE * pct) / 100);
>> > +}
>> > +
>> > +static inline unsigned int scale_to_percent(unsigned int value)
>> > +{
>> > +       unsigned int rounding = 0;
>> > +
>> > +       WARN_ON(value > SCHED_FIXEDPOINT_SCALE);
>> > +
>> > +       /* Compensate rounding errors for: 0, 256, 512, 768, 1024 */
>> > +       if (likely((value & 0xFF) && ~(value & 0x700)))
>> > +               rounding = 1;
>>
>> Hmm. I don't think ~(value & 0x700) will ever yield FALSE... What am I missing?
>
> So, 0x700 is the topmost 3 bits sets (111 0000 0000) which different
> configuration corresponds to:
>
>  001 0000 0000 =>  256
>  010 0000 0000 =>  512
>  011 0000 0000 =>  768
>  100 0000 0000 => 1024
>
> Thus, if 0x700 matches then we have one of these values in input and
> for these cases we have to add a unit to the percentage value.
>
> For the case (value == 0) we translate it into 0% thanks to the check
> on (value & 0xFF) to ensure rounding = 0.
>

I think just (value & 0xFF) is enough to get you the right behavior.
~(value & 0x700) is not needed, it's effectively a NoOp which always
yields TRUE. For any *value* (value & 0x700) == 0x...00 and ~(value &
0x700) == 0x...FF == TRUE.

> Here is a small python snippet I've used to check the conversion of
> all the possible percentage values:
>
> ---8<---
> values = range(0, 101)
> for pct in xrange(0, 101):
>         util = int((1024 * pct) / 100)
>         rounding = 1
>         if not ((util & 0xFF) and ~(util & 0x700)):
>             print "Fixing util_to_perc({:3d} => {:4d})".format(pct, util)
>             rounding = 0
>         pct2 = (rounding + ((100 * util) / 1024))
>         if pct2 in values:
>                 values.remove(pct2)
>         if pct != pct2:
>             print "Convertion failed for: {:3d} => {:4d} => {:3d}".format(pct, util, pct2)
> if values:
>     print "ERROR: not all percentage values converted"
> ---8<---
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
