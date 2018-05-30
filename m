Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968714AbeE3IXh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:23:37 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44161 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968692AbeE3IXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:23:32 -0400
X-Google-Smtp-Source: ADUXVKKbBPNeG6ixkzd8UnFbzmhGm7lEqCNXsPaW04bfaG1Ae+ediDt9vs3GEL7JJdQl5/ya7gkfWrNXzLZZQSYdXoI=
MIME-Version: 1.0
In-Reply-To: <20180530070303.qpcgjng7vaell5me@vireshk-i7>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org> <20180530070303.qpcgjng7vaell5me@vireshk-i7>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 30 May 2018 10:23:10 +0200
Message-ID: <CAKfTPtDp4T=HUR-K3Wcq84cZ3RFDE6A5c5MVHndCb=R8ACYfFw@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] cpufreq/schedutil: add rt utilization tracking
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2018 at 09:03, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25-05-18, 15:12, Vincent Guittot wrote:
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>       /*
>>        * Utilization required by DEADLINE must always be granted while, for
>> @@ -197,7 +205,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>>        * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>>        * ready for such an interface. So, we only do the latter for now.
>>        */
>> -     return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
>> +     return min(sg_cpu->max, util);
>
> Need to update comment above this line to include RT in that ?

yes good point

>
>>  }
>
> --
> viresh
