Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965211AbeBMPAX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:00:23 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:39337 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965128AbeBMPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:00:21 -0500
Date: Tue, 13 Feb 2018 15:00:20 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] sched/numa: Delay retrying placement for automatic
 NUMA balance after wake_affine
Message-ID: <20180213150020.xds3htkutdk4sdwx@techsingularity.net>
References: <20180213133730.24064-1-mgorman@techsingularity.net>
 <20180213133730.24064-7-mgorman@techsingularity.net>
 <20180213140137.GN25201@hirez.programming.kicks-ass.net>
 <20180213141812.ikin7n2owi5uor3b@techsingularity.net>
 <20180213144326.GO25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180213144326.GO25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 03:43:26PM +0100, Peter Zijlstra wrote:
> > 
> > Well, it was deliberate. While it's possible to be on the same memory
> > node and not sharing cache, the scheduler typically is more concerned with
> > the LLC than NUMA per-se. If they share LLC, then I also assume that they
> > share memory locality.
> 
> True, but the remaining code only has effect for numa balance, which is
> concerned with nodes. So I don't see the point of using something
> potentially smaller.
> 
> Suppose someone did hardware where a node has 2 cache clusters, then
> we'd still set a wake_affine back-off for numa-balance, even though it
> remains on the same node.
> 
> How would that be useful?

Fair point, it could be unexpected from a NUMA balancing perspective and
sub-numa clustering does exist so it's a potential issue. I'm happy to
change it to cpu_to_node. I can resend the series if you prefer but feel
free to change it in-place if you're picking it up. I do not expect any
change on the machines I tested with as for all of them LLC was equivalent
to checking the node ID.

-- 
Mel Gorman
SUSE Labs
