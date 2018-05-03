Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeECOpF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:45:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43614 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeECOpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:45:04 -0400
Date: Thu, 3 May 2018 16:44:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180503144450.GD12217@hirez.programming.kicks-ass.net>
References: <20180417142119.GA4511@codeblueprint.co.uk>
 <20180420095005.GH4064@hirez.programming.kicks-ass.net>
 <20180424133325.GA3179@codeblueprint.co.uk>
 <1525349542.9956.2.camel@gmx.de>
 <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
 <1525351221.9956.4.camel@gmx.de>
 <20180503124943.GB12217@hirez.programming.kicks-ass.net>
 <1525354359.5576.1.camel@gmx.de>
 <20180503135617.GC12217@hirez.programming.kicks-ass.net>
 <1525357015.5577.2.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525357015.5577.2.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 04:16:55PM +0200, Mike Galbraith wrote:
> On Thu, 2018-05-03 at 15:56 +0200, Peter Zijlstra wrote:
> > On Thu, May 03, 2018 at 03:32:39PM +0200, Mike Galbraith wrote:
> > 
> > > Dang.  With $subject fix applied as well..
> > 
> > That's a NO then... :-(
> 
> Could say who cares about oddball offline wakeup stat. <cringe>

Yeah, nobody.. but I don't want to have to change the wakeup code to
deal with this if at all possible. That'd just add conditions that are
'always' false, except in this exceedingly rare circumstance.

So ideally we manage to tell RCU that it needs to pay attention while
we're doing this here thing, which is what I thought RCU_NONIDLE() was
about.
