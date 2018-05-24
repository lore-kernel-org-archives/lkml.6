Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971673AbeEXVr4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966099AbeEXVrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:47:55 -0400
Date: Thu, 24 May 2018 17:47:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/4] rcu: Speed up calling of RCU tasks callbacks
Message-ID: <20180524174752.0928d562@gandalf.local.home>
In-Reply-To: <20180523200458.GD3803@linux.vnet.ibm.com>
References: <20180523063815.198302-1-joel@joelfernandes.org>
        <20180523063815.198302-2-joel@joelfernandes.org>
        <20180523155734.GK3803@linux.vnet.ibm.com>
        <20180523124531.7b0e972a@gandalf.local.home>
        <20180523170303.GR3803@linux.vnet.ibm.com>
        <20180523151337.469bba34@gandalf.local.home>
        <20180523200458.GD3803@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018 13:04:58 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Looks plausible to me!
> 

BTW looking at the code:

> 		/* Invoke the callbacks. */
> 		while (list) {
> 			next = list->next;
> 			local_bh_disable();
> 			list->func(list);
> 			local_bh_enable();
> 			list = next;
> 			cond_resched();
> 		}
> 		schedule_timeout_uninterruptible(HZ/10);

What's the purpose of this final sleep?

-- Steve

> 	}
> }
