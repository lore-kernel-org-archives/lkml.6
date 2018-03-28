Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeC1Khr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:37:47 -0400
Received: from foss.arm.com ([217.140.101.70]:39232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752649AbeC1Khq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:37:46 -0400
Subject: Re: Problem with commit 31e77c93e432 "sched/fair: Update blocked load
 when newly idle"
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
 <20180324064627.GA10884@linaro.org>
 <c5daea3c-0834-1629-3e38-3db5130eb32f@gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6b151c56-9ead-7bbe-d1b7-b0e6d69c0d7f@arm.com>
Date: Wed, 28 Mar 2018 12:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <c5daea3c-0834-1629-3e38-3db5130eb32f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/24/2018 01:47 PM, Heiner Kallweit wrote:
> Am 24.03.2018 um 07:46 schrieb Vincent Guittot:
>> Hi Heiner,
>>
>> Le Friday 23 Mar 2018 à 22:28:09 (+0100), Heiner Kallweit a écrit :
>>> Recently I started to get the following problems with linux-next:
>>>
>>> - When working via Putty/SSH on the system the console frequently freezes
>>>    for few seconds. Sometimes only opening a second console makes the
>>>    first one react again.
>>>
>>> - I get "INFO: rcu_sched detected stalls on CPUs/tasks:" warnings as
>>>    described in [1].
>>>

I can't catch this issue on my Juno r0 (arm64 big.Little).

root@juno:~# uname -r
4.16.0-rc4-00198-g31e77c93e432

I'm using openssh-client and openssh-server though.

>>> Bisecting the issue resulted in:
>>>
>>> 31e77c93e432dec79c7d90b888bbfc3652592741 is the first bad commit
>>> commit 31e77c93e432dec79c7d90b888bbfc3652592741
>>> Author: Vincent Guittot <vincent.guittot@linaro.org>
>>> Date:   Wed Feb 14 16:26:46 2018 +0100
>>>
>>>      sched/fair: Update blocked load when newly idle
>>>
>>>      When NEWLY_IDLE load balance is not triggered, we might need to update the
>>>      blocked load anyway. We can kick an ilb so an idle CPU will take care of
>>>      updating blocked load or we can try to update them locally before entering
>>>      idle. In the latter case, we reuse part of the nohz_idle_balance.
>>>
>>> After reversing this commit at least the issue with the freezing console
>>> is gone. The second one appeared only sporadically, I still have to see
>>> whether it pops up again.

[...]
