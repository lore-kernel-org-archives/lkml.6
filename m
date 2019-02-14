Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3FFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16992229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pzNAgZMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406525AbfBNKbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:31:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbfBNKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cz5E1STMYTb9r24YsxFX2EIKYAjHOnBW1E39BRqOjIc=; b=pzNAgZMFQqf2rpZPA5AoHx2wY
        I21zX13gc0L3xvMCwenDvp1FgHFvAtk/Ttv98OAd9sHz/j7MHWTmbWD1IRuoL3gm9WurbolV5cejZ
        H6FRzhsPlyGQcAxHRF7dhdPR6BK09cMKIvoAl7ZbpE8qdulZxIzWDjfuSrrP7SCt17JALDEwo2sx9
        vWoPBotEx9kAkYwutGqIuhxdOhtCKt2EY8p0IUKOuHiwPOBPtR1cijqdsY3iCmyAUwPbpnDPjLEXd
        gsgQHqF38bx5/cllVgVz6gKkdPDqy64vEJdqkrdG4af5a0WnT+G9t0xZxo3R8iuDrrrhb7ym39vb9
        vciRDYdmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guEIw-0004W5-8o; Thu, 14 Feb 2019 10:31:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A63A820298375; Thu, 14 Feb 2019 11:31:40 +0100 (CET)
Date:   Thu, 14 Feb 2019 11:31:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Message-ID: <20190214103140.GG32494@hirez.programming.kicks-ass.net>
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
 <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
 <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
 <20190213125651.GP32494@hirez.programming.kicks-ass.net>
 <e6138aeb-9ce4-fbfa-4d6a-b76f189a3e47@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6138aeb-9ce4-fbfa-4d6a-b76f189a3e47@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 03:23:36PM -0800, Vineet Gupta wrote:
> On 2/13/19 4:56 AM, Peter Zijlstra wrote:
> >
> > Personally I think u64 and company should already force natural
> > alignment; but alas.
> 
> But there is an ISA/ABI angle here too. e.g. On 32-bit ARC, LDD (load double) is
> allowed to take a 32-bit aligned address to load a register pair. Thus all u64
> need not be 64-bit aligned (unless attribute aligned 8 etc) hence the relaxation
> in ABI (alignment of long long is 4). You could certainly argue that we end up
> undoing some of it anyways by defining things like ARCH_KMALLOC_MINALIGN to 8, but
> still...

So what happens if the data is then split across two cachelines; will a
STD vs LDD still be single-copy-atomic? I don't _think_ we rely on that
for > sizeof(unsigned long), with the obvious exception of atomic64_t,
but yuck...

So even though it is allowed by the chip; does it really make sense to
use this?
