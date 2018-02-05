Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbeBEPOl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752919AbeBEPOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:14:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3174D2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Tue, 6 Feb 2018 00:14:28 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-Id: <20180206001428.baf7f16d4a836a17488d7248@kernel.org>
In-Reply-To: <CA+55aFwtCP3Nf86jwNFzdRy_m0GZWH5U2KBDutPDh1ZVATHLYg@mail.gmail.com>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
        <CA+55aFz1=qWvnJ2271SGwuezwQRBA2nZp8_BxFyR-R0VKKgXRw@mail.gmail.com>
        <292744194.15823.1517758204087.JavaMail.zimbra@efficios.com>
        <CA+55aFwtCP3Nf86jwNFzdRy_m0GZWH5U2KBDutPDh1ZVATHLYg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Note that I also agree with Linus's opinion that this is
 like a debugger, since I already did it in perf-probe :))

On Sun, 4 Feb 2018 11:39:39 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> (Obviously it's not entirely black-and-white, but I do think there is
> a pretty big difference between the two groups. And the first group
> will obviously use the explicit trace points _too_, generally to
> narrow down where they want to go with the function-based one).
> 
> We'll see. Maybe I'm entirely wrong. But I'm hoping that the
> function-based one will end up being helpful.

BTW, if the function-based tracing is helpful for both of them,
they can start using it back in 2010 because kprobe-based tracer
already supported it.

It was less announced, I must admit that I was lazy at that point.
Also, since I moved usability effort on perf-probe, kprobe-based
event syntax is not so funcy.

"SyS_openat(int dfd, string path, x32 flags, x16 mode)"

is equal to

"p SyS_openat dfd=%di:x64 path=%si:string flags=%dx:x32 mode=%cx:x16"

in kprobe probe definition syntax, but with perf-probe and CONFIG_DEBUG_INFO,

perf probe -a 'sys_openat $params'

will setup the event correctly.

So, we need to clarify what will attract more "2nd group" people to
function based events. E.g. the events for EXPORT_SYMBOL_GPL() symbols
already defined and easily on/off.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
