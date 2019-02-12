Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0290C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D3E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfBLQWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:22:52 -0500
Received: from muru.com ([72.249.23.125]:38214 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfBLQWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:22:51 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2625E803A;
        Tue, 12 Feb 2019 16:23:00 +0000 (UTC)
Date:   Tue, 12 Feb 2019 08:22:47 -0800
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
Message-ID: <20190212162247.GK5720@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212074237.2875-6-lokeshvutla@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
> +Example:
> +--------
> +The following example demonstrates both interrupt router node and the consumer
> +node(main gpio) on the AM654 SoC:
> +
> +main_intr: interrupt-controller0 {
> +	compatible = "ti,sci-intr";
> +	interrupt-controller;
> +	interrupt-parent = <&gic500>;
> +	#interrupt-cells = <4>;
> +	ti,sci = <&dmsc>;
> +	ti,sci-dst-id = <56>;
> +	ti,sci-rm-range-girq = <0x1>;
> +};

Can you describe a bit what the "ti,sci-dst-id" is above?

These IDs seem to be listed at at [0] below, but is it really a property
of the hardware? Or is it some enumeration of SoC devices in the firmware?

Regards,

Tony


[0] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/irq_dsts.html
