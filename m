Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F93C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FA421900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dI8opS5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394394AbfBNMYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:24:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55718 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438523AbfBNMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fPgFVPIuY5n/zvRvxzxsqoQ2vBuYsDE+tjyDMLEDA6w=; b=dI8opS5K0ZgGIFr6wthD+Ea5p
        jPlds8X2j+fAL/yFuasVHxS3sUxxOY0fkJjV6yxS0S8w/tY84vJw4U74BzcVMkg0L3Qhs0Xr+Za5L
        6GQ4uL1Rn9tfdNxgJRbvUURbUxFUhWShp/+Nj5Rgozyl9EAzzMRGJyIdT9Y/nBOHJyy6EdcMeAbNg
        oKc0J0xYz1xeeRy4AJ50GAFzH85PvEPiGjzwZ/noJ8h7+daF84G/1DN/UwW9mQaPEqAjFo6dyuw/U
        DVabihev8ycrB0tEZ2AGEgdTTGzfpO4r4utcTCG9P2VsUhMGhdanM3Sq1ZMFKUgwDqQ6vH2VrAlrC
        0ooPBrdHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guG3p-00035g-9S; Thu, 14 Feb 2019 12:24:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F25192029E070; Thu, 14 Feb 2019 13:24:11 +0100 (CET)
Date:   Thu, 14 Feb 2019 13:24:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Message-ID: <20190214122411.GN32494@hirez.programming.kicks-ass.net>
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
 <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
 <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
 <20190213125651.GP32494@hirez.programming.kicks-ass.net>
 <e6138aeb-9ce4-fbfa-4d6a-b76f189a3e47@synopsys.com>
 <20190214103140.GG32494@hirez.programming.kicks-ass.net>
 <4881796E12491D4BB15146FE0209CE64681DB122@DE02WEMBXB.internal.synopsys.com>
 <20190214110813.GK32494@hirez.programming.kicks-ass.net>
 <4881796E12491D4BB15146FE0209CE64681DB202@DE02WEMBXB.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4881796E12491D4BB15146FE0209CE64681DB202@DE02WEMBXB.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:05:47PM +0000, Alexey Brodkin wrote:

> > > > So what happens if the data is then split across two cachelines; will a
> > > > STD vs LDD still be single-copy-atomic? I don't _think_ we rely on that
> > > > for > sizeof(unsigned long), with the obvious exception of atomic64_t,
> > > > but yuck...
> > >
> > > STD & LDD are simple store/load instructions so there's no problem for
> > > their 64-bit data to be from 2 subsequent cache lines as well as 2 pages
> > > (if we're that unlucky). Or you mean something else?
> > 
> > u64 x;
> > 
> > WRITE_ONCE(x, 0x1111111100000000);
> > WRITE_ONCE(x, 0x0000000011111111);
> > 
> > vs
> > 
> > t = READ_ONCE(x);
> > 
> > is t allowed to be 0x1111111111111111 ?
> > 
> > If the data is split between two cachelines, the hardware must do
> > something very funny to avoid that.
> > 
> > single-copy-atomicity requires that to never happen; IOW no load or
> > store tearing. You must observe 'whole' values, no mixing.
> > 
> > Linux requires READ_ONCE()/WRITE_ONCE() to be single-copy-atomic for
> > <=sizeof(unsigned long) and atomic*_read()/atomic*_set() for all atomic
> > types. Your atomic64_t alignment should ensure this is so.
> 
> Thanks for explanation!
> 
> I'm not completely sure about single-copy-atomic for our LDD/STD instructions
> (need to check with HW guys) but given above requirement:
> ---------------------------->8--------------------------
> READ_ONCE()/WRITE_ONCE() to be single-copy-atomic for <=sizeof(unsigned long)
> ---------------------------->8--------------------------
> that's OK for them (LDD/STD) to not follow this, right? As they are obviously
> longer than "unsigned long".

Correct.

> Though I'm wondering if READ_ONCE()/WRITE_ONCE() could be used on 64-bit data
> even on 32-bit arches?

Some people were talking about just that a while ago; there's a number
of 32bit platforms (including arm-v7) that can actually do this and
there would be some performance benefits.

But this is currently not done (in generic code) afaik. And once they do
this, it would be under some CONFIG knob.

In particular, things like:

  - u64_stats_sync.h
  - most CONFIG_64BIT chunks from kernel/sched/fair.c

and ISTR there were some other cases.

> Now as for LLOCKD/SCONDD which implement single instruction 64-bit atomics require
> double-word alignment and so cannot possible span between cache lines.
> 
> So what am I missing here?

atomic64_{set,read}() will use STD/LDD resp and should be
single-copy-atomic vs the LLOCKD/SCONDD. But that again is aligned
properly so I don't see problems there.

Aside of that just me being curious and paranoid at the same time.
