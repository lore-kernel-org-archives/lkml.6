Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeC2HmD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:42:03 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:50745 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbeC2HmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:42:01 -0400
X-Google-Smtp-Source: AIpwx48bx7QlJ/Dy2LamMsBMH492RARXi99FQkpTIWsG/6N/OqK65S0t2ijLTvC/gO9m1wZPBrCMAVm3raZ64bPSAw8=
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDigSEOmtxk7daTTBb3o6kVR8AgUVhu4X6YWutK9yWNwg@mail.gmail.com>
References: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
 <20180324064627.GA10884@linaro.org> <c5daea3c-0834-1629-3e38-3db5130eb32f@gmail.com>
 <6b151c56-9ead-7bbe-d1b7-b0e6d69c0d7f@arm.com> <CAKfTPtDigSEOmtxk7daTTBb3o6kVR8AgUVhu4X6YWutK9yWNwg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 29 Mar 2018 09:41:40 +0200
Message-ID: <CAKfTPtAisq0tQ_Kw3OptJYm=u7tSk6vyi3CFZJdhBxD=d=EN1g@mail.gmail.com>
Subject: Re: Problem with commit 31e77c93e432 "sched/fair: Update blocked load
 when newly idle"
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2T7g8XM023037

On 28 March 2018 at 16:01, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> Hi,
>
> On 28 March 2018 at 12:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>> Hi,
>>
>> On 03/24/2018 01:47 PM, Heiner Kallweit wrote:
>>>
>>> Am 24.03.2018 um 07:46 schrieb Vincent Guittot:
>>>>
>>>> Hi Heiner,
>>>>
>>>> Le Friday 23 Mar 2018 à 22:28:09 (+0100), Heiner Kallweit a écrit :
>>>>>
>>>>> Recently I started to get the following problems with linux-next:
>>>>>
>>>>> - When working via Putty/SSH on the system the console frequently
>>>>> freezes
>>>>>    for few seconds. Sometimes only opening a second console makes the
>>>>>    first one react again.
>>>>>
>>>>> - I get "INFO: rcu_sched detected stalls on CPUs/tasks:" warnings as
>>>>>    described in [1].
>>>>>
>>
>> I can't catch this issue on my Juno r0 (arm64 big.Little).
>>
>> root@juno:~# uname -r
>> 4.16.0-rc4-00198-g31e77c93e432
>>
>> I'm using openssh-client and openssh-server though.
>
> I think that I have finally been able to reproduce it on my hikey
> (octo cortex-A53) after unplugging 6 cores and waiting for almost 2
> hours
> This seems to happen only on dual core system as I haven't faced that
> before on the hikey which I have used for my tests
>

I'm finally not so sure that i have the right set up to reproduce the
problem as I haven't been able to reproduce it since.

Heiner,

How fast the problem happens on your board ?
Are you doing anything specific on the console that trigger the problem ?

Regards,
Vincent

>>
>>>>> Bisecting the issue resulted in:
>>>>>
>>>>> 31e77c93e432dec79c7d90b888bbfc3652592741 is the first bad commit
>>>>> commit 31e77c93e432dec79c7d90b888bbfc3652592741
>>>>> Author: Vincent Guittot <vincent.guittot@linaro.org>
>>>>> Date:   Wed Feb 14 16:26:46 2018 +0100
>>>>>
>>>>>      sched/fair: Update blocked load when newly idle
>>>>>
>>>>>      When NEWLY_IDLE load balance is not triggered, we might need to
>>>>> update the
>>>>>      blocked load anyway. We can kick an ilb so an idle CPU will take
>>>>> care of
>>>>>      updating blocked load or we can try to update them locally before
>>>>> entering
>>>>>      idle. In the latter case, we reuse part of the nohz_idle_balance.
>>>>>
>>>>> After reversing this commit at least the issue with the freezing console
>>>>> is gone. The second one appeared only sporadically, I still have to see
>>>>> whether it pops up again.
>>
>>
>> [...]
>>
