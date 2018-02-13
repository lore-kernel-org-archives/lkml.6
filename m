Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964813AbeBMNaA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:30:00 -0500
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:43356 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935174AbeBMN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:29:59 -0500
Date: Tue, 13 Feb 2018 13:29:57 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Consider SD_NUMA when selecting the most
 idle group to schedule on
Message-ID: <20180213132957.2c2lbsa5pd536oga@techsingularity.net>
References: <20180212171131.26139-1-mgorman@techsingularity.net>
 <20180212171131.26139-2-mgorman@techsingularity.net>
 <20180213104541.GG25201@hirez.programming.kicks-ass.net>
 <20180213113548.tb7zxzly32oz3mfb@techsingularity.net>
 <20180213130445.GH25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180213130445.GH25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 02:04:45PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 13, 2018 at 11:35:48AM +0000, Mel Gorman wrote:
> > > However, if we have numa balancing enabled, that will counteract
> > > the normal spreading across nodes, so in that regard it makes sense, but
> > > the above code is not conditional on numa balancing.
> > > 
> > 
> > It's not conditional on NUMA balancing because one case where it mattered
> > was a fork-intensive workload driven by shell scripts. In that case, the
> > workload benefits from preferring a local node without any involvement from
> > NUMA balancing. I could make it conditional on it but it's not strictly
> > related to automatic NUMA balancing, it's about being less eager about
> > starting new children on remote nodes.
> 
> Yeah, I suppose. And you're right, there's no real winning this. It's
> all tea-leaves and entrails.
> 

That is my new favourite description of this portion of the scheduler :D

> In any case, I think I prefer the kill sync early variant and you were
> going to ammend some comments. Can you respin and resend all these
> patches (can do in a single series)?

No problem. I had it prepared already and am just waiting for one result
before I push send.

Thanks.

-- 
Mel Gorman
SUSE Labs
