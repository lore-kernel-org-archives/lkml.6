Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeA3M7X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:59:23 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:44242 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751577AbeA3M7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:59:22 -0500
Date: Tue, 30 Jan 2018 12:59:20 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180130125920.oi6eyvx6mwahh2oh@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130104555.4125-5-mgorman@techsingularity.net>
 <20180130115349.GB2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180130115349.GB2269@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 12:53:49PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 30, 2018 at 10:45:55AM +0000, Mel Gorman wrote:
> > The results can be less dramatic on NUMA where automatic balancing interferes
> > with the test. It's also known that network benchmarks running on localhost
> > also benefit quite a bit from this patch (roughly 10% on netperf RR for UDP
> > and TCP depending on the machine). Hackbench also seens small improvements
> > (6-11% depending on machine and thread count). The facebook schbench was also
> > tested but in most cases showed little or no different to wakeup latencies.
> 
> What cpufreq setting were you using for these tests?

Default powersave settings in general -- intel_pstate driver is the one
used most often but HWP was not always available. By and large, no special
tuning was applied. Two sets of tests were run, one with turbostat and perf
keeping track of p-states and migrations and one without to make sure the
measured increase was real. The irony when hitting cpufreq-related problems
is that monitoring can mask the issue by increasing overall utilisation.

-- 
Mel Gorman
SUSE Labs
