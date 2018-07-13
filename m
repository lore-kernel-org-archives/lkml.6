Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86524ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A502124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A502124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeGMKUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:20:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55628 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeGMKUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:20:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A97BD20741; Fri, 13 Jul 2018 12:06:33 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 80558206A6;
        Fri, 13 Jul 2018 12:06:33 +0200 (CEST)
Date:   Fri, 13 Jul 2018 12:06:33 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, nicolas.ferre@microchip.com,
        lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v10 5/6] spi: at91-usart: add driver for at91-usart as spi
Message-ID: <20180713100633.GR16084@piout.net>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-6-radu.pirea@microchip.com>
 <20180710181559.GG8104@sirena.org.uk>
 <dc410321-5dfd-7c26-2a3e-d2b2840da214@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc410321-5dfd-7c26-2a3e-d2b2840da214@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2018 12:56:22+0300, Radu Pirea wrote:
> 
> 
> On 07/10/2018 09:15 PM, Mark Brown wrote:
> > On Mon, Jun 25, 2018 at 08:22:29PM +0300, Radu Pirea wrote:
> > 
> > This is mostly good, just a couple of small things:
> > 
> > > +config SPI_AT91_USART
> > > +	tristate "Atmel USART Controller SPI driver"
> > > +	depends on HAS_DMA
> > > +	depends on (ARCH_AT91 || COMPILE_TEST)
> > > +	select MFD_AT91_USART
> > 
> > Why is this selecting rather than depending on the MFD like we normally
> > do?
> > 
> 
> Hi Mark,
> 
> If I add depends instead of select, current defconfigs will be broken and
> the proper driver will not be selected. Like this, there is no required
> change in any defconfig. Selecting the serial or spi driver from menuconfig
> makes the MFD completely transparent.

I would say that this is true for the USART part but the SPI part can
use a depends on as it didn't exist before.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
