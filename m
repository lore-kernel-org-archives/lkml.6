Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5841CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2659D222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QiluadKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfBKRcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:32:07 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53640 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfBKRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l/8BkGwH/DMSeIAmiqUBDgDFHaYCnWW4zMB0yKVQuZs=; b=QiluadKvKtGm4PDlDKgwhcAfT
        R3OaGstbe85cSNbJ3d/tvruljZdE7b5tfrC1SQ2FIAMnbzsgOacDjDl/vFw4c5H5Mwm2W1HlfFlip
        7mdAx7tEyEUfrwUId2W4aCInHBAcAYjGpEQ6m9XvztRgOdOibG7YLNm9SuAvBvkEOlFPI=;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54404)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gtFQz-0007sR-Nh; Mon, 11 Feb 2019 17:31:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gtFQx-0001Lo-Ou; Mon, 11 Feb 2019 17:31:55 +0000
Date:   Mon, 11 Feb 2019 17:31:55 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Alexander Syring <alex@asyring.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: marvell: mcbin: Adding SPI-NOR Flash
 Config
Message-ID: <20190211173155.azppt37uvsd6rn2w@shell.armlinux.org.uk>
References: <20190211171401.434-1-alex@asyring.de>
 <3040714f-471c-6773-57dd-455e7d1f195c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3040714f-471c-6773-57dd-455e7d1f195c@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:27:37PM +0000, Marc Zyngier wrote:
> On 11/02/2019 17:14, Alexander Syring wrote:
> > According to U-Boot dts file enabling the SPI-NOR flash for use in
> > Linux
> > 
> > Signed-off-by: Alexander Syring <alex@asyring.de>
> > ---
> >  .../boot/dts/marvell/armada-8040-mcbin.dtsi   | 23 +++++++++++++++----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> > index 329f8ceeebea..83994ff46e2d 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> > @@ -333,11 +333,24 @@
> >  	status = "okay";
> >  
> >  	spi-flash@0 {
> > -		compatible = "st,w25q32";
> > -		spi-max-frequency = <50000000>;
> > -		reg = <0>;
> > -	};
> > -};
> > +		compatible = "st,w25q32", "jedec,spi-nor";
> > +		reg = <0>;
> > +		spi-max-frequency = <50000000>;
> > +
> > +		partitions {
> > +			compatible = "fixed-partitions";
> > +
> > +			partition@0 {
> > +				label = "U-Boot";
> > +				reg = <0 0x200000>;
> > +			};
> > +			partition@400000 {
> > +				label = "U-Boot Env";
> > +				reg = <0x200000 0xce0000>;
> > +			};
> > +		};
> > +	};
> > +};
> >  
> >  &cp1_usb3_0 {
> >  	/* CPS Lane 2 - CON7 */
> > 
> 
> Really?
> 
> My mcbin SPI flash doesn't have this partitioning, and doesn't have
> u-boot at all. This should be provided by the bootloader itself, and not
> baked into the reference DT.

Exactly.

Simple solution for the above.  Instead of the above, create
/etc/fw_env.config with:

/dev/mtdblock0 0x200000 0x10000

Then its possible to read and write the u-boot environment using
fw_printenv and fw_setenv.  No partitions are required, and IMHO
are pointless for such a scenario.

That will allow those of us with a different SPI flash layout and
already have this in /etc/fw_env.config:

/dev/mtdblock0 0x3f0000 0x10000

to not experience any breakage.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
