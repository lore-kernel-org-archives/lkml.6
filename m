Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932935AbeD0QWG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932802AbeD0QWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:22:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B8D218C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 27 Apr 2018 12:22:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks
 executing with preempt on
Message-ID: <20180427122201.75abc313@gandalf.local.home>
In-Reply-To: <CAJWu+or9GJwkDK9+842YbobG3=xVW-PgqS=uE5P2xFbDhmqxEQ@mail.gmail.com>
References: <20180427042656.190746-1-joelaf@google.com>
        <20180427155701.GL26088@linux.vnet.ibm.com>
        <CAJWu+or9GJwkDK9+842YbobG3=xVW-PgqS=uE5P2xFbDhmqxEQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 09:14:30 -0700
Joel Fernandes <joelaf@google.com> wrote:

> > Hmmm...  Do I need to create a _notrace variant of srcu_read_lock()
> > and srcu_read_unlock()?  
> 
> That shouldn't be needed. For the rcu_read_lock_sched case, there is a
> preempt_disable which needs to be a notrace, but for the srcu one,
> since we don't do that, I think it should be fine.

Actually, I think I may agree here too. Because the _notrace is for
function tracing, and it shouldn't affect it. If people don't want it
traced, they could add those functions to the list in the notrace file.

-- Steve
