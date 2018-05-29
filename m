Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbeE2IV6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:21:58 -0400
Received: from foss.arm.com ([217.140.101.70]:34926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755190AbeE2IVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:21:55 -0400
Date: Tue, 29 May 2018 09:21:51 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH v5 01/10] sched/pelt: Move pelt related code in a
 dedicated file
Message-ID: <20180529082151.GD15173@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-2-git-send-email-vincent.guittot@linaro.org>
 <20180525142648.GC15173@e108498-lin.cambridge.arm.com>
 <20180525161423.GP12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525161423.GP12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 May 2018 at 18:14:23 (+0200), Peter Zijlstra wrote:
> On Fri, May 25, 2018 at 03:26:48PM +0100, Quentin Perret wrote:
> > (both quite old TBH -- 4.9.4 for arm64, 4.8.4 for x86).
> 
> You really should try with a more recent compiler.

Right, so I just gave it a try for x86 with gcc 8.0.1 (which seem to
introduce a lot of LTO-related enhancements) and I get the following:

Without patch
   text data bss dec hex filename
   17474129 4980348 995532 23450009 165d199 vmlinux

With patch
   text data bss dec hex filename
   17474049 4980348 995532 23449929 165d149 vmlinux

So it is still true that this patch actually changes the code size, most
likely because of new function calls. But maybe we don't care if the
impact on performance isn't noticeable ... As Patrick said, a hackbench
run should be more interesting here. I'll give a try later today.

Thanks,
Quentin
