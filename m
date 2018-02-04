Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbeBDIoO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 03:44:14 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60677 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBDIoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 03:44:07 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle candidate and the basis for SIS
Date: Sun, 04 Feb 2018 09:42:28 +0100
Message-ID: <2563202.Cx1TqSeWJa@aspire.rjw.lan>
In-Reply-To: <20180202194801.mhvuwzbz6pauf63f@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net> <1517583264.18051.60.camel@linux.intel.com> <20180202194801.mhvuwzbz6pauf63f@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 2, 2018 8:48:01 PM CET Mel Gorman wrote:
> On Fri, Feb 02, 2018 at 06:54:24AM -0800, Srinivas Pandruvada wrote:
> > > > > No idea, desired would be the one I would start with, it matches
> > > > > with
> > > > > the intent here. But I've no idea what our current HWP
> > > > > implementation
> > > > > actually does with it.
> > > > Desired !=0 will disable HWP autonomous mode of frequency
> > > > selection.
> > > But I don't think it will just run at "desired" then, will it?
> > HWP all are these hints only not a guarantee.
> 
> Sure, but the lack on detection when tasks are low utilisation but still
> latency/throughput sensitive is problematic. Users shouldn't have to
> know they need to disable HWP or set performance goernor out of the box.
> It's only going to get worse as sockets get larger.

OK, so that's the case I was thinking about when the kernel actually knows
more about what's going on than the HW-based logic.  That's when it makes
sense to provide hints, of course.

> > There are totally different way HWP is handled in client an servers.
> > If you set desired all heuristics they collected will be dumped, so
> > they suggest don't set desired when you are in autonomous mode. If we
> > really want a boost set the EPP. We know that EPP makes lots of
> > measurable difference.
> > 
> 
> Sure boosting EPP makes a difference -- it's essentially what the performance
> goveror does and I know that can be done by a user but it's still basically a
> cop-out. Default performance for low utilisation or lightly loaded machines
> is poor. Maybe it should be set based on the ACPI preferred profile but
> that information is not always available. It would be nice if *some*
> sort of hint about new migrations or tasks waking from IO would be desirable.

Agreed, we only need to figure out a clean way to do that.
