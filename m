Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeDWIyP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:54:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754152AbeDWIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:54:11 -0400
Date: Mon, 23 Apr 2018 10:53:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 06/22] rcu: Rename cond_resched_rcu_qs() to
 cond_resched_tasks_rcu_qs()
Message-ID: <20180423085347.GS4064@hirez.programming.kicks-ass.net>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-6-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524450747-22778-6-git-send-email-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 07:32:11PM -0700, Paul E. McKenney wrote:
> Commit e31d28b6ab8f ("trace: Eliminate cond_resched_rcu_qs() in favor
> of cond_resched()") substituted cond_resched() for the earlier call
> to cond_resched_rcu_qs().  However, the new-age cond_resched() does
> not do anything to help RCU-tasks grace periods because (1) RCU-tasks
> is only enabled when CONFIG_PREEMPT=y and (2) cond_resched() is a
> complete no-op when preemption is enabled.  This situation results
> in hangs when running the trace benchmarks.

But a few patches earlier you tried to address that..
