Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73914C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D10F21104
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D10F21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeLHRiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:38:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeLHRiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:38:09 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0453B2081C;
        Sat,  8 Dec 2018 17:38:06 +0000 (UTC)
Date:   Sat, 8 Dec 2018 12:38:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181208123805.1c158665@vmware.local.home>
In-Reply-To: <20181208104423.GE5289@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
        <20181205160509.1168-2-jolsa@kernel.org>
        <20181206081028.GE4234@hirez.programming.kicks-ass.net>
        <20181206083400.GA13675@hirez.programming.kicks-ass.net>
        <20181206131946.2c47f556@vmware.local.home>
        <20181207085839.GC2237@hirez.programming.kicks-ass.net>
        <20181207072701.5bc564c7@vmware.local.home>
        <20181207151105.GB5289@hirez.programming.kicks-ass.net>
        <20181207151433.20bf0399@vmware.local.home>
        <20181208104423.GE5289@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2018 11:44:23 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> It's a tool I haven't used in years, given we have so many better tools
> around these days.

So because you don't use it, it's useless? As you don't care about lost
events I can see why you may think there are better tools out there.
But since those tools don't guarantee no lost events, they are
obviously not better to those that do care about lost events.

> 
> > Why do we care about lost events? Because strace records *all* events,
> > as that's what it does and that's what it always has done. It would be
> > a break in functionality (a regression) if it were to start losing
> > events. I use strace to see everything that an application is doing.  
> 
> So make a new tool; break the expectation of all events. See if there's
> anybody that really cares.

Basically you are saying, break strace and see if anyone notices?

> 
> > When we discussed this at plumbers, Oracle people came to me and said
> > how awesome it would be to run strace against their database accesses.
> > The problem today is that strace causes such a large overhead that it
> > isn't feasible to trace any high speed applications, especially if
> > there are time restraints involved.  
> 
> So have them run that perf thing acme pointed to.
> 
> So far nobody's made a good argument for why we cannot have LOST events.

If you don't see the use case, I'm not sure anyone can convince you.
Again, I like the fact that when I do a strace of an application I know
that all system calls that the application I'm tracing is recorded. I
don't need to worry about what happened in the "lost events" space.

-- Steve

