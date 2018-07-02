Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DB7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8125A252B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8125A252B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbeGBKun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:50:43 -0400
Received: from muru.com ([72.249.23.125]:49492 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753124AbeGBKul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:50:41 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 15A388047;
        Mon,  2 Jul 2018 10:53:35 +0000 (UTC)
Date:   Mon, 2 Jul 2018 03:50:38 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Robert Nelson <robertcnelson@gmail.com>
Cc:     Faiz Abbas <faiz_abbas@ti.com>,
        linux kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] ARM: dts: am33xx: Add pinmux data for mmc1 in
 am335x-evm, evmsk and beaglebone
Message-ID: <20180702105037.GQ112168@atomide.com>
References: <1523447304-21037-1-git-send-email-faiz_abbas@ti.com>
 <CAOCHtYjrgRTAz4ZfkQVWL0YzC8SGbC9p1b8VYJ1TWLy5JXs3mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCHtYjrgRTAz4ZfkQVWL0YzC8SGbC9p1b8VYJ1TWLy5JXs3mQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Nelson <robertcnelson@gmail.com> [180618 14:00]:
> On Wed, Apr 11, 2018 at 6:48 AM, Faiz Abbas <faiz_abbas@ti.com> wrote:
> > am335x-evm, am335x-evmsk and am335x-beaglebone are currently relying on
> > pinmux set by the bootloader to set the correct value for mmc1. Fix
> > this by adding pinmux data for the same in kernel.
> >
> > Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> > ---
> >  arch/arm/boot/dts/am335x-bone-common.dtsi | 9 ++++++++-
> >  arch/arm/boot/dts/am335x-evm.dts          | 9 ++++++++-
> >  arch/arm/boot/dts/am335x-evmsk.dts        | 9 ++++++++-
> >  3 files changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> > index e67b4d6..f9e8667 100644
> > --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> > +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> > @@ -161,7 +161,14 @@
> >
> >         mmc1_pins: pinmux_mmc1_pins {
> >                 pinctrl-single,pins = <
> > -                       AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* GPIO0_6 */
> > +                       AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)              /* spio0_cs1.gpio0_6 */
> > +                       AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat0.mmc0_dat0 */
> > +                       AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat1.mmc0_dat1 */
> > +                       AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat2.mmc0_dat2 */
> > +                       AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat3.mmc0_dat3 */
> > +                       AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_cmd.mmc0_cmd */
> > +                       AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_clk.mmc0_clk */
> > +                       AM33XX_IOPAD(0x9a0, PIN_INPUT | MUX_MODE4)              /* mcasp0_aclkr.mmc0_sdwp */
> 
> We went one pin too far on the Beagle's here:
> 
> 0x9a0 ( mcasp0_aclkr.mmc0_sdwp ) = Routed to P9_42, (muxed with C18,
> to a shared pin on the header), so not connected to the microSD
> socket...
> 
> https://github.com/beagleboard/beaglebone-black/blob/master/BBB_SCH.pdf
> 
> Looking at this evm schematic, it looks like 0x9a0 should be removed
> too, but I'm not sure on all revisions:
> 
> http://processors.wiki.ti.com/images/a/a2/TMDSSK3358_3H0009_REV1_2B_SCH.pdf

Hmm care to post a fix for this?

Regards,

Tony
