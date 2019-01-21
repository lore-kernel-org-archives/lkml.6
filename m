Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C8EC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DB720870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfAUQg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:36:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57711 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfAUQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:36:26 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1glcYh-0005TT-Vh; Mon, 21 Jan 2019 17:36:23 +0100
Message-ID: <1548088583.3287.14.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] reset: Add Broadcom STB SW_INIT reset controller
 driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Scott Branden <scott.branden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 21 Jan 2019 17:36:23 +0100
In-Reply-To: <7bc8d9ee-5be1-1765-55dd-b7407cff962f@broadcom.com>
References: <20190115184406.3164-1-f.fainelli@gmail.com>
         <20190115184406.3164-3-f.fainelli@gmail.com>
         <7bc8d9ee-5be1-1765-55dd-b7407cff962f@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On Wed, 2019-01-16 at 10:15 -0800, Scott Branden wrote:
> On 2019-01-15 10:44 a.m., Florian Fainelli wrote:
> > Add support for resetting blocks through the Linux reset controller
> > subsystem when reset lines are provided through a SW_INIT-style reset
> > controller on Broadcom STB SoCs.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >   drivers/reset/Kconfig         |   7 ++
> >   drivers/reset/Makefile        |   1 +
> >   drivers/reset/reset-brcmstb.c | 130 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 138 insertions(+)
> >   create mode 100644 drivers/reset/reset-brcmstb.c
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 2e01bd833ffd..1ca03c57e049 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -40,6 +40,13 @@ config RESET_BERLIN
> >   	help
> >   	  This enables the reset controller driver for Marvell Berlin SoCs.
> >   
> > +config RESET_BRCMSTB
> > +	bool "Broadcom STB reset controller" if COMPILE_TEST
> 
> Could this even be:
> 
> depends on ARCH_BRCMSTB || COMPILE_TEST

I don't think this is necessary. Since the symbol is non-interactive if
COMPILE_TEST is disabled, it just vanishes when both are disabled.

> > +	default ARCH_BRCMSTB

And if it is actually needed, it defaults to the correct value.

regards
Philipp
