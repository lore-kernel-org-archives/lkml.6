Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbeEAPHO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:07:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40782 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754798AbeEAPHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:07:13 -0400
X-Google-Smtp-Source: AB8JxZq1P3i629KLPVrUB3gj3BWg5CFuwYuvGom5h/MBqcCQY6VboD0T8OYa6JaoyvYAsjCM+/dsNCDr+hU9lNOs3FQ=
MIME-Version: 1.0
References: <20180501014204.67548-1-joelaf@google.com> <20180501014204.67548-4-joelaf@google.com>
 <20180501100623.7ebec465@gandalf.local.home>
In-Reply-To: <20180501100623.7ebec465@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 01 May 2018 15:07:01 +0000
Message-ID: <CAJWu+oprTcnEhDprzaRmaO3-fyJ8vsdZP+ceNAEg2TqK-ZXwQA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 3/6] srcu: Add notrace variant of srcu_dereference
To: Steven Rostedt <rostedt@goodmis.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 7:06 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Apr 2018 18:42:01 -0700
> Joel Fernandes <joelaf@google.com> wrote:

> > In this series, we are making lockdep use an rcuidle tracepoint. For
> > this reason we need a notrace variant of srcu_dereference since
> > otherwise we get lockdep splats since lockdep hooks may not have run
> > yet. This patch adds the needed variant.

> This change log is rather confusing. Why would lockdep use an rcuidle
> tracepoint? I think we need to explain more here.

Patch 6/6 registers lockdep onto irq_disable and irq_enable tracepoints
which use rcuidle:
https://github.com/torvalds/linux/blob/master/kernel/trace/trace_irqsoff.c#L791

I can add more details to the change log about this.

thanks,

- Joel
