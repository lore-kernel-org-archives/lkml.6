Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeCLO3m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:29:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLO3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:29:40 -0400
Date: Mon, 12 Mar 2018 15:29:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <20180312142933.GF4043@hirez.programming.kicks-ass.net>
References: <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <20180309174605.GC4064@hirez.programming.kicks-ass.net>
 <20180309202550.j66qphz3txupt55u@linutronix.de>
 <20180309222643.GC5926@hirez.programming.kicks-ass.net>
 <20180312105113.p7jifhwdwbhpvxds@linutronix.de>
 <20180312132729.GI4064@hirez.programming.kicks-ass.net>
 <20180312141107.roveviectc6a75s7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312141107.roveviectc6a75s7@linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:11:07PM +0100, Sebastian Andrzej Siewior wrote:
> I assumed you complained about the unbounded list-walk with interrupts
> disabled (which is cheap but unbound is unbound). So here I suggested I
> move 20 entries off that list a time and enable interrupts again so an
> interrupt could set need_resched.
> But if we get invoked !preemptible then nothing changes.

Right, so any !preemptible invocation of wake_all is bad.
