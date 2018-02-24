Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeBXUSV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 15:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751417AbeBXUSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 15:18:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F72321716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 24 Feb 2018 15:18:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 10/10] rcu: Account for rcu_all_qs() in
 cond_resched()
Message-ID: <20180224151816.45597ca1@vmware.local.home>
In-Reply-To: <20171202122220.GM7829@linux.vnet.ibm.com>
References: <20171201192122.GA19301@linux.vnet.ibm.com>
        <1512156104-20104-10-git-send-email-paulmck@linux.vnet.ibm.com>
        <20171202085626.GS3326@worktop>
        <20171202122220.GM7829@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2017 04:22:20 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
 
> Because there are a few key places within RCU and rcutorture that need it.
> Without it, there are scenarios where the new cond_resched() never gets
> activated, and thus doesn't take effect.
> 
> The key point is that with this series in place, it should not be necessary
> to use cond_resched_rcu_qs() outside of kernel/rcu and kernel/torture.c.
> Which is a valuable step forward, right?

I'm guessing the tracepoint benchmark is another situation. It's only
existence is to benchmark tracepoints and should not be enabled on any
production system. Thus, I think reverting patch 6 (the one removing it
from the benchmark code) is the proper solution.

-- Steve
