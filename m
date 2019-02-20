Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8BEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93742089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uOFoFF1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBTJnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:43:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40998 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfBTJnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xVaQVBmN5RK/avp2ECXjZHgBwBLk1QHGNLRfuNiYHN0=; b=uOFoFF1+9rqmK8DHs5ILUh1Au
        I3BIthDQa/B9LHgwtilsu2ZrxpJbfFhCneAC3vDRM9Wx1VGUqRDLkf/E2tf6EW6SWoP5GSYNQ0PVo
        /dm9Z9p7kxinWfeI9LLsd7GppShXnRpun0nD6X1Diy19i/5kpilUg/83vQli9pOPH6MfAofK3cXz/
        uAgo9gCCGERSp4rlD7qs3vt1QGFXb3EhqcqZaoAFUIk6OdAnvU1qPUx9jgsQqAml8Z7Al9KUBy86z
        N0RrHbYmXOj59k7cm8HONQzLIBKs3Why0G7OXo1y/IgZhUGmAscovuX+YuICW34fWyyFuW1Yoyt6F
        UuIC5noog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwOP4-0005Na-CD; Wed, 20 Feb 2019 09:42:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0284D28B675A1; Wed, 20 Feb 2019 10:42:55 +0100 (CET)
Date:   Wed, 20 Feb 2019 10:42:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg Kerr <kerrnel@google.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, Paul Turner <pjt@google.com>,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190220094255.GE32494@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <CAJGSLMt_X97Ux=1YiZcXWXvBy4n=ExO=2yAJhfbvxDh+wnWPvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJGSLMt_X97Ux=1YiZcXWXvBy4n=ExO=2yAJhfbvxDh+wnWPvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Tue, Feb 19, 2019 at 02:07:01PM -0800, Greg Kerr wrote:
> Thanks for posting this patchset Peter. Based on the patch titled, "sched: A
> quick and dirty cgroup tagging interface," I believe cgroups are used to
> define co-scheduling groups in this implementation.
> 
> Chrome OS engineers (kerrnel@google.com, mpdenton@google.com, and
> palmer@google.com) are considering an interface that is usable by unprivileged
> userspace apps. cgroups are a global resource that require privileged access.
> Have you considered an interface that is akin to namespaces? Consider the
> following strawperson API proposal (I understand prctl() is generally
> used for process
> specific actions, so we aren't married to using prctl()):

I don't think we're anywhere near the point where I care about
interfaces with this stuff.

Interfaces are a trivial but tedious matter once the rest works to
satisfaction.

As it happens; there is actually a bug in that very cgroup patch that
can cause undesired scheduling. Try spotting and fixing that.

Another question is if we want to be L1TF complete (and how strict) or
not, and if so, build the missing pieces (for instance we currently
don't kick siblings on IRQ/trap/exception entry -- and yes that's nasty
and horrible code and missing for that reason).

So first; does this provide what we need? If that's sorted we can
bike-shed on uapi/abi.
