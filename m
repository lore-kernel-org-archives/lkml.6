Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EB4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D70214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D70214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeKVDXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:23:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55120 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbeKVDXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:23:33 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BDD7020D2E; Wed, 21 Nov 2018 17:48:20 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 930BD2037D;
        Wed, 21 Nov 2018 17:48:20 +0100 (CET)
Date:   Wed, 21 Nov 2018 17:48:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     radu_nicolae.pirea@upb.ro,
        Richard Genoud <richard.genoud@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.co>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for
 SPI mode
Message-ID: <20181121164820.GC12656@piout.net>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
 <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
 <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 21/11/2018 10:41:01-0600, Rob Herring wrote:
> > +Optional properties in serial and SPI mode:
> > +- dma bindings for dma transfer:
> > +       - dmas: DMA specifier, consisting of a phandle to DMA controller node,
> > +               memory peripheral interface and USART DMA channel ID, FIFO configuration.
> > +               Refer to dma.txt and atmel-dma.txt for details.
> > +       - dma-names: "rx" for RX channel, "tx" for TX channel.
> 
> > +               dma-names = "tx", "rx";
> 
> The dma-names should have a defined order.
> 

Why is that? Isn't the purpose of names to get rid of any particular
ordering?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
