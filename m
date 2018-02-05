Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeBEPHx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753134AbeBEPHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:07:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5E92075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Feb 2018 10:07:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        acme <acme@kernel.org>, Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, bristot <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Namhyung Kim <namhyung@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-ID: <20180205100743.4420c0e6@gandalf.local.home>
In-Reply-To: <20180205135355.GX19535@localhost.localdomain>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
        <20180203140217.2382df69@gandalf.local.home>
        <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
        <20180203161732.4a65c66b@gandalf.local.home>
        <20180205135355.GX19535@localhost.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2018 14:53:55 +0100
Juri Lelli <juri.lelli@redhat.com> wrote:

> First impression is that this is going to be definitely useful if
> 
>  - it's possibile to hook at function end (e.g., replenish_dl_entity above
>    carries more useful information _after_ it did its job)

The one issue is that you will only have access to one argument at the
end. And that will be the return value. How useful would that be?

Hmm, actually, if we incorporate Tom Zanussi's histogram patches (which
I'll start reviewing this week for inclusion), we could add the pseudo
events to carry necessary data.

>  - inside functions? not really sure it's actually going to be needed, but I
>    was wondering if it's possible at all :); with tracepoints it's for example
>    easy to collect detailed information about which branches has been taken etc.

This will not be something to handle anything other than function
calls. You have three options for dealing with inside a function.

 - add another function that can be traced with this, inside the
   function

 - use kprobes

 - add a tracepoint

> 
> I'm going to play with this more. Just wanted to give back a quick positive
> feedback.

Thanks!

> 
> I'm also adding Arm folks to the discussion, as they (and I :) have been
> asking to add tracepoints to scheduler code in the past [1].

You will need to implement the arch_get_func_args() for ARM too.

-- Steve
