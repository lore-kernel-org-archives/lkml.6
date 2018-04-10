Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeDJM0S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:26:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeDJM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:26:17 -0400
Date: Tue, 10 Apr 2018 14:26:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: yuankuiz@codeaurora.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH] time: tick-sched: use bool for tick_stopped
Message-ID: <20180410122604.GE4082@hirez.programming.kicks-ass.net>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
 <f253686d26b3470f0e9b60502eb62315@codeaurora.org>
 <alpine.DEB.2.21.1804101110080.2058@nanos.tec.linutronix.de>
 <a7d6dddd7d4f9fdc0be8f94251af237f@codeaurora.org>
 <20180410112637.GD4082@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1804101407040.2058@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804101407040.2058@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 02:07:32PM +0200, Thomas Gleixner wrote:
> On Tue, 10 Apr 2018, Peter Zijlstra wrote:
> > Do you have any actual evidence for that? Is there a compiler stupid
> > enough to generate code to convert a bool to a 1bit value?
> 
> Sure, if you do:
> 
> > > > > > > +       bool                            tick_stopped    : 1;
> 
> which is stupidly allowed by the standard....

The code-gen changes are because of the layout change, not because of
the type change.
