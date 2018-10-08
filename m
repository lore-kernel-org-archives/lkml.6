Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D491C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F3921565
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pWxtdB8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F3921565
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeJHWlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:41:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46838 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbeJHWlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:41:52 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98FT66Y048317;
        Mon, 8 Oct 2018 10:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539012546;
        bh=sGZTgnl+y4YOaUvd49KK4Sg1Yn3YjKcjhQ4qFTyQu3I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pWxtdB8o2BYuWmsyseU4v0Ed1hQypfKdt2cxOs1bb+Np1t1s7z3YtnHrC01q21PU3
         NkRddVIn5bjkkERQxVznPoI5kGdAZCFEpFUrYShgOIph7YQO0ZW4uSLEI2y2PQn0Qr
         bToeOi8DZEIY54BGFLXXPoUUPxFGm0/31ypoUQqI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98FT3Fi021441;
        Mon, 8 Oct 2018 10:29:06 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 10:29:05 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 10:29:05 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98FT1kB021905;
        Mon, 8 Oct 2018 10:29:02 -0500
Subject: Re: [PATCH 1/2] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
References: <20181006072812.15814-1-lokeshvutla@ti.com>
 <20181006072812.15814-2-lokeshvutla@ti.com>
 <86tvlztmt1.wl-marc.zyngier@arm.com>
 <8a05f735-01bd-5c2d-fcfa-dcc00adffd0b@ti.com>
 <7e7e7778-c67d-5fc1-6b4a-52a7089a9691@arm.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <bd356e10-48df-3a07-51d0-feae5735a862@ti.com>
Date:   Mon, 8 Oct 2018 20:58:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7e7e7778-c67d-5fc1-6b4a-52a7089a9691@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 08 October 2018 07:25 PM, Marc Zyngier wrote:
> On 08/10/18 10:46, Lokesh Vutla wrote:
>> Hi Marc,
>>
>> On Saturday 06 October 2018 03:32 PM, Marc Zyngier wrote:
>>> On Sat, 06 Oct 2018 08:28:11 +0100,
>>> Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>>>
>>>> Add the DT binding documentation for Interrupt router driver.
>>>>
>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>> ---
>>>>     .../interrupt-controller/ti,sci-intr.txt      | 83 +++++++++++++++++++
>>>>     MAINTAINERS                                   |  1 +
>>>>     2 files changed, 84 insertions(+)
>>>>     create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>>> new file mode 100644
>>>> index 000000000000..681ca53cc5fb
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>>> @@ -0,0 +1,83 @@
>>>> +Texas Instruments K3 Interrupt Router
>>>> +=====================================
>>>> +
>>>> +The Interrupt Router (INTR) module provides a mechanism to mux M
>>>> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
>>>> +to be driven per N output. There is one register per output (MUXCNTL_N) that
>>>> +controls the selection.
>>>> +
>>>> +
>>>> +                                 Interrupt Router
>>>> +                             +----------------------+
>>>> +                             |  Inputs     Outputs  |
>>>> +        +-------+            | +------+             |
>>>> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
>>>> +        +-------+            | +------+             |      controller
>>>> +                             |    .        +-----+  |      +-------+
>>>> +        +-------+            |    .        |  0  |  |----->|  GIC  |
>>>> +        | INTA  |----------->|    .        +-----+  |      +-------+
>>>> +        +-------+            |    .          .      |
>>>> +                             | +------+      .      |
>>>> +                             | | irqM |    +-----+  |
>>>> +                             | +------+    |  N  |  |
>>>> +                             |             +-----+  |
>>>> +                             +----------------------+
>>>> +
>>>> +Configuration of these MUXCNTL_N registers is done by a system controller
>>>> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
>>>> +controller will keep track of the used and unused registers within the Router.
>>>> +Driver should request the system controller to get the range of GIC IRQs
>>>> +assigned to the requesting hosts. It is the drivers responsibility to keep
>>>> +track of GIC IRQs.
>>>
>>> I would drop the GIC here, and replace it by "parent interrupt
>>> controller", as nothing here is GIC specific
>>>
>>>> +
>>>> +Communication between the host processor running an OS and the system
>>>> +controller happens through a protocol called TI System Control Interface
>>>> +(TISCI protocol). For more details refer:
>>>> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>>>> +
>>>> +TISCI Interrupt Router Node:
>>>> +----------------------------
>>>> +- compatible:		Must be "ti,sci-intr".
>>>> +- interrupt-controller:	Identifies the node as an interrupt controller
>>>> +- #interrupt-cells:	Specifies the number of cells needed to encode an
>>>> +			interrupt source. The value should be 3.
>>>> +			First cell should contain the TISCI device ID of source
>>>> +			Second cell should contain the interrupt source offset
>>>> +			within the device
>>>> +			Third cell specifies the trigger type as defined
>>>> +			in interrupts.txt in this directory.
>>>
>>> Are all trigger types supported?
>>
>> Nope, only level interrupts are supported. Will fix it in v2.
>>
>>>
>>>> +- interrupt-parent:	phandle of irq parent for TISCI intr. The parent must
>>>> +			use the same interrupt-cells format as GIC.
>>>
>>> Why that constraint? From what I can see, the two are fairly
>>> independent, and the constraint looks more of a Linux driver issue
>>> than a DT constraint.
>>
>> Driver when calling irq_domain_alloc_irqs_parent(), the fwspec node that gets
>> passed assumes that parent is gic. parameters are filled in with such
>> assumption. Do you suggest anything to make it more generic?
> 
> As I said, that's a Linux driver issue, not a DT specification at all.
> It is not worth it trying to generalize it in the driver implementation,
> but the DT spec it self should be generic enough.

okay, will fix it in next version.

> 
>>
>>>
>>>> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
>>>> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>>>> +- ti,sci-rm-range-girq:	Tuple corresponding to unique TISCI resource type that
>>>> +			defines the dst host irq ranges assigned to this
>>>> +			interrupt router from this host context.
>>>> +			Tuple should be of format <type subtype>.
>>>> +
>>
>> Thanks a lot for the review. Also, I need a suggestion regarding one more
>> interrupt controller(Interrupt Aggregator) on the same SoC controlled by
>> TISCI_PROTOCOL.
>>
>> The Interrupt Aggregator (INTA) provides a centralized machine
>> which handles the termination of system events to that they can
>> be coherently processed by the host(s) in the system. Integration looks
>> something similar https://pastebin.ubuntu.com/p/T32vbrwsch/ .
>>
>> Configuration of the Intmap registers that maps global events to vint is done
>> by a system controller (like the Device Memory and Security Controller on K3
>> AM654 SoC). Driver should request the system controller to get the range
>> of global events and vints assigned to the requesting host. Management
>> of these requested resources should be handled by driver and requests
>> system controller to map specific global event to vint, bit pair.
> 
> I'm sorry, but I really have no idea what the global events and the
> vints are. Maybe you should describe what this is all about, and maybe
> provide a pointer to some documentation...

Sorry I should have done that earlier. TRM is available here[1], Section 9.3 
talks about Interrupt Router, Section 10.2.7 talks about Interrupt aggregator. 
Documentation for TISCI IRQ management is available here[2].


[1] http://www.ti.com/lit/ug/spruid7a/spruid7a.pdf
[2] http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html

> 
>>
>> There can be cases such that IRQ routes can involve both INTR and INTA like below:
>> 	IP ---> INTA ---> INTR ----> GIC.
>>
>> In these cases TISCI involves only one message with parametes(source id, source
>> offset, inta_id, dst id) for configuring IRQ route till the destination. Co
>> processor will detect there is INTR in the IRQ path and configure that as well.
>>
>> Right now I kind of differentiated this scenario in INTA driver by passing a
>> flag(TI_SCI_EVENT) to INTR driver. If such flag comes, INTR driver should avoid
>> calling ti_sci api for configuring. Do you think this is the right direction or
>> do you suggest a better solution.
> 
> Frankly, it mostly indicates that the firmware does too much, and should
> be more flexible.
> 
>> If I am not clear in the above description, I can post an RFC for INTA driver
>> for continuing this discussion.
> 
> That'd be preferable, IMO. Please provide definitions for all the above

Sure, will try to post the consolidated series asap. Thanks a lot for the help.

Regards,
Lokesh
