Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162000AbeBPRcE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:32:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161052AbeBPRcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:32:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E177217CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Feb 2018 12:31:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>,
        Juergen Gross <jgross@suse.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] jump_label: Warn on failed jump_label patch
Message-ID: <20180216123158.2ab0c159@gandalf.local.home>
In-Reply-To: <20180215223558.poirr2e6wxs2jhzb@treble>
References: <cover.1518626149.git.jpoimboe@redhat.com>
        <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
        <20180214120112.43821b5e@gandalf.local.home>
        <a4ad6f69-8836-779b-f7e7-0e303885c7f5@akamai.com>
        <20180214173407.guhytdurv4pmhzvk@treble>
        <20180214124034.13d7d833@gandalf.local.home>
        <20180214211707.hivwfwemghgy62mh@treble>
        <20180215223558.poirr2e6wxs2jhzb@treble>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018 16:35:58 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:


> > Interesting idea.  The static key's entries (i.e. tracepoint sites) are
> > in a static array.  Maybe we could rewrite the affected arrays when init
> > memory is freed.  I'm not sure whether that would be overkill though.  I
> > can tinker with it and see how it compares to the current solution.  
> 
> It turns out that something like this is already done for module init
> code.  It doesn't *remove* the entry, but it does disable it by setting
> entry->code to zero.  I'll just do the same thing right before initmem
> is freed.

Yes, I was actually going to mention to do it like the module code does.

Thanks!

-- Steve
