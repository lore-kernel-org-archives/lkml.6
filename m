Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE2CC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2878E20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="e9089IAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUpEq+GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2878E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933773AbeFTWaW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:30:22 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37235 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933528AbeFTWaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:30:21 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5EBC221D7B;
        Wed, 20 Jun 2018 18:30:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Jun 2018 18:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=6NOdBvEcCWNnlMA4wBVywo3zt39RPJlVj3Sh6y0Dklg=; b=e9089IAn
        5RAuoPRKEOQ559UVV3i6YOqxiu8yuDwbEJVZ6T4S+vkM3XkzwyzK/+8mwGM2buDG
        yfetH1wMSVMoIO4x4X5wf+IuYYKOFhxGIrj9GlwnaoU1s7nUHmj1xs9uGQJrpArH
        Yb4Nt49ALQSn0urNGigyPQU8FCl5h4bsAYT1YV+VrYr/0OSGan4fGQxfYMH8oatF
        1pXGA93OgKJjG8piu+3iqQj59iutn94hrJDLLmb9ytjYgiOhB3n49r5RIlWJuIxH
        xxVaE6yGoWeP9Kfkab5IbP3HOaeLiGaXbCDfJFMZPNyN3DNVjc3Hg45mhHhPhKeB
        qtlqCKZX935mAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=6NOdBvEcCWNnlMA4wBVywo3zt39RP
        JlVj3Sh6y0Dklg=; b=IUpEq+GHO8yuDLokBLpKf/bTuddyCYOgvIlAlUFZDh3mh
        kVQa6o/QvKAIOfdYlYNM6pjyIpdV2Ymi8zLXH33RgAN/In5po3AgNH2mwWRRpfir
        7E21ibPn1buW7ivR2jglxXbQXw2+Scmudgt+ruAI1qNVvtjxb6m0nIYCDO6AQ7k4
        mYIcnRfh705BGIHiJlepgpntq9navvshYD92Yd5FuONUclYVrn2aRNOxxv5Mfnw/
        Hbp5gqqC6A0qrcPqY73GeGT7+3xVSEOIyLTuxhdVq14iFvM5RsRMMQ77DG1myW69
        ZqpTYZ2zZrgEW8uhud8va2oIg3k3UbVCFZ1t1YIEQ==
X-ME-Proxy: <xmx:etUqWwKxiXEA58AHZ2rSfEDKuQQTH0v1z9Z5xZB-FX-UeByyI8x9RA>
    <xmx:etUqW3yFWmrRgWalc-k9nkIVa-fuCUuMTkQGH6bo55prvcdO2jH8zA>
    <xmx:etUqW-U4McEIVs1nAXZ0eZsSzUkkbNNG1TFK_ZUEEGo7AJUjN6DVTw>
    <xmx:etUqW3i1uxetBeuf52CrFQ1nlxXZ_8Ws9TjqgqRcCLvrqufft2G9Hw>
    <xmx:etUqW-Axf4-ZZbzoDnVXgK6PF2L_YuNnGvp26i-VvXy8zrAnmhGNPQ>
    <xmx:etUqWydf30HhY-EF-voWi61IBSmro5ETWhy4508_pSqa2LXcG0DTKQ>
X-ME-Sender: <xms:etUqWxgpxT5CqqslD773euwT64dqNIxQyGNUh0ZlLWBY_cKyN3nWlw>
Received: from localhost (124-171-16-226.dyn.iinet.net.au [124.171.16.226])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69F13E4445;
        Wed, 20 Jun 2018 18:30:17 -0400 (EDT)
Date:   Thu, 21 Jun 2018 08:30:14 +1000
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
Message-ID: <20180620223014.GE11671@eros>
References: <20180620042046.30806-1-me@tobin.cc>
 <20180620042046.30806-5-me@tobin.cc>
 <e4f6bfb3-68c7-9f57-0d90-d68d0913234a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4f6bfb3-68c7-9f57-0d90-d68d0913234a@infradead.org>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 09:09:49AM -0700, Randy Dunlap wrote:
> On 06/19/2018 09:20 PM, Tobin C. Harding wrote:
> > Currently printing [hashed] pointers requires enough entropy to be
> > available.  Early in the boot sequence this may not be the case
> > resulting in a dummy string '(____ptrval____)' being printed.  This
> > makes debugging the early boot sequence difficult.  We can relax the
> > requirement to use cryptographically secure hashing during debugging.
> > This enables debugging while keeping development/production kernel
> > behaviour the same.
> > 
> > If new command line option debug_boot_weak_hash is enabled use
> > cryptographically insecure hashing and hash pointer value immediately.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >  lib/vsprintf.c                                  | 17 +++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 638342d0a095..a116fc0366b0 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -748,6 +748,15 @@
> >  
> >  	debug		[KNL] Enable kernel debugging (events log level).
> >  
> > +	debug_boot_weak_hash
> > +			[KNL] Enable printing pointers early in the boot
> > +			sequence.  If enabled, we use a weak hash instead of
> > +			siphash to hash pointers.  Use this option if you need
> > +			to see pointer values during early boot (i.e you are
> 
> maybe:
> 			to see hashed pointer values
> i.e., not raw pointers.

You cannot see 'raw pointers' anyways?

> 
> > +			seeing instances of '(___ptrval___)').
> > +			Cryptographically insecure, please do not use on
> > +			production kernels.

thanks for the review, I don't quiet see how to use your suggestion to
make the text clearer.  If you still feel this change is needed perhaps
you could write so I understand i.e 'Use this option if ...'


thanks,
Tobin.
