Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B701205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B701205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeIFJnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 05:43:51 -0400
Received: from mailoutvs43.siol.net ([185.57.226.234]:48763 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725851AbeIFJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 05:43:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id D7EA7520396;
        Thu,  6 Sep 2018 07:10:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id I7K_M70Ue4Zj; Thu,  6 Sep 2018 07:10:11 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4CD5A52034C;
        Thu,  6 Sep 2018 07:10:11 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id A22A3520396;
        Thu,  6 Sep 2018 07:10:07 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/4] clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
Date:   Thu, 06 Sep 2018 07:10:06 +0200
Message-ID: <2955967.qdhifWMYUT@jernej-laptop>
In-Reply-To: <20180905070335.dclhpxjld4vdkdu4@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com> <20180905070335.dclhpxjld4vdkdu4@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 05. september 2018 ob 09:03:35 CEST je Maxime Ripard napisal(a):
> On Tue, Sep 04, 2018 at 10:06:06PM +0530, Jagan Teki wrote:
> > Allwinner SoC like SUN8I and SUN50I has DE2 CCU so enable them
> > as default.
> > 
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v4, v3:
> > - none
> > Changes for v2:
> > - Enable for MACH_SUN8I
> > 
> >  drivers/clk/sunxi-ng/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> > index 826674d090fd..e20182aa9748 100644
> > --- a/drivers/clk/sunxi-ng/Kconfig
> > +++ b/drivers/clk/sunxi-ng/Kconfig
> > @@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
> > 
> >  config SUN8I_DE2_CCU
> >  
> >  	bool "Support for the Allwinner SoCs DE2 CCU"
> > 
> > +	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> > +	depends on DRM_SUN4I && (MACH_SUN8I || (ARM64 && ARCH_SUNXI))
> 
> I don't see why there's a dependency on the DRM driver. I'm pretty
> sure this would even break simplefb.

I think best approach would be that SUN8I_MIXER selects (or depends on?) this 
symbol, since it can't work if there is no DE2 CCU clock present.

Best regards,
Jernej



