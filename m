Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeDOMBI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 08:01:08 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33225 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeDOMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 08:01:06 -0400
X-Google-Smtp-Source: AIpwx48BT6VYU9Px33XUWXp/wJcIn3pSUCzdWZwxDttdbt54CeWUmn1nLw8UzX/WPnqv8TOXVOFU8oT/2k/YUNypCeA=
MIME-Version: 1.0
In-Reply-To: <08e478a1-e1ff-4547-b95b-2975bc5c5b5d@arm.com>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org> <08e478a1-e1ff-4547-b95b-2975bc5c5b5d@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 15 Apr 2018 14:00:45 +0200
Message-ID: <CAKfTPtBJwDCFB=tkSYyFK58kOF9C+JjZY=1c=hf3JLG2eB=G5g@mail.gmail.com>
Subject: Re: [PATCH 0/4 v4] sched/rt: track rt rq utilization
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On 15 April 2018 at 13:56, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 03/16/2018 12:25 PM, Vincent Guittot wrote:
>
> [...]
>
>
>> For a 15 seconds long test on a hikey 6220 (octo core cortex A53
>> platfrom),
>> the cpufreq statistics outputs (stats are reset just before the test) :
>> $ cat /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans
>> without patchset : 1230
>> with patchset : 14
>>
>> If we replace the cfs thread of rt-app by a sysbench cpu test, we can see
>> performance improvements:
>>
>> - Without patchset :
>> Test execution summary:
>>      total time:                          15.0009s
>>      total number of events:              4903
>>      total time taken by event execution: 14.9972
>>      per-request statistics:
>>           min:                                  1.23ms
>>           avg:                                  3.06ms
>>           max:                                 13.16ms
>>           approx.  95 percentile:              12.73ms
>>
>> Threads fairness:
>>      events (avg/stddev):           4903.0000/0.00
>>      execution time (avg/stddev):   14.9972/0.00
>>
>> - With patchset:
>> Test execution summary:
>>      total time:                          15.0014s
>>      total number of events:              7694
>>      total time taken by event execution: 14.9979
>>      per-request statistics:
>>           min:                                  1.23ms
>>           avg:                                  1.95ms
>>           max:                                 10.49ms
>>           approx.  95 percentile:              10.39ms
>>
>> Threads fairness:
>>      events (avg/stddev):           7694.0000/0.00
>>      execution time (avg/stddev):   14.9979/0.00
>>
>> The performance improvement is 56% for this use case.
>
>
> How do you get this number? Normally we use the 'total time' value.

The test stop after an defined amount of time with --max-time=15 in my case

>
> [...]
