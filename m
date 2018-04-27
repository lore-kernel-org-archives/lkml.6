Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758455AbeD0Pno (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:43:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:57438 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeD0Pnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:43:42 -0400
Date: Fri, 27 Apr 2018 11:43:41 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
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
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@android.com>
Message-ID: <1953337577.5844.1524843821731.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180427114005.31d1e8ab@gandalf.local.home>
References: <20180427042656.190746-1-joelaf@google.com> <1169911546.5820.1524839189395.JavaMail.zimbra@efficios.com> <20180427104747.2d965925@gandalf.local.home> <20180427153826.GK26088@linux.vnet.ibm.com> <20180427114005.31d1e8ab@gandalf.local.home>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks
 executing with preempt on
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: tracepoint: Introduce tracepoint callbacks executing with preempt on
Thread-Index: uGfmIaQW6AeHRGCAYeYIDe7deQIzzQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 27, 2018, at 11:40 AM, rostedt rostedt@goodmis.org wrote:

> On Fri, 27 Apr 2018 08:38:26 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
>> On Fri, Apr 27, 2018 at 10:47:47AM -0400, Steven Rostedt wrote:
>> > On Fri, 27 Apr 2018 10:26:29 -0400 (EDT)
>> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> >   
>> > > The general approach and the implementation look fine, except for
>> > > one small detail: I would be tempted to explicitly disable preemption
>> > > around the call to the tracepoint callback for the rcuidle variant,
>> > > unless we plan to audit every tracer right away to remove any assumption
>> > > that preemption is disabled in the callback implementation.
>> > 
>> > I'm thinking that we do that audit. There shouldn't be many instances
>> > of it. I like the idea that a tracepoint callback gets called with
>> > preemption enabled.
>> 
>> Are you really sure you want to increase your state space that much?
> 
> Why not? The code I have in callbacks already deals with all sorts of
> context - normal, softirq, irq, NMI, preemption disabled, irq
> disabled.

It does so by disabling preemption in the callbacks, even when it's
redundant with the guarantees already provided by tracepoint-sched-rcu
and by kprobes. It's not that great for a fast-path.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
