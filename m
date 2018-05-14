Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeENFFi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 01:05:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35246 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeENFFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 01:05:37 -0400
X-Google-Smtp-Source: AB8JxZprPiLLANkRwYfzB27uXJZht6G6rXGz4FCJ2gtsifNdpzJXeDpCu2ubeN9XH5ETZiHYFVHRcw==
Date: Sun, 13 May 2018 22:05:36 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 1/8] rcu: Add comment documenting how rcu_seq_snap
 works
Message-ID: <20180514050536.GB80415@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-2-joel@joelfernandes.org>
 <d13d5fca-d98c-c657-316d-aed10fd3eff0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d13d5fca-d98c-c657-316d-aed10fd3eff0@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 08:47:24PM -0700, Randy Dunlap wrote:
> On 05/13/2018 08:15 PM, Joel Fernandes (Google) wrote:
> > rcu_seq_snap may be tricky for someone looking at it for the first time.
> > Lets document how it works with an example to make it easier.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/rcu.h | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 003671825d62..fc3170914ac7 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -91,7 +91,29 @@ static inline void rcu_seq_end(unsigned long *sp)
> >  	WRITE_ONCE(*sp, rcu_seq_endval(sp));
> >  }
> >  
> > -/* Take a snapshot of the update side's sequence number. */
> > +/*
> > + * Take a snapshot of the update side's sequence number.
> > + *
> > + * This function predicts what the grace period number will be the next
> > + * time an RCU callback will be executed, given the current grace period's
> > + * number. This can be gp+1 if RCU is idle, or gp+2 if a grace period is
> > + * already in progress.
> > + *
> > + * We do this with a single addition and masking.
> > + * For example, if RCU_SEQ_STATE_MASK=1 and the least significant bit (LSB) of
> > + * the seq is used to track if a GP is in progress or not, its sufficient if we
> 
>                                                               it's

Pardon my english. Fixed, thanks,

- Joel
