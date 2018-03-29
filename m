Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeC2Oz4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:55:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeC2Ozy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:55:54 -0400
Date: Thu, 29 Mar 2018 16:55:44 +0200
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
Message-ID: <20180329145544.GE4043@hirez.programming.kicks-ass.net>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
 <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
 <20180329134723.GA4043@hirez.programming.kicks-ass.net>
 <596dcb0c-5bbc-f3be-203b-571170ee8f11@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <596dcb0c-5bbc-f3be-203b-571170ee8f11@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 07:37:29AM -0700, Dave Hansen wrote:
> On 03/29/2018 06:47 AM, Peter Zijlstra wrote:
> > Further I think Dave argued that we should not change the llc-size,
> > because while SNC presents a subset of the cache to local CPUs, for
> > remote data the whole cache is still available, again something some
> > applications might rely on.
> 
> BTW, I may have argued this in the past, but I don't think it's the best
> thing to do.
> 
> If anything, we should optimize for the _users_ of this information: the
> performance-sensitive ones who are digging up the cache topology.  They
> are also likely to be the most NUMA-affinitized and stay node-local with
> much of their memory traffic.  That would seem to point us in the
> direction of enumerating two separate, half-sized LLCs "shared" only by
> the slice when SNC mode is on.
> 
> That's what I've argued to the hardware folks lately, at least.

Fair enough; then we need change the reported cache-size and mention all
this in (preferably) both comment and Changelog.
