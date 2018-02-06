Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeBFO2B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbeBFO1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:27:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA55208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Feb 2018 09:27:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [RFC] tracing: Improve design of preemptirq tracepoints and its
 users
Message-ID: <20180206092705.49445560@gandalf.local.home>
In-Reply-To: <CAJWu+ooXZRVUhsc9mSLc2H28EeX=8XyDo6iMPur3DtH=y=rxAA@mail.gmail.com>
References: <20180206023950.64030-1-joelaf@google.com>
        <CAJWu+ooXZRVUhsc9mSLc2H28EeX=8XyDo6iMPur3DtH=y=rxAA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2018 23:15:32 -0800
Joel Fernandes <joelaf@google.com> wrote:

> On Mon, Feb 5, 2018 at 6:39 PM, Joel Fernandes <joelaf@google.com> wrote:
> > This patch detaches the preemptirq tracepoints from the tracers and
> > keeps it separate. With this, several ifdefs are cleaner, and lockdep
> > and other users can use the preemptirq tracepoints by registering probes
> > onto them. This makes it much cleaner, but not just that: PROVE_LOCKING
> > and CONFIG_IRQSOFF_TRACER can be enabled now at the same time and we
> > get rid of all the horrific ifdeferry around PROVE_LOCKING.
> >  
> 
> Sorry for the misstatement, irqsoff tracer and PROVE_LOCKING can still
> be used at the same time (without this patch). I will correct the
> commit message in the next rev. However this patch avoids the
> complication that arises when enabling the 2 together, by eliminating
> time_hardirqs_on/off.
> 

Hi Joel,

This looks nice, but I currently don't have time to look at it. Please
ping me again if you don't hear from me by beginning of next week.

-- Steve
