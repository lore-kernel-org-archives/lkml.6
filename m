Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeBTNFU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:05:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbeBTNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:02:01 -0500
Date: Mon, 19 Feb 2018 15:53:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched/fair: Avoid unnecessary balancing of
 asymmetric capacity groups
Message-ID: <20180219145335.GN25235@hirez.programming.kicks-ass.net>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-5-git-send-email-morten.rasmussen@arm.com>
 <20180219145012.GH25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219145012.GH25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 03:50:12PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 15, 2018 at 04:20:51PM +0000, Morten Rasmussen wrote:
> > On systems with asymmetric cpu capacities, a skewed load distribution
> > might yield better throughput than balancing load per group capacity.
> > For example, preferring high capacity cpus for compute intensive tasks
> > leaving low capacity cpus idle rather than balancing the number of idle
> > cpus across different cpu types. Instead, let load-balance back off if
> > the busiest group isn't really overloaded.
> 
> I'm sorry. I just can't seem to make sense of that today. What?

Aah, you're saying that is we have 4+4 bit.little and 4 runnable tasks,
we would like them running on our big cluster and leave the small
cluster entirely idle, instead of runnint 2+2.

So what about this DynamicQ nonsense? Or is that so unstructured we
can't really do anything sensible with it?
