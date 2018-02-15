Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427031AbeBORKo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:10:44 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:55990 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422753AbeBORKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:10:41 -0500
Message-ID: <1518714636.2464.12.camel@gentoo.org>
Subject: Re: [PATCH-next] sched/headers: Clean up <linux/sched.h>
From: Christopher =?ISO-8859-1?Q?D=EDaz?= Riveros <chrisadr@gentoo.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date: Thu, 15 Feb 2018 12:10:36 -0500
In-Reply-To: <20180215165212.GB25181@hirez.programming.kicks-ass.net>
References: <20180215154318.15894-1-chrisadr@gentoo.org>
         <20180215165212.GB25181@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, thanks for the reply.


El jue, 15-02-2018 a las 17:52 +0100, Peter Zijlstra escribió:
> On Thu, Feb 15, 2018 at 10:43:18AM -0500, Christopher Diaz Riveros
> wrote:
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
> 
> Why, are those not valid kerneldoc comments?

Following the same structure from most of the multiline comments in the
file, they tend to be 

/*
 *
 */

I thought it was a typo, and maybe this makes the whole file have a
uniform multiline comment style.

> 
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
> 
> That's a whole lot less readable :/

Well, while reading the file on a 80 columns width terminal, it breaks
lines producing results like:

/* Maximum runtime for e
ach instance */

/* dl_runtime / dl_deadl
ine */

among others.

In fact, most of the comments in the file follow the structure:

/* comment about var */
type 			identifier

You can see this structure in lines:

631
689
740
781
820
among others.

-- 
Christopher Díaz Riveros
Gentoo Linux Developer
GPG Fingerprint: E517 5ECB 8152 98E4 FEBC  2BAA 4DBB D10F 0FDD 2547
