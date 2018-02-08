Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBHPxb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeBHPx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:53:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE6F2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 10:53:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 01/20 v2] tracing: Add function based events
Message-ID: <20180208105323.6263b2dd@gandalf.local.home>
In-Reply-To: <20180208112014.GA30958@krava>
References: <20180207202402.253089656@goodmis.org>
        <20180207202814.738058149@goodmis.org>
        <20180208112014.GA30958@krava>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 12:20:14 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Wed, Feb 07, 2018 at 03:24:03PM -0500, Steven Rostedt wrote:
> 
> SNIP
> 
> > +
> > +void create_function_event_file(struct dentry *d_tracer)
> > +{
> > +	struct dentry *d;
> > +
> > +	d = trace_create_file("function_events", 0644, d_tracer, NULL,
> > +			      &func_event_fops);
> > +	WARN(!d, "Failed to create function_events file");
> > +}  
> 
> this fucntion seems like leftover.. can't see any code using it
> 

You are right. My original version had it created via instance, but
then I realized that the events are for all instances. I'll nuke this.

Thanks!

-- Steve
