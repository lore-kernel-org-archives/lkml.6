Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C1BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A012A25560
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fKFU9Tuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A012A25560
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755201AbeFYQio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:38:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeFYQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=00lWR76EPRxqdazQnRbTEd2SjXK+alBJSlw2sX7RI8U=; b=fKFU9TuyPIr+Urmvgffe0+fSn
        ufXIqFKUvlM8Kf19g4tuwyCk0u5k7p8jHuuAGfiqGlFOfytRAFYFqB3mn+vkzpw7m3r7+Wn30XxHM
        rEyIB06c9AfsrS7soui99cH8XoNxqSztPKOqVPvgujMcCma5J1lk7ziIevj+87t+fOkAmOICGZxiw
        KHlcB70ORs7d3Vh5VnkNyDp4K9acczfpsj0YmU2No5S2+P2GmqzVkgb6fewfwBdnvX0xSVM3GFbiw
        csrjp+n14rzzLezqbzYCrUCJzdhl+U8QwiNsLh2xCrrFA1XaKLLidW7y0mdtSleQmlDR62WpxzJmQ
        1eoWRxbyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXUVa-00049I-D0; Mon, 25 Jun 2018 16:38:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 955872029FA0A; Mon, 25 Jun 2018 18:38:28 +0200 (CEST)
Date:   Mon, 25 Jun 2018 18:38:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lustig <dlustig@nvidia.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Message-ID: <20180625163828.GV2458@hirez.programming.kicks-ass.net>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <20180625105618.GA12676@andrea>
 <20180625123121.GY2494@hirez.programming.kicks-ass.net>
 <20180625131643.GA15126@andrea>
 <20180625141830.GC2494@hirez.programming.kicks-ass.net>
 <20180625145611.GA16333@andrea>
 <bad7783b-9510-0049-b10a-a0d7f7273b57@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad7783b-9510-0049-b10a-a0d7f7273b57@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 08:44:14AM -0700, Daniel Lustig wrote:
> RISC-V is (other-)multi-copy-atomic, so I don't think transitivity
> should be an issue here.

Ah, ok.

> We do have a "fence w,r", but we decided to warn against actually using
> it for a few reasons: 1) lack of known common use cases :), 2) IIRC
> there was some corner case discrepancy between the axiomatic and
> operational models if we allowed it, and 3) in practice, it's already
> both expensive enough and obscure enough that many or most
> implementations will simply just treat it as "fence rw,rw" anyway.

Because the majority of the cost is flushing the store-buffer in either
case?

> So, in theory, "fence w,r" should be enough to prevent SB-like patterns.
> It's just not yet clear that it's a big enough win that it's worth
> creating a new fence macro for it, or pulling the current RISC-V
> recommendation against its use.  What do you all think?

It was mostly a theoretical argument for why smp_mb() is too strong, not
a real practical desire to have w,t.
