Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5149DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183532085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="oEDqX8+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iTs6B7VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183532085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anarazel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeJLBQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:16:09 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:33239 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727693AbeJLBQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:16:09 -0400
X-Greylist: delayed 643 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 21:16:08 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B4D92CB7;
        Thu, 11 Oct 2018 13:37:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 11 Oct 2018 13:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=bLT2q5CwEHScJdfh1PtyO3N/B49
        SNOgT6nYZigpqXYo=; b=oEDqX8+rgD6cy4lmm6DJAslUjWd5WKMe0ijfTy7yJUC
        97vUb/angQHLOgQqzzf2uqEwoeUh/U0VpmIlAmKn3RMIpTFhrZ4xKcANgVjhi1UP
        5gGC/D22Y1CiEfDXB6xM8am45CAw6aGSYXgkqfhjsX7rmeVi6b8o1c5Q67VfFTi9
        UuWcvZJqp9WFf8Jce1FLwCpN5f1uE/tO8bkRpmxxC1CiUcDMw5UghOaDLGkeMWpA
        4v3dCZBjA848+2O3jRCi+cyhpdCdRqjHPGyn3fVkrHNunpWb5UpfReKnYFwNDWXI
        wuIEkeog0/FnKHIRjvR+FhcFP6xVORJ8XsCPaD8wFWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bLT2q5
        CwEHScJdfh1PtyO3N/B49SNOgT6nYZigpqXYo=; b=iTs6B7VHDcWkYC8YQc2QSs
        Pyv30jfrwu027Rr0J3KsRlq/9sHhQmbTqBljBfHS2kMo+l5TVSM6eV3X0HbXwP4N
        EFdFiSEKn8CPC1OxS4rMjw/A6T6vdS9mojIa0Ag6OZ9iLWxjwQqgc6a2Q1KBEVit
        QqpCF6OYImQAWa1sFVFBUCSC7zLyDhRlyN3atvHfjU7ZuVRTjvlZbWehSvj184OI
        MHFkO0u4VGmxAVgUKVPjtYw5UavCaJ4iUjsv58Iunq52bhT/N6yg/1pSlWfU6S7x
        xh9rXEO2noaqg5SAlw+/YEBKG76ryCY68ZgYHMNqV+pBqpBhVS53QYLDxpoOniNA
        ==
X-ME-Sender: <xms:RYq_W8CFETW_pVTqCDZFnkSHMYSJts7AGwlwTJE1ceOywADz5rynyQ>
X-ME-Proxy: <xmx:RYq_W46OCs8H7bfhv57WDGtZ9B9crINzfbBt73I8FgJp38U969-HrA>
    <xmx:RYq_W3QemI71HdGW6nN0Ggbi2Dczsv5EYq4Plq_PPUyGZmEKbuth9A>
    <xmx:RYq_W-ymE-bIxySYdyk9T90FtM5mtp9aVGPV2KJoMes00lsfUxHJKg>
    <xmx:RYq_W3qDprt4zt0tfX2exUEkXRFiLj-VUdgJC63liiWkcR43drVKug>
    <xmx:RYq_W52n70IcYOrhPxK94vCt3-ZlngofJDYj4XrUArSFbgSldQrZOw>
    <xmx:R4q_W44PWuFld3OptlleKUyxS8uVLP54pOAc4pOYDr3dfXK58CDjKA>
Received: from intern.anarazel.de (c-98-210-140-171.hsd1.ca.comcast.net [98.210.140.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 153C2102ED;
        Thu, 11 Oct 2018 13:37:09 -0400 (EDT)
Date:   Thu, 11 Oct 2018 10:37:07 -0700
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
Message-ID: <20181011173707.26pekp65tlipvhdx@alap3.anarazel.de>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
 <56957D54.5000602@zytor.com>
 <20160126101921-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126101921-mutt-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2016-01-26 10:20:14 +0200, Michael S. Tsirkin wrote:
> On Tue, Jan 12, 2016 at 02:25:24PM -0800, H. Peter Anvin wrote:
> > On 01/12/16 14:10, Michael S. Tsirkin wrote:
> > > mb() typically uses mfence on modern x86, but a micro-benchmark shows that it's
> > > 2 to 3 times slower than lock; addl $0,(%%e/rsp) that we use on older CPUs.
> > > 
> > > So let's use the locked variant everywhere - helps keep the code simple as
> > > well.
> > > 
> > > While I was at it, I found some inconsistencies in comments in
> > > arch/x86/include/asm/barrier.h
> > > 
> > > I hope I'm not splitting this up too much - the reason is I wanted to isolate
> > > the code changes (that people might want to test for performance) from comment
> > > changes approved by Linus, from (so far unreviewed) comment change I came up
> > > with myself.
> > > 
> > > Lightly tested on my system.
> > > 
> > > Michael S. Tsirkin (3):
> > >   x86: drop mfence in favor of lock+addl
> > >   x86: drop a comment left over from X86_OOSTORE
> > >   x86: tweak the comment about use of wmb for IO
> > > 
> > 
> > I would like to get feedback from the hardware team about the
> > implications of this change, first.

> Any luck getting some feedback on this one?

Ping?  I just saw a bunch of kernel fences in a benchmark, making me
wonder why linux uses mfence rather than lock addl. Leading me to this
thread.

Greetings,

Andres Freund
