Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeBTNCE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:02:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55420 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeBTNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:01:59 -0500
Date: Mon, 19 Feb 2018 16:10:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched/fair: Avoid unnecessary balancing of
 asymmetric capacity groups
Message-ID: <20180219151011.GI25181@hirez.programming.kicks-ass.net>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-5-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518711654-23503-5-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:20:51PM +0000, Morten Rasmussen wrote:
> +/*
> + * group_similar_cpu_capacity: Returns true if the minimum capacity of the
> + * compared groups differ by less than 12.5%.
> + */
> +static inline bool
> +group_similar_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> +{
> +	long diff = sg->sgc->min_capacity - ref->sgc->min_capacity;
> +	long max = max(sg->sgc->min_capacity, ref->sgc->min_capacity);
> +
> +	return abs(diff) < max >> 3;
> +}

This seems a fairly random and dodgy heuristic.
