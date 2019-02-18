Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADEEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFE221479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ktbJ1t5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbfBRP2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:28:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33036 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfBRP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:28:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1IFRkm0115387;
        Mon, 18 Feb 2019 09:27:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550503666;
        bh=miwyYbk1jOcC+qDGNn9LiVtca9U6dhXM5Um/z5oRPBM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ktbJ1t5QIYcf3iDxJtCWJMAYPZwhVLxB7BLkrYjBbFyGAFY1S8+QKHJycmjOuv0I/
         wbHv0bu8/Kmd52ZSTIfvCTKl1avERrWAGwUU/h5eABKsgvJHAJn2JPCPHdGH8/ryga
         q0lYpQ0ynY7q+fS+qmEu5rFJ0VaV/H4B/2YZGTCs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1IFRk8v049118
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 09:27:46 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 09:27:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 09:27:46 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1IFRfqn029950;
        Mon, 18 Feb 2019 09:27:42 -0600
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190218150738.527a0507@why.wild-wind.fr.eu.org>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <d67d993a-e2c0-676c-5b83-f6722796e5be@ti.com>
Date:   Mon, 18 Feb 2019 20:57:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190218150738.527a0507@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 18/02/19 8:42 PM, Marc Zyngier wrote:
> On Tue, 12 Feb 2019 13:12:32 +0530
> Lokesh Vutla <lokeshvutla@ti.com> wrote:
> 
>> Add the DT binding documentation for Interrupt router driver.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> Changes since v4:
>> - None
>>
>>  .../interrupt-controller/ti,sci-intr.txt      | 85 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 86 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> new file mode 100644
>> index 000000000000..4b0ca797fda1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> @@ -0,0 +1,85 @@
>> +Texas Instruments K3 Interrupt Router
>> +=====================================
>> +
>> +The Interrupt Router (INTR) module provides a mechanism to route M
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
> 
> This is odd. Doesn't the aggregator have a device ID too, which could
> be used to discriminate between the two?

For that we have to store the list of INTA device IDs connected to the INTR in
the router driver. Again we have to get this list from DT. I felt this is easier
to differentiate the INTA interrupts. If you prefer to get the list of ids and
store it in INTR driver, I can change that by adding an extra DT property.

I guess you assumed that there is a single INTA attached to an INTR. There are
cases where there are more than one INTA connected to INTR. We will have to
handle that as well.

Thanks and regards,
Lokesh
