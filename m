Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39864C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9FA25705
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n1swV0yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9FA25705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeFYJu5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:50:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47390 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754866AbeFYJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WwlG8w8T3e9RqPUhmyd4u81FqB0MnXxew8C2ERjsbQk=; b=n1swV0yufzmnZJQeiiOW4xJOg
        KGMG9Qo1xtoCyI9He8M0fmD52eiWkDF7+pd/7ZLAqZjixrmzbLnyEuo2mYI9A8g5/Lc+Q3xQB8Slc
        BILkxQJwZP8hnz4+UeBYzZW5c0YSmmGh++N8W1L4g+kN19hYbH8r+AwiOxDoje5I273sm8QVaVIOh
        B90nK4Pq5YRCBoRvf/sLYiPPtHi9xbOHsHJ792fLXVR4RtESoZFxaaibXoYSrdNvZJLdrRRkqLxJt
        8kXMmR27tQEL09pE0pbsjseK6LGuJIxwCX3jfVoQG4ZJxDMpzv9ozg7V3Yaohh6LFNF/VaCl6B63Y
        WnFre+khg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXO8n-0006uS-1q; Mon, 25 Jun 2018 09:50:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86A922029F1D7; Mon, 25 Jun 2018 11:50:31 +0200 (CEST)
Date:   Mon, 25 Jun 2018 11:50:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Message-ID: <20180625095031.GX2494@hirez.programming.kicks-ass.net>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:17:38AM +0200, Andrea Parri wrote:
> Both the implementation and the users' expectation [1] for the various
> wakeup primitives have evolved over time, but the documentation has not
> kept up with these changes: brings it into 2018.

I wanted to reply to this saying that I'm not aware of anything relying
on this actually being a smp_mb() and that I've been treating it as an
RELEASE.

But then I found my own comment that goes with smp_mb__after_spinlock(),
which explains why we do in fact need the transitive thing if I'm not
mistaken.

So yes, I suppose we're entirely suck with the full memory barrier
semantics like that. But I still find it easier to think of it like a
RELEASE that pairs with the ACQUIRE of waking up, such that the task
is guaranteed to observe it's own wake condition.

And maybe that is the thing I'm missing here. These comments only state
that it does in fact imply a full memory barrier, but do not explain
why, should it?
