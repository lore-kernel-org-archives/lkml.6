Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757070AbeDXLTL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:19:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51594 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751284AbeDXLTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:19:10 -0400
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
 <20180424104304.GE4064@hirez.programming.kicks-ass.net>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
Date: Tue, 24 Apr 2018 12:19:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424104304.GE4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/18 11:43, Peter Zijlstra wrote:
> On Tue, Apr 24, 2018 at 11:02:26AM +0100, Valentin Schneider wrote:
>> I'd argue making things easier to read is a non-negligible part as well.
> 
> Right, so I don't object to either of these (I think); but it would be
> good to see this in combination with that proposed EAS change.
> 

True, I would've said the call to find_energy_efficient_cpu() ([1]) could
simply be added to the if (sd) {} case, but...

> I think you (valentin) wanted to side-step the entire domain loop in
> that case or something.
> 

...this would change more things. Admittedly I've been sort of out of the loop
(no pun intended) lately, but this doesn't ring a bell. That might have been
the other frenchie (Quentin) :)

> But yes, getting this code more readable is defninitely useful.
> 

[1]: See [RFC PATCH v2 5/6] sched/fair: Select an energy-efficient CPU on task wake-up
@ https://lkml.org/lkml/2018/4/6/856
