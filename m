Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03996C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2CF20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="iLM5ytMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2CF20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632835AbeKXCwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:52:37 -0500
Received: from mail-sender200.upb.ro ([141.85.13.200]:57056 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2632803AbeKXCwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:52:36 -0500
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id A3364B560086;
        Fri, 23 Nov 2018 18:07:45 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id 87834B560085;
        Fri, 23 Nov 2018 18:07:45 +0200 (EET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro 87834B560085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1542989265;
        bh=N17DbxNe5WtsCQE9/8kAJPUPENgcF3M5cvkfvxL4RE0=;
        h=Message-ID:From:To:Date:Mime-Version;
        b=iLM5ytMGzrAKDSE8sfKtZW7KsBAl7zX9CJSEsZGO6h244dAkbaDwiMP12SmDWtWef
         PQoN1VaJ2mvVfm5WFrNKyh1BcG3DRgGZBaYgcYd8F0tngRoWh7f83DbX8icXhPgKvJ
         S7JWfrslVrVxkgJzmKtIz5uPn0ZkxVuLjly9N3jg=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7rGEMjQiBLNf; Fri, 23 Nov 2018 18:07:45 +0200 (EET)
Received: from asus-rog (arh.pub.ro [141.85.160.17])
        by mx.upb.ro (Postfix) with ESMTPSA id 62A98B560084;
        Fri, 23 Nov 2018 18:07:45 +0200 (EET)
Message-ID: <975b9de554cea6f905afd1f54a2d5510c2e24bd4.camel@upb.ro>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for
 SPI mode
From:   Radu Nicolae Pirea <radu_nicolae.pirea@upb.ro>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.co>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
Date:   Fri, 23 Nov 2018 18:07:40 +0200
In-Reply-To: <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
         <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
         <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-21 at 10:41 -0600, Rob Herring wrote:
> On Wed, Nov 21, 2018 at 5:29 AM Radu Pirea <radu_nicolae.pirea@upb.ro
> > wrote:
> > The bindings for DMA are now common for both drivers of the USART
> > IP.
> > 
> > The node given as an example for USART in SPI mode has been updated
> > in
> > order to include DMA bindings.
> > 
> > Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
> > ---
> >  .../devicetree/bindings/mfd/atmel-usart.txt       | 15 ++++++++++-
> > ----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> > b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> > index 7f0cd72f47d2..8ad008175343 100644
> > --- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> > +++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> > @@ -17,17 +17,19 @@ Required properties for USART in SPI mode:
> >  - cs-gpios: chipselects (internal cs not supported)
> >  - atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-
> > bindings/mfd/at91-usart.h)
> > 
> > +Optional properties in serial and SPI mode:
> > +- dma bindings for dma transfer:
> > +       - dmas: DMA specifier, consisting of a phandle to DMA
> > controller node,
> > +               memory peripheral interface and USART DMA channel
> > ID, FIFO configuration.
> > +               Refer to dma.txt and atmel-dma.txt for details.
> > +       - dma-names: "rx" for RX channel, "tx" for TX channel.
> > +               dma-names = "tx", "rx";
> 
> The dma-names should have a defined order.

Thanks Rob.
I will specify in bindings a fixed order for dmas and dma-names.

> 
> Rob

