Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966761AbeEJRh5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:37:57 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42389 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966673AbeEJRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:37:55 -0400
X-Google-Smtp-Source: AB8JxZo7tY7jshG3UloHtV5dhZs1wa9xCDJsGpUy6kzoRm0RUOq9ZNBFxUPRQy7IIFFo+tvPyCRhxw==
Date: Thu, 10 May 2018 10:37:54 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel.opensrc@gmail.com, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: Re: [tip/core/rcu, 05/21] rcu: Make rcu_gp_cleanup() more accurately
 predict need for new GP
Message-ID: <20180510173754.GB228531@joelaf.mtv.corp.google.com>
References: <1524452624-27589-5-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180510072133.GA122810@joelaf.mtv.corp.google.com>
 <20180510131546.GN26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510131546.GN26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 06:15:46AM -0700, Paul E. McKenney wrote:
[...] 
> > Also in rcu_future_gp_cleanup, we call:
> > 	trace_rcu_future_gp(rnp, rdp, c,
> > 			    needmore ? TPS("CleanupMore") : TPS("Cleanup"));
> > For this case, in the final trace event record, rnp->completed and c will be
> > the same, since c is set to rnp->completed before calling
> > trace_rcu_future_gp. I was thinking they should be different, do you expect
> > them to be the same?
> 
> Hmmm...  That does look a bit inconsistent.  And it currently uses
> rnp->gp_seq instead of rnp->gp_seq_needed despite having the same
> "CleanupMore" name.
> 
> Looks like a review of the calls to trace_rcu_this_gp() is in order.

I see you changed trace_rcu_future_gp to use trace_rcu_this_gp in 15/21.. I
am not sure if the concern is still valid then since you seem to be correctly
getting the future GP in those cases, except for the naming which I suggest
be changed from 'c' to 'future_gp' just for clarity / self-documenting code.

thanks,

- Joel
 
