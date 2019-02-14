Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F95C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDFC222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439282AbfBNOgD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:36:03 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:52089 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfBNOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:36:03 -0500
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 182E8240005;
        Thu, 14 Feb 2019 14:35:55 +0000 (UTC)
Date:   Thu, 14 Feb 2019 15:35:55 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] arm64: dts: allwinner: h6: orangepi: Add CPU supply
 regulator
Message-ID: <20190214143555.4jago2wp4vojz7rk@flea>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-2-tiny.windzz@gmail.com>
 <20190214134617.b44pa7onf3brmhhj@flea>
 <CAEExFWvG4Vz2KsDnHJ6BL72nD6x=Lp+Hzj+q7LfggzFtzrgRow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAEExFWvG4Vz2KsDnHJ6BL72nD6x=Lp+Hzj+q7LfggzFtzrgRow@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 14, 2019 at 10:07:02PM +0800, Frank Lee wrote:
> On Thu, Feb 14, 2019 at 9:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > Thanks for your patches
> >
> > On Thu, Feb 14, 2019 at 08:09:07AM -0500, Yangtao Li wrote:
> > > The original orangepi use the dcdca to supply the CPU cores. According
> > > to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
> > > In order to support more CPU frequency, slightly increase the voltage
> > > maximum and minimum.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > index b2526dac2fcf..e7aebaf91ede 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > > @@ -159,8 +159,8 @@
> > >
> > >                       reg_dcdca: dcdca {
> > >                               regulator-always-on;
> > > -                             regulator-min-microvolt = <810000>;
> > > -                             regulator-max-microvolt = <1080000>;
> > > +                             regulator-min-microvolt = <800000>;
> > > +                             regulator-max-microvolt = <1160000>;
> >
> > This violates the minimum and maximum recommended voltages in the H6
> > datasheet. Could you clarify why you are doing so (ideally in the
> > commit log)?
>
> In fact, in sunxi's sdk, the actual minimum and maximum voltage of the
> cpu is smaller or larger than the datasheet.
> 
> For some better quality ic, the minimum voltage can be smaller.
> For some poor quality ic, the maximum voltage needs to be increased a little.

Ok, that should definitely be part of the commit log then :)

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
