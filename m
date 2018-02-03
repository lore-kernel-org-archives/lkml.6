Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeBCQay (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 11:30:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:7954 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbeBCQat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 11:30:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,455,1511856000";
   d="scan'208";a="24461048"
Message-ID: <1517675448.21379.2.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
Date: Sat, 03 Feb 2018 08:30:48 -0800
In-Reply-To: <20180202140817.GP2295@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
         <3838689.GpfBVtfPr0@aspire.rjw.lan>
         <20180201091104.GW2269@hirez.programming.kicks-ass.net>
         <8930678.7E2iWGoJnn@aspire.rjw.lan>
         <20180202124647.GK2269@hirez.programming.kicks-ass.net>
         <20180202140817.GP2295@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 15:08 +0100, Peter Zijlstra wrote:
> On Fri, Feb 02, 2018 at 01:46:47PM +0100, Peter Zijlstra wrote:
> 
> > +static void __intel_pstate_hwp_set_desired(int val)
> > +{
> > +	u64 value;
> > +
> > +	value = rdmsrl(MSR_HWP_REQUEST);
> > +	value &= ~GENMASK_ULL(23, 16);
> > +	value |= (val & 0xff) << 16;
> > +	wrmsrl(MSR_HWP_REQUEST, val);
> > +}
> 
> Also, if we keep a software shadow of that MSR, we can avoid the
> rdmsr, which might also help.
The reason we don't keep a software shadow as users can use x86-energy-
perf utility or via BMC to adjust.  CCed  to Len. 
