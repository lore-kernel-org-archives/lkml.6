Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEKR3O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEKR3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:29:13 -0400
Date: Fri, 11 May 2018 13:29:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        peterz@infradead.org
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
Message-ID: <20180511132910.4e729a26@gandalf.local.home>
In-Reply-To: <20180511172735.GB26088@linux.vnet.ibm.com>
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
        <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
        <20180511161746.GX26088@linux.vnet.ibm.com>
        <20180511122321.722a12cc@gandalf.local.home>
        <20180511122528.2a398d24@gandalf.local.home>
        <20180511122712.2d67992b@gandalf.local.home>
        <20180511172735.GB26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018 10:27:35 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Fri, May 11, 2018 at 12:27:12PM -0400, Steven Rostedt wrote:
> > On Fri, 11 May 2018 12:25:28 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > I would also say that one should never call schedule() directly without
> > > changing its state to something other than TASK_RUNNING. Hence, calling
> > > schedule directly is saying you are ready to sleep. But that is not the
> > > case with cond_resched() which should always be called with the state
> > > as TASK_RUNNING.  
> > 
> > To continue this, with tracing, when a task is scheduled out in the
> > RUNNING state, it is considered preempted, otherwise it is not.  
> 
> I suppose another option would be for cond_resched_tasks_rcu_qs() to set
> (and later clear) a per-CPU variable that causes rcu_note_context_switch()
> to ignore its "preempt" parameter.  Byungchul's approach seems more
> straightforward, though.

I agree that I prefer Byungchul's approach better ;-)

-- Steve
