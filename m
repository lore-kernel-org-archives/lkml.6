Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC69EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE1420846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE1420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933262AbeFULhy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:37:54 -0400
Received: from gloria.sntech.de ([95.129.55.99]:50554 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933009AbeFULhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:37:52 -0400
Received: from wd0142.dip.tu-dresden.de ([141.76.108.142] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fVxu8-0001xZ-HL; Thu, 21 Jun 2018 13:37:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     khilman@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vagrant Cascadian <vagrant@debian.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector Firefly-RK3399
Date:   Thu, 21 Jun 2018 13:37:26 +0200
Message-ID: <5740207.Zs2D9gmsc0@phil>
In-Reply-To: <3b6e37c8-0ee2-1723-1aa8-499fcb30471c@gmx.de>
References: <20180604171523.28454-1-xypron.glpk@gmx.de> <cd7447bc-1c3d-29ca-9671-144b1f474711@gmx.de> <3b6e37c8-0ee2-1723-1aa8-499fcb30471c@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 21. Juni 2018, 02:57:02 CEST schrieb Heinrich Schuchardt:
> On 06/20/2018 09:57 PM, Heinrich Schuchardt wrote:
> > On 06/20/2018 11:15 AM, Heiko Stübner wrote:
> >> Hi Heinrich,
> >>
> >> Am Mittwoch, 20. Juni 2018, 07:59:34 CEST schrieb Heinrich Schuchardt:
> >>> On 06/20/2018 01:21 AM, Heiko Stuebner wrote:
> >>>> Am Donnerstag, 14. Juni 2018, 14:55:27 CEST schrieb Heiko Stuebner:
> >>>>> Am Montag, 4. Juni 2018, 19:15:23 CEST schrieb Heinrich Schuchardt:
> >>>>>> Without this patch the Firefly-RK3399 board boot process hangs after
> >>>>>> these
> >>>>>>
> >>>>>> lines:
> >>>>>>    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
> >>>>>>    fan53555-reg: supplied by vcc_sys
> >>>>>>    vcc1v8_s3: supplied by vcc_1v8
> >>>>>>
> >>>>>> Blacklisting driver fan53555 allows booting.
> >>>>>>
> >>>>>> The device tree uses a value of fcs,suspend-voltage-selector different
> >>>>>> to
> >>>>>> any other board.
> >>>>>>
> >>>>>> Changing this setting to the usual value is sufficient to enable
> >>>>>> booting.
> >>>>>>
> >>>>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>>>
> >>>>> applied for 4.19.
> >>>>
> >>>> and dropped again.
> >>>>
> >>>> Sadly it looks like the patch causes conflicts with at least one firefly
> >>>> board in a kernelci lab. My own is currently not ready to use, so I cannot
> >>>> look myself right now.
> >>>>
> >>>> The issue kernelci people described sounded quite a lot like the one
> >>>> in your commit message, so my current theory is that the
> >>>> suspend-voltage-selector must in some form corespond to the
> >>>> cpu_b_sleep_h gpio setting we're currently not handling at all, which
> >>>> would therefore depend on how the bootloader sets this up.
> >>>
> >>> please, provide a link to the log displaying the issue and the contact
> >>> who can provide the exact setup.
> >>>
> >>> I have been testing with U-Boot as boot loader.
> >>
> >> failing boot can be found on
> >> https://kernelci.org/boot/id/5b2a053d59b514569079a872/
> >>
> >> As this board is sitting in the "lab-baylibre-seattle", I guess
> >> Kevin Hilman (Cc'ed now) is the one that can say a bit more about the
> >> board setup.
> >>
> >>
> >> The more interesting question would be how to make sure we don't
> >> die with possible different bootloader versions. As I don't really thing 
> >> "upgrade your bootloader" is an always valid option.
> >>
> >>
> >> Heiko
> >>
> > 
> > Hi Kevin,
> > 
> > the RK3399-Firefly was booted on lab-baylibre-seattle with
> > U-Boot 2017.05-rc3-00131-gf79fd58d5f5c-dirty
> > 
> > f79fd58d5f5c is not a commit in U-Boot master.
> > The version number tells us it is 131 patches ahead of U-Boot 2017.05-rc3.
> > Dirty means the source contained uncommitted changes.
> > 
> > Unfortunately this is not a reproducible test environment.
> > Could you, please, provide the build recipe to reproduce the U-Boot
> > BayLibre is using?
> > Would it be possible to use mainline U-Boot in kernelci for this board?
> > 
> > Best regards
> > 
> > Heinrich
> > 
> 
> I have now built the last available release of U-Boot (v2018.05)
> according to the following recipe:
> 
> git clone https://github.com/xypron/u-boot-build.git
> cd u-boot-build/
> git checkout firefly-rk3399-rkloader
> # commit 251b12fb4f0eabfff2d0552d0807d8ddc44ae2aa
> # tag firefly-rk3399-rkloader-v2018.05
> make
> make install DESTDIR=foo
> cd foo/usr/lib/u-boot/firefly-rk3399/
> # be careful to specify your SD card as device!
> ./sd_fusing /dev/sdX
> 
> # in U-Boot 2018.05 (Jun 21 2018 - 02:33:12 +0200)
> load mmc 1:1 ${fdt_addr_r} 2018-06-20/rk3399-firefly.dtb
> load mmc 1:1 ${kernel_addr_r} 2018-06-20/Image
> booti ${kernel_addr_r} - ${fdt_addr_r}
> 
> The error observed in kernelci when initializing the FAN53555 driver
> does not occur.
> 
> The console log is here:
> https://gist.github.com/xypron/34b6485deabfc8172f978b5a99705466

For one, the kernelci board uses the uboot SPL not rkloader as 1st stage.
But I also think the real culprit might be the unconfigured cpu_b_sleep_h
gpio. 

So far I haven't seen any code that touches this pin at all, so it is probably
floating and both mine as well as the kernelci board are from an early
production run, so I guess it is possible that either rkloader configures
this pin or some board change between ours and your board could make
the pin take another state.

Requiring replacement of a bootloader still isn't the best way forward,
so my current idea would be to let the driver know the vsel-gpio via the
devicetree and have the driver then make sure the gpio is set correctly
_after_ setting the regulator voltage.


Heiko


