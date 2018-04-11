Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeDKKxg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:53:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbeDKKxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:53:34 -0400
Date: Wed, 11 Apr 2018 12:53:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/7] sched/fair: Consider misfit tasks when
 load-balancing
Message-ID: <20180411105329.GI4043@hirez.programming.kicks-ass.net>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
 <1521125224-15434-4-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521125224-15434-4-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 02:47:00PM +0000, Morten Rasmussen wrote:
> +	/*
> +	 * Don't try to pull misfit tasks we can't help.
> +	 */
> +	if (sgs->group_type == group_misfit_task &&
> +	    (!group_smaller_cpu_capacity(sg, sds->local) ||
> +	     !group_has_capacity(env, &sds->local_stat)))
> +		return false;
> +

I think that has the same 'problem' as last time, right? Since
group_smaller_cpu_capacity() is affected by RT/IRQ pressure.

We should have a comment stating this and preferably explaining why that
is ok.
