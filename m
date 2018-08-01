Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3CBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4715420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2mWDl83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4715420894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbeHALZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:25:25 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43923 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbeHALZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:25:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so33411499oib.10;
        Wed, 01 Aug 2018 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vnzbhlXPkLpemDsdY13D6KE0aYQPyzedPywqzD0RHBY=;
        b=N2mWDl83cW1E7Sj8zPqaJ4dYjYpoX2XHK13RP50t3sRZSIuX/Gv8qWY2UMy02kJBSB
         ZZDL8QjLz/eymdmamSh9seBa1B2VjCWibE6+o4RSDW4PZ4lPZVD5im+7vSmdmXfu0syw
         tsG6FGOtuj7s6bY6DXKFJi66Ky8G6k/jkTC/tVsVs3QIzu9TmAxGdDAHEBoWuTguIAjm
         RGrwL5NtO1DNI6DGMyqKjS+jJFzhNs/w6Qzyj8TsuXkk2pTKNllg0CyuuHbnm1GWgC3u
         9IuzTOS+Rp83M3lhQdjB2EWhT/T8HOTsBceaEx4YNQPolQHRrzZp/ykd5CIG5hZ1JJ3T
         uLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vnzbhlXPkLpemDsdY13D6KE0aYQPyzedPywqzD0RHBY=;
        b=b+LhEZkW0nxMCrGGYgBP+8i1+LyDglPO7SPUmimz/pn595N3ahlegYi4SHtotMu9VI
         iNokbi0mZCn7yblSMENZ8PbLDurP13YFEn1xH3IgeXoIu3S2UqTL2L1iX5l7gbei7xNs
         E3hkwj1CSB285yqeYQFdRo2vfa7HjrAQHvpXhHbe57VlwTNQGznQyA/fBrGAvmvKZE+T
         /RzhCm2QqWQ7uEF2JV+YaQ2l3pwa6JHojoNKhGHGG+iASLjsj4NrjThJBN9YNPU3MWKd
         w9GKO8iDT0D9mcfGT+CM73wRMwhbVoN9dwZOs/C4dmrjVj0cJIIX1opdc5Iu7dqWawH8
         8iTA==
X-Gm-Message-State: AOUpUlHyowq5wL0Y91tfJdTTKj8+rIph6QTQJT31aNHwdZmaBNxad2io
        da65p7Q/KL2xOyziVpPzRDiJeQfI1cEQ9W0ExkY=
X-Google-Smtp-Source: AAOMgpf8C6oRTQyr+ZowUL3q3VDA0E9e2bN7JjVJrd7kIVgUVRsLXLuXsQHyKEpplRiUEMNER7S7NcpdCuz9DnVh0MQ=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr2842754oie.174.1533116431201;
 Wed, 01 Aug 2018 02:40:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 02:40:30 -0700 (PDT)
In-Reply-To: <20180801092325.g2upcivcvdo62hub@queper01-ThinkPad-T460s>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com> <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin> <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
 <CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com>
 <20180801082353.egym4tsbr7ppql27@queper01-lin> <CAJZ5v0joYFXkXxoV8odPtrCNW=jAw3RVv3rTzMoabeYWGDnREw@mail.gmail.com>
 <20180801092325.g2upcivcvdo62hub@queper01-ThinkPad-T460s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Aug 2018 11:40:30 +0200
X-Google-Sender-Auth: R0js_MjXRfhGnnjg6QBxkzWfvvI
Message-ID: <CAJZ5v0g7VK3Gh5L5PM_z3_GbuaguAd_Dz17RmA6-0pTChuW+Sg@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@quicinc.com,
        skannan@quicinc.com, Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>,
        linux-pm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 11:23 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> On Wednesday 01 Aug 2018 at 10:35:32 (+0200), Rafael J. Wysocki wrote:
>> On Wed, Aug 1, 2018 at 10:23 AM, Quentin Perret <quentin.perret@arm.com> wrote:
>> > On Wednesday 01 Aug 2018 at 09:32:49 (+0200), Rafael J. Wysocki wrote:
>> >> On Tue, Jul 31, 2018 at 9:31 PM,  <skannan@codeaurora.org> wrote:
>> >> >> On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org wrote:
>> >> >>> If it's going to be a different aggregation from what's done for
>> >> >>> frequency
>> >> >>> guidance, I don't see the point of having this inside schedutil. Why not
>> >> >>> keep it inside the scheduler files?
>> >> >>
>> >> >> This code basically results from a discussion we had with Peter on v4.
>> >> >> Keeping everything centralized can make sense from a maintenance
>> >> >> perspective, I think. That makes it easy to see the impact of any change
>> >> >> to utilization signals for both EAS and schedutil.
>> >> >
>> >> > In that case, I'd argue it makes more sense to keep the code centralized in
>> >> > the scheduler. The scheduler can let schedutil know about the utilization
>> >> > after it aggregates them. There's no need for a cpufreq governor to know
>> >> > that there are scheduling classes or how many there are. And the scheduler
>> >> > can then choose to aggregate one way for task packing and another way for
>> >> > frequency guidance.
>> >>
>> >> Also the aggregate utilization may be used by cpuidle governors in
>> >> principle to decide how deep they can go with idle state selection.
>> >
>> > The only issue I see with this right now is that some of the things done
>> > in this function are policy decisions which really belong to the governor,
>> > I think.
>>
>> Well, the scheduler makes policy decisions too, in quite a few places. :-)
>
> That is true ... ;-) But not so much about frequency selection yet I guess
>
>> The really important consideration here is whether or not there may be
>> multiple governors making different policy decisions in that respect.
>> If not, then where exactly the single policy decision is made doesn't
>> particularly matter IMO.
>
> I think some users of the aggregated utilization signal do want to make
> slightly different decisions (I'm thinking about the RT-go-to-max thing
> again which makes perfect sense in sugov, but could possibly hurt EAS).

Fair enough.

> So the "hard" part of this work is to figure out what really is a
> governor-specific policy decision, and what is common between all users.
> I put "hard" between quotes because I only see the case of RT as truly
> sugov-specific for now.

OK

> If we also want a special case for DL, Peter's enum should work OK, and
> enable to add more special cases for new users (cpuidle ?) if needed.
> But maybe that is something for later ?

I agree.  That can be done later if need be.
