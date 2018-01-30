Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeA3NGP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:06:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35138 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbeA3NGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:06:14 -0500
Date: Tue, 30 Jan 2018 14:06:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180130130606.GH2295@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130104555.4125-5-mgorman@techsingularity.net>
 <20180130115349.GB2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130115349.GB2269@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
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

I cannot measure any hackbench variation one way or the other with these
patches using 'performance' mode. So I'll assume you've been running
things with HWP or something.
