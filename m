Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422BE208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Iw8e8rQq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFWQ5ou2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422BE208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeFUFk4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:40:56 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44291 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932707AbeFUFkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:40:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 620E9218AF;
        Thu, 21 Jun 2018 01:40:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 01:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pEc+a15SdwXe/hU8NPmqzBPWgXb4DzEYU0epAfBqWnM=; b=Iw8e8rQq
        v2VWAQTGPH6TklgPeSOvjFHqWidXw682NgQZAwnS0InQ2sEw9AjyaEZDLFcltTTc
        /ee4ri+aB/Oj8Pf3g44NM8LSKlOsZ6me9ADgihhDqowpr8HRK48tgeQ9hYDtuz3r
        EV9NRXKbSMvUsM7H+bkKvqa2zAtlYwQvOsbKeTCpCoMELXTKhf4uf1Xigs5o6NYY
        Lb7x7yYn5/uAwx0kgDdDGj2cDSgU5IYQ16jP2UwpaRuKSIOU1hwbg/E0q1kKqZmr
        FBBWMBSI82O0yZ5Biu91Dr/fYeOIuyfpiR1+ZL9PcCAnjFuTMX3KniI6TuwnGyGD
        IWlFR8B9DLHM+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=pEc+a15SdwXe/hU8NPmqzBPWgXb4D
        zEYU0epAfBqWnM=; b=kFWQ5ou2r3U00TfJqfeKbvFuCfxu4inPok8SO0pRJMTxV
        RPfSJgCJopud9ixwXJbNAVIP9PGwW7NAPc9K3t+Qx4xBo9DTY0g/9aZ8Q+g3CxPU
        MokSVeA5UuUSiI5IZUL8X1eneyho+Dovgn8o9HmcOhmkRyfmF226plCI9RJrhief
        uH2w6H8os9CzrEIKnGOl44RwfLoNbXLtJ//xT/75XFK80j8tIPR8r3zO6E4FdRwL
        ogKiaHuxgrPZikLkjedXELcZc8aRe1iNOf8wjtfD7aocc0pSWdArDm6J0KIAp5k2
        pfIjqbHbnPQe7sbCBAIWGbAe/woRi/osAyUATDqsg==
X-ME-Proxy: <xmx:ZjorW1EWh_biOQDdzQ9u75fNDv_QGRgHBa5c-RqwWTWxSBDPq2XjUw>
    <xmx:ZjorW2Rcap8Uz798ic8uDYL7dihkw0y29lSkD-h2syOS3YVzSqXvmA>
    <xmx:ZjorW6NLDPHDQ8HLHApelxWVpgeQh6Ff_kVphNJWVTNdMkYlEdTQ2w>
    <xmx:ZjorW2dWRPLPUxh5Hbl7VgWuu-7HI_eHigLVbUvuwRmaMhjSJG6plQ>
    <xmx:ZjorW9VpIpD1vS9moMxsfninqJmBI4BKGqpPlsOk3NYEKi8opVEqIA>
    <xmx:ZjorW08CN8LIchUA8VpwJ65F-EMCCriKllBvU31mNxQ9-aqKPHw_bg>
X-ME-Sender: <xms:ZjorWwFx6PrX4AiFMpd3x5Dvb7AYvfl5uNxcltIXGLAI1fAMwEfopA>
Received: from localhost (124-171-16-226.dyn.iinet.net.au [124.171.16.226])
        by mail.messagingengine.com (Postfix) with ESMTPA id 51E4DE403B;
        Thu, 21 Jun 2018 01:40:53 -0400 (EDT)
Date:   Thu, 21 Jun 2018 15:40:50 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] vsprintf: Add command line option
 debug_boot_weak_hash
Message-ID: <20180621054050.GB18398@eros>
References: <20180620042046.30806-1-me@tobin.cc>
 <20180620042046.30806-5-me@tobin.cc>
 <e4f6bfb3-68c7-9f57-0d90-d68d0913234a@infradead.org>
 <20180620223014.GE11671@eros>
 <b472dca0-9bd0-caf3-efab-586b6ff32765@infradead.org>
 <20180620232233.GH11671@eros>
 <983177e0-8684-c7b8-4328-065be5c78e63@infradead.org>
 <20180621031505.GA18398@eros>
 <71eb048a-c414-779d-974d-20ab7d2582f0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71eb048a-c414-779d-974d-20ab7d2582f0@infradead.org>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 09:09:49PM -0700, Randy Dunlap wrote:
> On 06/20/2018 08:15 PM, Tobin C. Harding wrote:
> > On Wed, Jun 20, 2018 at 04:38:05PM -0700, Randy Dunlap wrote:
> >> On 06/20/2018 04:22 PM, Tobin C. Harding wrote:
> >>> On Wed, Jun 20, 2018 at 03:36:44PM -0700, Randy Dunlap wrote:
> >>>> On 06/20/2018 03:30 PM, Tobin C. Harding wrote:
> >>>>> On Wed, Jun 20, 2018 at 09:09:49AM -0700, Randy Dunlap wrote:
> >>>>>> On 06/19/2018 09:20 PM, Tobin C. Harding wrote:
> >>>>>>> Currently printing [hashed] pointers requires enough entropy to be
> >>>>>>> available.  Early in the boot sequence this may not be the case
> >>>>>>> resulting in a dummy string '(____ptrval____)' being printed.  This
> >>>>>>> makes debugging the early boot sequence difficult.  We can relax the
> >>>>>>> requirement to use cryptographically secure hashing during debugging.
> >>>>>>> This enables debugging while keeping development/production kernel
> >>>>>>> behaviour the same.
> >>>>>>>
> >>>>>>> If new command line option debug_boot_weak_hash is enabled use
> >>>>>>> cryptographically insecure hashing and hash pointer value immediately.
> >>>>>>>
> >>>>>>> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> >>>>>>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >>>>>>> ---
> >>>>>>>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >>>>>>>  lib/vsprintf.c                                  | 17 +++++++++++++++++
> >>>>>>>  2 files changed, 26 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >>>>>>> index 638342d0a095..a116fc0366b0 100644
> >>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>>>>> @@ -748,6 +748,15 @@
> >>>>>>>  
> >>>>>>>  	debug		[KNL] Enable kernel debugging (events log level).
> >>>>>>>  
> >>>>>>> +	debug_boot_weak_hash
> >>>>>>> +			[KNL] Enable printing pointers early in the boot
> >>>>>>> +			sequence.  If enabled, we use a weak hash instead of
> >>>>>>> +			siphash to hash pointers.  Use this option if you need
> >>>>>>> +			to see pointer values during early boot (i.e you are
> >>>>>>
> >>>>>> maybe:
> >>>>>> 			to see hashed pointer values
> >>>>>> i.e., not raw pointers.
> >>>>>
> >>>>> You cannot see 'raw pointers' anyways?
> >>>>
> >>>> only if using %px ?
> >>>>
> >>>> Maybe it's just terminology.  I don't consider a hashed value as a pointer value.
> >>>> It's just a key or handle or some other number, but it's not a pointer.
> >>>>
> >>>>>>
> >>>>>>> +			seeing instances of '(___ptrval___)').
> >>>>>>> +			Cryptographically insecure, please do not use on
> >>>>>>> +			production kernels.
> >>>>>
> >>>>> thanks for the review, I don't quiet see how to use your suggestion to
> >>>>> make the text clearer.  If you still feel this change is needed perhaps
> >>>>> you could write so I understand i.e 'Use this option if ...'
> >>>>
> >>>>
> >>>> OK, if you are good with it, I am too.  :)
> >>>
> >>> I get you know.  I agree, how about this
> >>>
> >>> 			[KNL] Enable printing pointers early in the boot
> >>> 			sequence.  If enabled, we use a weak hash instead of
> >>> 			siphash to hash pointers.  Use this option if you need
> >>> 			to print pointers with %px during early boot
> >>> 			(i.e you are seeing instances of '(___ptrval___)').
> >>> 			Cryptographically insecure, please do not use on
> >>> 			production kernels.
> >>
> >> Sorry, I'm still confused by this paragraph.  It seems to say two different
> >> things.
> > 
> > My bad, I got totally confused myself.  After all this time you would
> > think I knew which specifier hashed and which didn't.  My apologies,
> > how about this:
> > 
> >  			[KNL] Enable printing [hashed] pointers early in
> > 			the boot sequence.  If enabled, we use a weak hash
> > 			instead of siphash to hash pointers.  Use this option if
> > 			you are seeing instances of '(___ptrval___)') and need
> > 			to see a value (hashed pointer) instead. Cryptographically
> > 			insecure, please do not use on production kernels.
> >  			 			
> > 
> > thanks for your patience,
> > Tobin.
> 
> Yes, that's good.  Thanks.

Awesome, v9 on it's way :)

thanks,
Tobin.
