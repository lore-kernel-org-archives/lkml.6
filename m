Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeAaJYa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:24:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64593 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeAaJYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:24:24 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle candidate and the basis for SIS
Date: Wed, 31 Jan 2018 10:22:49 +0100
Message-ID: <4353713.vEOq6OHvJN@aspire.rjw.lan>
In-Reply-To: <20180130131531.GD2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net> <20180130125718.iwntjuvcp3yplvdx@techsingularity.net> <20180130131531.GD2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 30, 2018 2:15:31 PM CET Peter Zijlstra wrote:
> On Tue, Jan 30, 2018 at 12:57:18PM +0000, Mel Gorman wrote:
> > On Tue, Jan 30, 2018 at 12:50:54PM +0100, Peter Zijlstra wrote:
> 
> > > Not saying this patch is bad; but Rafael / Srinivas we really should do
> > > better. Why isn't cpufreq (esp. sugov) fixing this? HWP or not, we can
> > > still give it hints, and it looks like we're not doing that.
> > > 
> > 
> > I'm not sure if HWP can fix it because of the per-cpu nature of its
> > decisions. I believe it can only give the most basic of hints to hardware
> > like an energy performance profile or bias (EPP and EPB respectively).
> > Of course HWP can be turned off but not many people can detect that it's
> > an appropriate decision, or even desirable, and there is always the caveat
> > that disabling it increases the system CPU footprint.
> 
> IA32_HWP_REQUEST has "Minimum_Performance", "Maximum_Performance" and
> "Desired_Performance" fields which can be used to give explicit
> frequency hints. And we really _should_ be doing that.
> 
> Because, esp. in this scenario; a task migrating; the hardware really
> can't do anything sensible, whereas the OS _knows_.

But IA32_HWP_REQUEST is not a cheap MSR to write to.
