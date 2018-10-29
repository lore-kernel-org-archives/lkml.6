Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F225EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A092F2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gJjITtPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A092F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeJ2Vx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:53:57 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52038 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeJ2Vx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:53:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9TD4Fsb112853;
        Mon, 29 Oct 2018 08:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540818255;
        bh=TZ7kBg/Bx8xOEaHCVCen/c/1yatQScEB/VRRAJv61iU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gJjITtPu8KSnh8nVzTX85Fz3DOUZwVcodS5dr2y+V3j0BHx98Im0CcouFfYNQkMw+
         8up6bMn0aipNy1rXIXinSA8FdvsPFCCxtK1E0K0OAWDeg9eRY4knRpIPJToCf9DLQN
         ltpDBZ9xOoQfpaofLVKLqW6f3SlrOtzBVXOJoY1U=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9TD4FLx036078
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Oct 2018 08:04:15 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 29
 Oct 2018 08:04:15 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 29 Oct 2018 08:04:15 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9TD4Apg018386;
        Mon, 29 Oct 2018 08:04:11 -0500
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
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
 <63ba5353-8470-b4c1-64a8-a1df5bf48614@ti.com>
 <86va5myz7t.wl-marc.zyngier@arm.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <81136b74-4b45-f44b-0168-23d191a4fb5e@ti.com>
Date:   Mon, 29 Oct 2018 18:34:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <86va5myz7t.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Sunday 28 October 2018 07:01 PM, Marc Zyngier wrote:
> Hi Lokesh,
> 
> On Fri, 26 Oct 2018 21:19:41 +0100,
> Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>
>> Hi Marc,
>>
>> [..snip..]
>>>> [...]
>>>>
>>>>>>> +/**
>>>>>>> + * ti_sci_inta_register_event() - Register a event to an interrupt aggregator
>>>>>>> + * @dev:	Device pointer to source generating the event
>>>>>>> + * @src_id:	TISCI device ID of the event source
>>>>>>> + * @src_index:	Event source index within the device.
>>>>>>> + * @virq:	Linux Virtual IRQ number
>>>>>>> + * @flags:	Corresponding IRQ flags
>>>>>>> + * @ack_needed:	If explicit clearing of event is required.
>>>>>>> + *
>>>>>>> + * Creates a new irq and attaches to IA domain if virq is not specified
>>>>>>> + * else attaches the event to vint corresponding to virq.
>>>>>>> + * When using TISCI within the client drivers, source indexes are always
>>>>>>> + * generated dynamically and cannot be represented in DT. So client
>>>>>>> + * drivers should call this API instead of platform_get_irq().
>>>>>>
>>>>>> NAK. Either this fits in the standard model, or we adapt the standard
>>>>>> model to catter for your particular use case. But we don't define a new,
>>>>>> TI specific API.
>>>>>>
>>>>>> I have a hunch that if the IDs are generated dynamically, then the model
>>>>>> we use for MSIs would fit this thing. I also want to understand what
>>>>>
>>>>> hmm..I haven't thought about using MSI. Will try to explore it. But
>>>>> the "struct msi_msg" is not applicable in this case as device does not
>>>>> write to a specific location.
>>>>
>>>> It doesn't need to. You can perfectly ignore the address field and
>>>> only be concerned with the data. We already have MSI users that do not
>>>> need programming of the doorbell address, just the data.
>>>
>>
>> Just one more clarification.
>>
>> First let me explain the IRQ routes a bit deeply. As I said earlier
>> there are three ways in which IRQ can flow in AM65x SoC
>> 1) Device directly connected to GIC
>> 	- Device IRQ --> GIC
>> 2) Device connected to INTR.
>> 	- Device IRQ --> INTR --> GIC
>> 3) Devices connected to INTA.
>> 	- Device IRQ --> INTA --> INTR --> GIC
>>
>> 1 and 2 are straight forward and we use DT for IRQ
>> representation. Coming to 3 the trickier part is that Input to INTA
>> and output from INTA and dynamically managed. To be more specific:
>> - By hardware design there are certain set of physical global
>> events(interrupts) attached to an INTA. Out of which a certain range
>> are assigned to the current linux host that can be queried from
>> system-controller.
>> - Similarly out of all the INTA outputs(referenced as vints) a certain
>> range can be used by the current linux host.
>>
>>
>> So for configuring an IRQ route in case 3, the following steps are needed:
>> - Device id and device resource index for which the interrupt is needed
> 
> THat is no different from a PCI device for example, where we need the
> requester ID and the number of the interrupt in the MSI-X table.
> 
>> - A free event id from the range assigned to the INTA in this host context
>> - A free vint from the range assigned to the INTA in this host context
>> - A free gic IRQ from the range assigned to the INTR in this host context.
> 
>  From what I understand of the driver, at least some of that is under
> the responsibility of the firmware, right? Or is the driver under
> control of all three parameters? To be honest, it doesn't really

Driver should control all three parameters.

> matter, as the as far as the kernel is concerned, the irqchip drivers
> are free to deal with the routing anyway they want.

Correct, that's my understanding as well.

> 
>> With the above information, linux should send a message to
>> system-controller using TISCI protocol. After policing the given
>> information, system-controller does the following:
>> - Attaches the interrupt(INTA input) to the device resource index
>> - Muxes the interrupt(INTA input) to corresponding vint(INTA output)
>> - Muxes the vint(INTR input) to GIC irq(INTR output).
> 
> Isn't there a 1:1 mapping between *used* INTR inputs and outputs?
> Since INTR is a router, there is no real muxing. I assume that the
> third point above is just a copy-paste error.

Right, my bad. INTR is just a router and no read muxing.

> 
>>
>> For grouping of interrupts, the same vint number is to be passed to
>> system-controller for all the requests.
>>
>> Keeping all the above in mind, I see the following as software IRQ
>> Domain Hierarchy:
>>
>> 1) INTA multi MSI --> 2)INTA  -->3) MSI --> 4) INTR  -->5) GIC
>>
>> INTA driver has to set a chained IRQ using virq allocated from its
>> parent MSI. This is to differentiate the grouped interrupts within
>> INTA.
>>
>> Inorder to cover the above two MSI domains, a new bus driver has to be
>> created as I couldn't find a fit with the existing bus drivers.
>>
>> Does the above approach make sense? Please correct me if i am wrong.
> 
> I think this can be further simplified, as you seem to assume that
> dynamic allocation implies MSI. This is not the case. You can
> perfectly use dynamically allocated interrupts and still not use MSIs.
> 
> INTA is indeed a chained interrupt controller, as it may mux several
> inputs onto a single output. But the output of INTA is not an MSI. It
> is just a regular interrupt that can allocated when the first mapping
> gets established.

okay. I guess it can just be done using irq_create_fwspec_mapping().

> 
> Also, INTA shouldn't offer any "multi-MSI". This is a PCI-specific
> concept that doesn't translate on any other type of bus. What you want
> is something that should behave like MSI-X for its allocation part,
> where each MSI gets allocated independently.
> 
> Hierarchy-wise, you should end-up with something like this:
> 
>         TISCI-MSI       Chained-intr       SPI
> Device ---------> INTA ------------> INTR ---> GIC

makes sense. Thanks for the clarification. Will re work the driver using this 
approach and post it.

Thanks and regards,
Lokesh

> 
> As for the bus, you have two choices:
> 
> - You create a new one altogether. See drivers/bus/fsl-mc for
>    an example of something totally over the top. This implies that all
>    your devices are following the exact same programming model for more
>    than just interrupts.
> 
> - You use the platform-MSI framework to build your interrupt
>    infrastructure, and you don't have to implement much more than
>    that.
> 
> Hope this helps,
> 
> 	M.
> 
