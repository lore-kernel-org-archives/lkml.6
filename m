Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeBEREQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:04:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48942 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeBEREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:04:10 -0500
Date: Mon, 5 Feb 2018 18:03:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com, tim.c.chen@linux.intel.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180205170358.GT2295@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202195943.GR2269@hirez.programming.kicks-ass.net>
 <25d67bd2-cbe7-2c2a-e89a-13a7ca5adc10@oracle.com>
 <20180205124854.GX2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205124854.GX2269@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 01:48:54PM +0100, Peter Zijlstra wrote:
> So while I see the point of tracking these numbers (for SMT>2), I don't
> think its worth doing outside of the core, and then we still need some
> powerpc (or any other architecture with abysmal atomics) tested.

FWIW Power has another 'fun' feature, their cores have asymmetric SMT.

Their cores have a static power level, based on _which_ SMT sibling is
running, not how many. A single SMT2 runs (much) slower than a single
SMT0.

So that random selection stuff really doesn't work well for them. Now
'sadly' x86 can also have ASYM_PACKING set on its SMT domain, so I'm
going to have to figure out what to do about all that.
