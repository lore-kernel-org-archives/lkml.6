Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeDNL30 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 07:29:26 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41941 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeDNL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 07:29:25 -0400
X-Google-Smtp-Source: AIpwx4+pJa6mG6D13lwzrxT1Rch1/ff5CKL0rT0eB8eVTgNVOUC1JCYntMyN8ozw90I9VHAiWYrNfkkJiJ5MHJJsYZs=
MIME-Version: 1.0
In-Reply-To: <20180414100515.GV4064@hirez.programming.kicks-ass.net>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
 <1521199541-15308-3-git-send-email-vincent.guittot@linaro.org> <20180414100515.GV4064@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 14 Apr 2018 13:29:03 +0200
Message-ID: <CAKfTPtBZnRLdeGY_VyLpLX6VW6at2_Nb8z1JRvt+8B1GL9ZJUA@mail.gmail.com>
Subject: Re: [PATCH 2/4 v4] sched/rt: add rt_rq utilization tracking
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 April 2018 at 12:05, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Mar 16, 2018 at 12:25:39PM +0100, Vincent Guittot wrote:
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 783eacf..a8003a9 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -592,6 +592,8 @@ struct rt_rq {
>>       unsigned long           rt_nr_total;
>>       int                     overloaded;
>>       struct plist_head       pushable_tasks;
>> +
>> +     struct sched_avg avg;
>
> We only want this for the root cgroup, right? So why is this per cgroup?

Yes it's only for root cgroup. I have put it there for consistency
with the CFS' PELT but it's only waste Bytes

>
> That is, I was expecting it to be rq::rt_avg or something.
