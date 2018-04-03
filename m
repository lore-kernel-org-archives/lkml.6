Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeDCRb5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:31:57 -0400
Received: from foss.arm.com ([217.140.101.70]:35954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeDCRb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:31:56 -0400
Date: Tue, 3 Apr 2018 18:32:08 +0100
From: Will Deacon <will.deacon@arm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Markus Metzger <markus.t.metzger@intel.com>
Subject: Re: [PATCH] perf: Allow suppressing AUX records
Message-ID: <20180403173207.GA8921@arm.com>
References: <20171115120022.o7hmfdb7vpeikvjl@hirez.programming.kicks-ass.net>
 <20180115150020.8509-1-alexander.shishkin@linux.intel.com>
 <20180329115429.GX4043@hirez.programming.kicks-ass.net>
 <20180331093546.ac7ygm4iz4l7hg4x@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331093546.ac7ygm4iz4l7hg4x@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 11:35:46AM +0200, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Jan 15, 2018 at 05:00:20PM +0200, Alexander Shishkin wrote:
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index c77c9a2ebbbb..d7a981130561 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -370,7 +370,8 @@ struct perf_event_attr {
> > >  				context_switch :  1, /* context switch data */
> > >  				write_backward :  1, /* Write ring buffer from end to beginning */
> > >  				namespaces     :  1, /* include namespaces data */
> > > -				__reserved_1   : 35;
> > > +				suppress_aux   :  1, /* don't generate PERF_RECORD_AUX */
> > > +				__reserved_1   : 34;
> > >  
> > >  	union {
> > >  		__u32		wakeup_events;	  /* wakeup every n events */
> > 
> > So I'm basically fine with this patch, however I wonder if we really
> > need this suppress flag and can't just unconditionally drop these
> > events.
> > 
> > Ash said that as far as he knows no Intel-PT user actually relies on it;
> > Will is there anything ARM that is known to rely on them?
> > 
> > In anycase, tentative ACK on this, unless we wants to be brave and forgo
> > this flag.
> > 
> > Ingo, any opinions?
> 
> Yeah, I'd suggest we just supress those record, and wait for complaints - let's 
> not complicate the ABI if not necessary?

Works for me. We've not had SPE support in mainline perf for very long and
the availability of hardware is extremely limited at the moment, so I don't
anticipate any ABI implications on the arm64 side.

Cheers,

Will
