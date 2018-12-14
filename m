Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13312C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAD320866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAD320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeLNJWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:22:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53765 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLNJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:22:22 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gXjfg-00007T-GT; Fri, 14 Dec 2018 10:22:12 +0100
Message-ID: <1544779331.3137.36.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Date:   Fri, 14 Dec 2018 10:22:11 +0100
In-Reply-To: <20181214011207.GB13243@dragon>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
         <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
         <1544711727.3137.32.camel@pengutronix.de>
         <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175>
         <20181214011207.GB13243@dragon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Am Freitag, den 14.12.2018, 09:12 +0800 schrieb Shawn Guo:
> On Thu, Dec 13, 2018 at 02:51:50PM +0000, Abel Vesa wrote:
> ...
> > > > diff --git a/arch/arm64/Kconfig.platforms
> > > > b/arch/arm64/Kconfig.platforms
> > > > index 7e1545a..318dbb9 100644
> > > > --- a/arch/arm64/Kconfig.platforms
> > > > +++ b/arch/arm64/Kconfig.platforms
> > > > @@ -148,14 +148,6 @@ config ARCH_MXC
> > > > > > > >  	  This enables support for the ARMv8 based SoCs in the
> > > > > > > >  	  NXP i.MX family.
> > > >  
> > > > -config SOC_IMX8MQ
> > > > > > > > -	bool "i.MX8MQ support"
> > > > > > > > -	depends on ARCH_MXC
> > > > > > > > -	select ARM64_ERRATUM_843419
> > > > > > > > -	select ARM64_ERRATUM_845719
> > > > > > > > -	help
> > > > > > > > -	  This enables support for the i.MX8MQ SoC.
> > > > -
> > > 
> > > NACK on this one. Having a single place where stuff that is absolutely
> > > critical for proper SoC operation can be selected is very useful and
> > > avoids hard to debug issues due to slightly wrong configs in the long
> > > run.
> > 
> > As mentioned in the cover letter, please ignore this patch set entirely.
> > The ARCH_MXC is actually used on arm32 too, so it won't work.
> > 
> > I'm working on a patchset that will add the Kconfig into 
> > drivers/clk/imx/ and in it will add CLK_IMX8MQ. That will
> > fix the clock dependency since the CLK_IMX8MQ will depend on
> > ARCH_MXC and ARM64. I believe the CLK_IMX8QXP will follow
> > the same pattern.
> > 
> > As for the SOC_IMX8MQ, all the other vendors have one single
> > config for all the arm64 platforms. TBH, to control every SoC
> > independently it's a little bit of an overkill.
> 
> Lucas,
> 
> We are still waiting for further comments from Olof [1].  But it sounds
> like SoC specific option is not welcomed on ARM64.

While I personally would prefer to keep the SoC options, I see that we
need to align with the judgment of the arm-soc maintainers.

But at the very least we should keep the select for vital system
workarounds. They need to move to the arch Kconfig symbol in that case
and might select stuff that isn't needed on each of the i.MX8 SoCs. But
better enabling more workaround and drivers than necessary than having
hard to debug system failures in the future.

Regards,
Lucas
