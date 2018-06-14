Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 07AD8C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCAF208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCAF208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754911AbeFNIc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:32:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43152 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbeFNIcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:32:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7BB5520719; Thu, 14 Jun 2018 10:32:21 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 52D1C203EB;
        Thu, 14 Jun 2018 10:32:21 +0200 (CEST)
Date:   Thu, 14 Jun 2018 10:32:20 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     broonie@kernel.org, nicolas.ferre@microchip.com,
        lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 3/6] mfd: at91-usart: added mfd driver for usart
Message-ID: <20180614083220.GU10521@piout.net>
References: <20180613163621.23995-1-radu.pirea@microchip.com>
 <20180613163621.23995-4-radu.pirea@microchip.com>
 <20180614075849.dfiqwcu6rtzgpzq7@rfolt0960.corp.atmel.com>
 <1086330e-40e4-8d9b-50aa-1ae9bf48aa22@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086330e-40e4-8d9b-50aa-1ae9bf48aa22@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2018 11:22:25+0300, Radu Pirea wrote:
> On 06/14/2018 10:58 AM, Ludovic Desroches wrote:
> > > +static int at91_usart_mode_probe(struct platform_device *pdev)
> > > +{
> > > +	struct mfd_cell cell;
> > > +	u32 opmode = AT91_USART_MODE_SERIAL;
> > > +
> > > +	device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> > > +
> > > +	switch (opmode) {
> > > +	case AT91_USART_MODE_SPI:
> > > +		cell = at91_usart_spi_subdev;
> > > +		break;
> > > +	case AT91_USART_MODE_SERIAL:
> > > +		cell = at91_usart_serial_subdev;
> > > +		break;
> > > +	default:
> > > +		break;
> > 
> > If there is an invalid opmode from the DT, you will pass a non initialized cell
> > to mfd_add_device().
> > 
> > Regards
> > 
> > Ludovic
> 
> Hi Ludovic,
> 
> Tnx. That's true. How is better to do if atmel,usart-mode has an invalid
> value? To initialize cell with at91_usart_serial_subdev or to print an error
> message and return -EINVAL?
> 

Returning an error is probably the correct choice because it means the
DT has an invalid value (something was done and is wrong).

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
