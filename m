Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeDNLm1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 07:42:27 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40773 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeDNLmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 07:42:25 -0400
X-Google-Smtp-Source: AIpwx4/EaKUAOasGiahswH8McfqUAgzvlSEjjcNu3AnF2Vqh5NgU6VtUMlz+JjAlAuZnYvBgtgPZN0Im6xRWLnr6NXU=
MIME-Version: 1.0
In-Reply-To: <20180414100720.GW4064@hirez.programming.kicks-ass.net>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org> <20180414100720.GW4064@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 14 Apr 2018 13:42:04 +0200
Message-ID: <CAKfTPtCwbqTkYs2GQakf-bKiUjGYfPtzNEWaFd7ZvDNizW26JQ@mail.gmail.com>
Subject: Re: [PATCH 0/4 v4] sched/rt: track rt rq utilization
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

On 14 April 2018 at 12:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> What I don't see in this patch-set is removal of the current rt_avg
> stuff.

This RT load tracking doesn't replace current rt_avg because they are
not using same period and providing same function
current rt_avg uses sysctl_sched_time_avg to define the averaging
period and it's default period is 1 second. But PELT uses a fixed
period
current rt_avg is tracking irq accounting which this patch doesn't do.
This is probably doable but will need more complex changes

Replacing current rt_avg by this new RT utilization tracking would
require more complex changes so I didn't want to add them this 1st
step.


>
> And I didn't look closely enough; but are the root cfs and rt pelt
> windows aligned? They really should be; otherwise you can't combine them
> sanely.

No They are not aligned.
I agree that this could generate some variation on the sum. I'm going
to fix this point
