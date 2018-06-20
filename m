Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0891C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D94320652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="SK7uULWv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwFcYjyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D94320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932431AbeFTXWj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:22:39 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34143 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754339AbeFTXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:22:38 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8FCE421B98;
        Wed, 20 Jun 2018 19:22:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Jun 2018 19:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=oAijAKVrsOvMXbmBw8Geq9oGa3XeT4mkjrnu0RPVmRI=; b=SK7uULWv
        LW8/QihrtjF1wTY72tz6QKrdlVwBvbFBGePns0WcVqnraOHS4UmDaOU5oK8ojquo
        zzxYsFK/qcYHUdGbwWZfrGq+kpRkQ5A1c/aumgS6RgmDBetSCqgHLmKbb0tfKKGb
        Phq2mX3foFcotvXuNkbvf5gxg8v8q/uWN+B2EZJVvUaOxpbFjzddQ98KCdSIa4al
        7iWH4CsI0VZtLYUsgtvrYbLUXy07k7xiy3XF6vcQRzrmssgo8ku59L0DgdVw1rXt
        0aImV0JK4dL6+N7p/zYeLS5Vc6xw9AeTDtONyIgo3spkHROcmzCh5bGOV60pkVpD
        ZsIJbPE1azPp2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=oAijAKVrsOvMXbmBw8Geq9oGa3XeT
        4mkjrnu0RPVmRI=; b=OwFcYjyAepCAsmmJgmL03C2z8aOB4ulLpWI3ZV5IS6Mqr
        I8xUrP3wtkyHiO7v2j2JZyaQBjh18faZTOV80rUBk4u23C7a9+i7O1UsdyXu8Tlo
        EtqQPJuhJvR/daCsXrd5W8Pn/jTKpGUdb2quvBVJA1MxgvkVxdX+w7ckk1xsv075
        RiaXvIeukyMiwW/MEwO6wmSgQB86nLOlwYAOPwv6K1wDojdXfabX2DDbRjJEANm+
        lByUhvGcda1t4xXSUi7LFj6jcpFWZ+UmficZ/E9xJh5N7V5KDL9xfALDEDIrTp/s
        7mvG8chIOnX4JZZhiFddmyfqmdz9AzsTfO82QMS6Q==
X-ME-Proxy: <xmx:veEqW0qNQhH9duTRRE1F3ESq0YzHrGbwSrWmJGVkMHFkeNJGgc1Fqg>
    <xmx:veEqW_3r_sDyx0VJHUj696zLg0piEwNH3JnunTveVjmmUKszZwgX3w>
    <xmx:veEqW8lQNkfAVKiwvYS5qiZNpRGWY9Chv214bkonzS5NYwRDDEw4fg>
    <xmx:veEqW7Y6H4TbJEEnCHLQz9372KS3R4PrAlKKl97ilQLf81raVyBiCQ>
    <xmx:veEqW-8WTybHrz1Cgy-ETM4lhffQhWJS9TCytkmDdoxcbvGJwFbWDg>
    <xmx:veEqW4ebn1vjawmHotnEfr58jVx0xUcz7hYSwDreXWQDeYB8ZnBWqg>
X-ME-Sender: <xms:veEqWziXUEBIMXMF2xMASgOUjNccJgCSogugcBLrBD-dWrwzp0-VUA>
Received: from localhost (124-171-16-226.dyn.iinet.net.au [124.171.16.226])
        by mail.messagingengine.com (Postfix) with ESMTPA id 76832E446F;
        Wed, 20 Jun 2018 19:22:36 -0400 (EDT)
Date:   Thu, 21 Jun 2018 09:22:33 +1000
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
Message-ID: <20180620232233.GH11671@eros>
References: <20180620042046.30806-1-me@tobin.cc>
 <20180620042046.30806-5-me@tobin.cc>
 <e4f6bfb3-68c7-9f57-0d90-d68d0913234a@infradead.org>
 <20180620223014.GE11671@eros>
 <b472dca0-9bd0-caf3-efab-586b6ff32765@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b472dca0-9bd0-caf3-efab-586b6ff32765@infradead.org>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 03:36:44PM -0700, Randy Dunlap wrote:
> On 06/20/2018 03:30 PM, Tobin C. Harding wrote:
> > On Wed, Jun 20, 2018 at 09:09:49AM -0700, Randy Dunlap wrote:
> >> On 06/19/2018 09:20 PM, Tobin C. Harding wrote:
> >>> Currently printing [hashed] pointers requires enough entropy to be
> >>> available.  Early in the boot sequence this may not be the case
> >>> resulting in a dummy string '(____ptrval____)' being printed.  This
> >>> makes debugging the early boot sequence difficult.  We can relax the
> >>> requirement to use cryptographically secure hashing during debugging.
> >>> This enables debugging while keeping development/production kernel
> >>> behaviour the same.
> >>>
> >>> If new command line option debug_boot_weak_hash is enabled use
> >>> cryptographically insecure hashing and hash pointer value immediately.
> >>>
> >>> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> >>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >>> ---
> >>>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >>>  lib/vsprintf.c                                  | 17 +++++++++++++++++
> >>>  2 files changed, 26 insertions(+)
> >>>
> >>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >>> index 638342d0a095..a116fc0366b0 100644
> >>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>> @@ -748,6 +748,15 @@
> >>>  
> >>>  	debug		[KNL] Enable kernel debugging (events log level).
> >>>  
> >>> +	debug_boot_weak_hash
> >>> +			[KNL] Enable printing pointers early in the boot
> >>> +			sequence.  If enabled, we use a weak hash instead of
> >>> +			siphash to hash pointers.  Use this option if you need
> >>> +			to see pointer values during early boot (i.e you are
> >>
> >> maybe:
> >> 			to see hashed pointer values
> >> i.e., not raw pointers.
> > 
> > You cannot see 'raw pointers' anyways?
> 
> only if using %px ?
> 
> Maybe it's just terminology.  I don't consider a hashed value as a pointer value.
> It's just a key or handle or some other number, but it's not a pointer.
> 
> >>
> >>> +			seeing instances of '(___ptrval___)').
> >>> +			Cryptographically insecure, please do not use on
> >>> +			production kernels.
> > 
> > thanks for the review, I don't quiet see how to use your suggestion to
> > make the text clearer.  If you still feel this change is needed perhaps
> > you could write so I understand i.e 'Use this option if ...'
> 
> 
> OK, if you are good with it, I am too.  :)

I get you know.  I agree, how about this

			[KNL] Enable printing pointers early in the boot
			sequence.  If enabled, we use a weak hash instead of
			siphash to hash pointers.  Use this option if you need
			to print pointers with %px during early boot
			(i.e you are seeing instances of '(___ptrval___)').
			Cryptographically insecure, please do not use on
			production kernels.


thanks for clarifying,
Tobin.
