Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeEPOKE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752567AbeEPOKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:10:02 -0400
Date: Wed, 16 May 2018 10:09:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH v2 14/14] tracing/selftest: Add test to test hist
 trigger between kernel event and trace_marker
Message-ID: <20180516100959.677fed4b@gandalf.local.home>
In-Reply-To: <20180516091153.GC30309@danjae.aot.lge.com>
References: <20180514205845.017925650@goodmis.org>
        <20180514205959.393826165@goodmis.org>
        <20180516091153.GC30309@danjae.aot.lge.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 18:11:53 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

 
> > +echo "Test histogram kernel event to trace_marker latency histogram trigger"
> > +
> > +echo 'latency u64 lat' > synthetic_events
> > +echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
> > +echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat)' > events/ftrace/print/trigger  
> 
> Shouldn't it be "onmatch(sched.sched_waking)" ?

Ug, yes! Cut-and-paste fail :-p

I tested this my hand and did it correctly, but instead of
cut-and-pasting the command line, I cut and pasted the other test and
updated it.

Thanks for reviewing Namhyung!

-- Steve
