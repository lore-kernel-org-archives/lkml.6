Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbeBEPKY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752991AbeBEPKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:10:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71712075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Feb 2018 10:10:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        acme <acme@kernel.org>, Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, bristot <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-ID: <20180205101011.720f9493@gandalf.local.home>
In-Reply-To: <20180205100930.GH2249@hirez.programming.kicks-ass.net>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
        <CA+55aFz1=qWvnJ2271SGwuezwQRBA2nZp8_BxFyR-R0VKKgXRw@mail.gmail.com>
        <292744194.15823.1517758204087.JavaMail.zimbra@efficios.com>
        <CA+55aFwtCP3Nf86jwNFzdRy_m0GZWH5U2KBDutPDh1ZVATHLYg@mail.gmail.com>
        <20180205100930.GH2249@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2018 11:09:31 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> As a run-around, Steve then suggested to decouple the trace-hook from
> the actual trace-event. Let the scheduler only provide the hook, nothing
> else. And then allow users to create their own events with the specific
> data they need for their specific use-case.

Actually, we can make the raw tracepoint callback no longer 'notrace',
and then we can extend all tracepoints as well with this.

One issue I hit was the structure randomization for security. If the
structures are randomized, it becomes much more difficult to find
specific aspects of task_struct.

-- Steve
