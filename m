Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC724C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8575020664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8575020664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbeKADUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:20:44 -0400
Received: from foss.arm.com ([217.140.101.70]:45570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbeKADUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:20:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D453B80D;
        Wed, 31 Oct 2018 11:21:34 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBD2C3F6A8;
        Wed, 31 Oct 2018 11:21:32 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <2369ea50-55db-c97b-5b43-99d572c97dc9@ti.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
Date:   Wed, 31 Oct 2018 18:21:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2369ea50-55db-c97b-5b43-99d572c97dc9@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grygorii,

On 31/10/18 16:39, Grygorii Strashko wrote:

[...]

> I'd try to provide some additional information here.
> (Sry, I'll still use term "events")
> 
> As Lokesh explained in other mail on K3 SoC everything is generic and most
> of resources allocated dynamicaly:
> - generic DMA channels
> - generic HW rings (used by DMA channel)
> - generic events (assigned to the rings) and muxed to different cores/hosts
> 
> So, when some driver would like to perform DMA transaction It's
> required to build (configure) DMA channel by allocating different type of
> resources and link them together to get finally working Data Movement path
> (situation complicated by ti-sci firmware which policies resources between cores/hosts):
> - get UDMA channel from available range
> - get HW rings and attach them to the UDMA channel
> - get event, assign it to the ring and mux it to the core/host through IA->IR-> chain
>    (and this step is done by ti_sci_inta_register_event() - no DT as everything is dynamic).
> 
> Next, how this is working now - ti_sci_inta_register_event():
> - first call does similar things as regular DT irq mapping (end up calling irq_create_fwspec_mapping()
>    and builds IRQ chain as below:
>    linux_virq = ti_sci_inta_register_event(dev, <ringacc tisci_dev_id>,
> 				<ringacc id>, 0, IRQF_TRIGGER_HIGH, false);
> 
>               +---------------------+
>               |         IA          |
> +--------+   |            +------+ |        +--------+         +------+
> | ring 1 +----->evtA+----->VintX +---------->   IR   +--------->  GIC +-->
> +--------+   |            +------+ |        +--------+         +------+  Linux IRQ Y
>     evtA      |                     |
>               |                     |
>               +---------------------+
> 
> - second call updates only IA input part while keeping other parts of IRQ chain the same
>    if valid <linux_virq> passed as input parameter:
>    linux_virq = ti_sci_inta_register_event(dev, <ringacc tisci_dev_id>,
> 				<ringacc id>, linux_virq, IRQF_TRIGGER_HIGH, false);
>               +---------------------+
>               |         IA          |
> +--------+   |            +------+ |        +--------+         +------+
> | ring 1 +----->evtA+--^-->VintX +---------->   IR   +--------->  GIC +-->
> +--------+   |         |  +------+ |        +--------+         +------+  Linux IRQ Y
>               |         |           |
> +--------+   |         |           |
> | ring 2 +----->evtB+--+           |
> +--------+   |                     |
>               +---------------------+

This is basically equivalent requesting a bunch of MSIs for a single
device, and obtaining a set of corresponding interrupts. The fact that
you end-up muxing them in the IA block is an implementation detail.

> 
>    As per above, irq-ti-sci-inta and tisci fw creates shared IRQ on HW layer by attaching
>    events to already established IA->IR->GIC IRQ chain. Any Rings events will trigger
>    Linux IRQ Y line and keep it active until Rings are not empty.
> 
> Now why this was done this way?
> Note. I'm not saying this is right, but it is the way we've done it as of now. And I hope MSI
> will help to move forward, but I'm not very familiar with it.
> 
> The consumer of this approach is K3 Networking driver, first of all, and
> this approach allows to eliminate runtime overhead in Networking hot path and
> provides possibility to implement driver's specific queues/rings handling policies
> - like round-robin vs priority.
> 
> CPSW networking driver doesn't need to know exact ring generated IRQ - it

Well, to fit the Linux model, you'll have to know. Events needs to be
signalled as individual IRQs.

> need to know if there is packet for processing, so current IRQ handling sequence we have (simplified):
> - any ring evt -> IA -> IR -> GIC -> Linux IRQ Y
>    handle_fasteoi_irq() -> cpsw_irq_handler -> disable_irq() -> napi_schedule()

Here, disable_irq() will only affect a single "event".

>    ...
>    soft_irq() -> cpsw_poll():
> 	- [1] for each ring from Hi prio to Low prio
> 	      [2] get packet
> 	      [3] if (packet) process packet & goto [2]
> 	          else goto [1]
> 	       if (no more packets) goto [4]
> 	  [4] enable_irq()
> 
> As can be seen there is no intermediate IRQ dispatchers on IA/IR levels and no IRQs-per-rings,
> and NAPI poll cycle allows to implement driver's specific rings handling policy.
> 
> Next: depending on the use case following optimizations are possible:
> 1) throughput: split all TX (or RX) rings on X groups, where X = num_cpus
> and allocate assign IRQ to each group for Networking XPS/RPS/RSS.
> For example, CPSW2G has 8 TX channels and so 8 completion rings, 4 CPUs:
>   rings[0,1] -(IA/IR) - Linux IRQ 1
>   rings[2,3] -(IA/IR) - Linux IRQ 2
>   rings[4,5] -(IA/IR) - Linux IRQ 3
>   rings[6,7] -(IA/IR) - Linux IRQ 4
> each Linux IRQ assigned to separate CPU.

What you call "Linux IRQ" is what ends up being generated at the GIC
level, and isn't the interrupt the driver will get. It will get an
interrupt number which represent a single event. We absolutely need to
maintain this 1:1 mapping between event and driver-visible interrupts.
Whatever happens between the scenes is none of the driver problem.

In your "one interrupt, multiple events" paradigm, the whole IA thing
would be conceptually part of your networking IP. I don't believe this
is the case, and trawling the documentation seems to confirm this view.

> 2) min latency:
>   Ring X is used by RT application for TX/RX some traffic (using AF_XDP sockets for example)
>   Ring X can be assigned with separate IRQ while other rings still grouped to
>   produce 1 IRQ
>   rings[0,6] - (IA/IR) - Linux IRQ 1
>   rings[7] - (IA/IR) - Linux IRQ 2
>   Linux IRQ 2 assigned to separate CPU where RT application is running.
> 
> Hope above will help to clarify some K3 AM6 IRQ generation questions and
> find the way to move forward.

Well, I'm convinced that we do not want a networking driver to be tied
to an interrupt architecture, and that the two should be completely
independent. But that's my own opinion. I can only see two solutions
moving forward:

1) You make the IA a real interrupt controller that exposes real
interrupts (one per event), and write your networking driver
independently of the underlying interrupt architecture.

2) you make the IA an integral part of your network driver, not exposing
anything outside of it, and limiting the interactions with the IR
*through the standard IRQ API*. You duplicate this knowledge throughout
the other client drivers.

I believe that (2) would be a massive design mistake as it locks the
driver to a single of the HW (and potentially a single revision of the
firmware) while (1) gives you the required level of flexibility by
hiding the whole event "concept" at a single location.

Yes, (1) makes you rewrite your existing, out of tree drivers. Oh well...

Thanks,
	
	M.
-- 
Jazz is not dead. It just smells funny...
