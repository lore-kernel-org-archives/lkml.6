Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B7AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E18214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E18214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeHBNiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:38:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46246 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbeHBNiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:38:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2632520756; Thu,  2 Aug 2018 13:48:04 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id A594920717;
        Thu,  2 Aug 2018 13:48:03 +0200 (CEST)
Date:   Thu, 2 Aug 2018 13:48:04 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Piotr Bugalski <pbu@cryptera.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>
Subject: Re: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
Message-ID: <20180802134804.2352ee89@bbrezillon>
In-Reply-To: <6f9ca4f1-6809-2d7d-4d64-6869a4e413cb@exceet.de>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
        <20180627131609.13681-6-bugalski.piotr@gmail.com>
        <20180801172747.GJ5509@sirena.org.uk>
        <20180801215733.4dfa3a95@bbrezillon>
        <20180802101742.GF9117@sirena.org.uk>
        <6f9ca4f1-6809-2d7d-4d64-6869a4e413cb@exceet.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 12:46:36 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> Hi Mark,
> 
> On 02.08.2018 12:17, Mark Brown wrote:
> > On Wed, Aug 01, 2018 at 09:57:33PM +0200, Boris Brezillon wrote:  
> >> Mark Brown <broonie@kernel.org> wrote:  
> >   
> >> 2/ Getting this patch [1] merged and implementing the ->get_name() hook
> >>     in this driver so that SPI NOR devs declared to the MTD layer keep
> >>     the same name after the transition to spi-mem and mtdparts= passed on
> >>     the cmdline keep working. Without this in place we're likely to
> >>     break a few setups :-/.  
> >   
> >> [1]https://patchwork.kernel.org/patch/10508693/  
> > 
> > I don't seem to have a copy of this patch...  not sure it was sent to
> > me?  
> 
> When I sent the patch I put you in cc. So if nothing went wrong you 
> should have it.
> It is part of the SPI MEM conversion series for the FSL QSPI driver [1].
> 
> Boris made some remarks on documentation in v2, that I have fixed, but 
> not sent out yet, as we have some blocking issues with the driver itself.

I don't remember where we were stuck. Are you still waiting answers
from Yogesh? Probably a good time to ping him if that's the case ;-).

> 
> So if you want I could send the patch separately so it can be applied 
> with the Atmel driver.

Yes please, send a v3 for patch 1 and 2.
