Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBDPuW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 10:50:22 -0500
Received: from mail.efficios.com ([167.114.142.141]:42934 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBDPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 10:50:13 -0500
Date: Sun, 4 Feb 2018 15:50:54 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Namhyung Kim <namhyung@kernel.org>
Message-ID: <960669116.15855.1517759454413.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180203160824.42a6c1bb@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org> <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com> <20180203140217.2382df69@gandalf.local.home> <20180203205207.mpob4w6eyehhg2ky@ast-mbp> <20180203160824.42a6c1bb@gandalf.local.home>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: Dynamically created function based events
Thread-Index: CxRfnXv6N2oBXWNgTL4Zpq6LsSC2Ag==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 3, 2018, at 4:08 PM, rostedt rostedt@goodmis.org wrote:

> On Sat, 3 Feb 2018 12:52:08 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
>> On Sat, Feb 03, 2018 at 02:02:17PM -0500, Steven Rostedt wrote:
>> > 
>> > From those that were asking about having "trace markers" (ie.
>> > Facebook), they told us they can cope with kernel changes.
>> 
>> There is some misunderstanding here.
>> We never asked for this interface.
> 
> But you wanted trace markers? Just to confirm.
> 
>> We're perfectly fine with existing kprobe/tracepoint+bpf.
> 
> OK, so no new development in this was wanted? So the entire talk about
> getting tracepoints into vfs and scheduling wasn't needed?

I did presentations in the past months about the need to add some
tracepoints into scheduling and IPI code on x86.

Instrumentation of IPI is needed not only by kernel developers, but also
by tools targeting sysadmins/app developers to help them figure out where
the time is spent when they are hitting unexpected long latencies in their
system. We can indeed start by using function instrumentation to show the
usefulness of this instrumentation, but I expect that we'll end up adding
a tracepoint there eventually.

Tracepoints in scheduling also falls in the category of letting sysadmins
and app developers understand where time is spent on their system. When
they hit an unexpected long latency, they want to understand what is
wrong in their task priority and scheduling policy that led to this delay.
The data extracted from the scheduler today is not sufficient to achieve
this. So this is another case where we might see kernel developers using
function instrumentation initially, but we'll probably end up adding and/or
changing tracepoints to help users out there who need tools analyzing this
scheduling data.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
