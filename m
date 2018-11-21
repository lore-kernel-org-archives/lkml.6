Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2541EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E198E204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E198E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbeKVH6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:58:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34780 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbeKVH6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:58:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6170420D73; Wed, 21 Nov 2018 22:22:07 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 387E720510;
        Wed, 21 Nov 2018 22:21:57 +0100 (CET)
Date:   Wed, 21 Nov 2018 22:21:57 +0100
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
Message-ID: <20181121212157.GD12656@piout.net>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
 <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
 <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
 <20181121164820.GC12656@piout.net>
 <CAL_JsqLO_L+rTZh70nrpBMU1+CYKct7HhNY0gLGUnU7=JVRuQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLO_L+rTZh70nrpBMU1+CYKct7HhNY0gLGUnU7=JVRuQw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 14:52:29-0600, Rob Herring wrote:
> On Wed, Nov 21, 2018 at 10:48 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hi Rob,
> >
> > On 21/11/2018 10:41:01-0600, Rob Herring wrote:
> > > > +Optional properties in serial and SPI mode:
> > > > +- dma bindings for dma transfer:
> > > > +       - dmas: DMA specifier, consisting of a phandle to DMA controller node,
> > > > +               memory peripheral interface and USART DMA channel ID, FIFO configuration.
> > > > +               Refer to dma.txt and atmel-dma.txt for details.
> > > > +       - dma-names: "rx" for RX channel, "tx" for TX channel.
> > >
> > > > +               dma-names = "tx", "rx";
> > >
> > > The dma-names should have a defined order.
> > >
> >
> > Why is that? Isn't the purpose of names to get rid of any particular
> > ordering?
> 
> Because a fundamental rule of DT is the order is defined and
> important. The purpose was to allow for cases that had a variable
> number of entries, but even a variable number still have a defined
> order.
> 

Thank you for the clarification!


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
