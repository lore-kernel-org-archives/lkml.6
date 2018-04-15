Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbeDOL5D (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 07:57:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52012 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbeDOL5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 07:57:02 -0400
Subject: Re: [PATCH 0/4 v4] sched/rt: track rt rq utilization
To: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <08e478a1-e1ff-4547-b95b-2975bc5c5b5d@arm.com>
Date: Sun, 15 Apr 2018 13:56:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 12:25 PM, Vincent Guittot wrote:

[...]

> For a 15 seconds long test on a hikey 6220 (octo core cortex A53 platfrom),
> the cpufreq statistics outputs (stats are reset just before the test) :
> $ cat /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans
> without patchset : 1230
> with patchset : 14
> 
> If we replace the cfs thread of rt-app by a sysbench cpu test, we can see
> performance improvements:
> 
> - Without patchset :
> Test execution summary:
>      total time:                          15.0009s
>      total number of events:              4903
>      total time taken by event execution: 14.9972
>      per-request statistics:
>           min:                                  1.23ms
>           avg:                                  3.06ms
>           max:                                 13.16ms
>           approx.  95 percentile:              12.73ms
> 
> Threads fairness:
>      events (avg/stddev):           4903.0000/0.00
>      execution time (avg/stddev):   14.9972/0.00
> 
> - With patchset:
> Test execution summary:
>      total time:                          15.0014s
>      total number of events:              7694
>      total time taken by event execution: 14.9979
>      per-request statistics:
>           min:                                  1.23ms
>           avg:                                  1.95ms
>           max:                                 10.49ms
>           approx.  95 percentile:              10.39ms
> 
> Threads fairness:
>      events (avg/stddev):           7694.0000/0.00
>      execution time (avg/stddev):   14.9979/0.00
> 
> The performance improvement is 56% for this use case.

How do you get this number? Normally we use the 'total time' value.

[...]
