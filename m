Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDD2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EE421104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EE421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeK1FZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeK1FZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:25:07 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF59120851;
        Tue, 27 Nov 2018 18:26:19 +0000 (UTC)
Date:   Tue, 27 Nov 2018 13:26:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, stable@kernel.org
Subject: Re: [for-next][PATCH 04/18] arm64: function_graph: Simplify with
 function_graph_entry()
Message-ID: <20181127132618.2b3e1944@gandalf.local.home>
In-Reply-To: <20181127180722.GB19216@arm.com>
References: <20181122002801.501220343@goodmis.org>
        <20181122003331.917870132@goodmis.org>
        <20181127180722.GB19216@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 18:07:23 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Wed, Nov 21, 2018 at 07:28:05PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The function_graph_entry() function does the work of calling the function
> > graph hook function and the management of the shadow stack, simplifying the
> > work done in the architecture dependent prepare_ftrace_return().
> > 
> > Have arm64 use the new code, and remove the shadow stack management as well as
> > having to set up the trace structure.
> > 
> > This is needed to prepare for a fix of a design bug on how the curr_ret_stack
> > is used.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: stable@kernel.org
> > Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/arm64/kernel/ftrace.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)  
> 
> Minor nit: the subject refers to function_graph_entry(), but looks like
> you settled on function_graph_enter() in the end.

Ah you're right!

> 
> Anyway, looks like no change for us, so:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks!

-- Steve
