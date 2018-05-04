Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEDSY1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:24:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeEDSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:24:26 -0400
Date: Fri, 4 May 2018 20:24:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com, catalin.marinas@arm.com,
        dvyukov@google.com, mingo@kernel.org, will.deacon@arm.com
Subject: Re: [PATCH 1/6] locking/atomic, asm-generic: instrument ordering
 variants
Message-ID: <20180504182422.GT12217@hirez.programming.kicks-ass.net>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 07:09:09PM +0100, Mark Rutland wrote:
> On Fri, May 04, 2018 at 08:01:05PM +0200, Peter Zijlstra wrote:
> > On Fri, May 04, 2018 at 06:39:32PM +0100, Mark Rutland wrote:

> > >  include/asm-generic/atomic-instrumented.h | 1195 ++++++++++++++++++++++++-----
> > >  1 file changed, 1008 insertions(+), 187 deletions(-)
> > 
> > Is there really no way to either generate or further macro compress this?
> 
> I can definitely macro compress this somewhat, but the bulk of the
> repetition will be the ifdeffery, which can't be macro'd away IIUC.

Right, much like what we already have in linux/atomic.h I suspect,
having to duplicating that isn't brilliant either.

> Generating this with a script is possible -- do we do anything like that
> elsewhere?

There's include/generated/ in your build directory. But nothing on this
scale I think.
