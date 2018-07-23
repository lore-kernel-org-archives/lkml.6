Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475B320874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475B320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbeGWIVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:21:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42587 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387775AbeGWIVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:21:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3FCB8207B0; Mon, 23 Jul 2018 09:22:02 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0B279206A6;
        Mon, 23 Jul 2018 09:21:52 +0200 (CEST)
Date:   Mon, 23 Jul 2018 09:21:52 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        Nadav Haklai <nadavh@marvell.com>, oferh@marvell.com,
        igall@marvell.com
Subject: Re: [PATCH 13/14] arm64: dts: marvell: armada-cp110: update the
 crypto engine compatible
Message-ID: <20180723072152.GA3456@kwain>
References: <20180628151544.22134-1-antoine.tenart@bootlin.com>
 <20180628151544.22134-14-antoine.tenart@bootlin.com>
 <CAOesGMjx_Qprh+4Y6GM4BqGOeJtKWwAhkFNvBz0PGqQkyuRtrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOesGMjx_Qprh+4Y6GM4BqGOeJtKWwAhkFNvBz0PGqQkyuRtrw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Sat, Jul 21, 2018 at 02:35:01PM -0700, Olof Johansson wrote:
> On Thu, Jun 28, 2018 at 8:15 AM, Antoine Tenart
> <antoine.tenart@bootlin.com> wrote:
> > New compatibles are now supported by the Inside Secure SafeXcel driver.
> > As they are more specific than the old ones, they should be used
> > whenever possible. This patch updates the Marvell cp110 device tree
> > accordingly.
> >
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> > index 2bf083272a87..bb2914f90048 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> > @@ -427,7 +427,7 @@
> >                 };
> >
> >                 CP110_LABEL(crypto): crypto@800000 {
> > -                       compatible = "inside-secure,safexcel-eip197";
> > +                       compatible = "inside-secure,safexcel-eip197b";
> 
> So the device is still compatible with the less-specific binding,
> right? If so, it should probably have both compatible properties in
> there, not just the more specific one.

Using "safexcel-eip197" as a compatible was a mistake as there's no such
thing as an eip197, they all have minor versions (such as 'b').

I've thought about using the compatible for a less specific binding, but
this isn't true for the other patch, using the compatible ending in
"-eip97". The engine it supports is the most specific one (i.e. with the
largest number of algorithms supported). So it would simply not work,
and as we only have a few device trees supporting the engine as of now,
I thought fixing this by removing the wrong compatible was a better
solution (of course the driver is backward compatible, and using the old
compatibles will still work).

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
