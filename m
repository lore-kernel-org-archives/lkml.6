Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9D5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF2C2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="qI8wWvTY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6VSgiS0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfBUFP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:15:26 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41761 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfBUFPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:15:25 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CC29216F9;
        Thu, 21 Feb 2019 00:15:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Feb 2019 00:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=K2Z5aAuAXuH4fT8iGliRn3Jx9rW
        /M1Y97uTsEqo6FxQ=; b=qI8wWvTYtBjOKSnlkAzqXg5p5Eanzg7Epn1NIoMYVj0
        7icvtWCyCd/6ZT47b9YigeBc/hVxc7+FrJErX6O6fEqRvsov9VuOJRG7b5OPuNuo
        Ftojjp1Wm34F72o6S2yH4yna6vFi92KW4wE/eMynrYfcCS+sdp4Q9KLEzgGWbZDz
        Cfm7DeJhLumWcPnZkfbLKYUNbqJ8Iag43pB4MVGXhRp2+Fgt9ToPrdwXCbee3OjT
        TCMcTxUKE1FceKvEWDFJR0MyWg2YZRsXoKiP1LAMmdQaXq1Hhg/6lNitDOYsmNx2
        Fo6wgcRmA/YufQOMQ4R9787JLl7MaKLnjolmhLBNlFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=K2Z5aA
        uAXuH4fT8iGliRn3Jx9rW/M1Y97uTsEqo6FxQ=; b=6VSgiS0yZV34yhf/ddZS66
        Eu4zqmIE2btgWd0RYszjfBPzpABAfc02GRPrRt8tk34rp0czBV3Fx1frGtzRW6q3
        4RLz7v0ei7WPZsmVRDBta4xtofWOdMitNzymZNnXC2lfDJHhFlJviBjLDIZTgPpD
        a9lkAnuv+uYlOcJ8NZhsQ5KujlQ5/9eCG+qBiea4oEW0xK28ojOi5ig0PfmZofUE
        bwuwMWi1ROCwMtgD34nhC34oq+ciOC1ni/qasKEUBnZLloi0rAyQLZ7MfQTEo7EI
        nmw+E7ivWP1QU+A/jCHzSZALV9wBwWVPG/INQEAMhJslCsndptaLLSJL6880rlIA
        ==
X-ME-Sender: <xms:6DNuXMxJQ92xpQqUkVyXCH8U-ELbMFdvJ_UNv2cg-fecTzeInwhFLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdejgdekvdculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvdefledrudeggeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:6DNuXINq-p203OFkgLF8S0lzay1WDsdsrQ7pgUCiaG-KPFpRzhJI-w>
    <xmx:6DNuXFgVux8DOPfRHeVAJjJnGBZpLttdWXt_XWbMqdk32Ym97laGig>
    <xmx:6DNuXA-E2KmZVH2mo6xtX-WsTgCSEZGlmG6FfcH1J0j-XgM6qoum_g>
    <xmx:6TNuXHWu_-x27PpLMt4zCH-NEFnHWM9YbLEkYaY6JBCbQNgtFbjj3A>
Received: from localhost (ppp121-44-239-144.bras2.syd2.internode.on.net [121.44.239.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA61DE461F;
        Thu, 21 Feb 2019 00:15:18 -0500 (EST)
Date:   Thu, 21 Feb 2019 16:15:00 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] lib: Add safe string funtions
Message-ID: <20190221051500.GB11758@eros.localdomain>
References: <20190218232308.11241-1-tobin@kernel.org>
 <CAGXu5j+gHMCjxMr3k0UNBcsT6DYuALtpROxazf7YVX=SUja_cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+gHMCjxMr3k0UNBcsT6DYuALtpROxazf7YVX=SUja_cQ@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:31:07PM -0800, Kees Cook wrote:
> On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
> > During your talk at LCA you mentioned that we could do with a couple
> > more safe string functions.  One to zero the tail of the destination
> > buffer after call to strscpy() and also the self explanatory
> > strscpy_from_user().
> 
> Thanks for jumping in with this! :)

Good to be working with you again.

> > I couldn't work out if this is a false positive or not?  Does the new
> > config option CONFIG_TEST_STRING need more documentation?  I don't see
> > where extra docs should be added and it seems self explanatory as is.
> 
> Usually this just means the help string in Kconfig is "too short".
> Sometimes this is a false positive -- really up to you if you think it
> needs more. :)

Cool, thanks.
