Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF3AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA90208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA90208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeHAVpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:45:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58001 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729765AbeHAVpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:45:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5867520789; Wed,  1 Aug 2018 21:57:34 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D730720739;
        Wed,  1 Aug 2018 21:57:33 +0200 (CEST)
Date:   Wed, 1 Aug 2018 21:57:33 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: Re: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
Message-ID: <20180801215733.4dfa3a95@bbrezillon>
In-Reply-To: <20180801172747.GJ5509@sirena.org.uk>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
        <20180627131609.13681-6-bugalski.piotr@gmail.com>
        <20180801172747.GJ5509@sirena.org.uk>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, 1 Aug 2018 18:27:47 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jun 27, 2018 at 03:16:08PM +0200, Piotr Bugalski wrote:
> > Kernel contains QSPI driver strongly tied to MTD and nor-flash memory.
> > New spi-mem interface allows usage also other memory types, especially
> > much larger NAND with SPI interface. This driver works as SPI controller
> > and is not related to MTD, however can work with NAND-flash or other
> > peripherals using spi-mem interface.  
> 
> This is fine from a SPI point of view

Cool. There are still 2 things I think should be addressed before
merging the driver:
1/ Fixing the SoB tag to match the author (problem reported by
   Alexandre)
2/ Getting this patch [1] merged and implementing the ->get_name() hook
   in this driver so that SPI NOR devs declared to the MTD layer keep
   the same name after the transition to spi-mem and mtdparts= passed on
   the cmdline keep working. Without this in place we're likely to
   break a few setups :-/.

> but I'd like to apply it directly
> to the SPI tree rather than ack it for merge via the MTD tree - can we
> work something out with a shared branch or something?

Sure, I can provide an immutable tag for you to pull and I'll add my
acks on those patches once the 2 things I mentioned above are
addressed.

Regards,

Boris

[1]https://patchwork.kernel.org/patch/10508693/ 

