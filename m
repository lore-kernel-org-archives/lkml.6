Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF1DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453E22081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453E22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436737AbeKVXZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:25:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388647AbeKVXZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:25:20 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC63B206B2;
        Thu, 22 Nov 2018 12:46:06 +0000 (UTC)
Date:   Thu, 22 Nov 2018 07:46:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 00/14] function_graph: Rewrite to allow multiple
 users
Message-ID: <20181122074605.063a7525@vmware.local.home>
In-Reply-To: <20181122100812.GO2131@hirez.programming.kicks-ass.net>
References: <20181122012708.491151844@goodmis.org>
        <20181122100812.GO2131@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 11:08:12 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 21, 2018 at 08:27:08PM -0500, Steven Rostedt wrote:
> > Well the fuction graph tracer is arguably the strongest of the tracers.
> > It shows both the entrance and exit of a function, can give the timings
> > of a function, and shows the execution of the code quite nicely.
> > 
> > But it has one major flaw.
> > 
> > It can't let more than one user access it at a time.  
> 
> The reason I 'never' use it is performance, it _sucks_.. I've never ran
> into the multi-user issue.

And performance is also something to fix (it has improved lately, you
probably haven't noticed).

> 
> So while I don't think the rewrite is bad, this argument here is.

Except that we plan on merging kretprobe with function graph tracing.
This also solves the issue that Mark Rutland has with ret protection.
He has a solution for function graph tracing, but not with kretprobes.

And yes, there's also the case of being able to trace to different
buffers where you can have a full function graph tracing enabled and
also trace a subset that you want to have.

Just because you don't need it, doesn't mean it's not needed by others.

-- Steve
