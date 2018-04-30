Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756231AbeD3Tkh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:40:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeD3Tke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:40:34 -0400
Date: Mon, 30 Apr 2018 21:40:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, mpe@ellerman.id.au, bigeasy@linutronix.de,
        gkohli@codeaurora.org, neeraju@codeaurora.org
Subject: Re: [PATCH 2/2] sched: Introduce set_special_state()
Message-ID: <20180430194024.GA12217@hirez.programming.kicks-ass.net>
References: <20180430141751.377491406@infradead.org>
 <20180430142235.900370484@infradead.org>
 <20180430164545.GA10951@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430164545.GA10951@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 06:45:46PM +0200, Oleg Nesterov wrote:
> On 04/30, Peter Zijlstra wrote:
> >
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1968,7 +1968,7 @@ static void ptrace_stop(int exit_code, i
> >  	 * atomic with respect to siglock and should be done after the arch
> >  	 * hook as siglock is released and regrabbed across it.
> >  	 */
> > -	set_current_state(TASK_TRACED);
> > +	set_special_state(TASK_TRACED);
> 
> Yes, but please note the comment above, we need a barrier after state = TASK_TRACED,
> that is why ptrace_stop() does set_current_state(), not __set_current_state().

OK, so I got properly lost in that stuff.

The comment says it we need to set TASK_TRACED before clearing
JOBCTL_TRAPPING because of do_wait(), but I cannot seem to locate code
in do_wait() and below that cares about JOBCTL_TRAPPING.

Could you elucidate my tired brain?
