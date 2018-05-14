Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbeENWVm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:21:42 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:45401 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeENWVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:21:39 -0400
X-Google-Smtp-Source: AB8JxZqpTqaobxe+nziCerRfnJ20YSoRk4WVxQcj/clQFMzqMMWuR6ZKqB5gTcTS59aNboMF4EePFg==
Date: Tue, 15 May 2018 08:21:20 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel.opensrc@gmail.com, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: Re: [PATCH tip/core/rcu 0/21] Contention reduction for v4.18
Message-ID: <20180515082120.1dbc32b5@roar.ozlabs.ibm.com>
In-Reply-To: <20180514160907.GX26088@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
        <20180514164233.7c7bff00@roar.ozlabs.ibm.com>
        <20180514160907.GX26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 09:09:07 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Mon, May 14, 2018 at 04:42:33PM +1000, Nicholas Piggin wrote:
> > On Sun, 22 Apr 2018 20:02:58 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> >   
> > > Hello!
> > > 
> > > This series reduces lock contention on the root rcu_node
> > > structure, and is also the first precursor to TBD changes to
> > > consolidate the three RCU flavors (RCU-bh, RCU-preempt, and
> > > RCU-sched) into one.  
> > 
> > Hi Paul,
> > 
> > I've been running your rcu/dev branch and haven't noticed any
> > problems yet. The irqsoff latency improvement is a little hard to
> > measure because the scheduler, but I've tried turning balancing
> > parameters right down and I'm yet to see any sign of RCU in traces
> > (down to about 100us on a 176 CPU machine), so that's great.  
> 
> Good to hear!!!

Yep, as in, various other latencies are down to 100us, and still
no sign of RCU, so RCU must be sitting somewhere below that.


> > (Not that RCU was ever the worst contributor to latency as I said,
> > just that I noticed those couple of traces where it showed up.)
> > 
> > Thanks very much for the fast response, sorry I've taken a while to
> > test.  
> 
> Would you be willing to give me a Tested-by on that series of patches?

Yes of course, for your rcu/dev series

Tested-by: Nicholas Piggin <npiggin@gmail.com>

Let me know if you make any other changes you'd like me to test before
merge.

Thanks,
Nick
