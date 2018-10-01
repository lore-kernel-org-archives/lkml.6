Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42765C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D38C20833
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 02:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HNKitz/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D38C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeJAJPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 05:15:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49959 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeJAJPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 05:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=GZ/rk/85NbBa0c92rLzr1BHEU6re5yZOYnzz8NEDv3g=;
        b=HNKitz/Wa967ymOnUAnStAlZPDx6f/3zxqhUNPT9ATxVOTv5X1uCXfYZQY5z6GbDPEwTcmHBfnlXe0fPFWMzEK/8FVTdm77WnzyQJNSJVgqLAA4m+yPSOGERj9MfeQXI+bhqWnEGj/Adtg3WUeBfi/Zcq5UETk8CihBUE3VOD3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g6o7f-0001Pt-Uh; Mon, 01 Oct 2018 04:39:47 +0200
Date:   Mon, 1 Oct 2018 04:39:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alex Xu <alex_y_xu@yahoo.ca>
Cc:     Daan Wendelen <daanwendelen@gmail.com>, netdev@vger.kernel.org,
        hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] r8169: always autoneg on resume
Message-ID: <20181001023947.GA4943@lunn.ch>
References: <1538319728.z22jaatdgh.astroid@alex-desktop.none>
 <20180930221751.rd7wva3zolephj6q@scappy>
 <153834665886.421.6376790866713055481@pink.alxu.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153834665886.421.6376790866713055481@pink.alxu.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 10:30:58PM +0000, Alex Xu wrote:
> Quoting Daan Wendelen (2018-09-30 22:17:51)
> > Hi Alex,
> > 
> > I randomly opened your patch even though I have absolutely no idea what this patch is about, but I
> > found a mistake in one of the comments:
> > 
> > On Sun, Sep 30, 2018 at 11:06:39AM -0400, Alex Xu (Hello71) wrote:
> > > This affects at least versions 25 and 33, so assume all cards are broken
> >                      ...
> > >        * 1GBit link after resuming from S3. For whatever reason the PHY on
> > > -      * this chip doesn't properly start a renegotiation when soft-reset.
> > > +      * these chips doesn't properly start a renegotiation when soft-reset.
> >                        ~~~~~~~ 
> > I believe it should be "these chips don't"
> > 
> > With kind regards,
> > Daan
> 
> The grammar is correct as is. The subject of the sentence is "the PHY",
> which is singular. However, I think it should be "the PHYs" instead,
> assuming that they are different.

I keep reading the patch wrong, so here is the end state:

        /* It was reported that several chips end up with 10MBit/Half on a
         * 1GBit link after resuming from S3. For whatever reason the PHY on
         * these chips doesn't properly start a renegotiation when soft-reset.
         * Explicitly requesting a renegotiation fixes this.
         */

I would also say 'don't'. For me the subject is 'PHY on these chips',
which is plural.

However:

For whatever reason the PHY, on these chips, doesn't properly start a
renegotiation when soft-reset.

Now just 'the PHY' is the subject, so singular.

But i'm just a native speaker who never actually learnt the rules of
grammar, it just sounds right or wrong, and i have no idea why.

	 Andrew
