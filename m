Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABCBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0EE20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0EE20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeH2AmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbeH2AmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:42:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699412087D;
        Tue, 28 Aug 2018 20:48:43 +0000 (UTC)
Date:   Tue, 28 Aug 2018 16:48:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: Re: [PATCH] locking/lockdep: Delete unnecesary #include
Message-ID: <20180828164841.27556dbe@gandalf.local.home>
In-Reply-To: <20180828203315.GD18030@decadent.org.uk>
References: <20180828203315.GD18030@decadent.org.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 21:33:15 +0100
Ben Hutchings <ben@decadent.org.uk> wrote:

> Commit c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and u
> nify their usage") added the inclusion of <trace/events/preemptirq.h>.
> liblockdep doesn't have a stub version of that header so now fails to
> build.
> 
> However, commit bff1b208a5d1 ("tracing: Partial revert of "tracing:
> Centralize preemptirq tracepoints and unify their usage"") removed the
> use of functions declared in that header.  So delete the #include.
> 
> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints ...")
> Fixes: bff1b208a5d1 ("tracing: Partial revert of "tracing: Centralize ...")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Peter, you want to take this to Ingo?

-- Steve

> ---
>  kernel/locking/lockdep.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e406c5fdb41e..dd13f865ad40 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -55,7 +55,6 @@
>  
>  #include "lockdep_internals.h"
>  
> -#include <trace/events/preemptirq.h>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/lock.h>
>  

