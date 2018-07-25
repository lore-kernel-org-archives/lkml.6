Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386EBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A2B20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A2B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeGYJnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:43:45 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:42466 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeGYJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:43:45 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23991808AbeGYIdGStRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 2 others);
        Wed, 25 Jul 2018 10:33:06 +0200
Date:   Wed, 25 Jul 2018 10:33:05 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Marek Belisko <marek@goldelico.com>,
        =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH 09/32] ARM: dts: omap3-gta04: make NAND partitions
 compatible with recent U-Boot
Message-ID: <20180725083305.GB8303@lenoch>
References: <cover.1532501910.git.hns@goldelico.com>
 <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com>
 <20180725080735.GA7467@lenoch>
 <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 10:18:28AM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 25.07.2018 um 10:07 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > 
> > On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller wrote:
> >> Vendor defined U-Boot has changed the partition scheme a while ago:
> >> 
> >> * kernel partition 6MB
> >> * file system partition uses the remainder up to end of the NAND
> >> * increased size of the environment partition (to get an OneNAND compatible base address)
> >> * shrink the U-Boot partition
> >> 
> >> Let's be compatible (e.g. Debian kernel built from upstream).
> > 
> > That, in fact, is breaking compatibility.
> 
> With what? Nobody is using the old u-boot partition scheme any more
> (it is >5 years old).
> 
> > So once you are touching this
> > what about relying on partitioning provided by bootloader just to prevent
> > something like this happening again?
> 
> Well, we define what compatible means here (since we are the vendor).
> And people complain with us. We simply recommend them to upgrade the
> boot-loader.

Fair enough. Suggestion was to remove partitioning scheme from DTB alltogether
and let U-Boot provide one. But you being vendor you decide, of course :)
(I'd use only two partitions: MLO and UBI, latter one with BCH8, and store
everything in UBI volumes. That's a bit more flexible approach)

	ladis

> BR,
> Nikolaus
> 
> > 
> > 	ladis
> > 
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> ---
> >> arch/arm/boot/dts/omap3-gta04.dtsi | 12 ++++++------
> >> 1 file changed, 6 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> >> index 65f77a0b5dd4..03fe404cbf56 100644
> >> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> >> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> >> @@ -645,22 +645,22 @@
> >> 
> >> 		bootloaders@80000 {
> >> 			label = "U-Boot";
> >> -			reg = <0x80000 0x1e0000>;
> >> +			reg = <0x80000 0x1c0000>;
> >> 		};
> >> 
> >> -		bootloaders_env@260000 {
> >> +		bootloaders_env@240000 {
> >> 			label = "U-Boot Env";
> >> -			reg = <0x260000 0x20000>;
> >> +			reg = <0x240000 0x40000>;
> >> 		};
> >> 
> >> 		kernel@280000 {
> >> 			label = "Kernel";
> >> -			reg = <0x280000 0x400000>;
> >> +			reg = <0x280000 0x600000>;
> >> 		};
> >> 
> >> -		filesystem@680000 {
> >> +		filesystem@880000 {
> >> 			label = "File System";
> >> -			reg = <0x680000 0xf980000>;
> >> +			reg = <0x880000 0>;	/* 0 = MTDPART_SIZ_FULL */
> >> 		};
> >> 	};
> >> };
> >> -- 
> >> 2.12.2
> >> 
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
