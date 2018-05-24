Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935336AbeEXBgA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935109AbeEXBf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:35:57 -0400
Date: Wed, 23 May 2018 21:35:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/4] rcu: Speed up calling of RCU tasks callbacks
Message-ID: <20180523213553.7a0ffd6d@gandalf.local.home>
In-Reply-To: <20180524005119.GA170821@joelaf.mtv.corp.google.com>
References: <20180523063815.198302-1-joel@joelfernandes.org>
        <20180523063815.198302-2-joel@joelfernandes.org>
        <20180523155734.GK3803@linux.vnet.ibm.com>
        <20180523124531.7b0e972a@gandalf.local.home>
        <20180523170303.GR3803@linux.vnet.ibm.com>
        <20180523151337.469bba34@gandalf.local.home>
        <20180523200458.GD3803@linux.vnet.ibm.com>
        <20180524005119.GA170821@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018 17:51:19 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> Shouldn't this assignment be done outside the loop? I believe the variable
> will be initialized on each iteration.
> 
> A program like this doesn't terminate:
> 
> #include<stdio.h>
> 
> int main() {
> 	for (;;) {
> 		int i = 10;
> 		if (!(i--))
> 			break;
> 	}
> 
> 	return 0;
> }

Hey, it compiled, booted and tested. SHIP IT! ;-)

But yeah, a little egg on my face for that one. I blame it for the
first code I wrote right off of coming back from vacation.

> 
> Otherwise looks good to me, I would initialize fract to 10 so its consistent
> with "HZ/10" in other parts of the code but I'm ok with either number.

I was thinking about that, but for some reason I thought 15. Not sure
why. I'm fine with dropping it down to 10. I'll send out a more proper
patch tomorrow.

Thanks!

-- Steve
