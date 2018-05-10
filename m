Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeEJXQz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 19:16:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750758AbeEJXQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 19:16:52 -0400
Date: Thu, 10 May 2018 18:16:49 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
Message-ID: <20180510231649.a5p3cv3g653jai6a@treble>
References: <20180501135850.enx4waqd5d7yowlj@treble>
 <alpine.DEB.2.21.1805011557240.19937@macbook-air>
 <20180501220458.p3rgwzh3jcqt4jmm@treble>
 <20180502205009.codkvscnh4j4hm6b@treble>
 <alpine.DEB.2.21.1805041033230.6376@macbook-air>
 <20180504162557.iodmglq3duomz6c2@treble>
 <alpine.DEB.2.21.1805051134230.11518@macbook-air>
 <20180505182912.llj7jb3v7yd43t5h@treble>
 <20180506234935.yq6zxjetlpldpzz7@treble>
 <20180510134841.GE12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510134841.GE12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 03:48:41PM +0200, Peter Zijlstra wrote:
> On Sun, May 06, 2018 at 06:49:35PM -0500, Josh Poimboeuf wrote:
> 
> > Deja vu.  Most of these are related to perf PEBS, similar to the
> > following issue:
> > 
> >   b8000586c90b ("perf/x86/intel: Cure bogus unwind from PEBS entries")
> > 
> > This is basically the ORC version of that.  setup_pebs_sample_data() is
> > assembling a franken-pt_regs which ORC isn't happy about.  RIP is
> > inconsistent with some of the other registers (like RSP and RBP).
> > 
> > Peter, any ideas?
> 
> Urgh..
> 
> Something like so perhaps? It's a bit of a hack, but I couldn't quickly
> think of something nicer.

I had to convert perf_callchain() to a global function to get it to
compile, but it does seem to fix the issue.

-- 
Josh
