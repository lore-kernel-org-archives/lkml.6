Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758765AbeD0QJG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758276AbeD0QJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:09:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6562F2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 27 Apr 2018 12:08:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks
 executing with preempt on
Message-ID: <20180427120858.1357f1e0@gandalf.local.home>
In-Reply-To: <1953337577.5844.1524843821731.JavaMail.zimbra@efficios.com>
References: <20180427042656.190746-1-joelaf@google.com>
        <1169911546.5820.1524839189395.JavaMail.zimbra@efficios.com>
        <20180427104747.2d965925@gandalf.local.home>
        <20180427153826.GK26088@linux.vnet.ibm.com>
        <20180427114005.31d1e8ab@gandalf.local.home>
        <1953337577.5844.1524843821731.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 11:43:41 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> It does so by disabling preemption in the callbacks, even when it's
> redundant with the guarantees already provided by tracepoint-sched-rcu
> and by kprobes. It's not that great for a fast-path.

Really, preempt_disable() is not bad for a fast path. It's far better
than a local_irq_disable().

-- Steve
