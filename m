Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeENGm4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 02:42:56 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:43032 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeENGmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 02:42:55 -0400
X-Google-Smtp-Source: AB8JxZrrC16xI0A7YGXN0JFVjvzNamTqFrSIOwAFD5naeQ5eUSqWUzrs1SvafHtoPJqA1/KgfWjPKQ==
Date: Mon, 14 May 2018 16:42:33 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel.opensrc@gmail.com, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: Re: [PATCH tip/core/rcu 0/21] Contention reduction for v4.18
Message-ID: <20180514164233.7c7bff00@roar.ozlabs.ibm.com>
In-Reply-To: <20180423030258.GA23370@linux.vnet.ibm.com>
References: <20180423030258.GA23370@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Apr 2018 20:02:58 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Hello!
> 
> This series reduces lock contention on the root rcu_node structure,
> and is also the first precursor to TBD changes to consolidate the
> three RCU flavors (RCU-bh, RCU-preempt, and RCU-sched) into one.

Hi Paul,

I've been running your rcu/dev branch and haven't noticed any problems
yet. The irqsoff latency improvement is a little hard to measure
because the scheduler, but I've tried turning balancing parameters
right down and I'm yet to see any sign of RCU in traces (down to about
100us on a 176 CPU machine), so that's great.

(Not that RCU was ever the worst contributor to latency as I said, just
that I noticed those couple of traces where it showed up.)

Thanks very much for the fast response, sorry I've taken a while to
test.

Thanks,
Nick
