Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038FEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D742151B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D742151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLFPzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeLFPzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:55:46 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5CAD214C1;
        Thu,  6 Dec 2018 15:55:44 +0000 (UTC)
Date:   Thu, 6 Dec 2018 10:55:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [for-next][PATCH 05/30] arm64: function_graph: Remove use of
 FTRACE_NOTRACE_DEPTH
Message-ID: <20181206105541.0120d556@vmware.local.home>
In-Reply-To: <20181206154931.GA4327@arm.com>
References: <20181205234749.372720574@goodmis.org>
        <20181205234829.164618323@goodmis.org>
        <20181206154931.GA4327@arm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 15:49:32 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Wed, Dec 05, 2018 at 06:47:54PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Functions in the set_graph_notrace no longer subtract FTRACE_NOTRACE_DEPTH
> > from curr_ret_stack, as that is now implemented via the trace_recursion
> > flags. Access to curr_ret_stack no longer needs to worry about checking for
> > this. curr_ret_stack is still initialized to -1, when there's not a shadow
> > stack allocated.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/arm64/kernel/stacktrace.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 4989f7ea1e59..7723dadf25be 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -61,9 +61,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
> >  			(frame->pc == (unsigned long)return_to_handler)) {
> >  		if (WARN_ON_ONCE(frame->graph == -1))
> >  			return -EINVAL;
> > -		if (frame->graph < -1)
> > -			frame->graph += FTRACE_NOTRACE_DEPTH;
> > -  
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 

Thanks Will!

-- Steve
