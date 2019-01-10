Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B890AC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9452D214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfAJRMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:12:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbfAJRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:12:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B27020874;
        Thu, 10 Jan 2019 17:12:33 +0000 (UTC)
Date:   Thu, 10 Jan 2019 12:12:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6/9] kprobes: Prohibit probing on hardirq tracers
Message-ID: <20190110121231.446b3396@gandalf.local.home>
In-Reply-To: <154708901305.6325.18088274750877716004.stgit@devbox>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
        <154708901305.6325.18088274750877716004.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 11:56:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since kprobes breakpoint handling involves hardirq tracer,
> probing these functions cause breakpoint recursion problem.
> 
> Prohibit probing on those functions.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_irqsoff.c    |    9 +++++++--
>  kernel/trace/trace_preemptirq.c |    5 +++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 


Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
