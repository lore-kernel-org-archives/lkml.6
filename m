Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755409AbeCSJqP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:46:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755291AbeCSJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:46:13 -0400
Date: Mon, 19 Mar 2018 10:45:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v5 6/7] cpuidle: menu: Refine idle state selection
 for running tick
Message-ID: <20180319094549.GG4043@hirez.programming.kicks-ass.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
 <4980385.RayypyZ8dA@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4980385.RayypyZ8dA@aspire.rjw.lan>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:16:41PM +0100, Rafael J. Wysocki wrote:

> --- linux-pm.orig/kernel/time/tick-sched.c
> +++ linux-pm/kernel/time/tick-sched.c
> @@ -1031,10 +1031,11 @@ void tick_nohz_irq_exit(void)
>  
>  /**
>   * tick_nohz_get_sleep_length - return the expected length of the current sleep
> + * @cur_ret: pointer for returning the current time to the next event

Both name and description are confusing, what it actually appears to
return is the duration until the next event. Which would suggest a name
like: delta_next or something along those lines.

But 'cur' short for current, is very misleading.
