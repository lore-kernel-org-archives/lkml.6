Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0857E21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbfBROfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:35:14 -0500
Received: from muru.com ([72.249.23.125]:39242 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388178AbfBROfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:35:12 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6230B80E4;
        Mon, 18 Feb 2019 14:35:21 +0000 (UTC)
Date:   Mon, 18 Feb 2019 06:35:08 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     marc.zyngier@arm.com, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190218143508.GD15711@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <41a9780b-d971-2b20-1ecb-c55852292563@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a9780b-d971-2b20-1ecb-c55852292563@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [190216 03:30]:
> On 2/12/2019 1:12 PM, Lokesh Vutla wrote:
> > +TISCI Interrupt Router Node:
> > +----------------------------
> > +- compatible:		Must be "ti,sci-intr".
> > +- interrupt-controller:	Identifies the node as an interrupt controller
> > +- #interrupt-cells:	Specifies the number of cells needed to encode an
> > +			interrupt source. The value should be 4.
> > +			First cell should contain the TISCI device ID of source
> > +			Second cell should contain the interrupt source offset
> > +			within the device
> > +			Third cell specifies the trigger type as defined
> > +			in interrupts.txt in this directory.
> > +			Fourth cell should be 1 if the irq is coming from
> > +			interrupt aggregator else 0.
> > +- ti,sci:		Phandle to TI-SCI compatible System controller node.
> > +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>
> Please help me here. As said this is the TISCI device id for the host
> interrupt controller. While sending message to the system co-processor
> this ID needs to be specified so that the irq route gets discovered and
> configured. Atleast with the current design device Ids are not
> discoverable. Can you mention what can be improved here? Is there any
> such example where a firmware supports querying the deivce ids?
> 
> Also do you have any further comments on this patch?

No reg property above. So if the interrupt router is not accessible
by Linux like you're saying, you should not set up a dts node for
it at all.

Regards,

Tony
