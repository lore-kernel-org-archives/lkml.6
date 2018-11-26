Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57812C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C3F208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C3F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeK0IB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbeK0IB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:01:28 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA052208E4;
        Mon, 26 Nov 2018 21:06:03 +0000 (UTC)
Date:   Mon, 26 Nov 2018 16:06:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 07/14] fgraph: Add new fgraph_ops structure to
 enable function graph hooks
Message-ID: <20181126160602.1b5605df@gandalf.local.home>
In-Reply-To: <20181126203049.88df7c2cafed2b30a9d02bb9@kernel.org>
References: <20181122012708.491151844@goodmis.org>
        <20181122012803.576692300@goodmis.org>
        <20181126203049.88df7c2cafed2b30a9d02bb9@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 20:30:49 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index f98063e273e5..477ff9412d26 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -749,6 +749,18 @@ typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *); /* entry */
> >  
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >  
> > +struct fgraph_ops {
> > +	trace_func_graph_ent_t		entryfunc;
> > +	trace_func_graph_ret_t		retfunc;  
> 
> > +	struct fgraph_ops __rcu		*next;
> > +	unsigned long			flags;
> > +	void				*private;
> > +#ifdef CONFIG_DYNAMIC_FTRACE
> > +	struct ftrace_ops_hash		local_hash;
> > +	struct ftrace_ops_hash		*func_hash;
> > +#endif  
> 
> Hmm, can we introduce these fields when we actually use it?

Sure.

> 
> BTW, would you have any idea for using private field?

I believe I answered this in another email.

-- Steve

