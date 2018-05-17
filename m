Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeEQHvU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:51:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeEQHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:51:19 -0400
Date: Thu, 17 May 2018 09:50:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 06/10] cpufreq / sched: Add interface to get
 utilization values
Message-ID: <20180517075050.GL12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-7-srinivas.pandruvada@linux.intel.com>
 <20180516081155.GA12217@hirez.programming.kicks-ass.net>
 <1526510439.61700.109.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526510439.61700.109.camel@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 03:40:39PM -0700, Srinivas Pandruvada wrote:
> On Wed, 2018-05-16 at 10:11 +0200, Peter Zijlstra wrote:

> > So I _really_ hate this... I'd much rather you make schedutil work
> > with the hwp passive stuff.

> Are you not happy with ifdefs are utility function itself? Can you
> explain more how this should be done?

The reason I hate it is because it exports data that should not be. We
created the schedutil governor as part of the scheduler such that we
could tightly couple it.

So if you want to use all that, get schedutil to work for you.
