Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeA3SwU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:52:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752555AbeA3SwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:52:18 -0500
Date: Tue, 30 Jan 2018 19:52:12 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH V3 0/5] bugs fix for large PEBS mmap read and rdpmc read
Message-ID: <20180130185212.GA16806@krava>
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <CABPqkBRjQp62ArVZzuH=TRU3mDPkS93D8_cNev6M=eXTCpBLkA@mail.gmail.com>
 <20180130133917.GC29098@krava>
 <6d708c09-52a7-a906-b651-b133a7b4f189@linux.intel.com>
 <20180130150454.GE29098@krava>
 <35090c62-466a-aec8-b1a3-69def959c1c6@linux.intel.com>
 <CABPqkBRWtSsKEM7ycPs0HYSKLsYDmZhr4ztUmMMqsytYamPGsw@mail.gmail.com>
 <24210bcb-0e4b-58fe-bcda-da30019f6e7e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24210bcb-0e4b-58fe-bcda-da30019f6e7e@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 11:48:18AM -0500, Liang, Kan wrote:

SNIP

> > > 
> > > The events in fixed mode could enable large PEBS. Events in freq mode should
> > > not enable large PEBS.
> > > I think that could be a problem if some events try to enable large PEBS,
> > > while others not.
> > > 
> > You only enable large PEBS if 100% of the events use fixed periods,
> > either via -c period
> > or because they all use individual period=p. The --no-period could
> > also be used to remove
> > the period for measurements where the period is not needed.
> 
> 
> Oh, right, the kernel has already guaranteed that.
> 	if (cpuc->n_pebs == cpuc->n_large_pebs) {
> 		threshold = ds->pebs_absolute_maximum -
> 			x86_pmu.max_pebs_events * x86_pmu.pebs_record_size;
> 	} else {
> 
> Sorry for the noise.
> 
> jirka's patch looks good to me.

cool, I'll post it later this week

thanks,
jirka
