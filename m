Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812ABC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C7620880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfA1Md4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:33:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51382 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfA1Md4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:33:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7CDD2078C; Mon, 28 Jan 2019 13:33:52 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id B875C20742;
        Mon, 28 Jan 2019 13:33:52 +0100 (CET)
Date:   Mon, 28 Jan 2019 13:33:53 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64-amarula-relic: Add STLM75
 sensor
Message-ID: <20190128123353.zgvrepgqvvselwzb@flea>
References: <20190124175254.27650-1-jagan@amarulasolutions.com>
 <20190125084004.fsbxtpcesb5yaiod@flea>
 <CAMty3ZBmHpsTRXARnT5nf1VcnCmz0QpZ5B8caHONLV0UZdXS9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMty3ZBmHpsTRXARnT5nf1VcnCmz0QpZ5B8caHONLV0UZdXS9Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 12:46:48PM +0530, Jagan Teki wrote:
> On Fri, Jan 25, 2019 at 2:10 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Jan 24, 2019 at 11:22:54PM +0530, Jagan Teki wrote:
> > > Amarula A64 Relic has STLM75 sensor for digital temperature
> > > and thermal watchdog.
> > >
> > > Add support for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Note: the respective driver change is already in mainline
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2e9a41bbc1079776dabe42ed8113b086b99ae56c
> > >
> > >  .../dts/allwinner/sun50i-a64-amarula-relic.dts    | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > index 6cb2b7f0c817..5d942543d978 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> > > @@ -34,6 +34,21 @@
> > >       status = "okay";
> > >  };
> > >
> > > +&i2c0 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&i2c0_pins>;
> > > +     status = "okay";
> > > +
> > > +     temp@48 {
> >
> > That would be sensor@48
> >
> > > +             compatible = "st,stlm75";
> >
> > That compatible isn't documented.
> 
> True, but none of the compatible strings used on the driver doesn't
> documented in binding instead there are documented in
> Documentation/hwmon/lm75.

It doesn't look like a DT binding documentation.

> Don't know the exact reason, do we need to document this in binding
> as well?

Yep

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
