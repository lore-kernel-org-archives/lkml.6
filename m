Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeBAQ4I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:56:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55936 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeBAQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:56:01 -0500
Date: Thu, 1 Feb 2018 17:55:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@foss.arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 2/5] sched: Add NOHZ_STATS_KICK
Message-ID: <20180201165556.GD2269@hirez.programming.kicks-ass.net>
References: <20171222075934.f6yenvcb2zkf2ysd@hirez.programming.kicks-ass.net>
 <CAKfTPtC0+5zjvgNXMyVcvnnyJh0giQgJHtx+5p-GEpjUW1x8eg@mail.gmail.com>
 <20171222082915.4lcb7xyyooqyjpia@hirez.programming.kicks-ass.net>
 <20171222091221.ow5vn3ydx3hj4nht@hirez.programming.kicks-ass.net>
 <CAKfTPtAzutuyA7D2qOErKPwdFaRK082YAtVn4ci8hAOUvL3zMQ@mail.gmail.com>
 <20171222185629.lysjebfifgdwvvhu@hirez.programming.kicks-ass.net>
 <20171222204247.kyc6ugyyu3ei7zhs@hirez.programming.kicks-ass.net>
 <CAKfTPtD13p-n9otxq23rQZZKUfA1r03bxYBSDtSdm5HbWX7H6Q@mail.gmail.com>
 <20180115082609.GA6320@linaro.org>
 <20180118103807.GD28799@e105550-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118103807.GD28799@e105550-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2018 at 10:38:07AM +0000, Morten Rasmussen wrote:
> It seems pointless to have a timer to update PELT if the system is
> completely idle, and when it isn't we can piggy back other events to
> make the updates happen.

Only if we do that update before making decisions based on the values.
The thing I was bothered by in the earlier patches was that wakeup would
use whatever current value and async kick something to go update.

That just seems wrong.
