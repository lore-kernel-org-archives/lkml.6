Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD513ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5882064A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5882064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeJ0E7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:59:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57174 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJ0E7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:59:02 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9QKJtDA080384;
        Fri, 26 Oct 2018 15:19:55 -0500
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9QKJt6f036800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Oct 2018 15:19:55 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 26
 Oct 2018 15:19:55 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 26 Oct 2018 15:19:55 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9QKJomV000948;
        Fri, 26 Oct 2018 15:19:51 -0500
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        <jason@lakedaemon.net>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, <tglx@linutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <b3a71622-7734-04be-0b0c-38e9dc6542d4@ti.com>
Message-ID: <63ba5353-8470-b4c1-64a8-a1df5bf48614@ti.com>
Date:   Sat, 27 Oct 2018 01:49:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b3a71622-7734-04be-0b0c-38e9dc6542d4@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

[..snip..]
>> [...]
>>
>>>>> +/**
>>>>> + * ti_sci_inta_register_event() - Register a event to an interrupt aggregator
>>>>> + * @dev:	Device pointer to source generating the event
>>>>> + * @src_id:	TISCI device ID of the event source
>>>>> + * @src_index:	Event source index within the device.
>>>>> + * @virq:	Linux Virtual IRQ number
>>>>> + * @flags:	Corresponding IRQ flags
>>>>> + * @ack_needed:	If explicit clearing of event is required.
>>>>> + *
>>>>> + * Creates a new irq and attaches to IA domain if virq is not specified
>>>>> + * else attaches the event to vint corresponding to virq.
>>>>> + * When using TISCI within the client drivers, source indexes are always
>>>>> + * generated dynamically and cannot be represented in DT. So client
>>>>> + * drivers should call this API instead of platform_get_irq().
>>>>
>>>> NAK. Either this fits in the standard model, or we adapt the standard
>>>> model to catter for your particular use case. But we don't define a new,
>>>> TI specific API.
>>>>
>>>> I have a hunch that if the IDs are generated dynamically, then the model
>>>> we use for MSIs would fit this thing. I also want to understand what
>>>
>>> hmm..I haven't thought about using MSI. Will try to explore it. But
>>> the "struct msi_msg" is not applicable in this case as device does not
>>> write to a specific location.
>>
>> It doesn't need to. You can perfectly ignore the address field and
>> only be concerned with the data. We already have MSI users that do not
>> need programming of the doorbell address, just the data.
> 

Just one more clarification.

First let me explain the IRQ routes a bit deeply. As I said earlier there are 
three ways in which IRQ can flow in AM65x SoC
1) Device directly connected to GIC
	- Device IRQ --> GIC
2) Device connected to INTR.
	- Device IRQ --> INTR --> GIC
3) Devices connected to INTA.
	- Device IRQ --> INTA --> INTR --> GIC

1 and 2 are straight forward and we use DT for IRQ representation. Coming to 3 
the trickier part is that Input to INTA and output from INTA and dynamically 
managed. To be more specific:
- By hardware design there are certain set of physical global events(interrupts) 
attached to an INTA. Out of which a certain range are assigned to the current 
linux host that can be queried from system-controller.
- Similarly out of all the INTA outputs(referenced as vints) a certain range can 
be used by the current linux host.


So for configuring an IRQ route in case 3, the following steps are needed:
- Device id and device resource index for which the interrupt is needed
- A free event id from the range assigned to the INTA in this host context
- A free vint from the range assigned to the INTA in this host context
- A free gic IRQ from the range assigned to the INTR in this host context.

With the above information, linux should send a message to system-controller 
using TISCI protocol. After policing the given information, system-controller 
does the following:
- Attaches the interrupt(INTA input) to the device resource index
- Muxes the interrupt(INTA input) to corresponding vint(INTA output)
- Muxes the vint(INTR input) to GIC irq(INTR output).

For grouping of interrupts, the same vint number is to be passed to 
system-controller for all the requests.

Keeping all the above in mind, I see the following as software IRQ Domain Hierarchy:

1) INTA multi MSI --> 2)INTA  -->3) MSI --> 4) INTR  -->5) GIC

INTA driver has to set a chained IRQ using virq allocated from its parent MSI. 
This is to differentiate the grouped interrupts within INTA.

Inorder to cover the above two MSI domains, a new bus driver has to be created 
as I couldn't find a fit with the existing bus drivers.

Does the above approach make sense? Please correct me if i am wrong.

Thanks and regards,
Lokesh
