Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4C5C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D9220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZ7Y+rqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D9220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeILA0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:26:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36912 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeILA0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:26:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so27162536wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wbJZNCvLlgJSFs/3QgwbaycN4QcEpBXubnHmC/YM7bY=;
        b=oZ7Y+rqmVvawzBn9t1hGx+4NWXzxboJhahE4k8J9opbdJ8kTp1iIGX5xvwp4RxMRts
         qQMaEeePgAYohVYXwuMZZpM6K6EQITsAVDkuM29UAvrQkr0PXj2kMUocvTZ1kshLceWc
         wZyj0ckfDlxcCoZAtn2mkOsGn4aEgHXk8l4KRpzqXHG1xt7HG+g94ruZkljGUv2g7tC9
         6mCdE/Z5IQj2LxM/Gjrfc1FwnSs8n+sF9/t0XKlKZ+t/jSx386KdUZqfkqpFDQjZ/Y1j
         ATU2drUZcO40wsiElldEJmuBjzUdK55jj+YZurqsN4f7hIVrtEybS2Awn/F4WEZFSLCN
         2frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wbJZNCvLlgJSFs/3QgwbaycN4QcEpBXubnHmC/YM7bY=;
        b=kTvm1rWvXfs67vsAWHaSfDvXN08M6AAJKP8xcMTjJfAhvooGGzcB8ZuyXOOk5Pw1hA
         Eoh8CCRFDQhLRzRzSUSY4V7+A9jEMuD80cT7sKYNMto5Wc8RzBZPGwYzqDGADGRjtJRr
         DGztzSHtLaRBZsiSM5JzHCwuMKxS8nYI4P+Od+78gzoW7nl9IenvHLWHGMzutaAWfVcI
         EbcqFWpMFTtBzyu5+ayCIHkjCa4CVF0UXtmOnxnAQ8fg9ERGaAd0bEUWLND7qPO3jpOt
         APLEv5EgCkP/BaPnniQg/0xXeKgBG6E6z8lCqeLymkPmGI0yNdBHaG81TRCbFBP3cJJv
         WLwQ==
X-Gm-Message-State: APzg51BYO+Jzm6y72SBEPTWHsc3K2yl5q0SMKK/pMuREzZN4bdbwKryE
        mvM+g5HjcfffShaxu3H0btUuKWoD6gGxZcGZvuJkCA==
X-Google-Smtp-Source: ANB0VdaIpKYitBsQJF3Tz6izIpzRwWSQDJb5bYgXGYjxmABqv+B+aBFcgBmGW2SgsyAAc9EcmgwIvQb1Un3bdNoj4+s=
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr18216992wrp.184.1536693928584;
 Tue, 11 Sep 2018 12:25:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:c710:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 12:25:28
 -0700 (PDT)
In-Reply-To: <20180911164637.GC1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-12-patrick.bellasi@arm.com> <CAJuCfpGSUzo9gxWZABUUKaEEEvxdnvny9d1ErnLVLEKrkYf+eQ@mail.gmail.com>
 <20180911164637.GC1413@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 11 Sep 2018 12:25:28 -0700
Message-ID: <CAJuCfpGK0PRt9-=+mjOM=VQqas8DPxT7YPiZojiQQiVuhua7bA@mail.gmail.com>
Subject: Re: [PATCH v4 11/16] sched/core: uclamp: add system default clamps
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
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

On Tue, Sep 11, 2018 at 9:46 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 10-Sep 09:20, Suren Baghdasaryan wrote:
>> On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>
> [...]
>
>> > @@ -1509,12 +1633,17 @@ static void __init init_uclamp(void)
>> >                 uc_se->group_id = UCLAMP_NOT_VALID;
>> >                 uclamp_group_get(NULL, clamp_id, 0, uc_se,
>> >                                  uclamp_none(clamp_id));
>> > +               /*
>> > +                * By default we do not want task-specific clamp values,
>> > +                * so that system default values apply.
>> > +                */
>> > +               uc_se->value = UCLAMP_NOT_VALID;
>> >
>> >  #ifdef CONFIG_UCLAMP_TASK_GROUP
>> >                 /* Init root TG's clamp group */
>> >                 uc_se = &root_task_group.uclamp[clamp_id];
>> >
>> > -               uc_se->effective.value = uclamp_none(clamp_id);
>> > +               uc_se->effective.value = uclamp_none(UCLAMP_MAX);
>>
>> Both clamps are initialized with 1023 because children can go lower
>> but can't go higher? Comment might be helpful.
>
> Yes, that's because with CGroups we set the max allowed value, which
> is also the one used for a clamp IFF:
>  - the task is not part of a more restrictive group
>  - the task has not a more restrictive task specific value
>
> I'll improve this comment on the next respin.
>
>> I saw this pattern of using uclamp_none(UCLAMP_MAX) for both clamps in
>> couple places.
>
> The other place is to define / initialize "uclamp_default_perf", which
> is the default clamps used for RT tasks, introduce by the last patch:
>
>  https://lore.kernel.org/lkml/20180828135324.21976-17-patrick.bellasi@arm.com/
>
> So, RT tasks and root task group are the only two exceptions for
> which, by default, we want a maximum boosting.
>
>> Maybe would be better to have smth like:
>>
>> static inline int tg_uclamp_none(int clamp_id) {
>>     /* TG's min and max clamps default to SCHED_CAPACITY_SCALE to
>> allow children to tighten the restriction */
>>     return SCHED_CAPACITY_SCALE;
>> }
>>
>> and use tg_uclamp_none(clamp_id) instead of uclamp_none(UCLAMP_MAX)?
>> Functionally the same but much more readable.
>
> Not entirely convinced, maybe because of the name you suggest: it
> cannot contain tg, because it applies also to RT tasks when TG are not
> in use.
>
> Maybe something like: uclamp_max_boost(clamp_id) could work instead ?

Sounds good to me.

>
> It will make more explicit that the configuration will maps into a:
>
>      util.min = util.max = SCHED_CAPACITY_SCALE
>
> Cheers,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
