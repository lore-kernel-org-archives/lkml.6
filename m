Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CE0C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7055D20844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfAUTp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:45:56 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:37990 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfAUTp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:45:56 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-66-19-nat.elisa-mobile.fi [85.76.66.19])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 758112006F;
        Mon, 21 Jan 2019 21:45:53 +0200 (EET)
Date:   Mon, 21 Jan 2019 21:45:53 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Arthur Demchenkov <spinal.by@gmail.com>, bcousson@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: n900: fix mmc1 card detect gpio polarity
Message-ID: <20190121194552.GA2792@darkstar.musicnaut.iki.fi>
References: <20190121032109.10220-1-spinal.by@gmail.com>
 <20190121171101.GD5544@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121171101.GD5544@atomide.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 21, 2019 at 09:11:01AM -0800, Tony Lindgren wrote:
> * Arthur Demchenkov <spinal.by@gmail.com> [190121 03:22]:
> > Wrong polarity of card detect GPIO pin leads to the system not
> > booting from external mmc, if the back cover of N900 is closed.
> > When the cover is open the system boots fine.
> > 
> > This wasn't noticed before, because of a bug, which was fixed
> > by commit e63201f19 (mmc: omap_hsmmc: Delete platform data GPIO
> > CD and WP).
> 
> Aaro, does this work for your test case too?

Yeah..

> > Kernels up to 4.19 ignored the card detect GPIO from DT.
> 
> Hmm so should this have a Fixes tag or not?

I think it should as v4.20 is broken.

A.

> Regards,
> 
> Tony
> 
> >  arch/arm/boot/dts/omap3-n900.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> > index 182a53991c90..826920e6b878 100644
> > --- a/arch/arm/boot/dts/omap3-n900.dts
> > +++ b/arch/arm/boot/dts/omap3-n900.dts
> > @@ -814,7 +814,7 @@
> >  	/* For debugging, it is often good idea to remove this GPIO.
> >  	   It means you can remove back cover (to reboot by removing
> >  	   battery) and still use the MMC card. */
> > -	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
> > +	cd-gpios = <&gpio6 0 GPIO_ACTIVE_LOW>; /* 160 */
> >  };
> >  
> >  /* most boards use vaux3, only some old versions use vmmc2 instead */
> > -- 
> > 2.11.0
> > 
