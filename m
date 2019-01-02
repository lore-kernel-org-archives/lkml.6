Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1737BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE18C218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hfEVSyJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfABL5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:57:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45038 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfABL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:57:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x02BujgU013169;
        Wed, 2 Jan 2019 05:56:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546430205;
        bh=ekHGi9G6FERg1Fv2mQi03caXGXaIhZBiZ8Gp+bhHbVc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hfEVSyJQyN8oYkMUbkLm9jOhBgBRRmj+SQqee93REvY8dbc3/e2oR70x3I87XMzek
         /hJSmwtdrIOWvsRY0HwZvQe9DaMTrT1kPCTXioGVBIH5UL9ygHCYasvrDUuBMZcegS
         JMJtfvA1Fa2AAEqTpKZw0e2TGz6k2HsSVbIwqiic=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x02BujF6123473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jan 2019 05:56:45 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 2
 Jan 2019 05:56:44 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 2 Jan 2019 05:56:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x02BufNq012045;
        Wed, 2 Jan 2019 05:56:42 -0600
Subject: Re: [PATCH v4 00/13] Add support for TISCI irqchip drivers
To:     Lokesh Vutla <lokeshvutla@ti.com>, <marc.zyngier@arm.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <cd50afd7-f093-b2a3-e567-f76af91db76c@ti.com>
Date:   Wed, 2 Jan 2019 13:58:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181227060829.5080-1-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/12/2018 8.08, Lokesh Vutla wrote:
> TI AM65x SoC based on K3 architecture, introduced support for Events
> which are message based interrupts with minimal latency. These events
> are not compatible with regular interrupts and are valid only through
> an event transport lane. An Interrupt Aggregator(INTA) is introduced
> to convert these events to interrupts. INTA can also group 64 events
> into a single interrupt. Now the SoC has many peripherals and a large
> number of event sources (time sync or DMA), the use of events is
> completely dependent on a user's specific application, which drives a
> need for maximum flexibility in which event sources are used in the
> system. It is also completely up to software control as to how the
> events are serviced.
> 
> Because of the huge flexibility there are certain standard peripherals
> (like GPIO etc)where all interrupts cannot be directly corrected to host
> interrupt controller. For this purpose, Interrupt Router(INTR) is
> introduced in the SoC. INTR just does a classic interrupt redirection.
> 
> So the SoC has 3 types of interrupt controllers:
> - GIC500
> - Interrupt Router
> - Interrupt Aggregator
> 
> Below is a diagrammatic view of how SoC integration of these interrupt
> controllers:(https://pastebin.ubuntu.com/p/9ngV3jdGj2/)
> 
> Device Index-x               Device Index-y
>            |                         |
>            |                         |
>                       ....
>             \                       /
>              \                     /
>               \  (global events)  /
>           +---------------------------+   +---------+
>           |                           |   |         |
>           |             INTA          |   |  GPIO   |
>           |                           |   |         |
>           +---------------------------+   +---------+
>                          |   (vint)            |
>                          |                     |
>                         \|/                    |
>           +---------------------------+        |
>           |                           |<-------+
>           |           INTR            |
>           |                           |
>           +---------------------------+
>                          |
>                          |
>                         \|/ (gic irq)
>           +---------------------------+
>           |                           |
>           |             GIC           |
>           |                           |
>           +---------------------------+
> 
> While at it, TISCI abstracts the handling of all above IRQ routes where
> interrupt sources are not directly connected to host interrupt controller.
> That would be configuration of Interrupt Aggregator and Interrupt Router.
> 
> This series adds support for:
> - TISCI commands needed for IRQ configuration
> - Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers

With the compilation fix to drivers/irqchip/irq-ti-sci-inta.c dmatest
and audio works with the series:

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Changes since v3:
> - Fix documentation for Interrupt Router driver
> - Rebased on top of latest next.
> - Fully tested with DMA(using out of tree patches)
> - Fixed a build error with allmodconfig
> 
> Grygorii Strashko (1):
>   firmware: ti_sci: Add support to get TISCI handle using of_phandle
> 
> Lokesh Vutla (11):
>   firmware: ti_sci: Add support for RM core ops
>   firmware: ti_sci: Add support for IRQ management
>   firmware: ti_sci: Add helper apis to manage resources
>   dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
>   irqchip: ti-sci-intr: Add support for Interrupt Router driver
>   genirq/msi: Add support for allocating single MSI for a device
>   genirq/msi: Add support for .msi_unprepare callback
>   soc: ti: Add MSI domain support for K3 Interrupt Aggregator
>   dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
>   irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
>   soc: ti: am6: Enable interrupt controller drivers
> 
> Peter Ujfalusi (1):
>   firmware: ti_sci: Add RM mapping table for am654
> 
>  .../bindings/arm/keystone/ti,sci.txt          |   3 +-
>  .../interrupt-controller/ti,sci-inta.txt      |  74 ++
>  .../interrupt-controller/ti,sci-intr.txt      |  85 ++
>  MAINTAINERS                                   |   4 +
>  drivers/firmware/ti_sci.c                     | 848 ++++++++++++++++++
>  drivers/firmware/ti_sci.h                     | 102 +++
>  drivers/irqchip/Kconfig                       |  23 +
>  drivers/irqchip/Makefile                      |   2 +
>  drivers/irqchip/irq-ti-sci-inta.c             | 561 ++++++++++++
>  drivers/irqchip/irq-ti-sci-intr.c             | 310 +++++++
>  drivers/soc/ti/Kconfig                        |  11 +
>  drivers/soc/ti/Makefile                       |   1 +
>  drivers/soc/ti/k3_inta_msi.c                  | 193 ++++
>  include/linux/irqdomain.h                     |   1 +
>  include/linux/msi.h                           |  12 +
>  include/linux/soc/ti/k3_inta_msi.h            |  22 +
>  include/linux/soc/ti/ti_sci_protocol.h        | 169 ++++
>  kernel/irq/msi.c                              |  72 +-
>  18 files changed, 2470 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>  create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
>  create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
>  create mode 100644 drivers/soc/ti/k3_inta_msi.c
>  create mode 100644 include/linux/soc/ti/k3_inta_msi.h
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
