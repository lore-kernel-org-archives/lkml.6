Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeETA46 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 20:56:58 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:33638 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeETA4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 20:56:55 -0400
X-Google-Smtp-Source: AB8JxZpsIdvEOQvQVBsIWGM7jeD/jWcbYbMB1e0n4KdZseH/OjAgB0BjNsfJaB1hT+SGhE0XuOTPjw==
Date: Sat, 19 May 2018 17:56:54 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: rostedt@goodmis.org, byungchul.park@lge.com,
        mathieu.desnoyers@efficios.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Message-ID: <20180520005632.GA58902@joelaf.mtv.corp.google.com>
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
 <20180519022918.GV3803@linux.vnet.ibm.com>
 <20180519225905.GB134184@joelaf.mtv.corp.google.com>
 <20180520004938.GZ3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520004938.GZ3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 05:49:38PM -0700, Paul E. McKenney wrote:
[...]
> > > And the problem with wrapping them with rcu_read_{lock,unlock} is that
> > > there would be a point before the trampoline executed rcu_read_lock()
> > > but while it was on the trampoline.  Nothing good comes from this.  ;-)
> > 
> > Yes, I see what you're saying. The data being protected and freed in this
> > case is the code so relying on it to do the rcu_read_lock seems infeasible.
> > Conceptually atleast, I feel this can be fixed by cleverly implementing
> > trampolines such that the rcu_read_lock isn't done during the trampoline
> > execution. But I am not very experienced with how the trampolines work to say
> > definitely whether it is or isn't possible or worth it. But atleast I felt it
> > was a worthwhile food for thought ;)
> 
> I suggested to Steven that the rcu_read_lock() and rcu_read_unlock() might
> be outside of the trampoline, but this turned out to be infeasible.  Not
> that I remember why!  ;-)
> 
> > I actually want to trace out the trampoline executing as it pertains to RCU,
> > with your latest rcu/dev.. I think it will be fun :)
> 
> Cool!
> 
> In addition, if you are interested, it might be worth looking for fields
> in rcu_dynticks, rcu_data, rcu_node, and rcu_state that are no longer
> actually used.  It might also be worth looking for RCU macros that are
> no longer used.

Yes, definitely interested. Will keep an eye out for such fields and macros.

thanks!

 - Joel
