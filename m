Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeEAUBD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbeEAUBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:01:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73814236FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 1 May 2018 16:00:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/irqtrace: only call trace_hardirqs_on/off when
 state changes
Message-ID: <20180501160059.6df6aae4@gandalf.local.home>
In-Reply-To: <20180501194838.GK12217@hirez.programming.kicks-ass.net>
References: <20171116161506.19691-1-npiggin@gmail.com>
        <20180501144620.1e832a09@gandalf.local.home>
        <20180501191951.GJ12217@hirez.programming.kicks-ass.net>
        <20180501153840.7281022a@gandalf.local.home>
        <20180501194838.GK12217@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2018 21:48:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, May 01, 2018 at 03:38:40PM -0400, Steven Rostedt wrote:
> > On Tue, 1 May 2018 21:19:51 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:  
> 
> > > Now, lockdep only minimally tracks these otherwise redundant operations;
> > > see redundant_hardirqs_{on,off} counters, and loosing that doesn't seen
> > > like a big issue.
> > > 
> > > But I'm confused how this helps track superfluous things, it looks like
> > > it explicitly tracks _less_ superfluous transitions.  
> > 
> > I think it is about triggering on OFF->OFF a warning, as that would
> > only happen if we have:
> > 
> > 	local_irq_save(flags);
> > 	[..]
> > 	local_irq_disable();
> >   
> 
> Ahh, ok. Yes, that is easier to do with these changes. The alternative
> is to add more information to the tracehooks such that we can do the
> same internally, but whatever.
> 
> Yeah, I'm fine with the proposed change, but maybe improve the Changelog
> a little for slow people like me :-)

Great!

Nicholas,

I know this is an old patch (from last November), but want to send it
again with a proper change log and signed off by?

-- Steve
