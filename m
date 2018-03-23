Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeCWI6C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:58:02 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35011 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeCWI6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:58:00 -0400
X-Google-Smtp-Source: AG47ELu6GomdImpId4mrfNZP1VGsKrk0fFAOxwPhhcf1PwHJS1FxZPWRdZb7XnzTxSVHINObr4ot52Hq4UXYh1yy9v4=
MIME-Version: 1.0
In-Reply-To: <004c01d3c255$c1f146a0$45d3d3e0$@net>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan> <20180314120450.GT4043@hirez.programming.kicks-ass.net>
 <004c01d3c255$c1f146a0$45d3d3e0$@net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Mar 2018 09:57:58 +0100
X-Google-Sender-Auth: g9Y5WsDLR3s7OKIoKLlEyiObNmc
Message-ID: <CAJZ5v0iZVVkevY2oJnySoa6uQesMXcj_ZshV97utdXsW2w-aAA@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
To: Doug Smythies <dsmythies@telus.net>
Cc: Rik van Riel <riel@surriel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 4:19 AM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2018.03.22 12:12 Doug Smythies wrote:
>>On 2018.03.22 09:32 Rik van Riel wrote:
>>> On Wed, 2018-03-14 at 13:04 +0100, Peter Zijlstra wrote:
>>>
>>>> On x86 we don't have to use that time_check_counter thing,
>>>> sched_clock()
>>>> is really cheap, not sure if it makes sense on other platforms.
>>>
>>> Are you sure? I saw a 5-10% increase in CPU use,
>>> for a constant query rate to a memcache style
>>> workload, with v3 of this patch.
>>
>> I would very much like to be able to repeat your test results.
>> However, I am not sure what you mean by "memcache style workload".
>> Is there a test you can point me to? Say a Phoronix type test, for example.
>>
>> All of my tests with the V3 of this patch have been fine.
>
> What is the difference between sched_clock() talked about herein,
> and local_clock() used in the patch?

It is almost the same (modulo offset) unless sched_clock_stable()
returns 'false'.

> I'm not sure how good it is but I made a test. I didn't believe
> the results, so I did it 3 times.
>
> V7.3 is as from the git branch.
> V7.3p is plus the patch adding the counter loop to poll_state.c
>
> The test is a tight loop (about 19600 loops per second) running
> on all 8 CPUs. I can not seem to get my system to use Idle State
> 0, so I disabled Idle States 1 and 2 to force use of Idle State 0.
>
> V7.3 uses a processor package power of 62.5 Watts
> V7.3p uses a processor package power of 53.4 Watts, or 14.6% less power.
>
> The loop times do not change.
> The Idle state 0 residency per unit time does not change.

OK, so this means that the results should improve for Rik with this
patch too. :-)

Thanks!
