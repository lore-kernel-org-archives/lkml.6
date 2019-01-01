Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAE5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746B4218DE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfAAMUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 07:20:50 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54380 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbfAAMUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 07:20:50 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1geJ24-0002ZI-9H; Tue, 01 Jan 2019 13:20:28 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     klaus.goger@theobroma-systems.com
Cc:     Pragnesh_Patel@mentor.com, Akash Gajjar <Akash_Gajjar@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>, Levin Du <djw@t-chip.com.cn>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liang Chen <cl@rock-chips.com>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add ROCK Pi 4 DTS support
Date:   Tue, 01 Jan 2019 13:20:26 +0100
Message-ID: <5662913.pS8bTmJHpa@phil>
In-Reply-To: <6B09C29B-CACB-4F71-A812-BE538AE6D996@theobroma-systems.com>
References: <Pragnesh_Patel@mentor.com> <20190101080848.5697-1-Pragnesh_Patel@mentor.com> <6B09C29B-CACB-4F71-A812-BE538AE6D996@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pragnesh, Klaus,

Am Dienstag, 1. Januar 2019, 10:54:55 CET schrieb klaus.goger@theobroma-systems.com:
> > On 01.01.2019, at 09:08, <Pragnesh_Patel@mentor.com> <Pragnesh_Patel@mentor.com> wrote:
> > 
> > From: Akash Gajjar <Akash_Gajjar@mentor.com>
> > 
> > ROCK Pi 4 is RK3399 based SBC from radxa.com. board has a 1G/2G/4G lpddr4, CSI,
> > DSI, HDMI, OTG, USB 2.0, USB 3.0, 10/100/1000 RGMII Ethernet Phy, es8316 codec,
> > POE, WIFI (for Model B only), PCIE M.2 support on board.
> > 
> > This patch enables
> > - HDMI Display
> > - Console
> > - MMC, EMMC
> > - USB 2.0, USB-3.0
> > - Ethernet
> > 
> > Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> > Signed-off-by: Pragnesh Patel <Pragnesh_Patel@mentor.com>

> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index de0c406c20cc..3fab0a3e4eeb 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-inx.dtb
> > dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-kd.dtb
> > dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> > dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
> 
> sort(1) would put it before roc-pc

I'd keep it were it is right now, aka after roc- and before roc960.
Otherwise we would need to resort the whole list to keep it consistent ;-)

And I really want to minimize resorts, so just keep it were it is now
and looks sorted :-D

[...]

> > +	usb2 {
> > +		vcc5v0_host_en: vcc5v0-host-en {
> > +			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +	};
> 
> Maybe use the GPIO bank macros here?
> 1 = RK_GPIO1, 2 = RK_GPIO2 and so forth.

Actually the other way around please :-)
Aka just use numbers for the gpio bank in new files
and the pin defines RK_PD1 for the pins.

The RK_GPIO1 -> 1, etc... defines don't really bring additional
usefulnes, so I encourage not using them in new boards.


> > +&sdmmc {
> > +	bus-width = <4>;
> > +	cap-mmc-highspeed;
> > +	cap-sd-highspeed;
> > +	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
> 
> RK_PA7 for consistency.

yep, here the mapping iomux 4*8 pins <-> gpio controllers (32 pins)
is non intuitive and makes it more difficult, so the defines actually help
in following schematics.


Heiko


