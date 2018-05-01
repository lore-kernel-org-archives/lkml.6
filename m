Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeEATso (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:48:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEATsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:48:43 -0400
Date: Tue, 1 May 2018 21:48:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/irqtrace: only call trace_hardirqs_on/off when
 state changes
Message-ID: <20180501194838.GK12217@hirez.programming.kicks-ass.net>
References: <20171116161506.19691-1-npiggin@gmail.com>
 <20180501144620.1e832a09@gandalf.local.home>
 <20180501191951.GJ12217@hirez.programming.kicks-ass.net>
 <20180501153840.7281022a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501153840.7281022a@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 03:38:40PM -0400, Steven Rostedt wrote:
> On Tue, 1 May 2018 21:19:51 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > Now, lockdep only minimally tracks these otherwise redundant operations;
> > see redundant_hardirqs_{on,off} counters, and loosing that doesn't seen
> > like a big issue.
> > 
> > But I'm confused how this helps track superfluous things, it looks like
> > it explicitly tracks _less_ superfluous transitions.
> 
> I think it is about triggering on OFF->OFF a warning, as that would
> only happen if we have:
> 
> 	local_irq_save(flags);
> 	[..]
> 	local_irq_disable();
> 

Ahh, ok. Yes, that is easier to do with these changes. The alternative
is to add more information to the tracehooks such that we can do the
same internally, but whatever.

Yeah, I'm fine with the proposed change, but maybe improve the Changelog
a little for slow people like me :-)
