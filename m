Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D80C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391F42147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfBTQgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:36:55 -0500
Received: from muru.com ([72.249.23.125]:39878 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTQgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:36:55 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 94ACD80E1;
        Wed, 20 Feb 2019 16:37:04 +0000 (UTC)
Date:   Wed, 20 Feb 2019 08:36:51 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        jason@lakedaemon.net, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        marc.zyngier@arm.com, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190220163651.GS15711@atomide.com>
References: <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
 <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
 <20190218143245.GC15711@atomide.com>
 <84b3ec21-9ce9-b9a8-80a9-75001db43a90@ti.com>
 <20190219153537.GJ15711@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219153537.GJ15711@atomide.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some more info on chained irq vs mux below that might
help.

* Tony Lindgren <tony@atomide.com> [190219 15:36]:
> * Lokesh Vutla <lokeshvutla@ti.com> [190219 08:51]:
> > With this can you tell me how can we not have a device-tree and still support
> > irq allocation?
> 
> Using standard dts reg property to differentiate the interrupt
> router instances. And if the interrupt router is a mux, you should
> treat it as a mux rather than a chained interrupt controller.
> 
> We do have drivers/mux nowadays, not sure if it helps in this case
> as at least timer interrupts need to be configured very early.

Adding Linus Walleij to Cc since he posted a good test to
consider if something should use chained (or nested) irq:

"individual masking and ACKing bits and can all be used at the
 same time" [0]

Not sure if we have that documented somewhere?

But seems like the interrupt router should be set up as
a separate mux driver talking with firmware that the
interrupt controller driver calls on request_irq()?

Cheers,

Tony


[0] https://marc.info/?l=linux-omap&m=155065629529311&w=2

