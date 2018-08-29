Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD16CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7026D20862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7026D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeH2Rq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbeH2Rq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:46:56 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8711D20659;
        Wed, 29 Aug 2018 13:49:53 +0000 (UTC)
Date:   Wed, 29 Aug 2018 09:49:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: Re: [PATCH] locking/lockdep: Delete unnecesary #include
Message-ID: <20180829094951.2d88cb75@gandalf.local.home>
In-Reply-To: <20180829093121.GQ24124@hirez.programming.kicks-ass.net>
References: <20180828203315.GD18030@decadent.org.uk>
        <20180829093121.GQ24124@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 11:31:21 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Aug 28, 2018 at 09:33:15PM +0100, Ben Hutchings wrote:
> > Commit c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and u
> > nify their usage") added the inclusion of <trace/events/preemptirq.h>.
> > liblockdep doesn't have a stub version of that header so now fails to
> > build.
> > 
> > However, commit bff1b208a5d1 ("tracing: Partial revert of "tracing:
> > Centralize preemptirq tracepoints and unify their usage"") removed the
> > use of functions declared in that header.  So delete the #include.
> > 
> > Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints ...")
> > Fixes: bff1b208a5d1 ("tracing: Partial revert of "tracing: Centralize ...")  
> 
> There's no actual breakage because of this extra include, is there?

I believe the user tool in tools/lib/lockdep fails because of it.
Although, I just tried building it myself, and it fails because of
nmi.h header file.

-- Steve
