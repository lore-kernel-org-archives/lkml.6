Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeD0PkK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932803AbeD0PkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:40:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC1F2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 27 Apr 2018 11:40:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks
 executing with preempt on
Message-ID: <20180427114005.31d1e8ab@gandalf.local.home>
In-Reply-To: <20180427153826.GK26088@linux.vnet.ibm.com>
References: <20180427042656.190746-1-joelaf@google.com>
        <1169911546.5820.1524839189395.JavaMail.zimbra@efficios.com>
        <20180427104747.2d965925@gandalf.local.home>
        <20180427153826.GK26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 08:38:26 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Fri, Apr 27, 2018 at 10:47:47AM -0400, Steven Rostedt wrote:
> > On Fri, 27 Apr 2018 10:26:29 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> > > The general approach and the implementation look fine, except for
> > > one small detail: I would be tempted to explicitly disable preemption
> > > around the call to the tracepoint callback for the rcuidle variant,
> > > unless we plan to audit every tracer right away to remove any assumption
> > > that preemption is disabled in the callback implementation.  
> > 
> > I'm thinking that we do that audit. There shouldn't be many instances
> > of it. I like the idea that a tracepoint callback gets called with
> > preemption enabled.  
> 
> Are you really sure you want to increase your state space that much?

Why not? The code I have in callbacks already deals with all sorts of
context - normal, softirq, irq, NMI, preemption disabled, irq
disabled.

-- Steve
