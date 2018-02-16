Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932299AbeBPJoi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:44:38 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37791 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeBPJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:44:37 -0500
X-Google-Smtp-Source: AH8x224JmIxnnHtWYMFnE3pWKNsUyX9QahkXs5VBJAJ68MpPqu7fSEoABbyTzhr7FhU5DMqMQawQfA==
Date: Fri, 16 Feb 2018 10:44:32 +0100
From: Juri Lelli <juri.lelli@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christopher Diaz Riveros <chrisadr@gentoo.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-next] sched/headers: Clean up <linux/sched.h>
Message-ID: <20180216094432.GG8032@localhost.localdomain>
References: <20180215154318.15894-1-chrisadr@gentoo.org>
 <20180215165212.GB25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215165212.GB25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/18 17:52, Peter Zijlstra wrote:
> On Thu, Feb 15, 2018 at 10:43:18AM -0500, Christopher Diaz Riveros wrote:

[...]

> > @@ -437,20 +437,28 @@ struct sched_dl_entity {
> >  	 * during sched_setattr(), they will remain the same until
> >  	 * the next sched_setattr().
> >  	 */
> > -	u64				dl_runtime;	/* Maximum runtime for each instance	*/
> > -	u64				dl_deadline;	/* Relative deadline of each instance	*/
> > -	u64				dl_period;	/* Separation of two instances (period) */
> > -	u64				dl_bw;		/* dl_runtime / dl_period		*/
> > -	u64				dl_density;	/* dl_runtime / dl_deadline		*/
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

Yep. :(
