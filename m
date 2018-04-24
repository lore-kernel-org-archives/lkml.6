Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeDXPri (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:47:38 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33518 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeDXPrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:47:37 -0400
X-Google-Smtp-Source: AIpwx49SV+ny9ag0/8bWHlKR6TxHTxsPdIL70Jg+OJ3MOaL2Bkcib0FQiVNbPxm7mziHSj9QeoZT5Vml0CnX9A5iRp4=
MIME-Version: 1.0
In-Reply-To: <CAEi0qN=qnej22F31jM2CMajee2h+ie0+AptFscwa5L8Arp8q3g@mail.gmail.com>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com> <20180424104304.GE4064@hirez.programming.kicks-ass.net>
 <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com> <20180424123523.GF4064@hirez.programming.kicks-ass.net>
 <CAEi0qN=qnej22F31jM2CMajee2h+ie0+AptFscwa5L8Arp8q3g@mail.gmail.com>
From: Joel Fernandes <joel.opensrc@gmail.com>
Date: Tue, 24 Apr 2018 08:47:35 -0700
Message-ID: <CAEi0qNmkkMEvbT+dJJqMwvRkQAw9xqKX65GKDZqtTAXUUxfs7Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize it
To: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 8:46 AM, Joel Fernandes <joel.opensrc@gmail.com> wrote:
> On Tue, Apr 24, 2018 at 5:35 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Tue, Apr 24, 2018 at 12:19:07PM +0100, Valentin Schneider wrote:
>>> On 24/04/18 11:43, Peter Zijlstra wrote:
>>> > On Tue, Apr 24, 2018 at 11:02:26AM +0100, Valentin Schneider wrote:
>>> >> I'd argue making things easier to read is a non-negligible part as well.
>>> >
>>> > Right, so I don't object to either of these (I think); but it would be
>>> > good to see this in combination with that proposed EAS change.
>>> >
>>>
>>> True, I would've said the call to find_energy_efficient_cpu() ([1]) could
>>> simply be added to the if (sd) {} case, but...
>>
>> I think the proposal was to put it before the for_each_domain() loop
>> entirely, however...
>>
>>> > I think you (valentin) wanted to side-step the entire domain loop in
>>> > that case or something.
>>> >
>>>
>>> ...this would change more things. Admittedly I've been sort of out of the loop
>>> (no pun intended) lately, but this doesn't ring a bell. That might have been
>>> the other frenchie (Quentin) :)
>>
>> It does indeed appear I confused the two of you, it was Quentin playing
>> with that.
>>
>> In any case, if there not going to be conflicts here, this all looks
>> good.
>
> Both Viresh's and Valentin's patch looks lovely to me too. I couldn't
> spot anything wrong with them either. One suggestion I was thinking
> off is can we add better comments to this code (atleast label fast
> path vs slow path) ?
>
> Also, annotate the conditions for the fast/slow path with
> likely/unlikely since fast path is the common case? so like:
>
> if (unlikely(sd)) {
>   /* Fast path, common case */
>   ...
> } else if (...) {
>   /* Slow path */
> }

Aargh, I messed that up, I meant:

if (unlikely(sd)) {
   /* Slow path */
   ...
} else if (...) {
   /* Fast path */
}


thanks, :-)

- Joel
