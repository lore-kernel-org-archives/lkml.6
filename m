Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeBBTsJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:48:09 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:54533 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753316AbeBBTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:48:03 -0500
Date: Fri, 2 Feb 2018 19:48:01 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180202194801.mhvuwzbz6pauf63f@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180201091104.GW2269@hirez.programming.kicks-ass.net>
 <1517491092.18051.52.camel@linux.intel.com>
 <2447536.u3g27UoP4q@aspire.rjw.lan>
 <1517583264.18051.60.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1517583264.18051.60.camel@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 06:54:24AM -0800, Srinivas Pandruvada wrote:
> > > > No idea, desired would be the one I would start with, it matches
> > > > with
> > > > the intent here. But I've no idea what our current HWP
> > > > implementation
> > > > actually does with it.
> > > Desired !=0 will disable HWP autonomous mode of frequency
> > > selection.
> > But I don't think it will just run at "desired" then, will it?
> HWP all are these hints only not a guarantee.

Sure, but the lack on detection when tasks are low utilisation but still
latency/throughput sensitive is problematic. Users shouldn't have to
know they need to disable HWP or set performance goernor out of the box.
It's only going to get worse as sockets get larger.

> There are totally different way HWP is handled in client an servers.
> If you set desired all heuristics they collected will be dumped, so
> they suggest don't set desired when you are in autonomous mode. If we
> really want a boost set the EPP. We know that EPP makes lots of
> measurable difference.
> 

Sure boosting EPP makes a difference -- it's essentially what the performance
goveror does and I know that can be done by a user but it's still basically a
cop-out. Default performance for low utilisation or lightly loaded machines
is poor. Maybe it should be set based on the ACPI preferred profile but
that information is not always available. It would be nice if *some*
sort of hint about new migrations or tasks waking from IO would be desirable.

-- 
Mel Gorman
SUSE Labs
