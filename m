Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE51C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF6F20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT1XROVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF6F20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbeHAJRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:17:10 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34553 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733234AbeHAJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:17:09 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so32864274ois.1;
        Wed, 01 Aug 2018 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tX9UsDEyOZJNvBTNXoFgx5DUuXw5/gizszvlw+nzdRY=;
        b=OT1XROVP7xHBJnJV5orGRr9R/V6yx6vK1ey0R0IP+5WNn/A+42vKTVmx56koRQtAIR
         WUNSAKx5iLlAdcQWVLLQS4+893MQ04+knJyBRXZhlZaatjtTobp8IEupbIdsr5w1KWMP
         qHhv4lu1tqPbiulpqptAlWdjP/rv+zvNxJYZkXA+7Nl+7pjHSSdjA6ReThwG+ez1EDzl
         GY/Opuy4kKo6N7ATHsgH5N0U1CwWsP5XVuFdcHHmh6g/I4YSyRJbnd6OOu9r11iJwwbj
         m49g8hFYLRnD9/kDJHW0eRv5xvFUoFmtnO/uRoWLJMdf/DVzcnEF/niCWp3ZGXxvbHa4
         gYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tX9UsDEyOZJNvBTNXoFgx5DUuXw5/gizszvlw+nzdRY=;
        b=ZrG+O0IpHpJ4w34bXXlH92yTVmPkEGy1wSIJTQyEzbNufQEw9lCccedTO9Vgz/K1P9
         iQCC3pU5LxaBB2+SsQBTQx3Rsmy//fnvDo4kXQku1Tef4fGBX7hGabXbag70je/66i5D
         oqyL2j8sC62GbtwpR44ao1vG1sFlKeum6OrqM15CHgPqukBPvYcstL+vEffMYPOq4OBB
         /LwjfgaMZ6nJJfNzy0mnx6vJQN9fkNpgH8h2PFjIGeKrkzYUFnx3i+bFXZ6pF6rNG4Kj
         2jSMxGTwj5WH1eWaIcqY3eDp7B+4Hb8i4Qf0cnRUFVkj4VaVJTvFd1hC6Ps9yd5iFqHl
         uVQw==
X-Gm-Message-State: AOUpUlGQt7Hh6RVQ06DjxJwtKTfQIY10p9hIJx4Nf+x7Q/VP1feJjIAe
        jjJYYrAiANDqKx1DwJ3A/IncpzrvPPn69tzyWGE=
X-Google-Smtp-Source: AAOMgpdS9R0dsZgmPLUphzDOX4D4S4XTWkYCMO8ug/iF/+qRmlSKdxBYMTKFL5aciK84eGgi0pjlfKUmBUqzT8JSexs=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr2551197oie.233.1533108770086;
 Wed, 01 Aug 2018 00:32:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 00:32:49 -0700 (PDT)
In-Reply-To: <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com> <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin> <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Aug 2018 09:32:49 +0200
X-Google-Sender-Auth: hYsWIe1o8-mDj-kKXMuOszoqaCI
Message-ID: <CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
To:     Saravana Kannan <skannan@codeaurora.org>,
        Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Jul 31, 2018 at 9:31 PM,  <skannan@codeaurora.org> wrote:
> On 2018-07-31 00:59, Quentin Perret wrote:
>>
>> On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org wrote:
>> [...]
>>>
>>> If it's going to be a different aggregation from what's done for
>>> frequency
>>> guidance, I don't see the point of having this inside schedutil. Why not
>>> keep it inside the scheduler files?
>>
>>
>> This code basically results from a discussion we had with Peter on v4.
>> Keeping everything centralized can make sense from a maintenance
>> perspective, I think. That makes it easy to see the impact of any change
>> to utilization signals for both EAS and schedutil.
>
>
> In that case, I'd argue it makes more sense to keep the code centralized in
> the scheduler. The scheduler can let schedutil know about the utilization
> after it aggregates them. There's no need for a cpufreq governor to know
> that there are scheduling classes or how many there are. And the scheduler
> can then choose to aggregate one way for task packing and another way for
> frequency guidance.

Also the aggregate utilization may be used by cpuidle governors in
principle to decide how deep they can go with idle state selection.
