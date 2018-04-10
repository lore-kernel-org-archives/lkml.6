Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeDJJLK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:11:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53050 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753679AbeDJJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:11:08 -0400
Date: Tue, 10 Apr 2018 11:10:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: yuankuiz@codeaurora.org
cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, aulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-owner@vger.kernel.org
Subject: Re: Subject: [PATCH] [PATCH] time: tick-sched: use bool for
 tick_stopped
In-Reply-To: <f253686d26b3470f0e9b60502eb62315@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1804101110080.2058@nanos.tec.linutronix.de>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org> <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com> <f253686d26b3470f0e9b60502eb62315@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018, yuankuiz@codeaurora.org wrote:
> On 2018-04-10 04:00 PM, Rafael J. Wysocki wrote:
> > On Tue, Apr 10, 2018 at 9:33 AM,  <yuankuiz@codeaurora.org> wrote:
> > > From: John Zhao <yuankuiz@codeaurora.org>
> > > 
> > > Variable tick_stopped returned by tick_nohz_tick_stopped
> > > can have only true / forse values. Since the return type
> > > of the tick_nohz_tick_stopped is also bool, variable
> > > tick_stopped nice to have data type as bool in place of int.
> > > Moreover, the executed instructions cost could be minimal
> > > without potiential data type conversion.
> > > 
> > > Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
> > > ---
> > >  kernel/time/tick-sched.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
> > > index 6de959a..4d34309 100644
> > > --- a/kernel/time/tick-sched.h
> > > +++ b/kernel/time/tick-sched.h
> > > @@ -48,8 +48,8 @@ struct tick_sched {
> > >         unsigned long                   check_clocks;
> > >         enum tick_nohz_mode             nohz_mode;
> > > 
> > > +       bool                            tick_stopped    : 1;
> > >         unsigned int                    inidle          : 1;
> > > -       unsigned int                    tick_stopped    : 1;
> > >         unsigned int                    idle_active     : 1;
> > >         unsigned int                    do_timer_last   : 1;
> > >         unsigned int                    got_idle_tick   : 1;
> > 
> > I don't think this is a good idea at all.
> > 
> > Please see https://lkml.org/lkml/2017/11/21/384 for example.
> [ZJ] Thanks for this sharing. Looks like, this patch fall into the case of
> "Maybe".

This patch falls into the case 'pointless' because it adds extra storage
for no benefit at all.

Thanks,

	tglx
