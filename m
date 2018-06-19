Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2801C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906D7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906D7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeFSXVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:21:51 -0400
Received: from gloria.sntech.de ([95.129.55.99]:51682 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeFSXVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:21:47 -0400
Received: from ip5f5a8448.dynamic.kabel-deutschland.de ([95.90.132.72] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fVPwK-00069o-My; Wed, 20 Jun 2018 01:21:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
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
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector Firefly-RK3399
Date:   Wed, 20 Jun 2018 01:21:31 +0200
Message-ID: <10782218.jfpm9omiT7@phil>
In-Reply-To: <19360053.2ABrQ075F2@phil>
References: <20180604171523.28454-1-xypron.glpk@gmx.de> <19360053.2ABrQ075F2@phil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heinrich,

Am Donnerstag, 14. Juni 2018, 14:55:27 CEST schrieb Heiko Stuebner:
> Am Montag, 4. Juni 2018, 19:15:23 CEST schrieb Heinrich Schuchardt:
> > Without this patch the Firefly-RK3399 board boot process hangs after these
> > lines:
> > 
> >    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
> >    fan53555-reg: supplied by vcc_sys
> >    vcc1v8_s3: supplied by vcc_1v8
> > 
> > Blacklisting driver fan53555 allows booting.
> > 
> > The device tree uses a value of fcs,suspend-voltage-selector different to
> > any other board.
> > 
> > Changing this setting to the usual value is sufficient to enable booting.
> > 
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> applied for 4.19.

and dropped again.

Sadly it looks like the patch causes conflicts with at least one firefly
board in a kernelci lab. My own is currently not ready to use, so I cannot
look myself right now.

The issue kernelci people described sounded quite a lot like the one
in your commit message, so my current theory is that the
suspend-voltage-selector must in some form corespond to the
cpu_b_sleep_h gpio setting we're currently not handling at all, which
would therefore depend on how the bootloader sets this up.


Heiko


