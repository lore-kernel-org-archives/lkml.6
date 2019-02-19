Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B179AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB1C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LvxBkHBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfBSQW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:22:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfBSQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FzNVHaVkFZnlRR3HZD34gSujam0izDjA7KATZLPFKLk=; b=LvxBkHBVqTAPmCCjJlJWekK0Z
        xbEQG8pLxE2I/kImdnFUGNxcIfBorSEziBBWKKgIpLx529kxSBIwZUjy9+1A/kBEQK62P+lscCxum
        wp9ZaLUxQ8I5jjEInn8oz4aWsYfw9Tabe6N/2TG9XmiZch2QOX+8IBu0uj7CCI+9R++wgetaAQqdd
        ofdGuz8nEZtWovRH7WMpjd5SkALDBYytgOsdKU/HAdtSRea1A+joBDbEOoofyIkczxFakabIOqjSg
        ldS5d7HHEm6McWiUTDd+aNr0TQHnWhckwhUjr0mmVvZleyMqfvJm5hnAQ0781Ao7LgAF0vCdQGJUa
        C3R+n+QLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw8AW-0002Q2-5G; Tue, 19 Feb 2019 16:22:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CCD9202BC403; Tue, 19 Feb 2019 17:22:50 +0100 (CET)
Date:   Tue, 19 Feb 2019 17:22:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Message-ID: <20190219162250.GC32494@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.064516553@infradead.org>
 <20190219161343.GA10816@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219161343.GA10816@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:13:43AM -0500, Phil Auld wrote:
> On Mon, Feb 18, 2019 at 05:56:23PM +0100 Peter Zijlstra wrote:
> > In preparation of playing games with rq->lock, abstract the thing
> > using an accessor.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Hi Peter,
> 
> Sorry... what tree are these for?  They don't apply to mainline. 
> Some branch on tip, I guess?

tip/master I think; any rejects should be trivial tough.
