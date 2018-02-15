Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166116AbeBOSKo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:10:44 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:59812 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165833AbeBOSK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:10:28 -0500
Message-ID: <1518718222.2464.18.camel@gentoo.org>
Subject: Re: [PATCH-next] sched/headers: Clean up <linux/sched.h>
From: Christopher =?ISO-8859-1?Q?D=EDaz?= Riveros <chrisadr@gentoo.org>
To: Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Thu, 15 Feb 2018 13:10:22 -0500
In-Reply-To: <7badd1c7-8d7d-02e9-1299-2d0e83754a66@infradead.org>
References: <20180215154318.15894-1-chrisadr@gentoo.org>
         <7badd1c7-8d7d-02e9-1299-2d0e83754a66@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El jue, 15-02-2018 a las 09:49 -0800, Randy Dunlap escribió:
> On 02/15/2018 07:43 AM, Christopher Diaz Riveros wrote:
> > Trivial clean up making  comments fit in 80 columns and keeping the
> > same comment style.
> 
> Why change the /** (indicates kernel-doc notation) to just /* ?
> 
> Is scripts/kernel-doc complaining with warnings or errors?
> 

If that's the case, then all the /** were correct and it's just me not
being aware of the meaning of /**.

Thanks Randy for clarifying it to me.

That leaves dl_* comments and a couple of oneline comments that may be
better in multiline format. I can prepare a v2 of that if you consider
it necessary.

> 
> > Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>
> > ---
> >  include/linux/sched.h | 54 +++++++++++++++++++++++++++++++++----
> > --------------
> >  1 file changed, 35 insertions(+), 19 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index b161ef8a902e..c752a0d48944 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -183,7 +183,7 @@ extern void io_schedule_finish(int token);
> >  extern long io_schedule_timeout(long timeout);
> >  extern void io_schedule(void);
> >  
> > -/**
> > +/*
> >   * struct prev_cputime - snapshot of system and user cputime
> >   * @utime: time spent in user mode
> >   * @stime: time spent in system mode
> > @@ -200,7 +200,7 @@ struct prev_cputime {
> >  #endif
> >  };
> >  
> > -/**
> > +/*
> >   * struct task_cputime - collected CPU time counts
> >   * @utime:		time spent in user mode, in nanoseconds
> >   * @stime:		time spent in kernel mode, in
> > nanoseconds
> > @@ -437,20 +437,28 @@ struct sched_dl_entity {
> >  	 * during sched_setattr(), they will remain the same until
> >  	 * the next sched_setattr().
> >  	 */
> > -	u64				dl_runtime;	/*
> > Maximum runtime for each instance	*/
> > -	u64				dl_deadline;	/*
> > Relative deadline of each instance	*/
> > -	u64				dl_period;	/*
> > Separation of two instances (period) */
> > -	u64				dl_bw;		/
> > * dl_runtime / dl_period		*/
> > -	u64				dl_density;	/*
> > dl_runtime / dl_deadline		*/
> > +	/* Maximum runtime for each instance	*/
> > +	u64				dl_runtime;
> > +	/* Relative deadline of each instance	*/
> > +	u64				dl_deadline;
> > +	/* Separation of two instances (period) */
> > +	u64				dl_period;
> > +	/* dl_runtime / dl_period		*/
> > +	u64				dl_bw;
> > +	/* dl_runtime / dl_deadline		*/
> > +	u64				dl_density;
> >  
> >  	/*
> >  	 * Actual scheduling parameters. Initialized with the
> > values above,
> >  	 * they are continously updated during task execution.
> > Note that
> >  	 * the remaining runtime could be < 0 in case we are in
> > overrun.
> >  	 */
> > -	s64				runtime;	/*
> > Remaining runtime for this instance	*/
> > -	u64				deadline;	/*
> > Absolute deadline for this instance	*/
> > -	unsigned int			flags;		
> > /* Specifying the scheduler behaviour	*/
> > +	/* Remaining runtime for this instance	*/
> > +	s64				runtime;
> > +	/* Absolute deadline for this instance	*/
> > +	u64				deadline;
> > +	/* Specifying the scheduler behaviour	*/
> > +	unsigned int			flags;	
> >  
> >  	/*
> >  	 * Some bool flags:
> > @@ -666,7 +674,8 @@ struct task_struct {
> >  	unsigned			no_cgroup_migration:1;
> >  #endif
> >  
> > -	unsigned long			atomic_flags; /*
> > Flags requiring atomic access. */
> > +	/* Flags requiring atomic access. */
> > +	unsigned long			atomic_flags;
> >  
> >  	struct restart_block		restart_block;
> >  
> > @@ -678,8 +687,9 @@ struct task_struct {
> >  	unsigned long			stack_canary;
> >  #endif
> >  	/*
> > -	 * Pointers to the (original) parent process, youngest
> > child, younger sibling,
> > -	 * older sibling, respectively.  (p->father can be
> > replaced with
> > +	 * Pointers to the (original) parent process, youngest
> > child,
> > +	 * younger sibling, older sibling, respectively.
> > +	 * (p->father can be replaced with
> >  	 * p->real_parent->pid)
> >  	 */
> >  
> > @@ -743,7 +753,10 @@ struct task_struct {
> >  	/* Boot based time in nsecs: */
> >  	u64				real_start_time;
> >  
> > -	/* MM fault and swap info: this can arguably be seen as
> > either mm-specific or thread-specific: */
> > +	/* 
> > +	 * MM fault and swap info: this can arguably be seen as
> > either
> > +	 * mm-specific or thread-specific: 
> > +	 */
> >  	unsigned long			min_flt;
> >  	unsigned long			maj_flt;
> >  
> > @@ -815,7 +828,10 @@ struct task_struct {
> >  	u32				parent_exec_id;
> >  	u32				self_exec_id;
> >  
> > -	/* Protection against (de-)allocation: mm, files, fs, tty,
> > keyrings, mems_allowed, mempolicy: */
> > +	/*
> > +	 * Protection against (de-)allocation: mm, files, fs, tty,
> > +	 * keyrings, mems_allowed, mempolicy: 
> > +	 */
> >  	spinlock_t			alloc_lock;
> >  
> >  	/* Protection of the PI data structures: */
> > @@ -1176,7 +1192,7 @@ static inline pid_t task_tgid_nr(struct
> > task_struct *tsk)
> >  	return tsk->tgid;
> >  }
> >  
> > -/**
> > +/*
> >   * pid_alive - check that a task structure is not stale
> >   * @p: Task structure to be checked.
> >   *
> > @@ -1275,7 +1291,7 @@ static inline char task_state_to_char(struct
> > task_struct *tsk)
> >  	return task_index_to_char(task_state_index(tsk));
> >  }
> >  
> > -/**
> > +/*
> >   * is_global_init - check if a task structure is init. Since init
> >   * is free to have sub-threads we need to check tgid.
> >   * @tsk: Task structure to be checked.
> > @@ -1422,7 +1438,7 @@ extern int yield_to(struct task_struct *p,
> > bool preempt);
> >  extern void set_user_nice(struct task_struct *p, long nice);
> >  extern int task_prio(const struct task_struct *p);
> >  
> > -/**
> > +/*
> >   * task_nice - return the nice value of a given task.
> >   * @p: the task in question.
> >   *
> > @@ -1442,7 +1458,7 @@ extern int sched_setattr(struct task_struct
> > *, const struct sched_attr *);
> >  extern int sched_setattr_nocheck(struct task_struct *, const
> > struct sched_attr *);
> >  extern struct task_struct *idle_task(int cpu);
> >  
> > -/**
> > +/*
> >   * is_idle_task - is the specified task an idle task?
> >   * @p: the task in question.
> >   *
> > 
> 
> 
-- 
Christopher Díaz Riveros
Gentoo Linux Developer
GPG Fingerprint: E517 5ECB 8152 98E4 FEBC  2BAA 4DBB D10F 0FDD 2547
