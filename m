Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeEDSJT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:09:19 -0400
Received: from foss.arm.com ([217.140.101.70]:57866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbeEDSJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:09:18 -0400
Date: Fri, 4 May 2018 19:09:09 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, mingo@kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 1/6] locking/atomic, asm-generic: instrument ordering
 variants
Message-ID: <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504180105.GS12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 08:01:05PM +0200, Peter Zijlstra wrote:
> On Fri, May 04, 2018 at 06:39:32PM +0100, Mark Rutland wrote:
> > Currently <asm-generic/atomic-instrumented.h> only instruments the fully
> > ordered variants of atomic functions, ignoring the {relaxed,acquire,release}
> > ordering variants.
> > 
> > This patch reworks the header to instrument all ordering variants of the atomic
> > functions, so that architectures implementing these are instrumented
> > appropriately.
> > 
> > To minimise repetition, a macro is used to generate each variant from a common
> > template. The {full,relaxed,acquire,release} order variants respectively are
> > then built using this template, where the architecture provides an
> > implementation.

> >  include/asm-generic/atomic-instrumented.h | 1195 ++++++++++++++++++++++++-----
> >  1 file changed, 1008 insertions(+), 187 deletions(-)
> 
> Is there really no way to either generate or further macro compress this?

I can definitely macro compress this somewhat, but the bulk of the
repetition will be the ifdeffery, which can't be macro'd away IIUC.

Generating this with a script is possible -- do we do anything like that
elsewhere?

> This is stupid repetitive, we just got rid of all that endless copy
> paste crap in atomic implementations and now we're going back to that.
> 
> Adding or changing atomic bits becomes horrifically painful because of this.

Sure thing; mangling it to its current state was a pain enough.

Thanks,
Mark.
