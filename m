Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8300DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420EB20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="baLOoNko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420EB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbeKFHai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:30:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XXm0KMiui1+LCsAFHzk7BMFPErfCxWJJiaZjO1TCefs=; b=baLOoNkoflZFTvq5/B6UI+iV7
        vHvQ3a0Qw+o5qgFHg9ftOzM7b0XDTB1ALxJxGQwdGkTdKUfCdGXf8UMfec5mcuFFiGlOgSYuUJT/Y
        sJWV9IQMkuqoEeTIIkVwzZffZE68/sCkQnrht8azmTFT+WVnsKqS0qCpQ6ZIlyvfv8eVn+ZxamN5O
        b07b4hVZO2VjUMOpDLtz7E0+9ZxURwP/cvUj7OSDaEN9mhM/aEnO87F9zDcKkCk4h+nLsiGDkREqm
        B0YigP5CkU/Vgu7GWMXwsN03/Kq58bO5do4ZzaHUHOaQFw3989vFMKAYzBosM19QSgTxdvNj4ZOUT
        Z/D1WaTIw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJn39-0006eA-KQ; Mon, 05 Nov 2018 22:08:47 +0000
Date:   Mon, 5 Nov 2018 14:08:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rong.a.chen@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [LKP] [xarray] 0e9446c35a:
 WARNING:at_include/linux/xarray.h:#xa_mk_value
Message-ID: <20181105220847.GA16465@bombadil.infradead.org>
References: <20181105070337.GX24195@shao2-debian>
 <CAHk-=wgHY5EdhvPoS458Wu8iUfC9C8UBG8GzEO72=0prT2nVcw@mail.gmail.com>
 <20181105180004.GA4923@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105180004.GA4923@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 10:00:04AM -0800, Matthew Wilcox wrote:
> On Mon, Nov 05, 2018 at 09:57:47AM -0800, Linus Torvalds wrote:
> > Should that part of the test be surrounded by #ifdef CONFIG_64BIT? Or
> > did you _want_ the warnings?
> 
> I should have just made that (1 << 24) instead of UINT_MAX.  I had forgotten
> about 32-bit machines while writing that test.
> 
> That prompted me to actually build the test suite on 32-bit and there's
> a few other things in there that want fixing.  I'll have a pull request
> for you later today.

I've pushed out an update to
http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray

Let's give the automated testers a couple of days to chew on this before
I send you a real pull request?  The last two commits are today's work
while the other commits have been stewing in the xarray-conv branch for
the last 2-3 weeks while I've been busily converting all the radix trees
and some of the IDRs to the XArray.

They say no battle plan survives contact with the enemy ... no API
survives contact with its users.
