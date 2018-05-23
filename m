Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbeEWBTr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 21:19:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39726 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753740AbeEWBTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 21:19:14 -0400
X-Google-Smtp-Source: AB8JxZoK/c+LI+F/cp/rExcbXKmQeSHorF3FrAuvT1q6FhDaZk0nuNWf+fGgjOS6pyYGfNa2/yTOqA==
Date: Tue, 22 May 2018 18:19:11 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, byungchul.park@lge.com,
        mathieu.desnoyers@efficios.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Message-ID: <20180523011911.GD55359@joelaf.mtv.corp.google.com>
References: <20180519225905.GB134184@joelaf.mtv.corp.google.com>
 <20180520004938.GZ3803@linux.vnet.ibm.com>
 <20180520112843.57079857@grimm.local.home>
 <20180520191846.GA248075@joelaf.mtv.corp.google.com>
 <20180521215951.2d6abfcb@gandalf.local.home>
 <20180522045414.GG40541@joelaf.mtv.corp.google.com>
 <20180522083832.45353d5f@gandalf.local.home>
 <20180522160949.GU3803@linux.vnet.ibm.com>
 <20180522132700.68b6660d@gandalf.local.home>
 <20180522174711.GY3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522174711.GY3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 10:47:11AM -0700, Paul E. McKenney wrote:
> On Tue, May 22, 2018 at 01:27:00PM -0400, Steven Rostedt wrote:
> > On Tue, 22 May 2018 09:09:49 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > Just for the record, if you guys realy want to take over Tasks RCU,
> > > I have no objections.  For one thing, I don't anticipate any other use
> > > cases for it (famous last words!).  But you break it, you buy it!  ;-)
> > 
> > It really matters how much of a burden is RCU_tasks to RCU itself? If
> > it causes a lot of headache for you, and it prevents you from cleaning
> > up RCU or making it better, then I would be happy to take it out of RCU
> > and maintain it separately myself. But if that's not the case, I'm happy
> > with keeping it within the RCU umbrella. Which brings me to the
> > question of what motivation does Joel have to remove it?
> 
> The burden on me from Tasks RCU has been quite light, so no need for a
> change from my end.
> 
> Over to you, Joel!  ;-)

My motivation was I felt RCU-preempt already did the same thing (which I
still believe it does) so its redundant. Although now I'm convinced from our
earlier discussions that its not feasible to do an rcu_read_lock and
rcu_read_unlock in trampoline code.

Sorry I didn't mean you should really nuke RCU-tasks if it has a purpose, but
I was more trying to understand what its purpose was that RCU-preempt didn't
solve. That's all.

And welcome back from Vacation Steve. I'm about to send v7 of my preempt/irq
tracepoint patches so the timing seems great. I hope you will be able to take
a look at them. thanks!

 - Joel
