Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBWQsB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:48:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39972 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBWQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:48:00 -0500
Date: Fri, 23 Feb 2018 17:47:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched/fair: Avoid unnecessary balancing of
 asymmetric capacity groups
Message-ID: <20180223164752.GW25181@hirez.programming.kicks-ass.net>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-5-git-send-email-morten.rasmussen@arm.com>
 <20180219151011.GI25181@hirez.programming.kicks-ass.net>
 <20180220163352.GD4589@e105550-lin.cambridge.arm.com>
 <20180220182605.GI25201@hirez.programming.kicks-ass.net>
 <20180223163806.GE4589@e105550-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223163806.GE4589@e105550-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 04:38:06PM +0000, Morten Rasmussen wrote:
> > Or am I now terminally confused again?
> 
> No, I think you are right, or I'm equally confused.

:-)

Would it make sense to also track max_capacity, but then based on the
value before RT scaling ?

That should readily be able to distinguish between big and little
clusters, although then DynamiQ would still completely ruin things.
