Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934291AbeCEKpL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:45:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933936AbeCEKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:45:04 -0500
Date: Mon, 5 Mar 2018 11:44:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH 1/7] time: tick-sched: Reorganize idle tick
 management code
Message-ID: <20180305104446.GN25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
 <46071692.o1R0bjyNQV@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46071692.o1R0bjyNQV@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 11:24:00PM +0100, Rafael J. Wysocki wrote:
> +/**
> + * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
> + *
> + * Called when we start the idle loop.
> + */
> +void tick_nohz_idle_prepare(void)
> +{
> +	__tick_nohz_idle_prepare();
> +
> +	local_irq_enable();
> +}

I really dislike the asymmetry in IRQ state you introduced here.
__tick_nohz_idle_prepare() disables IRQs. Must we do that?
