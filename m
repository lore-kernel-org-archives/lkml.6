Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeC3Gup (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 02:50:45 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:37494 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeC3Gun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 02:50:43 -0400
X-Google-Smtp-Source: AG47ELuQIMv1lEH50Jl9i5xxjOofRdajp1PUcxUmpqgHHqHc6BaeMy1lZv2NvqASXKLOiC7xdH4atZzY3yhOVbfZYqw=
MIME-Version: 1.0
In-Reply-To: <796bbd7b-8512-7370-28c9-0f082dc3f287@gmail.com>
References: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
 <20180324064627.GA10884@linaro.org> <c5daea3c-0834-1629-3e38-3db5130eb32f@gmail.com>
 <6b151c56-9ead-7bbe-d1b7-b0e6d69c0d7f@arm.com> <CAKfTPtDigSEOmtxk7daTTBb3o6kVR8AgUVhu4X6YWutK9yWNwg@mail.gmail.com>
 <CAKfTPtAisq0tQ_Kw3OptJYm=u7tSk6vyi3CFZJdhBxD=d=EN1g@mail.gmail.com> <796bbd7b-8512-7370-28c9-0f082dc3f287@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 30 Mar 2018 08:50:22 +0200
Message-ID: <CAKfTPtD17yUrp5G7gPN6ijB+C-TKJcK1UTCmP_JhMK5DvSDN_g@mail.gmail.com>
Subject: Re: Problem with commit 31e77c93e432 "sched/fair: Update blocked load
 when newly idle"
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 March 2018 at 19:40, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Am 29.03.2018 um 09:41 schrieb Vincent Guittot:

>>
>> I'm finally not so sure that i have the right set up to reproduce the
>> problem as I haven't been able to reproduce it since.
>>
>> Heiner,
>>
>> How fast the problem happens on your board ?
>> Are you doing anything specific on the console that trigger the problem ?
>>
> Hi Vincent,
>
> the lag when working on the console is constantly there, the "rcu_preempt
> detected stalls" happens after several hours (so far always within 24h)
> w/o any triggering event I would be aware of. It occured also when the
> system was idle at that point in time.

Ok, so I don't have the problem on my hikey as the console never lag
on my setup.

Can you send me the config of  your kernel ? I'd like to check if you
have enable something that could trigger such problem

Thanks,
Vincent

>
> Rgds, Heiner
>
>> Regards,
>> Vincent
>>
>>>>
>>>>>>> Bisecting the issue resulted in:
>>>>>>>
>>>>>>> 31e77c93e432dec79c7d90b888bbfc3652592741 is the first bad commit
>>>>>>> commit 31e77c93e432dec79c7d90b888bbfc3652592741
>>>>>>> Author: Vincent Guittot <vincent.guittot@linaro.org>
>>>>>>> Date:   Wed Feb 14 16:26:46 2018 +0100
>>>>>>>
>>>>>>>      sched/fair: Update blocked load when newly idle
>>>>>>>
>>>>>>>      When NEWLY_IDLE load balance is not triggered, we might need to
>>>>>>> update the
>>>>>>>      blocked load anyway. We can kick an ilb so an idle CPU will take
>>>>>>> care of
>>>>>>>      updating blocked load or we can try to update them locally before
>>>>>>> entering
>>>>>>>      idle. In the latter case, we reuse part of the nohz_idle_balance.
>>>>>>>
>>>>>>> After reversing this commit at least the issue with the freezing console
>>>>>>> is gone. The second one appeared only sporadically, I still have to see
>>>>>>> whether it pops up again.
>>>>
>>>>
>>>> [...]
>>>>
>>
>
