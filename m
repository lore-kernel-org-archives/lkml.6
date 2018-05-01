Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755615AbeEAN72 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:59:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754798AbeEAN71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:59:27 -0400
Date: Tue, 1 May 2018 15:59:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, mpe@ellerman.id.au, bigeasy@linutronix.de,
        gkohli@codeaurora.org, neeraju@codeaurora.org
Subject: Re: [PATCH 2/2] sched: Introduce set_special_state()
Message-ID: <20180501135924.GA12696@redhat.com>
References: <20180430141751.377491406@infradead.org>
 <20180430142235.900370484@infradead.org>
 <20180430164545.GA10951@redhat.com>
 <20180430194024.GA12217@hirez.programming.kicks-ass.net>
 <20180501095054.GD12235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501095054.GD12235@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01, Peter Zijlstra wrote:
>
> The only code I found that seems to care is ptrace_attach(), where we
> wait for JOBCTL_TRAPPING to get cleared. That same function has a
> comment about hiding the STOPPED -> RUNNING -> TRACED transition. So I'm
> assuming it needs to observe TRACED if it observes !TRAPPING.

Yes, exactly.

> But I don't think there's enough barriers on that end to guarantee this.
> Any ->state load after wait_on_bit() is, afact, free to have happened
> before the ->jobctl load.

do_wait() does set_current_state() before it checks ->state or anything else.

Oleg.
