Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531E8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1432920872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1432920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbeFTJQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:16:20 -0400
Received: from gloria.sntech.de ([95.129.55.99]:32774 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754113AbeFTJQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:16:17 -0400
Received: from ip5f5a8448.dynamic.kabel-deutschland.de ([95.90.132.72] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fVZDV-0001D1-5i; Wed, 20 Jun 2018 11:15:53 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector Firefly-RK3399
Date:   Wed, 20 Jun 2018 11:15:52 +0200
Message-ID: <6592028.l3WmXB2ndK@diego>
In-Reply-To: <459cb125-a3e2-8f1e-b960-011020d41b3c@gmx.de>
References: <20180604171523.28454-1-xypron.glpk@gmx.de> <10782218.jfpm9omiT7@phil> <459cb125-a3e2-8f1e-b960-011020d41b3c@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heinrich,

Am Mittwoch, 20. Juni 2018, 07:59:34 CEST schrieb Heinrich Schuchardt:
> On 06/20/2018 01:21 AM, Heiko Stuebner wrote:
> > Am Donnerstag, 14. Juni 2018, 14:55:27 CEST schrieb Heiko Stuebner:
> >> Am Montag, 4. Juni 2018, 19:15:23 CEST schrieb Heinrich Schuchardt:
> >>> Without this patch the Firefly-RK3399 board boot process hangs after
> >>> these
> >>> 
> >>> lines:
> >>>    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
> >>>    fan53555-reg: supplied by vcc_sys
> >>>    vcc1v8_s3: supplied by vcc_1v8
> >>> 
> >>> Blacklisting driver fan53555 allows booting.
> >>> 
> >>> The device tree uses a value of fcs,suspend-voltage-selector different
> >>> to
> >>> any other board.
> >>> 
> >>> Changing this setting to the usual value is sufficient to enable
> >>> booting.
> >>> 
> >>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> 
> >> applied for 4.19.
> > 
> > and dropped again.
> > 
> > Sadly it looks like the patch causes conflicts with at least one firefly
> > board in a kernelci lab. My own is currently not ready to use, so I cannot
> > look myself right now.
> > 
> > The issue kernelci people described sounded quite a lot like the one
> > in your commit message, so my current theory is that the
> > suspend-voltage-selector must in some form corespond to the
> > cpu_b_sleep_h gpio setting we're currently not handling at all, which
> > would therefore depend on how the bootloader sets this up.
>
> please, provide a link to the log displaying the issue and the contact
> who can provide the exact setup.
> 
> I have been testing with U-Boot as boot loader.

failing boot can be found on
https://kernelci.org/boot/id/5b2a053d59b514569079a872/

As this board is sitting in the "lab-baylibre-seattle", I guess
Kevin Hilman (Cc'ed now) is the one that can say a bit more about the
board setup.


The more interesting question would be how to make sure we don't
die with possible different bootloader versions. As I don't really thing 
"upgrade your bootloader" is an always valid option.


Heiko


