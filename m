Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeAaLyJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 06:54:09 -0500
Received: from outbound-smtp23.blacknight.com ([81.17.249.191]:53530 "EHLO
        outbound-smtp23.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751587AbeAaLyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 06:54:08 -0500
Date: Wed, 31 Jan 2018 11:54:06 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180131115406.4g7oj46xhmteefc5@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
 <20180130131531.GD2269@hirez.programming.kicks-ass.net>
 <4353713.vEOq6OHvJN@aspire.rjw.lan>
 <20180131101710.GM2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180131101710.GM2269@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 11:17:10AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 31, 2018 at 10:22:49AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, January 30, 2018 2:15:31 PM CET Peter Zijlstra wrote:
> 
> > > IA32_HWP_REQUEST has "Minimum_Performance", "Maximum_Performance" and
> > > "Desired_Performance" fields which can be used to give explicit
> > > frequency hints. And we really _should_ be doing that.
> > > 
> > > Because, esp. in this scenario; a task migrating; the hardware really
> > > can't do anything sensible, whereas the OS _knows_.
> > 
> > But IA32_HWP_REQUEST is not a cheap MSR to write to.
> 
> That just means we might need to throttle writing to it, like it already
> does for the regular pstate (PERF_CTRL) msr in any case (also, is that a
> cheap msr?)
> 
> Not touching it at all seems silly.
> 

Note that even if we do such programming, it would still be desirable to
minimise the number of times we have to reprogram it so the series as it
stands would still be useful.

-- 
Mel Gorman
SUSE Labs
