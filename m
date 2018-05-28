Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeE1JtM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:49:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754224AbeE1JtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:49:10 -0400
Date: Mon, 28 May 2018 11:49:06 +0200 (CEST)
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, ebiederm@xmission.com
Subject: Re: [PATCH v2 1/2] rcu: Update documentation of rcu_read_unlock()
In-Reply-To: <20180525141942.GB3803@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1805281148080.4496@hypnos.tec.linutronix.de>
References: <20180525090507.22248-1-anna-maria@linutronix.de> <20180525090507.22248-2-anna-maria@linutronix.de> <20180525141942.GB3803@linux.vnet.ibm.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, Paul E. McKenney wrote:

> On Fri, May 25, 2018 at 11:05:06AM +0200, Anna-Maria Gleixner wrote:
> > Since commit b4abf91047cf ("rtmutex: Make wait_lock irq safe") the
> > explanation in rcu_read_unlock() documentation about irq unsafe rtmutex
> > wait_lock is no longer valid.
> > 
> > Remove it to prevent kernel developers reading the documentation to rely on
> > it.
> > 
> > Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> > Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> Or let me know if you would like me to carry this patch.  Either way,
> just let me know!
> 

Thanks! Thomas told be he will take both.

Anna-Maria


> 
> > ---
> >  include/linux/rcupdate.h | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 36360d07f25b..64644fda3b22 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -653,9 +653,7 @@ static inline void rcu_read_lock(void)
> >   * Unfortunately, this function acquires the scheduler's runqueue and
> >   * priority-inheritance spinlocks.  This means that deadlock could result
> >   * if the caller of rcu_read_unlock() already holds one of these locks or
> > - * any lock that is ever acquired while holding them; or any lock which
> > - * can be taken from interrupt context because rcu_boost()->rt_mutex_lock()
> > - * does not disable irqs while taking ->wait_lock.
> > + * any lock that is ever acquired while holding them.
> >   *
> >   * That said, RCU readers are never priority boosted unless they were
> >   * preempted.  Therefore, one way to avoid deadlock is to make sure
> > -- 
> > 2.15.1
> > 
> 
> 
