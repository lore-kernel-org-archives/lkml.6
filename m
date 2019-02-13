Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF75C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B38222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391873AbfBMP0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:26:25 -0500
Received: from muru.com ([72.249.23.125]:38492 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391841AbfBMP0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:26:25 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4A62480AE;
        Wed, 13 Feb 2019 15:26:33 +0000 (UTC)
Date:   Wed, 13 Feb 2019 07:26:20 -0800
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
Message-ID: <20190213152620.GS5720@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [190213 04:26]:
> Hi Tony,
> 
> On 12/02/19 9:52 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
> >> +Example:
> >> +--------
> >> +The following example demonstrates both interrupt router node and the consumer
> >> +node(main gpio) on the AM654 SoC:
> >> +
> >> +main_intr: interrupt-controller0 {
> >> +	compatible = "ti,sci-intr";
> >> +	interrupt-controller;
> >> +	interrupt-parent = <&gic500>;
> >> +	#interrupt-cells = <4>;
> >> +	ti,sci = <&dmsc>;
> >> +	ti,sci-dst-id = <56>;
> >> +	ti,sci-rm-range-girq = <0x1>;
> >> +};
> > 
> > Can you describe a bit what the "ti,sci-dst-id" is above?
> > 
> > These IDs seem to be listed at at [0] below, but is it really a property
> > of the hardware? Or is it some enumeration of SoC devices in the firmware?
> 
> This is the way that sysfw describes the hardware. In this case it is GIC and it
> is identified by this ID.

If this ID is an enumeration in the sysfw rather than an actual
hardware property it should not be in the device tree. If so,
the device driver should request the id from the sysfw based
on a name. That is, if no struct device or device phandle can
be used.

The problem with using enumeration in the dts is that it
requires maintaining the dts, driver(s) and possibly firmware
in sync. And that might change between SoCs variants when new
devices get added and removed.

Regards,

Tony
