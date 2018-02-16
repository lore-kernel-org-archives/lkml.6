Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756326AbeBPRoG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:44:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbeBPRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:44:05 -0500
Date: Fri, 16 Feb 2018 18:43:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>, mingo@redhat.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] sched: Add static_key for asymmetric cpu capacity
 optimizations
Message-ID: <20180216174355.GK25201@hirez.programming.kicks-ass.net>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-2-git-send-email-morten.rasmussen@arm.com>
 <20180216134704.GE25201@hirez.programming.kicks-ass.net>
 <20180216154101.GE28799@e105550-lin.cambridge.arm.com>
 <20180216173927.GA5352@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216173927.GA5352@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 05:39:27PM +0000, Quentin Perret wrote:
> AFAIU it should be safe, but without your check you'll have to go through
> cpus_read_lock()/unlock() every time a CPU is hotplugged. There is probably
> no good reason to re-do that again and again if the state of the key
> never changes. I don't know how expensive those lock/unlock operations are,
> but I bet they are more expensive than testing static_branch_unlikely() :)

This is not a performance critical path, more obvious code is more
better.

Also cpus_read_lock() is dirt cheap most of the time.
