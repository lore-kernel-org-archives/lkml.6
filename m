Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCWTuV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:50:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeCWTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:50:18 -0400
Date: Fri, 23 Mar 2018 12:50:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?ISO-8859-1?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] [RFC] init, tracing: Add initcall trace events
Message-Id: <20180323125016.270ea1558fe2499b1a12bfd7@linux-foundation.org>
In-Reply-To: <20180323150241.878778199@goodmis.org>
References: <20180323150241.878778199@goodmis.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 11:02:41 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> A while ago we had a boot tracer. But it was eventually removed:
>  commit 30dbb20e68e6f ("tracing: Remove boot tracer").
> 
> The rational was because there is already a initcall_debug boot option
> that causes printk()s of all the initcall functions.

"rationale" :)

> The problem with the initcall_debug option is that printk() is awfully slow,
> and makes it difficult to see the real impact of initcalls. Mainly because
> a single printk() is usually slower than most initcall functions.

Not understanding this.  We do it correctly:

	calltime = ktime_get();
	ret = fn();
	rettime = ktime_get();

so the displayed initcall timing is independent of the printk()
execution time?
