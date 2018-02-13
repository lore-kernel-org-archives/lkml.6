Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeBMNEx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:04:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60502 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeBMNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:04:52 -0500
Date: Tue, 13 Feb 2018 14:04:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Consider SD_NUMA when selecting the most
 idle group to schedule on
Message-ID: <20180213130445.GH25201@hirez.programming.kicks-ass.net>
References: <20180212171131.26139-1-mgorman@techsingularity.net>
 <20180212171131.26139-2-mgorman@techsingularity.net>
 <20180213104541.GG25201@hirez.programming.kicks-ass.net>
 <20180213113548.tb7zxzly32oz3mfb@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213113548.tb7zxzly32oz3mfb@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 11:35:48AM +0000, Mel Gorman wrote:
> > However, if we have numa balancing enabled, that will counteract
> > the normal spreading across nodes, so in that regard it makes sense, but
> > the above code is not conditional on numa balancing.
> > 
> 
> It's not conditional on NUMA balancing because one case where it mattered
> was a fork-intensive workload driven by shell scripts. In that case, the
> workload benefits from preferring a local node without any involvement from
> NUMA balancing. I could make it conditional on it but it's not strictly
> related to automatic NUMA balancing, it's about being less eager about
> starting new children on remote nodes.

Yeah, I suppose. And you're right, there's no real winning this. It's
all tea-leaves and entrails.

In any case, I think I prefer the kill sync early variant and you were
going to ammend some comments. Can you respin and resend all these
patches (can do in a single series)?
