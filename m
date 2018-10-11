Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A8C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7033E2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="MycTpT0t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCERwpSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7033E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anarazel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeJLBti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:49:38 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58799 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727443AbeJLBti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:49:38 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DF8C9C75;
        Thu, 11 Oct 2018 14:21:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 11 Oct 2018 14:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=p31DR/2IEs6IrwxH2KzqkwxgHS2
        jpl2p3gFlTpAJyVc=; b=MycTpT0tYz8b+a/D91j75nOSmQLAJwGK4uUCIUqq33G
        y3qgGrowITyEwM+X9hmjrdiymoZMGBP3RwaVgD38HpCN7tsh168G+EKzAX+IWgjZ
        j2mGWI0zQxhfDD5kErbxGWrGEOogH3HdGEEszq0XJrTlmknKwEFI+Dc1Mlz6Msr7
        m++Jih/pPTIBfHImPGlmTA2i5r+PqgtkEa2s9Q1Ipsnuzsr3xNdp1SFdHLLB8XZh
        ChyQHJvKNivOO9EF0jQS0Xh/SzCV3vSj6QHPObga4ROUntNoU49utvJqLrPfauwc
        gLbxJTvCmzoZwta1RkmTtzNvo2NT/D7k8+F57uILedA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=p31DR/
        2IEs6IrwxH2KzqkwxgHS2jpl2p3gFlTpAJyVc=; b=GCERwpSvLNw5V0+ACa8udv
        KcWs3BXEcouVhuV2RnRUU/8AxnPMJpPwjcmGMv+nlARUbS/lvvDiflHBENZq2lfm
        wZczU6ntyLpBRbcmX9lbR5lThvGNhvuWW5XMHiEOQUl3pT5Ucj2GVovYPG+U6LUE
        T78Dxo//nslQa8vvBZ+73d4qyvx7jdxAeZD14DK6sea24Fyfa9SLiBwOsomurt+R
        unrY/wAzMotwJrlFdMCtJFo5JHJH/qo77ht/1YRLz/lDw5LLt2SZ5F6BqT32L/GL
        uCF75OG5prwcPIJY7W581zrHEcJftsKuoD5SIsr8knPDbzJpJylXLHXBuY64IDnA
        ==
X-ME-Sender: <xms:mJS_W2uCl_3ugTpqdEevTbymItDgrY5pbye0e8mcvEGgNzGRswhQ-g>
X-ME-Proxy: <xmx:mJS_W2B6ZZFPfwJUmHWBwvZilmc90F-ng5QopV8xL-BVkthbBwTnUA>
    <xmx:mJS_WyB3buaaIqTy5rupzp-a40p2Woxk79Ug6SwY_penkqdf3EpCkg>
    <xmx:mJS_WyMHqKI0fN5N5_--yxEzcfCKR2306ncX21q3JgElJkn_1eYeJg>
    <xmx:mJS_W2yOkWuOusLunV1U_dNQTSZ3bi-hU-oKgWTa28XqJNgUM0Nu3A>
    <xmx:mJS_W-nl_s2YrYneqXEMiILTWyYQe2qF8HQeY6E0xvaEvHmN45eR9Q>
    <xmx:mpS_W9miB8pzAfNsVojX7PmRezay0A9HbvWYJWsG42z4Z94WmrXgiQ>
Received: from intern.anarazel.de (c-98-210-140-171.hsd1.ca.comcast.net [98.210.140.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id C2688102DE;
        Thu, 11 Oct 2018 14:21:11 -0400 (EDT)
Date:   Thu, 11 Oct 2018 11:21:10 -0700
From:   Andres Freund <andres@anarazel.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 0/3] x86: faster mb()+other barrier.h tweaks
Message-ID: <20181011182110.y4rkfdfj75w3fwoy@alap3.anarazel.de>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
 <56957D54.5000602@zytor.com>
 <20160126101921-mutt-send-email-mst@redhat.com>
 <20181011173707.26pekp65tlipvhdx@alap3.anarazel.de>
 <20181011140837-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011140837-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-10-11 14:11:42 -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 11, 2018 at 10:37:07AM -0700, Andres Freund wrote:
> > Hi,
> > 
> > On 2016-01-26 10:20:14 +0200, Michael S. Tsirkin wrote:
> > > On Tue, Jan 12, 2016 at 02:25:24PM -0800, H. Peter Anvin wrote:
> > > > On 01/12/16 14:10, Michael S. Tsirkin wrote:
> > > > > mb() typically uses mfence on modern x86, but a micro-benchmark shows that it's
> > > > > 2 to 3 times slower than lock; addl $0,(%%e/rsp) that we use on older CPUs.
> > > > > 
> > > > > So let's use the locked variant everywhere - helps keep the code simple as
> > > > > well.
> > > > > 
> > > > > While I was at it, I found some inconsistencies in comments in
> > > > > arch/x86/include/asm/barrier.h
> > > > > 
> > > > > I hope I'm not splitting this up too much - the reason is I wanted to isolate
> > > > > the code changes (that people might want to test for performance) from comment
> > > > > changes approved by Linus, from (so far unreviewed) comment change I came up
> > > > > with myself.
> > > > > 
> > > > > Lightly tested on my system.
> > > > > 
> > > > > Michael S. Tsirkin (3):
> > > > >   x86: drop mfence in favor of lock+addl
> > > > >   x86: drop a comment left over from X86_OOSTORE
> > > > >   x86: tweak the comment about use of wmb for IO
> > > > > 
> > > > 
> > > > I would like to get feedback from the hardware team about the
> > > > implications of this change, first.
> > 
> > > Any luck getting some feedback on this one?
> > 
> > Ping?  I just saw a bunch of kernel fences in a benchmark, making me
> > wonder why linux uses mfence rather than lock addl. Leading me to this
> > thread.
> > 
> > Greetings,
> > 
> > Andres Freund
> 
> It doesn't do it for smp_mb any longer:
> 
> commit 450cbdd0125cfa5d7bbf9e2a6b6961cc48d29730
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Fri Oct 27 19:14:31 2017 +0300
> 
>     locking/x86: Use LOCK ADD for smp_mb() instead of MFENCE

Ooh, missed that one.


> I didn't bother with mb() since I didn't think it's performance
> critical, and one needs to worry about drivers possibly doing
> non-temporals etc which do need mfence.
> 
> Do you see mb() in a benchmark then?

No it was a smp_mp(). It was on an older kernel (was profiling postgres
on hardware I have limited control over,not the kernel. Just noticed the
barrier while looking at perf output). I quickly looked into a current
arch/x86/include/asm/barrier.h and still saw mfences, and then found
this thread. Should have looked more carefully.

Sorry for the noise, and thanks for the quick answer.

- Andres
