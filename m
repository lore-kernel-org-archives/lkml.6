Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C87C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC97C222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404483AbfBMQlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:41:17 -0500
Received: from muru.com ([72.249.23.125]:38570 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404221AbfBMQlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:41:17 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9218F80AE;
        Wed, 13 Feb 2019 16:41:25 +0000 (UTC)
Date:   Wed, 13 Feb 2019 08:41:12 -0800
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
Subject: Re: [PATCH v5 09/10] soc: ti: Add MSI domain support for K3
 Interrupt Aggregator
Message-ID: <20190213164112.GW5720@atomide.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-10-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212074237.2875-10-lokeshvutla@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
> With the system coprocessor managing the range allocation of the
> inputs to Interrupt Aggregator, it is difficult to represent
> the device IRQs from DT.
> 
> The suggestion is to use MSI in such cases where devices wants
> to allocate and group interrupts dynamically.
> 
> Create a MSI domain bus layer that allocates and frees MSIs for
> a device.
> 
> APIs that are implemented are:
> - inta_msi_create_irq_domain() that creates a MSI domain
> - inta_msi_domain_alloc_irqs() that creates MSIs for the
>   specified device and source indexes.
> - inta_msi_domain_free_irqs() frees the grouped irqs.

Can you please describe what all code will be calling these
functions?

If the callers are limited to drivers/soc/ti, then you
can can maybe make it local and get rid of the exported
custom functions as it's all built-in anyways.

Or does the dma ring accelerator for example need to call
these?

If various subsystems will be calling these I'd assume
we'd have some generic API.. Marc, any comments on that?

Regards,

Tony
