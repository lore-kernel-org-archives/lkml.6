Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754950AbeCGWLh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:11:37 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43606 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754926AbeCGWLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:11:33 -0500
X-Google-Smtp-Source: AG47ELuNeyPbg0QQHEyVIhy58+3IsQC9Pw4PkhKOjqleFfEt5r5SFnp2PCn7DY52Q6iKsM8U2cn7/wBd3/JD8s65Isg=
MIME-Version: 1.0
In-Reply-To: <000a01d3b636$57b75c00$07261400$@net>
References: <000a01d3b636$57b75c00$07261400$@net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Mar 2018 23:11:32 +0100
X-Google-Sender-Auth: HPkI8BpRvUNfPy6nBmOqolRCjwo
Message-ID: <CAJZ5v0iFvQ3_mR_6tZ6Db4YWqfQshjoah51vWmcki1VvYW-1AA@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 6:04 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2018.03.06 12:57 Rafael J. Wysocki wrote:
>
> ...[snip]...
>
>> And the two paragraphs below still apply:
>
>>> I have tested these patches on a couple of machines, including the very laptop
>>> I'm sending them from, without any obvious issues, but please give them a go
>>> if you can, especially if you have an easy way to reproduce the problem they
>>> are targeting.  The patches are on top of 4.16-rc3 (if you need a git branch
>>> with them for easier testing, please let me know).
>
> Hi,
>
> I am still having some boot troubles with V2. However, and because my system
> did eventually boot, seemingly O.K., I didn't re-boot a bunch of times for
> further testing.

OK, thanks for letting me know.

> I ran my 100% load on one CPU test, which is for idle state 0 issues, on
> my otherwise extremely idle test server. I never did have very good ways
> to test issues with the other idle states (Thomas Ilsche's specialty).
>
> During the test I got some messages (I also got some with the V1 patch set):
>
> [16246.655148] rcu_preempt kthread starved for 60005 jiffies! g10557 c10556
>                         f0x0 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=5
> [19556.565007] rcu_preempt kthread starved for 60003 jiffies! g12126 c12125
>                         f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=5
> [20223.066251] clocksource: timekeeping watchdog on CPU4: Marking clocksource
>                         'tsc' as unstable because the skew is too large:
> [20223.066260] clocksource:                       'hpet' wd_now: 6b02e6a0
>                         wd_last: c70685ef mask: ffffffff
> [20223.066262] clocksource:                       'tsc' cs_now: 3ed0d6f109f5
>                         cs_last: 3e383b5c058d mask: ffffffffffffffff
> [20223.066264] tsc: Marking TSC unstable due to clocksource watchdog
> [26720.509156] rcu_preempt kthread starved for 60003 jiffies! g16640
>                         c16639 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=5
> [29058.215330] rcu_preempt kthread starved for 60004 jiffies! g17522
>                         c17521 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=4
> ...

Can you please check if that's reporoducible with just the first three
patches in the series applied?

> The other observation is sometimes the number of irqs (turbostat) jumps
> a lot. This did not occur with the V1 patch set. An increase in irqs is
> expected, but I don't think that much.

Right.

> Note: I am unable to show a correlation between the above log entries
> and the jumps in irqs.

Thanks,
Rafael
