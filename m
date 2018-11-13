Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08233C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A6121780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A6121780
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbeKMQKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:10:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36792 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKMQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:10:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAD6DEOD005901;
        Tue, 13 Nov 2018 00:13:14 -0600
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAD6DEwe007676
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 00:13:14 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 13
 Nov 2018 00:13:13 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 13 Nov 2018 00:13:13 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAD6D9ao025458;
        Tue, 13 Nov 2018 00:13:10 -0600
Subject: Re: [PATCH v3 06/13] dt-bindings: irqchip: Introduce TISCI Interrupt
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
References: <20181106084105.32483-1-lokeshvutla@ti.com>
 <20181106084105.32483-7-lokeshvutla@ti.com>
 <5bea0eb4.1c69fb81.843ed.0186@mx.google.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <569674da-07a1-107b-020a-4a11534a06b6@ti.com>
Date:   Tue, 13 Nov 2018 11:43:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5bea0eb4.1c69fb81.843ed.0186@mx.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 12/11/18 11:30 PM, Rob Herring wrote:
> On Tue, Nov 06, 2018 at 02:10:58PM +0530, Lokesh Vutla wrote:
>> Add the DT binding documentation for Interrupt router driver.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> Changes since v2:
>> - Dropped interrupt-parent from reqired properties description
>> - Updated the interrupt cells to 4.
>>
>>   .../interrupt-controller/ti,sci-intr.txt      | 84 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 85 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> new file mode 100644
>> index 000000000000..06e69f8c812c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> @@ -0,0 +1,84 @@
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
>> +			interrupt source. The value should be 4.
>> +			First cell should contain the TISCI device ID of source
>> +			Second cell should contain the interrupt source offset
>> +			within the device
>> +			Third cell specifies the trigger type as defined
>> +			in interrupts.txt in this directory.
>> +			Fourth cell should be 1 if the irq is coming from
>> +			interrupt aggregator else 0.
>> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
>> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>> +- ti,sci-rm-range-girq:	TISCI subtype id representing the host irqs assigned
>> +			to this interrupt router.
> 
> u32 or array?

it is u32.

> 
>> +
>> +For more details on TISCI IRQ resource management refer:
>> +http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
>> +
>> +Example:
>> +--------
>> +The following example demonstrates both interrupt router node and the consumer
>> +node(main gpio) on the AM654 SoC:
>> +
>> +main_intr: interrupt-controller@1 {
> 
> Unit-address is not valid here without a reg property.

Sure will fix it in next version.

Thanks and regards,
Lokesh

> 
>> +	compatible = "ti,sci-intr";
>> +	interrupt-controller;
>> +	interrupt-parent = <&gic>;
>> +	#interrupt-cells = <4>;
>> +	ti,sci = <&dmsc>;
>> +	ti,sci-dst-id = <56>;
>> +	ti,sci-rm-range-girq = <0x1>;
>> +};
>> +
>> +main_gpio0: gpio@600000 {
>> +	...
>> +	interrupt-parent = <&main_intr>;
>> +	interrupts = <57 256 IRQ_TYPE_EDGE_RISING 0>,
>> +			<57 257 IRQ_TYPE_EDGE_RISING 0>,
>> +			<57 258 IRQ_TYPE_EDGE_RISING 0>,
>> +			<57 259 IRQ_TYPE_EDGE_RISING 0>,
>> +			<57 260 IRQ_TYPE_EDGE_RISING 0>,
>> +			<57 261 IRQ_TYPE_EDGE_RISING 0>;
>> +	...
>> +};
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 88b28f6dec45..0e3aa3386287 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14739,6 +14739,7 @@ F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
>>   F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>>   F:	drivers/clk/keystone/sci-clk.c
>>   F:	drivers/reset/reset-ti-sci.c
>> +F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>   
>>   THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>>   M:	Hans Verkuil <hverkuil@xs4all.nl>
>> -- 
>> 2.19.1
>>
> 
