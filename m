Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeEDRhb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbeEDRh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:37:29 -0400
Date: Fri, 4 May 2018 13:37:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: rcu-bh design
Message-ID: <20180504133726.3f04d7bf@gandalf.local.home>
In-Reply-To: <20180504173205.GQ26088@linux.vnet.ibm.com>
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
        <20180504123050.2841f80d@gandalf.local.home>
        <20180504173205.GQ26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018 10:32:06 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > > But preemptible RCU *does not* use context-switch as a quiescent state.  
> > 
> > It doesn't?  
> 
> It does, but only sort of.

Ah, my confusion. I was thinking of rcu_read_lock_sched() as
"preemptible RCU", not the "we can preempt in rcu_read_lock() context".

-- Steve


> 
> A context switch really is always an RCU-preempt quiescent state from
> the perspective of the CPU.  However, from the perspective of the task,
> context switch is a quiescent state only if the task is not in an
> RCU-preempt read-side critical section at the time.
