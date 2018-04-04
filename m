Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeDDQjZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:39:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50326 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeDDQjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:39:24 -0400
Date: Wed, 4 Apr 2018 18:39:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: mingo@kernel.org, efault@gmx.de, rostedt@goodmis.org,
        matt@codeblueprint.co.uk, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP
 warning
Message-ID: <20180404163910.GL4043@hirez.programming.kicks-ass.net>
References: <20180402164954.16255-1-dave@stgolabs.net>
 <20180404161539.nhadkff2aats74jh@linux-n805>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404161539.nhadkff2aats74jh@linux-n805>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 09:15:39AM -0700, Davidlohr Bueso wrote:
> On Mon, 02 Apr 2018, Davidlohr Bueso wrote:
> 
> > The case for the rt task throttling (which this workload also hits) can be ignored in
> > that the skip_update call is actually bogus and quite the contrary (the request bits
> > are removed/reverted).
> 
> While at it, how about this trivial patch?
> 
> ----8<--------------------------------------------------------
> [PATCH 2/1] sched: Simplify helpers for rq clock update skip requests
> 
> By renaming the functions we can get rid of the skip parameter
> and have better code redability. It makes zero sense to have
> things such as:
> 
> rq_clock_skip_update(rq, false)
> 
> When the skip request is in fact not going to happen. Ever. Rename
> things such that we end up with:
> 
> rq_clock_skip_update(rq)
> rq_clock_cancel_skipupdate(rq)
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Works for me :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
