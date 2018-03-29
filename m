Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeC2N5U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:57:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34972 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752299AbeC2N5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:57:19 -0400
Date: Thu, 29 Mar 2018 15:57:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180329135702.GB4043@hirez.programming.kicks-ass.net>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
 <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
 <aa369ee2-6557-8e3f-e2b4-d347b27825a6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa369ee2-6557-8e3f-e2b4-d347b27825a6@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 06:45:12AM -0700, Dave Hansen wrote:
> On 03/29/2018 06:16 AM, Thomas Gleixner wrote:
> >> This is OK at least on the hardware we are immediately concerned about
> >> because the LLC sharing happens at both the slice and at the package
> >> level, which are also NUMA boundaries.
> > So that addresses the scheduler interaction, but it still leaves the
> > information in the sysfs files unchanged. See cpu/intel_cacheinfo.c.  There
> > are applications which use that information so it should be correct.
> 
> Were you thinking of shared_cpu_list/map? 

Yes, the fact that those are changed and the Changelog doesn't mention
them is a giant fail all by itself.

> The information in there is
> correct for core->off-package access.  It is not correct for
> core->on-package access, unless that access is perfectly interleaved
> across both package "slices".

The fact that 'simple' measures like cache/cpu are now completely broken
is a problem.
