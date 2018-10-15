Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C78C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F9C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F/y6PfX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F9C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeJOSvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:51:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59152 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeJOSvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:51:22 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9FB5Yjs095672;
        Mon, 15 Oct 2018 06:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539601534;
        bh=EPOx5m7RTgg+IGD7sHbdtQ1/YLwqZHWYdQIaI095Zsk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F/y6PfX+jr+1kA1NVNBl3mgL1izp1zTSVHykt5ysQMNqVq4rcnknzhHpI/tYTDQXQ
         fId1yitF12Bz+BDlZuHkZV+SHVeG+oDgPAIcXE/pXLGHtb6REuT+odNoPgmPGFeg3B
         fGZjD8mrTUsyhuwXyLRpKyeb5vF7UNe3hSEM1glE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FB5YY5006553;
        Mon, 15 Oct 2018 06:05:34 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 06:05:34 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 06:05:34 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FB5Uu2007761;
        Mon, 15 Oct 2018 06:05:31 -0500
Subject: Re: [PATCH 1/2] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
CC:     Tero Kristo <t-kristo@ti.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
References: <20181006072812.15814-1-lokeshvutla@ti.com>
 <20181006072812.15814-2-lokeshvutla@ti.com>
 <20181006162929.u6uh4ffn6gm3incf@akan>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <c3dada07-d04f-a4c8-b8e3-bece678aea15@ti.com>
Date:   Mon, 15 Oct 2018 16:35:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181006162929.u6uh4ffn6gm3incf@akan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, DT maintainers,

On Saturday 06 October 2018 09:59 PM, Nishanth Menon wrote:
> On 12:58-20181006, Lokesh Vutla wrote:
>> Add the DT binding documentation for Interrupt router driver.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>   .../interrupt-controller/ti,sci-intr.txt      | 83 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 84 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> new file mode 100644
>> index 000000000000..681ca53cc5fb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> @@ -0,0 +1,83 @@
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
>> +        +-------+            |    .        |  0  |  |----->|  GIC  |
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
>> +track of GIC IRQs.
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
>> +			in interrupts.txt in this directory.
>> +- interrupt-parent:	phandle of irq parent for TISCI intr. The parent must
>> +			use the same interrupt-cells format as GIC.
>> +- ti,sci:		Phandle to TI-SCI compatible System controller node.
>> +- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
>> +- ti,sci-rm-range-girq:	Tuple corresponding to unique TISCI resource type that
>> +			defines the dst host irq ranges assigned to this
>> +			interrupt router from this host context.
>> +			Tuple should be of format <type subtype>.
>> +
> 
> Rob, DT maintainers,
> 
> I'd like a feedback from DT maintainers on this 'range' topic.
> 
> TISCI Firmware [1] currently seems to define a type corresponding to a
> device ID[2]. in AM6 device, for example, this is different, however
> have a 1 to 1 correspondence. However, there is expectation that type will
> end up as device ID in a future SoC.
> 
> While this is subject to much debate internally, I'd like some feedback if this
> is OK from Device tree representation - it is true that Firmware does
> look at it as type, however in some future SoC, it could be that the
> values themselves may correspond one to one with a device id -> The
> original wish was that types might be something reusable across SoCs,
> but that is turning out to be more of a theoretical wish than any thing
> practical.
> 
> [1]http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
> [2]http://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am6x/devices.html

Any help on this topic?

Thanks and regards,
Lokesh

> 
