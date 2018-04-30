Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755063AbeD3Qpt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:45:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754781AbeD3Qps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:45:48 -0400
Date: Mon, 30 Apr 2018 18:45:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, mpe@ellerman.id.au, bigeasy@linutronix.de,
        gkohli@codeaurora.org, neeraju@codeaurora.org
Subject: Re: [PATCH 2/2] sched: Introduce set_special_state()
Message-ID: <20180430164545.GA10951@redhat.com>
References: <20180430141751.377491406@infradead.org>
 <20180430142235.900370484@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430142235.900370484@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30, Peter Zijlstra wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1968,7 +1968,7 @@ static void ptrace_stop(int exit_code, i
>  	 * atomic with respect to siglock and should be done after the arch
>  	 * hook as siglock is released and regrabbed across it.
>  	 */
> -	set_current_state(TASK_TRACED);
> +	set_special_state(TASK_TRACED);

Yes, but please note the comment above, we need a barrier after state = TASK_TRACED,
that is why ptrace_stop() does set_current_state(), not __set_current_state().

Otherwise both patches look good to me, feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
