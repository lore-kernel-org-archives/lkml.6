Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5E020838
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D6r1YdPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395560AbfBNLIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:08:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfBNLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aWIZyZMmST8ebU3DT/Rlvq66ym1KIAlYo0p9mg3XXYw=; b=D6r1YdPqaEGX911CeKiPT8/19
        aQHGgLTVFVNO0YU0yKheAnibjZMfiz6wI3YcxORYYn0qBjVKEP16VsTLeVZCAE/gShrgT9ymIESiw
        Pl5cXj6FNHnORqmPh/xvQtNSsUjOQea/fBuVvOYcyC36dMQucrzp4udjlmOC49vTOY1SIrw1m74Gq
        31dNWiV0Ra5pCoDgVSLvnjHLmvav03tBKhXgf63LV9w52FNa/tN/1oxB29fqC/xbFDvcLvDKzJZA2
        SDD8TsIlE+O9CU6SUw57SLYbBry7llFxRxil/kaT2+4WURnk5NCKHJrO/vpQK2z7DOL/42gU/lSs3
        cIze0QVqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guEsJ-0008HC-Ho; Thu, 14 Feb 2019 11:08:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0AD620298565; Thu, 14 Feb 2019 12:08:13 +0100 (CET)
Date:   Thu, 14 Feb 2019 12:08:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Message-ID: <20190214110813.GK32494@hirez.programming.kicks-ass.net>
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
 <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
 <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
 <20190213125651.GP32494@hirez.programming.kicks-ass.net>
 <e6138aeb-9ce4-fbfa-4d6a-b76f189a3e47@synopsys.com>
 <20190214103140.GG32494@hirez.programming.kicks-ass.net>
 <4881796E12491D4BB15146FE0209CE64681DB122@DE02WEMBXB.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4881796E12491D4BB15146FE0209CE64681DB122@DE02WEMBXB.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:44:49AM +0000, Alexey Brodkin wrote:
> > On Wed, Feb 13, 2019 at 03:23:36PM -0800, Vineet Gupta wrote:
> > > On 2/13/19 4:56 AM, Peter Zijlstra wrote:
> > > >
> > > > Personally I think u64 and company should already force natural
> > > > alignment; but alas.
> > >
> > > But there is an ISA/ABI angle here too. e.g. On 32-bit ARC, LDD (load double) is
> > > allowed to take a 32-bit aligned address to load a register pair. Thus all u64
> > > need not be 64-bit aligned (unless attribute aligned 8 etc) hence the relaxation
> > > in ABI (alignment of long long is 4). You could certainly argue that we end up
> > > undoing some of it anyways by defining things like ARCH_KMALLOC_MINALIGN to 8, but
> > > still...
> > 
> > So what happens if the data is then split across two cachelines; will a
> > STD vs LDD still be single-copy-atomic? I don't _think_ we rely on that
> > for > sizeof(unsigned long), with the obvious exception of atomic64_t,
> > but yuck...
> 
> STD & LDD are simple store/load instructions so there's no problem for
> their 64-bit data to be from 2 subsequent cache lines as well as 2 pages
> (if we're that unlucky). Or you mean something else?

u64 x;

WRITE_ONCE(x, 0x1111111100000000);
WRITE_ONCE(x, 0x0000000011111111);

vs

t = READ_ONCE(x);

is t allowed to be 0x1111111111111111 ?

If the data is split between two cachelines, the hardware must do
something very funny to avoid that.

single-copy-atomicity requires that to never happen; IOW no load or
store tearing. You must observe 'whole' values, no mixing.

Linux requires READ_ONCE()/WRITE_ONCE() to be single-copy-atomic for
<=sizeof(unsigned long) and atomic*_read()/atomic*_set() for all atomic
types. Your atomic64_t alignment should ensure this is so.

So while I think we're fine, I do find hardware instructions that tear
yuck (yah, I know, x86...)

> > So even though it is allowed by the chip; does it really make sense to
> > use this?
> 
> It gives performance benefits when dealing with either 64-bit or even
> larger buffers, see how we use it in our string routines like here [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arc/lib/memset-archs.S#n81

That doesn't require the ABI alignment crud.
