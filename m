Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeEEJMj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:12:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33616 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbeEEJMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:12:38 -0400
Date: Sat, 5 May 2018 10:12:29 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, mingo@kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 1/6] locking/atomic, asm-generic: instrument ordering
 variants
Message-ID: <20180505091229.smbvp7vlgpyld7dn@salmiak>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180504182422.GT12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504182422.GT12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 08:24:22PM +0200, Peter Zijlstra wrote:
> On Fri, May 04, 2018 at 07:09:09PM +0100, Mark Rutland wrote:
> > On Fri, May 04, 2018 at 08:01:05PM +0200, Peter Zijlstra wrote:
> > > On Fri, May 04, 2018 at 06:39:32PM +0100, Mark Rutland wrote:
> 
> > > >  include/asm-generic/atomic-instrumented.h | 1195 ++++++++++++++++++++++++-----
> > > >  1 file changed, 1008 insertions(+), 187 deletions(-)
> > > 
> > > Is there really no way to either generate or further macro compress this?
> > 
> > I can definitely macro compress this somewhat, but the bulk of the
> > repetition will be the ifdeffery, which can't be macro'd away IIUC.
> 
> Right, much like what we already have in linux/atomic.h I suspect,
> having to duplicating that isn't brilliant either.
> 
> > Generating this with a script is possible -- do we do anything like that
> > elsewhere?
> 
> There's include/generated/ in your build directory. But nothing on this
> scale I think.

Sure. I'm not familiar with how we generate those, so I'll go digging through
the build infrastructure.

Thanks,
Mark.
