Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB486ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DEF20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DEF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJZPP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:15:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35900 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeJZPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:15:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9Q6d9dm110649;
        Fri, 26 Oct 2018 01:39:09 -0500
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9Q6d9HK046251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Oct 2018 01:39:09 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 26
 Oct 2018 01:39:09 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 26 Oct 2018 01:39:09 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9Q6d4fv019413;
        Fri, 26 Oct 2018 01:39:05 -0500
Subject: Re: [PATCH v2 06/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Rob Herring <robh@kernel.org>
CC:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-7-lokeshvutla@ti.com> <20181025184556.GA19597@bogus>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <bf6c5c14-5f35-7d6b-10c9-36a1cbe22e09@ti.com>
Date:   Fri, 26 Oct 2018 12:08:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025184556.GA19597@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Friday 26 October 2018 12:15 AM, Rob Herring wrote:
> On Thu, Oct 18, 2018 at 09:10:13PM +0530, Lokesh Vutla wrote:
>> Add the DT binding documentation for Interrupt router driver.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> Changes since v1:
>> - Drop dependency on GIC
>> - Updated supported interrupt types.
>>
>>   .../interrupt-controller/ti,sci-intr.txt      | 81 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 82 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> new file mode 100644
>> index 000000000000..276bb4f0ad12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> @@ -0,0 +1,81 @@
>> +Texas Instruments K3 Interrupt Router
>> +=====================================
>> +
>> +The Interrupt Router (INTR) module provides a mechanism to mux M
>> +interrupt inputs to N interrupt outputs, where all M inputs are selectable
>> +to be driven per N output. There is one register per output (MUXCNTL_N) that
>> +controls the selection.
>> +
>> +
>> +                                 Interrupt Router
>> +                             +----------------------+
>> +                             |  Inputs     Outputs  |
>> +        +-------+            | +------+             |
>> +        | GPIO  |----------->| | irq0 |             |       Host IRQ
>> +        +-------+            | +------+             |      controller
>> +                             |    .        +-----+  |      +-------+
>> +        +-------+            |    .        |  0  |  |----->|  IRQ  |
>> +        | INTA  |----------->|    .        +-----+  |      +-------+
>> +        +-------+            |    .          .      |
>> +                             | +------+      .      |
>> +                             | | irqM |    +-----+  |
>> +                             | +------+    |  N  |  |
>> +                             |             +-----+  |
>> +                             +----------------------+
>> +
>> +Configuration of these MUXCNTL_N registers is done by a system controller
>> +(like the Device Memory and Security Controller on K3 AM654 SoC). System
>> +controller will keep track of the used and unused registers within the Router.
>> +Driver should request the system controller to get the range of GIC IRQs
>> +assigned to the requesting hosts. It is the drivers responsibility to keep
>> +track of Host IRQs.
>> +
>> +Communication between the host processor running an OS and the system
>> +controller happens through a protocol called TI System Control Interface
>> +(TISCI protocol). For more details refer:
>> +Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> +
>> +TISCI Interrupt Router Node:
>> +----------------------------
>> +- compatible:		Must be "ti,sci-intr".
>> +- interrupt-controller:	Identifies the node as an interrupt controller
>> +- #interrupt-cells:	Specifies the number of cells needed to encode an
>> +			interrupt source. The value should be 3.
>> +			First cell should contain the TISCI device ID of source
>> +			Second cell should contain the interrupt source offset
>> +			within the device
>> +			Third cell specifies the trigger type as defined
>> +			in interrupts.txt in this directory. Only level
>> +			sensitive trigger types are supported.
>> +- interrupt-parent:	phandle of irq parent for TISCI intr.
> 
> This is implied and could be in a parent node.

okay, will drop it in next version.

> 
>> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
>> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>> +- ti,sci-rm-range-girq:	TISCI subtype id representing the host irqs assigned
>> +			to this interrupt router.
> 
> These need a better explanation and there's still some questions on v1
> asked of me that I tried to answer.

Before I jump into the details, I would like to provide a brief on TISCI 
resource management:

- Host_id: Typically it is the representation of the host processing entities 
(example: A53 cores running in a VM) as identified by the TISCI.[1]
- Device_id: Each Device in SoC is uniquely identified by TISCI using an ID.
- Each device has Resources like interrupts, DMA channels etc. A simple example 
would be Interrupt Router and GIC($subject). There are n physical GIC interrupts 
connected to Interrupt Router. Such resources are are uniquely identified by 
TISCI using a type ID.[2]

For the sake of simplicity lets consider an Interrupt Router(IR) to which GIC 
line 32-63 are connected. Considering Isolation for each VM in picture, TISCI 
allows for a certain range within [32-63] to be assigned to a specific Host_ID. 
This is mainly to provide the ability for OSs running in virtual machines to be 
able to independently communicate with the firmware without the need going 
through a hypervisor.

- Now for Linux to know the GIC irq range that can be used by this Interrupt 
router, IR driver should send a message to system-controller using TISCI 
protocol with the resource type as parameter.
- For configuring the IRQ,(i.e. attaching an input to IR to a GIC irq), IR 
driver should send a message to system-controller using TISCI protocol with 
gic-device-id and an irq from the provided range as parameters.

For covering the above two scenarios, ti,sci-dst-id and ti,sci-rm-range-girq is 
introduced in DT.

[1] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/hosts.html
[2] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html

> 
>> +
>> +Example:
>> +--------
>> +The following example demonstrates both interrupt router node and the consumer
>> +node(main gpio) on the AM654 SoC:
>> +
>> +main_intr: interrupt-controller@1 {
>> +	compatible = "ti,sci-intr";
>> +	interrupt-controller;
>> +	interrupt-parent = <&gic>;
>> +	#interrupt-cells = <3>;
>> +	ti,sci = <&dmsc>;
>> +	ti,sci-dst-id = <56>;
>> +	ti,sci-rm-range-girq = <0x1>;
>> +};
>> +
>> +main_gpio0:  main_gpio0@600000 {
> 
> gpio@...

Sure, will fix it in next version.

Thanks and regards,
Lokesh
