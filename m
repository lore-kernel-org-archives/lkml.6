Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7456EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7A420830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UEL+CqBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7A420830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeKGF0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:26:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42940 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeKGF0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JH84b8nHxqkSb49O2caRfdND4835aQY3QFfUxC2wx/Y=; b=UEL+CqBr76N6WjxUuOouUIl7I
        WvNp7MQ+Yjyy5XArMGtGxHf8YMwLylws9NraJLhgeTjXwjZPVzvoeVCOfgXbLcvcF+4UL+Jh2lpEQ
        Q5SF2Vq2uL1IQkatOEUA7xOaL1nedgKyJm58+59zGye69wTkjmYkxr39xZM+Ej23zi9p72XUIpTdo
        mG/bNhOt05nUvciLg9zEp+fGxcAeWt/Fy8EVq+dABWjAkjstAK5o11UDCy6456xxjcVvgZ2HNagqi
        7g3lc6sXzqxZi8BbKplfnbj7efv1ixylmmvHXYkCvl9EhOxsmDIg1QWefWxjeGFQkfKJwpKRchKRb
        06khSVYbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK7VR-0001qJ-RX; Tue, 06 Nov 2018 19:59:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C5982029F881; Tue,  6 Nov 2018 20:59:20 +0100 (CET)
Date:   Tue, 6 Nov 2018 20:59:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        bp@alien8.de, namit@vmware.com, joe@perches.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        segher@kernel.crashing.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH] tree-wide: Remove __inline__ and __inline usage
Message-ID: <20181106195920.GE9781@hirez.programming.kicks-ass.net>
References: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
 <CAHk-=wjFL-4p-4FrJbtKADXRaBPK_Pi_-BSSqm_j784Mq6aHjQ@mail.gmail.com>
 <20181106194149.GC9761@hirez.programming.kicks-ass.net>
 <CAHk-=wgTKDiDiQzoH=-ho1bn_SqvxHg+SEy1tQ_dSqqJJB5Rcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTKDiDiQzoH=-ho1bn_SqvxHg+SEy1tQ_dSqqJJB5Rcw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 11:51:35AM -0800, Linus Torvalds wrote:
> On Tue, Nov 6, 2018 at 11:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Do you want me to do that patch, or have you already just done it?
> 
> I'd rather see it go through something like -tip than doing it myself
> directly, and get at least some of the automated testing before
> unleashing it on an unsuspecting world.
> 
> I don't think it will affect much, but there *could* be situations
> where there are some crusty __inline__ users that actually want
> __always_inline behavior.
> 
> And we *may* actually have cases where we want the "let compiler make
> a judgement call" behavior, so with this change people will have that
> as an option. But yes, in the short term, it has the possibility of
> regressions due to missed inlining.

Fair enough; I'll do the patch and let it soak a bit in tip.

Thanks!
