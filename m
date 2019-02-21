Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F24CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1302148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="SftL8wjY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGijuLHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfBUFRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:17:52 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48403 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfBUFRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:17:51 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3232D3267;
        Thu, 21 Feb 2019 00:17:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Feb 2019 00:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DSLOt6sSx13pwF8kN3wR69DjN9E
        jZG83SA6w04TzjHk=; b=SftL8wjY0VF320sFficLm5yMVVsBesc8Jm1yE1GQbcU
        OlnU3OvtTyisUfPpOKBj+bXP35xf7tV4L6iih80EERoUXWRNawjhzdAqR/t9EghT
        Kk6z03cdf2eyxITE1hfaZQrHYcFLS8Jr3tDq216GkU1TG5vwwY1698ul0wNoSmcH
        0VLMHlgfoB1Rk6OHLmmKMrOVNk8z3KbPmLHU0r7GKTcn9SeedcwvzJbu7wGEUCco
        NMEETtldgnB+V1SzeGxkIJhvaCFFvMLvkMllNVGleXZuxm7CL2dTCPNKQgyANBU9
        HJUlkZ5T3HfjAERYSHP9FxNB68AQAeySRstccMJMV7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DSLOt6
        sSx13pwF8kN3wR69DjN9EjZG83SA6w04TzjHk=; b=lGijuLHCARsCySNFPcL4hV
        e05vVVaA4zzQ2OlIYFZHAdSph92Vxf07X52oKzRvkOfXUyEgXk4HieLAipioP6Nw
        OgP8zwOkbAq4xBL3F9AwbbzTfKgoy06i4AtZJsb31iKEY80gzp1Hjh78QGXgcvVZ
        a2AZhrN5/x2tOG0VPMJeH/e7IlHwFx22aWngrqnKN3WhDrae/obVlAucP3AyHWRe
        LFOIR/epws+Edtiuqpp5R1q0eiAUJyZCFcXpCcIzBlwwUjh6oDLAQeDSHLiYYyLs
        XG6qjkVCkXJNevv/YDDnbccbPh7gm2nFxQhUfg+A8oXtQftOmPDs85sj6Sk9upNA
        ==
X-ME-Sender: <xms:fTRuXIKlzeeG1dxWjHKipJ174GqRkW67_uzO4St_44LqwKT9aUbNjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdejgdekvdculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvdefledrudeggeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:fTRuXEyQtgGwGSYSLTNxHnPaFfXeDo8BqBDqJh4Z6nOTrUvbco8yHw>
    <xmx:fTRuXPEdkFIj1H90fDAiaO9hIzok86NbjXG4f0m_z34W6oDrdaJcdw>
    <xmx:fTRuXPTb_BcIEwpgmgnqFmst_gn7iGPRLV1YceV8R5x1Q0gI75LBKA>
    <xmx:fTRuXDwKLacXZq7C_ckjy7Lntprprxp3Amg20Cnc4-nJgsuwAvy7gA>
Received: from localhost (ppp121-44-239-144.bras2.syd2.internode.on.net [121.44.239.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE7BFE44A2;
        Thu, 21 Feb 2019 00:17:48 -0500 (EST)
Date:   Thu, 21 Feb 2019 16:17:36 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] lib/string: Fix erroneous 'overflow' documentation
Message-ID: <20190221051736.GD11758@eros.localdomain>
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-3-tobin@kernel.org>
 <CAGXu5jJcf8S3vS5d7B9oC2V7F6Gjbeu5vUCQiAFXTzeXcrno0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJcf8S3vS5d7B9oC2V7F6Gjbeu5vUCQiAFXTzeXcrno0w@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:02:37PM -0800, Kees Cook wrote:
> On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
> >
> > Current documentation uses 'overflow' to describe a situation where less
> > data is written to a buffer than buffer size not more.  'overflow' is
> > the wrong word here - since we don't typically say 'underflow' change
> > the whole sentence.
> >
> > Fix erroneous 'overflow' documentation for under filled buffer.
> >
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  lib/string.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/string.c b/lib/string.c
> > index 38e4ca08e757..7f1d72db53c5 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -173,8 +173,8 @@ EXPORT_SYMBOL(strlcpy);
> >   *
> >   * Preferred to strncpy() since it always returns a valid string, and
> >   * doesn't unnecessarily force the tail of the destination buffer to be
> > - * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
> > - * with an overflow test, then just memset() the tail of the dest buffer.
> > + * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy(),
> > + * check the return size, then just memset() the tail of the dest buffer.
> >   */
> 
> I'd just fold this patch into the strscpy_zeroed() patch. No need for
> a kind of "no op" change here when we'll just change it again with a
> better advice ("use strscpy_zeroed()!")

Got it.

thanks,
Tobin.
