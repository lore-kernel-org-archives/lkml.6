Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeBASQm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:16:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56632 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbeBASQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:16:39 -0500
Date: Thu, 1 Feb 2018 19:16:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 2/5] sched: Add NOHZ_STATS_KICK
Message-ID: <20180201181634.GG2269@hirez.programming.kicks-ass.net>
References: <20171222082915.4lcb7xyyooqyjpia@hirez.programming.kicks-ass.net>
 <20171222091221.ow5vn3ydx3hj4nht@hirez.programming.kicks-ass.net>
 <CAKfTPtAzutuyA7D2qOErKPwdFaRK082YAtVn4ci8hAOUvL3zMQ@mail.gmail.com>
 <20171222185629.lysjebfifgdwvvhu@hirez.programming.kicks-ass.net>
 <20171222204247.kyc6ugyyu3ei7zhs@hirez.programming.kicks-ass.net>
 <CAKfTPtD13p-n9otxq23rQZZKUfA1r03bxYBSDtSdm5HbWX7H6Q@mail.gmail.com>
 <20180115082609.GA6320@linaro.org>
 <20180118103807.GD28799@e105550-lin.cambridge.arm.com>
 <20180124082536.GA32318@linaro.org>
 <b1efd041-2faa-76e0-7d9b-3d2917e03012@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1efd041-2faa-76e0-7d9b-3d2917e03012@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 07:31:07PM +0000, Valentin Schneider wrote:

> But for load update via _nohz_idle_balance(), we iterate through all of the
> nohz CPUS and unconditionally call update_blocked_averages(). This could be
> avoided by remembering which CPUs have stale load before going idle.
> Initially I thought that was what nohz.stats_state was for, but it isn't.
> With Vincent's patches it's only ever set to either 0 or 1, but we could use
> it as a CPU mask, and use it to skip nohz CPUs that don't have stale load in
> _nohz_idle_balance() (when NOHZ_STATS_KICK).

Yes, you'd need to allocate a second cpumask, worse you need atomic
bitops to set and clear bits there.

That all _might_ be worth it... dunno.
