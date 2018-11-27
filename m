Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21273C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA63F20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA63F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeK1B1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbeK1B1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:27:33 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BD2208E4;
        Tue, 27 Nov 2018 14:29:27 +0000 (UTC)
Date:   Tue, 27 Nov 2018 09:29:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, trace: Fix prev_state output in sched_switch
 tracepoint
Message-ID: <20181127092925.46c77ae7@gandalf.local.home>
In-Reply-To: <CAEU1=PkZQGEZueS=cLOT9kbGeMBptKRL=A56BrBgG85R9PrHDA@mail.gmail.com>
References: <1540882473-1103-1-git-send-email-pkondeti@codeaurora.org>
        <CAEU1=PkZQGEZueS=cLOT9kbGeMBptKRL=A56BrBgG85R9PrHDA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 15:04:25 +0530
Pavan Kondeti <pkondeti@codeaurora.org> wrote:

> Hi Peter/Thomas,
> 
> On Tue, Oct 30, 2018 at 12:25 PM Pavankumar Kondeti
> <pkondeti@codeaurora.org> wrote:
> >
> > commit 3f5fe9fef5b2 ("sched/debug: Fix task state recording/printout")
> > tried to fix the problem introduced by a previous commit efb40f588b43
> > ("sched/tracing: Fix trace_sched_switch task-state printing"). However
> > the prev_state output in sched_switch is still broken.
> >
> > task_state_index() uses fls() which considers the LSB as 1. Left
> > shifting 1 by this value gives an incorrect mapping to the task state.
> > Fix this by decrementing the value returned by __get_task_state()
> > before shifting.
> >
> > Fixes: 3f5fe9fef5b2 ("sched/debug: Fix task state recording/printout")
> > Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> > ---
> >  include/trace/events/sched.h | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)  
> 
> Can you please review this patch?
> 

I've already tested this patch. I'm working on getting other patches
upstream and this looks like it should be marked for stable. I'll take
it.

Thanks!

-- Steve
