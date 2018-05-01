Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755720AbeEAPEI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755230AbeEAPEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:04:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A7D236F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 1 May 2018 11:04:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
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
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH RFC v5 3/6] srcu: Add notrace variant of
 srcu_dereference
Message-ID: <20180501110403.0b661039@gandalf.local.home>
In-Reply-To: <20180501141817.GE26088@linux.vnet.ibm.com>
References: <20180501014204.67548-1-joelaf@google.com>
        <20180501014204.67548-4-joelaf@google.com>
        <20180501141817.GE26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2018 07:18:17 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:


> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 2ec618979b20..a1c4947be877 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -135,6 +135,11 @@ static inline int srcu_read_lock_held(const struct srcu_struct *sp)
> >   */
> >  #define srcu_dereference(p, sp) srcu_dereference_check((p), (sp), 0)
> > 
> > +/**
> > + * srcu_dereference_notrace - no tracing and no lockdep calls from here
> > + */
> > +#define srcu_dereference_notrace(p, sp) srcu_dereference_check((p), (sp), 1)  
> 
> Given that this is a one-liner, why not just use srcu_dereference_check()
> directly, with 1 as you do above to disable lockdep?

I prefer what Joel did. It documents why we are doing this. Open coding
the call directly will just confuse others that touch tracepoint code.

-- Steve
