Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDEHVL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:21:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40363 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDEHVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:21:09 -0400
X-Google-Smtp-Source: AIpwx4/qfFeXulXTNIQ12BnKjRhekU1+eB5sjt379fKATlq60wZAA3FudXvm4AvZVyw/0JDCY+L0uA==
Date: Thu, 5 Apr 2018 09:21:05 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, efault@gmx.de,
        rostedt@goodmis.org, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP
 warning
Message-ID: <20180405072105.egwq2pg26np3l7pb@gmail.com>
References: <20180402164954.16255-1-dave@stgolabs.net>
 <20180404161539.nhadkff2aats74jh@linux-n805>
 <20180404163910.GL4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404163910.GL4043@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 04, 2018 at 09:15:39AM -0700, Davidlohr Bueso wrote:
> > On Mon, 02 Apr 2018, Davidlohr Bueso wrote:
> > 
> > > The case for the rt task throttling (which this workload also hits) can be ignored in
> > > that the skip_update call is actually bogus and quite the contrary (the request bits
> > > are removed/reverted).
> > 
> > While at it, how about this trivial patch?
> > 
> > ----8<--------------------------------------------------------
> > [PATCH 2/1] sched: Simplify helpers for rq clock update skip requests
> > 
> > By renaming the functions we can get rid of the skip parameter
> > and have better code redability. It makes zero sense to have
> > things such as:
> > 
> > rq_clock_skip_update(rq, false)
> > 
> > When the skip request is in fact not going to happen. Ever. Rename
> > things such that we end up with:
> > 
> > rq_clock_skip_update(rq)
> > rq_clock_cancel_skipupdate(rq)
> > 
> > Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> 
> Works for me :-)
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I have applied both patches, thanks guys!

	Ingo
