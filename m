Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F89AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CAC223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CAC223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeKLUtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:49:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42939 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbeKLUtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:49:24 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 27A5C207BD; Mon, 12 Nov 2018 11:56:39 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 52A41206D8;
        Mon, 12 Nov 2018 11:56:28 +0100 (CET)
Date:   Mon, 12 Nov 2018 11:56:28 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.De>
Cc:     Olof Johansson <olof@lixom.net>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Brian Norris" <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Eric Anholt <eric@anholt.net>, Stefan Agner <stefan@agner.ch>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "yannick.fertre@st.com" <yannick.fertre@st.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
Message-ID: <20181112115628.68a84b92@bbrezillon>
In-Reply-To: <b01d70ae-9feb-985a-8001-dba54206662d@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
        <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
        <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
        <b12936f5-871d-a982-13c5-9d894f4a1521@kontron.de>
        <20181108093451.08dfe63e@bbrezillon>
        <b01d70ae-9feb-985a-8001-dba54206662d@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 10:46:45 +0000
Schrempf Frieder <frieder.schrempf@kontron.De> wrote:

> On 08.11.18 09:34, Boris Brezillon wrote:
> > On Wed, 7 Nov 2018 16:36:13 +0000
> > Schrempf Frieder <frieder.schrempf@kontron.De> wrote:
> >   
> >> Hi Olof,
> >>
> >> On 07.11.18 17:20, Olof Johansson wrote:  
> >>> On Wed, Nov 7, 2018 at 6:44 AM Frieder Schrempf
> >>> <frieder.schrempf@kontron.de> wrote:  
> >>>>
> >>>> From: Frieder Schrempf <frieder.schrempf@exceet.de>
> >>>>
> >>>> The new driver at spi/spi-fsl-qspi.c replaces the old SPI NOR driver
> >>>> at mtd/fsl-quadspi.c. Switch to the new driver in the defconfigs.
> >>>>
> >>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>  
> >>>
> >>> Hi Frieder,
> >>>
> >>> This patch is part of a series that I didn't see the rest of, but in
> >>> general we prefer to merge these through arm-soc even if the driver
> >>> goes in through another tree. The way we'd prefer to handle it is that
> >>> once the driver lands, we'll take the config option change to turn it
> >>> on. To avoid our branches to break until both sides have landed, it
> >>> might be a good idea to keep both drivers on for a short while (one
> >>> release).
> >>>
> >>> So, I'm not going to ack this since we avoid taking defconfig changes
> >>> through driver trees (these two defconfigs tend to churn a lot and we
> >>> don't want to create merge conflicts where we don't have to), but
> >>> we'll be happy to pick it up when the time comes.  
> >>
> >> Ok, thank you for explaining the common practice. I will drop the config
> >> changes for the next version and send it separately when the time is ready.
> >>
> >> Both the old driver and the new one use the same compatible strings for
> >> probing. Wouldn't that cause problems if both drivers are enabled for a
> >> while, or am I missing something?  
> > 
> > Or maybe we should not introduce a new Kconfig option and just reuse
> > the old one. It probably requires re-ordering patches a bit (patch 1
> > should be moved after patch 5). Then you have 2 choices:
> > 
> > 1/ merge patch 1 and 6 so that the new driver effectively replaces the
> >     old one but uses the same Kconfig option
> > 2/ remove the ability to compile the old driver when the new one is
> >     introduced: remove the line from drivers/mtd/spi-nor Makefile and
> >     move the Kconfig entry from drivers/mtd/spi-nor/Kconfig to
> >     drivers/spi/Kconfig. And remove the old code in a separate patch
> > 
> > I'm fine either way, but option #2 will probably make the patch
> > introducing the new driver bigger and hurt readability.  
> 
> I think having both drivers in the tree for a while wouldn't be so bad. 
> So if any compatibility issues come up with the new driver, people can 
> still use the old one.

Except that's not what happens in practice. Believe me, I tried this
approach several times, and people keep using the old driver until
they're forced to switch to the new one. So you actually don't address
the problem, you just delay it a bit, and you'll have to fix
regressions anyway.

> 
> Therefore I think I will drop the patches that change the defconfig and 
> remove the old driver code and keep the different Kconfig options. And 
> maybe add an exclusive dependency in Kconfig, so both drivers can not be 
> enabled at the same time.
> 
> Does this make sense?

I'd really prefer to have the removal of the old driver in the same
release the new driver is introduced but if that's not possible, let's
have a clear plan, like "introduce new driver in release X, remove the
old one in release X+1".
