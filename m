Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbeBDDuX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 22:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbeBDDuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 22:50:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2601F21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sun, 4 Feb 2018 12:50:12 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 13/18] tracing: Add array type to function based events
Message-Id: <20180204125012.562129292eaa1843184c4997@kernel.org>
In-Reply-To: <20180203102903.070ae30a@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.977452228@goodmis.org>
        <20180203225615.6e1a21982335405dad13b99b@kernel.org>
        <20180203102903.070ae30a@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2018 10:29:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 3 Feb 2018 22:56:15 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > This idea looks good for kprobe events too.
> > I'll try to implement same one :)
> 
> We should have the two re-use the same code.
> 
> In other words, I would like as much code sharing as possible.

Finally it will be, but currently the code base is too far.
I would like to implement it on current code for avoiding
break anything, but refactoring afterwards.

I think current fetch function implementation may be too heavy
with retpoline. I would like to reimplement it with eBPF :)

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
