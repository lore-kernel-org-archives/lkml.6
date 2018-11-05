Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF26C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828432086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828432086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbeKFCFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:05:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47098 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387420AbeKFCFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:05:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45EBD80D;
        Mon,  5 Nov 2018 08:44:44 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C82A73F718;
        Mon,  5 Nov 2018 08:44:41 -0800 (PST)
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        jason@lakedaemon.net, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <b3a71622-7734-04be-0b0c-38e9dc6542d4@ti.com>
 <63ba5353-8470-b4c1-64a8-a1df5bf48614@ti.com>
 <86va5myz7t.wl-marc.zyngier@arm.com>
 <81136b74-4b45-f44b-0168-23d191a4fb5e@ti.com>
 <c8778f4a-148a-2b4d-6dd9-7b7ca89b20a9@ti.com>
 <c2e7c31d-95c7-5ae2-fea3-ed4fcbb73746@arm.com>
 <a7e3095f-0ceb-838b-d8dc-b2e864c02d20@ti.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 xsFNBE6Jf0UBEADLCxpix34Ch3kQKA9SNlVQroj9aHAEzzl0+V8jrvT9a9GkK+FjBOIQz4KE
 g+3p+lqgJH4NfwPm9H5I5e3wa+Scz9wAqWLTT772Rqb6hf6kx0kKd0P2jGv79qXSmwru28vJ
 t9NNsmIhEYwS5eTfCbsZZDCnR31J6qxozsDHpCGLHlYym/VbC199Uq/pN5gH+5JHZyhyZiNW
 ozUCjMqC4eNW42nYVKZQfbj/k4W9xFfudFaFEhAf/Vb1r6F05eBP1uopuzNkAN7vqS8XcgQH
 qXI357YC4ToCbmqLue4HK9+2mtf7MTdHZYGZ939OfTlOGuxFW+bhtPQzsHiW7eNe0ew0+LaL
 3wdNzT5abPBscqXWVGsZWCAzBmrZato+Pd2bSCDPLInZV0j+rjt7MWiSxEAEowue3IcZA++7
 ifTDIscQdpeKT8hcL+9eHLgoSDH62SlubO/y8bB1hV8JjLW/jQpLnae0oz25h39ij4ijcp8N
 t5slf5DNRi1NLz5+iaaLg4gaM3ywVK2VEKdBTg+JTg3dfrb3DH7ctTQquyKun9IVY8AsxMc6
 lxl4HxrpLX7HgF10685GG5fFla7R1RUnW5svgQhz6YVU33yJjk5lIIrrxKI/wLlhn066mtu1
 DoD9TEAjwOmpa6ofV6rHeBPehUwMZEsLqlKfLsl0PpsJwov8TQARAQABzSNNYXJjIFp5bmdp
 ZXIgPG1hcmMuenluZ2llckBhcm0uY29tPsLBewQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYC
 AwECHgECF4AFAk6NvYYCGQEACgkQI9DQutE9ekObww/+NcUATWXOcnoPflpYG43GZ0XjQLng
 LQFjBZL+CJV5+1XMDfz4ATH37cR+8gMO1UwmWPv5tOMKLHhw6uLxGG4upPAm0qxjRA/SE3LC
 22kBjWiSMrkQgv5FDcwdhAcj8A+gKgcXBeyXsGBXLjo5UQOGvPTQXcqNXB9A3ZZN9vS6QUYN
 TXFjnUnzCJd+PVI/4jORz9EUVw1q/+kZgmA8/GhfPH3xNetTGLyJCJcQ86acom2liLZZX4+1
 6Hda2x3hxpoQo7pTu+XA2YC4XyUstNDYIsE4F4NVHGi88a3N8yWE+Z7cBI2HjGvpfNxZnmKX
 6bws6RQ4LHDPhy0yzWFowJXGTqM/e79c1UeqOVxKGFF3VhJJu1nMlh+5hnW4glXOoy/WmDEM
 UMbl9KbJUfo+GgIQGMp8mwgW0vK4HrSmevlDeMcrLdfbbFbcZLNeFFBn6KqxFZaTd+LpylIH
 bOPN6fy1Dxf7UZscogYw5Pt0JscgpciuO3DAZo3eXz6ffj2NrWchnbj+SpPBiH4srfFmHY+Y
 LBemIIOmSqIsjoSRjNEZeEObkshDVG5NncJzbAQY+V3Q3yo9og/8ZiaulVWDbcpKyUpzt7pv
 cdnY3baDE8ate/cymFP5jGJK++QCeA6u6JzBp7HnKbngqWa6g8qDSjPXBPCLmmRWbc5j0lvA
 6ilrF8nOwU0ETol/RQEQAM/2pdLYCWmf3rtIiP8Wj5NwyjSL6/UrChXtoX9wlY8a4h3EX6E3
 64snIJVMLbyr4bwdmPKULlny7T/R8dx/mCOWu/DztrVNQiXWOTKJnd/2iQblBT+W5W8ep/nS
 w3qUIckKwKdplQtzSKeE+PJ+GMS+DoNDDkcrVjUnsoCEr0aK3cO6g5hLGu8IBbC1CJYSpple
 VVb/sADnWF3SfUvJ/l4K8Uk4B4+X90KpA7U9MhvDTCy5mJGaTsFqDLpnqp/yqaT2P7kyMG2E
 w+eqtVIqwwweZA0S+tuqput5xdNAcsj2PugVx9tlw/LJo39nh8NrMxAhv5aQ+JJ2I8UTiHLX
 QvoC0Yc/jZX/JRB5r4x4IhK34Mv5TiH/gFfZbwxd287Y1jOaD9lhnke1SX5MXF7eCT3cgyB+
 hgSu42w+2xYl3+rzIhQqxXhaP232t/b3ilJO00ZZ19d4KICGcakeiL6ZBtD8TrtkRiewI3v0
 o8rUBWtjcDRgg3tWx/PcJvZnw1twbmRdaNvsvnlapD2Y9Js3woRLIjSAGOijwzFXSJyC2HU1
 AAuR9uo4/QkeIrQVHIxP7TJZdJ9sGEWdeGPzzPlKLHwIX2HzfbdtPejPSXm5LJ026qdtJHgz
 BAb3NygZG6BH6EC1NPDQ6O53EXorXS1tsSAgp5ZDSFEBklpRVT3E0NrDABEBAAHCwV8EGAEC
 AAkFAk6Jf0UCGwwACgkQI9DQutE9ekMLBQ//U+Mt9DtFpzMCIHFPE9nNlsCm75j22lNiw6mX
 mx3cUA3pl+uRGQr/zQC5inQNtjFUmwGkHqrAw+SmG5gsgnM4pSdYvraWaCWOZCQCx1lpaCOl
 MotrNcwMJTJLQGc4BjJyOeSH59HQDitKfKMu/yjRhzT8CXhys6R0kYMrEN0tbe1cFOJkxSbV
 0GgRTDF4PKyLT+RncoKxQe8lGxuk5614aRpBQa0LPafkirwqkUtxsPnarkPUEfkBlnIhAR8L
 kmneYLu0AvbWjfJCUH7qfpyS/FRrQCoBq9QIEcf2v1f0AIpA27f9KCEv5MZSHXGCdNcbjKw1
 39YxYZhmXaHFKDSZIC29YhQJeXWlfDEDq6nIhvurZy3mSh2OMQgaIoFexPCsBBOclH8QUtMk
 a3jW/qYyrV+qUq9Wf3SKPrXf7B3xB332jFCETbyZQXqmowV+2b3rJFRWn5hK5B+xwvuxKyGq
 qDOGjof2dKl2zBIxbFgOclV7wqCVkhxSJi/QaOj2zBqSNPXga5DWtX3ekRnJLa1+ijXxmdjz
 hApihi08gwvP5G9fNGKQyRETePEtEAWt0b7dOqMzYBYGRVr7uS4uT6WP7fzOwAJC4lU7ZYWZ
 yVshCa0IvTtp1085RtT3qhh9mobkcZ+7cQOY+Tx2RGXS9WeOh2jZjdoWUv6CevXNQyOUXMM=
Organization: ARM Ltd
Message-ID: <93deaffd-296f-3118-26d5-231cbe9e705f@arm.com>
Date:   Mon, 5 Nov 2018 16:44:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a7e3095f-0ceb-838b-d8dc-b2e864c02d20@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/18 16:20, Lokesh Vutla wrote:
> Hi Marc,
> 
> On Monday 05 November 2018 09:06 PM, Marc Zyngier wrote:
>> On 05/11/18 08:08, Lokesh Vutla wrote:
>>> Hi Marc,
>>>
>>> On Monday 29 October 2018 06:34 PM, Lokesh Vutla wrote:
>>>> Hi Marc,
>>>>
>>>> On Sunday 28 October 2018 07:01 PM, Marc Zyngier wrote:
>>>>> Hi Lokesh,
>>>>>
>>>>> On Fri, 26 Oct 2018 21:19:41 +0100,
>>>>> Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>>>>>
>>>>>> Hi Marc,
>>>>>>
>>>>>> [..snip..]
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>>>> +/**
>>>>>>>>>>> + * ti_sci_inta_register_event() - Register a event to an interrupt aggregator
>>>>>>>>>>> + * @dev:	Device pointer to source generating the event
>>>>>>>>>>> + * @src_id:	TISCI device ID of the event source
>>>>>>>>>>> + * @src_index:	Event source index within the device.
>>>>>>>>>>> + * @virq:	Linux Virtual IRQ number
>>>>>>>>>>> + * @flags:	Corresponding IRQ flags
>>>>>>>>>>> + * @ack_needed:	If explicit clearing of event is required.
>>>>>>>>>>> + *
>>>>>>>>>>> + * Creates a new irq and attaches to IA domain if virq is not specified
>>>>>>>>>>> + * else attaches the event to vint corresponding to virq.
>>>>>>>>>>> + * When using TISCI within the client drivers, source indexes are always
>>>>>>>>>>> + * generated dynamically and cannot be represented in DT. So client
>>>>>>>>>>> + * drivers should call this API instead of platform_get_irq().
>>>>>>>>>>
>>>>>>>>>> NAK. Either this fits in the standard model, or we adapt the standard
>>>>>>>>>> model to catter for your particular use case. But we don't define a new,
>>>>>>>>>> TI specific API.
>>>>>>>>>>
>>>>>>>>>> I have a hunch that if the IDs are generated dynamically, then the model
>>>>>>>>>> we use for MSIs would fit this thing. I also want to understand what
>>>>>>>>>
>>>>>>>>> hmm..I haven't thought about using MSI. Will try to explore it. But
>>>>>>>>> the "struct msi_msg" is not applicable in this case as device does not
>>>>>>>>> write to a specific location.
>>>>>>>>
>>>>>>>> It doesn't need to. You can perfectly ignore the address field and
>>>>>>>> only be concerned with the data. We already have MSI users that do not
>>>>>>>> need programming of the doorbell address, just the data.
>>>>>>>
>>>>>>
>>>>>> Just one more clarification.
>>>>>>
>>>>>> First let me explain the IRQ routes a bit deeply. As I said earlier
>>>>>> there are three ways in which IRQ can flow in AM65x SoC
>>>>>> 1) Device directly connected to GIC
>>>>>> 	- Device IRQ --> GIC
>>>>>> 2) Device connected to INTR.
>>>>>> 	- Device IRQ --> INTR --> GIC
>>>>>> 3) Devices connected to INTA.
>>>>>> 	- Device IRQ --> INTA --> INTR --> GIC
>>>>>>
>>>>>> 1 and 2 are straight forward and we use DT for IRQ
>>>>>> representation. Coming to 3 the trickier part is that Input to INTA
>>>>>> and output from INTA and dynamically managed. To be more specific:
>>>>>> - By hardware design there are certain set of physical global
>>>>>> events(interrupts) attached to an INTA. Out of which a certain range
>>>>>> are assigned to the current linux host that can be queried from
>>>>>> system-controller.
>>>>>> - Similarly out of all the INTA outputs(referenced as vints) a certain
>>>>>> range can be used by the current linux host.
>>>>>>
>>>>>>
>>>>>> So for configuring an IRQ route in case 3, the following steps are needed:
>>>>>> - Device id and device resource index for which the interrupt is needed
>>>>>
>>>>> THat is no different from a PCI device for example, where we need the
>>>>> requester ID and the number of the interrupt in the MSI-X table.
>>>>>
>>>>>> - A free event id from the range assigned to the INTA in this host context
>>>>>> - A free vint from the range assigned to the INTA in this host context
>>>>>> - A free gic IRQ from the range assigned to the INTR in this host context.
>>>>>
>>>>>    From what I understand of the driver, at least some of that is under
>>>>> the responsibility of the firmware, right? Or is the driver under
>>>>> control of all three parameters? To be honest, it doesn't really
>>>>
>>>> Driver should control all three parameters.
>>>>
>>>>> matter, as the as far as the kernel is concerned, the irqchip drivers
>>>>> are free to deal with the routing anyway they want.
>>>>
>>>> Correct, that's my understanding as well.
>>>>
>>>>>
>>>>>> With the above information, linux should send a message to
>>>>>> system-controller using TISCI protocol. After policing the given
>>>>>> information, system-controller does the following:
>>>>>> - Attaches the interrupt(INTA input) to the device resource index
>>>>>> - Muxes the interrupt(INTA input) to corresponding vint(INTA output)
>>>>>> - Muxes the vint(INTR input) to GIC irq(INTR output).
>>>>>
>>>>> Isn't there a 1:1 mapping between *used* INTR inputs and outputs?
>>>>> Since INTR is a router, there is no real muxing. I assume that the
>>>>> third point above is just a copy-paste error.
>>>>
>>>> Right, my bad. INTR is just a router and no read muxing.
>>>>
>>>>>
>>>>>>
>>>>>> For grouping of interrupts, the same vint number is to be passed to
>>>>>> system-controller for all the requests.
>>>>>>
>>>>>> Keeping all the above in mind, I see the following as software IRQ
>>>>>> Domain Hierarchy:
>>>>>>
>>>>>> 1) INTA multi MSI --> 2)INTA  -->3) MSI --> 4) INTR  -->5) GIC
>>>>>>
>>>>>> INTA driver has to set a chained IRQ using virq allocated from its
>>>>>> parent MSI. This is to differentiate the grouped interrupts within
>>>>>> INTA.
>>>>>>
>>>>>> Inorder to cover the above two MSI domains, a new bus driver has to be
>>>>>> created as I couldn't find a fit with the existing bus drivers.
>>>>>>
>>>>>> Does the above approach make sense? Please correct me if i am wrong.
>>>>>
>>>>> I think this can be further simplified, as you seem to assume that
>>>>> dynamic allocation implies MSI. This is not the case. You can
>>>>> perfectly use dynamically allocated interrupts and still not use MSIs.
>>>>>
>>>>> INTA is indeed a chained interrupt controller, as it may mux several
>>>>> inputs onto a single output. But the output of INTA is not an MSI. It
>>>>> is just a regular interrupt that can allocated when the first mapping
>>>>> gets established.
>>>>
>>>> okay. I guess it can just be done using irq_create_fwspec_mapping().
>>>>
>>>
>>> I am facing an issue with this approach as I am trying to call
>>> irq_create_fwspec_mapping() from alloc callback of INTA driver. During
>>> allocation the function call flow looks like:
>>>
>>> inta_msi_domain_alloc_irqs()
>>> 	msi_domain_alloc_irqs()
>>> 		__irq_domain_alloc_irqs()
>>> 			*mutex_lock(&irq_domain_mutex);*
>>> 			irq_domain_alloc_irqs_hierarchy()
>>> 				ti_sci_inta_irq_domain_alloc()
>>> 					if (first event in group)
>>> 							irq_create_fwspec_mapping()
>>> 								irq_find_matching_fwspec()
>>> 									*mutex_lock(&irq_domain_mutex);*
>>> 									
>>>
>>> The mutex_lock is called again if INTR IRQ gets allocated in alloc callback of
>>> INTA driver. So I am clearly calling irq_create_fwspec_mapping() from a wrong place.
>>
>> The real issue is that you're are calling irq_create_fwspec_mapping at
>> all. This is only supposed to be called by the high level code, not an
>> irqchip driver in the middle of its own allocation.
>>
>> The right API to use is irq_domain_alloc_irqs_parent(), which calls into
>> the parent domain allocation. See the multiple uses in the tree already.
> 
> But irq_domain_alloc_irqs_parent() doesn't create a new IRQ mapping. Or your 
> suggestion is that when first event mapping gets established in the group, use 
> the same Linux virq number to allocate the parent interrupts?

I had already forgotten that your INTA is the multiplexer in your system.

No, using the same virq is completely wrong, as you must have a unique
irq for each of the outputs lines of your INTA.

One solution would be to pre-allocate all the interrupts for the output
lines at probe time, so that you don't have to do much when the INTA
irqs get allocated.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
