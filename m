Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426555AbeBOQui (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:50:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49748 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423727AbeBOQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:50:34 -0500
Date: Thu, 15 Feb 2018 17:50:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v5 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180215165028.GA25181@hirez.programming.kicks-ass.net>
References: <1518622006-16089-1-git-send-email-vincent.guittot@linaro.org>
 <1518622006-16089-2-git-send-email-vincent.guittot@linaro.org>
 <20180215152247.GA25247@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215152247.GA25247@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 03:22:47PM +0000, Patrick Bellasi wrote:
> > >  static struct {
> > >  	cpumask_var_t idle_cpus_mask;
> > >  	atomic_t nr_cpus;
> > > +	int has_blocked;		/* Idle CPUS has blocked load */
> 
> Why not "bool"?
> 
Because then he gets me yelling that sizeof(_Bool) is undefined and the
whole structure layout goes out the window :-)

Never use bool in a composite type.
