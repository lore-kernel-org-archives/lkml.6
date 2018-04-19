Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeDSKDQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:03:16 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:16035 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeDSKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:03:14 -0400
X-IronPort-AV: E=Sophos;i="5.48,468,1517900400";
   d="scan'208";a="13414658"
Message-ID: <68cdbb8b60c32980caa7b130409d05d28788edd9.camel@microchip.com>
Subject: Re: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
From: Radu Pirea <radu.pirea@microchip.com>
To: Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Date: Thu, 19 Apr 2018 13:04:16 +0300
In-Reply-To: <20180417110358.GD8973@sirena.org.uk>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
         <20180413161117.20274-3-radu.pirea@microchip.com>
         <20180413162327.GE22187@piout.net>
         <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
         <20180413181251.GG22187@piout.net> <20180417110358.GD8973@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 12:03 +0100, Mark Brown wrote:
> On Fri, Apr 13, 2018 at 08:12:51PM +0200, Alexandre Belloni wrote:
> > On 13/04/2018 19:12:54+0200, Nicolas Ferre wrote:
> > > This layout of the hardware is completely different from the
> > > USART one and
> > > it seems to makes sense to address it with a different hardware
> > > description
> > > and so a different compatible string.
> > But then, you can end up with two drivers trying to use the same IP
> > because nothing prevents you from writing a DT with both a usart
> > and an
> > spi node enabled for the same IP. request_mem_region() will not
> > help
> > here because then the working driver will depend on the probing
> > order.
> 
> We don't really have too much in the way of better ideas for how to
> handle this though.  Take a look at how the PXA SSP stuff handles
> this,
> though that's not really doing too much different it at least layers
> a
> mechanism on top to avoid collisions.
Hi Mark,

Thank you for suggestions. I followed your advice and looked at PXA SSP
driver. In my opinion it is a layer that avoids collsions and
unfortunately complicates things a bit. My ideea is to keep the things
as simple as possible. For example, I can enhance usart-serial and
usart-spi drivers to print detailed messages if probe fails because one
driver tries to request a memory region already used by another driver.
What do you think? Is this approach a good way to move forward?
