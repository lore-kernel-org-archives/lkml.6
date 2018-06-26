Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915FDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DE32401B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DE32401B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934430AbeFZA2k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:28:40 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40214 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933424AbeFZA2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:28:38 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 1848763445;
        Tue, 26 Jun 2018 00:28:29 +0000 (UTC)
Message-ID: <0b80e778a7c03b5aeeb0e4142895e0e820df3a95.camel@aosc.io>
Subject: Re: [linux-sunxi] [PATCH 2/3] arm64: allwinner: h6: add device tree
 nodes for MMC controllers
From:   Icenowy Zheng <icenowy@aosc.io>
To:     =?ISO-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 26 Jun 2018 08:28:18 +0800
In-Reply-To: <8259b2d9-be02-68fb-90bb-bd0ebdee0b05@arm.com>
References: <20180426140728.43155-1-icenowy@aosc.io>
         <20180426140728.43155-3-icenowy@aosc.io>
         <9571735d-929f-a2ef-ed97-dc9193420b73@arm.com>
         <77DF7884-8DA8-4ED5-BB51-941CFDE4A123@aosc.io>
         <0ae1b6ce-c1cf-61e8-e09b-abec47b089b2@arm.com>
         <6EBD7D16-E985-4345-B2C2-D0CE7B32F8C5@aosc.io>
         <8259b2d9-be02-68fb-90bb-bd0ebdee0b05@arm.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-04-27五的 22:25 +0100，André Przywara写道：
> On 27/04/18 10:23, Icenowy Zheng wrote:
> > 
> > 
> > 于 2018年4月27日 GMT+08:00 下午5:18:23, Andre Przywara <andre.przywara@ar
> > m.com> 写到:
> > > Hi,
> > > 
> > > On 27/04/18 09:36, Icenowy Zheng wrote:
> > > > 
> > > > 
> > > > 于 2018年4月27日 GMT+08:00 上午12:45:38, Andre Przywara
> > > 
> > > <andre.przywara@arm.com> 写到:
> > > > > Hi,
> > > > > 
> > > > > On 26/04/18 15:07, Icenowy Zheng wrote:
> > > > > > The Allwinner H6 SoC have 3 MMC controllers.
> > > > > > 
> > > > > > Add device tree nodes for them.
> > > > > > 
> > > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 56
> > > > > 
> > > > > ++++++++++++++++++++++++++++
> > > > > >  1 file changed, 56 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > 
> > > > > b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > > index 4debc3962830..3cbfc035c979 100644
> > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > > > > @@ -124,12 +124,68 @@
> > > > > >  			interrupt-controller;
> > > > > >  			#interrupt-cells = <3>;
> > > > > >  
> > > > > > +			mmc0_pins: mmc0-pins {
> > > > > > +				pins = "PF0", "PF1",
> > > > > > "PF2", "PF3",
> > > > > > +				       "PF4", "PF5";
> > > > > > +				function = "mmc0";
> > > > > > +				drive-strength = <30>;
> > > > > > +				bias-pull-up;
> > > > > > +			};
> > > > > > +
> > > > > > +			mmc2_pins: mmc2-pins {
> > > > > > +				pins = "PC1", "PC4",
> > > > > > "PC5", "PC6",
> > > > > > +				       "PC7", "PC8",
> > > > > > "PC9", "PC10",
> > > > > > +				       "PC11", "PC12",
> > > > > > "PC13", "PC14";
> > > > > > +				function = "mmc2";
> > > > > > +				drive-strength = <30>;
> > > > > > +				bias-pull-up;
> > > > > > +			};
> > > > > > +
> > > > > >  			uart0_ph_pins: uart0-ph {
> > > > > >  				pins = "PH0", "PH1";
> > > > > >  				function = "uart0";
> > > > > >  			};
> > > > > >  		};
> > > > > >  
> > > > > > +		mmc0: mmc@4020000 {
> > > > > > +			compatible = "allwinner,sun50i-h6-
> > > > > > mmc";
> > > > > 
> > > > > This should be:
> > > > > 			compatible = "allwinner,sun50i-h6-mmc",
> > > > > 				     "allwinner,sun50i-a64-
> > > > > mmc";
> > > > 
> > > > I'm intended to not add A64 compatible, as
> > > > H6 is a quite new design
> > > > (new process) and there might be different behavior, even on
> > > > mmc0/1.
> > > 
> > > But as your patch proves, it is fully backwards compatible: An
> > > A64
> > > driver works with this device.
> > 
> > No, my patch only proves "the current A64 driver works
> > with this device", not "Any A64 driver works with device", as
> > the current driver doesn't fully use the capability provided
> > by A64 MMC cobtrollers.
> 
> Good point, but I still believe every A64 driver would be capable of
> driving an H6 MMC controller, ....
> 
> > > And this is what this compatible string list says: If your system
> > > does
> > > not have a specific H6 driver, you can use an A64 driver.
> > > You might not get all the (potentially) new features, but it
> > > covers
> > > everything the A64 has.
> > > 
> > > And a new silicon process doesn't matter here, since the software
> > > interface is unchanged. *If* we find bugs, we can add quirks
> > > matching
> > 
> > I think there's timing parameters for higher speed bins which
> > are different among chips. As we have currently no support
> > for speed bins higher than DDR50, they're not added yet.
> 
> True, but what are those differences? I compared the A64 and H6
> manuals
> side by side, the differences I found are:
> SMHC_FIFOTH[+0x40]:
> 	BSIZE_OF_TRANS[30:28]:
> 	- H6 supports 16 transfers for SMHC0 also.
> 	other parameters:
> 	- H6 recommends better values for SMHC0 also
> SMHC_CSDC[+0x54]:
> 	- H6 doesn't mention restriction to SMHC2
> 	(though this might be a mistake)
> SMHC_NTSR_REG[+0x5C]:
> 	- H6 defines fields for bits[24:8]
> SMHC_EMCE[+0x64] and SMHC_EMCE_DBG[+0x68]:
> 	- H6 adds, for EMCE support
> EMMC_DDR_SBIT_DET_REG[0x10c]:
> 	- A64 doesn't mention restriction to SMHC2,
> 	  but I believe this is a mistake
> SMHC_EMCE_BMn[0x150 + 0x4 * 0..31]
> 	- H6 adds, for EMCE support
> 
> All those pieces are only *additions* to the H6 over the A64, so
> don't
> affect backwards compatibility.
> 
> > > on
> > > the H6 compatible string - that's why we put it here already,
> > > despite
> > > having a matching string in the kernel at the moment.
> > 
> > Device tree is not driver data but hardware description, so
> > it should follow "how the device is formed" rather than
> > "how the device works".
> 
> True, but as shown above, the compatibility is really at the device
> level.
> Unless you have any other information ...

Rob, could you answer whether we should add the A64 compatible or not?

> 
> Cheers,
> Andre.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
