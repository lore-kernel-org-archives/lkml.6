Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeDJMdS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:33:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbeDJMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:33:14 -0400
Date: Tue, 10 Apr 2018 14:33:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, aulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        apw@canonical.com, joe@perches.com
Subject: Re: Subject: [PATCH] [PATCH] time: tick-sched: use bool for
 tick_stopped
Message-ID: <20180410123305.GF4082@hirez.programming.kicks-ass.net>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 10:00:01AM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 10, 2018 at 9:33 AM,  <yuankuiz@codeaurora.org> wrote:
> > +++ b/kernel/time/tick-sched.h
> > @@ -48,8 +48,8 @@ struct tick_sched {
> >         unsigned long                   check_clocks;
> >         enum tick_nohz_mode             nohz_mode;
> >
> > +       bool                            tick_stopped    : 1;
> >         unsigned int                    inidle          : 1;
> > -       unsigned int                    tick_stopped    : 1;
> >         unsigned int                    idle_active     : 1;
> >         unsigned int                    do_timer_last   : 1;
> >         unsigned int                    got_idle_tick   : 1;
> 
> I don't think this is a good idea at all.
> 
> Please see https://lkml.org/lkml/2017/11/21/384 for example.

Joe, apw, could we get Checkpatch to whinge about _Bool in composite
types? That should immediately also disqualify using it as the base type
of bitfields.
