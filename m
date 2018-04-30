Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeD3WAQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 18:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751265AbeD3WAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 18:00:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553FA22576
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 30 Apr 2018 18:00:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH] softirq: reorder trace_softirqs_on to prevent lockdep
 splat
Message-ID: <20180430180011.2ded931c@gandalf.local.home>
In-Reply-To: <CAJWu+ookMimv4rgSyjgzKyd8Cr0MgJHFFj8XftawZ7GRr4vOvg@mail.gmail.com>
References: <20180427041100.133772-1-joelaf@google.com>
        <20180430123813.3b8315d8@gandalf.local.home>
        <CAJWu+ooY-BXFQO+TK526pZpE6gsGRZdHq6i7yM7LSmgXi4552g@mail.gmail.com>
        <CAJWu+ookMimv4rgSyjgzKyd8Cr0MgJHFFj8XftawZ7GRr4vOvg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018 17:01:04 +0000
Joel Fernandes <joelaf@google.com> wrote:
Tried 4.17-rc3 and see it too. Could be difference in configs? Also, the
> environment is a Qemu system with single CPU 1GB memory. Attached is the
> config.
> 
> I think when I had multiple CPUs it was harder to trigger it, but can't
> really remember now. There was a time when triggering it was quite
> intermittent.
>

Bah, I didn't have CONFIG_DEBUG_LOCKDEP enabled, and that is what does
the backtrace.

-- Steve
