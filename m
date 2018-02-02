Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbeBBUBp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:01:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:64352 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbeBBUBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:01:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="27628449"
Message-ID: <1517601697.83171.361.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Date: Fri, 02 Feb 2018 12:01:37 -0800
In-Reply-To: <20180202194801.mhvuwzbz6pauf63f@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
         <20180201091104.GW2269@hirez.programming.kicks-ass.net>
         <1517491092.18051.52.camel@linux.intel.com>
         <2447536.u3g27UoP4q@aspire.rjw.lan>
         <1517583264.18051.60.camel@linux.intel.com>
         <20180202194801.mhvuwzbz6pauf63f@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 19:48 +0000, Mel Gorman wrote:
> On Fri, Feb 02, 2018 at 06:54:24AM -0800, Srinivas Pandruvada wrote:
> > > > > No idea, desired would be the one I would start with, it
> > > > > matches
> > > > > with
> > > > > the intent here. But I've no idea what our current HWP
> > > > > implementation
> > > > > actually does with it.
> > > > 
> > > > Desired !=0 will disable HWP autonomous mode of frequency
> > > > selection.
> > > 
> > > But I don't think it will just run at "desired" then, will it?
> > 
> > HWP all are these hints only not a guarantee.
> 
> Sure, but the lack on detection when tasks are low utilisation but
> still
> latency/throughput sensitive is problematic. Users shouldn't have to
> know they need to disable HWP or set performance goernor out of the
> box.
> It's only going to get worse as sockets get larger.
I am not saying that we shouldn't do anything. Can you give me some
workloads which you care the most?

> 
> > There are totally different way HWP is handled in client an
> > servers.
> > If you set desired all heuristics they collected will be dumped, so
> > they suggest don't set desired when you are in autonomous mode. If
> > we
> > really want a boost set the EPP. We know that EPP makes lots of
> > measurable difference.
> > 
> 
> Sure boosting EPP makes a difference -- it's essentially what the
> performance
> goveror does and I know that can be done by a user but it's still
> basically a
> cop-out. Default performance for low utilisation or lightly loaded
> machines
> is poor. Maybe it should be set based on the ACPI preferred profile
> but
> that information is not always available. It would be nice if *some*
> sort of hint about new migrations or tasks waking from IO would be
> desirable.
EPP is a range not a single value. So you don't need to make EPP=0 as a
performance governor. PeterZ gave me some scheduler change to
experiment, which can be used as hint to play with EPP. 

Thanks,
Srinivas
