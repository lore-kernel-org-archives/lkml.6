Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC9EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6550A20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6550A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeJZPQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:16:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37710 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:16:53 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9Q6dp69114971;
        Fri, 26 Oct 2018 01:39:51 -0500
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9Q6dp86022110
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Oct 2018 01:39:51 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 26
 Oct 2018 01:39:50 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 26 Oct 2018 01:39:50 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9Q6dkAX019824;
        Fri, 26 Oct 2018 01:39:47 -0500
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <b3a71622-7734-04be-0b0c-38e9dc6542d4@ti.com>
Date:   Fri, 26 Oct 2018 12:09:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <86va5ssrfm.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tuesday 23 October 2018 07:20 PM, Marc Zyngier wrote:
> Hi Lokesh,
> 
> On Mon, 22 Oct 2018 15:35:41 +0100,
> Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>
>> Hi Marc,
>>
>> On Friday 19 October 2018 08:52 PM, Marc Zyngier wrote:
>>> Hi Lokesh,
>>>
>>> On 18/10/18 16:40, Lokesh Vutla wrote:
>>>> Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
>>>> which is an interrupt controller that does the following:
>>>> - Converts events to interrupts that can be understood by
>>>>     an interrupt router.
>>>> - Allows for multiplexing of events to interrupts.
>>>> - Allows for grouping of multiple events to a single interrupt.
>>>
>>> Aren't the last two points the same thing? Also, can you please define
>>> what an "event" is? What is its semantic? If they look like interrupts,
>>> can we just name them as such?
>>
>> Event is actually a message sent by a master via an Event transport
>> lane. Based on the id within the message, each message is directed to
>> corresponding Interrupt Aggregator(IA). In turn IA raises a
>> corresponding interrupt as configured for this event.
> 
> Ergo, this is an interrupt, and there is nothing more to it. HW folks
> may want to give it a sexy name, but as far as SW is concerned, it has
> the properties of an interrupt and should be modelled as such.
> 
> [...]
> 
>>>> +	for_each_set_bit(bit, vint_desc->event_map, MAX_EVENTS_PER_VINT) {
>>>> +		val = 1 << bit;
>>>> +		__raw_writeq(val, inta->base + data->hwirq * 0x1000 +
>>>> +			     VINT_ENABLE_CLR_OFFSET);
>>>> +	}
>>>
>>> If you need an ack callback, why is this part of the eoi? We have
>>> interrupt flows that allow you to combine both, so why don't you use that?
>>
>> Actually I started with ack_irq. But I did not see this callback being
>> triggered when interrupt is raised. Then I was suggested to use
>> irq_roi. Will see why ack_irq is not being triggered and  update it in
>> next version.
> 
> It is probably because you're not using the right interrupt flow.
> 
>>> Also, the __raw_writeq call is probably wrong, as it assumes that both
>>> the CPU and the INTA have the same endianness.
>>
>> hmm.. May I know what is the right call to use here?
> 
> writeq_relaxed is most probably what you want. I assume this code will
> never run on a 32bit platform, right?
> 
> [...]
> 
>>>> +/**
>>>> + * ti_sci_inta_irq_domain_free() - Free an IRQ from the IRQ domain
>>>> + * @domain:	Domain to which the irqs belong
>>>> + * @virq:	base linux virtual IRQ to be freed.
>>>> + * @nr_irqs:	Number of continuous irqs to be freed
>>>> + */
>>>> +static void ti_sci_inta_irq_domain_free(struct irq_domain *domain,
>>>> +					unsigned int virq, unsigned int nr_irqs)
>>>> +{
>>>> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
>>>> +	struct ti_sci_inta_vint_desc *vint_desc;
>>>> +	struct irq_data *data, *gic_data;
>>>> +	int event_index;
>>>> +
>>>> +	data = irq_domain_get_irq_data(domain, virq);
>>>> +	gic_data = irq_domain_get_irq_data(domain->parent->parent, virq);
>>>
>>> That's absolutely horrid...
>>
>> I agree. But I need to get GIC irq for sending TISCI message. Can you
>> suggest a better way of doing it?
> 
> I'd say "fix the firmware to have a layered approach". But I guess
> that's not an option, right?

yeah, we cannot change the APIs now.

> 
> [...]
> 
>>>> +/**
>>>> + * ti_sci_allocate_event_irq() - Allocate an event to a IA vint.
>>>> + * @inta:	Pointer to Interrupt Aggregator IRQ domain
>>>> + * @vint_desc:	Virtual interrupt descriptor to which the event gets attached.
>>>> + * @src_id:	TISCI device id of the event source
>>>> + * @src_index:	Event index with in the device.
>>>> + * @dst_irq:	Destination host irq
>>>> + * @vint:	Interrupt number within interrupt aggregator.
>>>> + *
>>>> + * Return 0 if all went ok else appropriate error value.
>>>> + */
>>>> +static int ti_sci_allocate_event_irq(struct ti_sci_inta_irq_domain *inta,
>>>> +				     struct ti_sci_inta_vint_desc *vint_desc,
>>>> +				     u16 src_id, u16 src_index, u16 dst_irq,
>>>> +				     u16 vint)
>>>> +{
>>>> +	struct ti_sci_inta_event_desc *event;
>>>> +	unsigned long flags;
>>>> +	u32 free_bit;
>>>> +	int err;
>>>> +
>>>> +	raw_spin_lock_irqsave(&vint_desc->lock, flags);
>>>> +	free_bit = find_first_zero_bit(vint_desc->event_map,
>>>> +				       MAX_EVENTS_PER_VINT);
>>>> +	if (free_bit != MAX_EVENTS_PER_VINT)
>>>> +		set_bit(free_bit, vint_desc->event_map);
>>>> +	raw_spin_unlock_irqrestore(&vint_desc->lock, flags);
>>>
>>> Why disabling the interrupts? Do you expect to take this lock
>>> concurrently with an interrupt? Why isn't it enough to just have a mutex
>>> instead?
>>
>> I have thought about this while coding. We are attaching multiple
>> events to the same interrupt. Technically the events from different
>> IPs can be attached to the same interrupt or events from the same IP
>> can be registered at different times. So I thought it is possible that
>> when an event is being allocated to an interrupt, an event can be
>> raised that belongs to the same interrupt.
> 
> I strongly dispute this. Events are interrupts, and we're not
> requesting an interrupt from an interrupt handler. That would be just
> crazy.

okay, will use mutex instead.

> 
> [...]
> 
>>>> +/**
>>>> + * ti_sci_inta_register_event() - Register a event to an interrupt aggregator
>>>> + * @dev:	Device pointer to source generating the event
>>>> + * @src_id:	TISCI device ID of the event source
>>>> + * @src_index:	Event source index within the device.
>>>> + * @virq:	Linux Virtual IRQ number
>>>> + * @flags:	Corresponding IRQ flags
>>>> + * @ack_needed:	If explicit clearing of event is required.
>>>> + *
>>>> + * Creates a new irq and attaches to IA domain if virq is not specified
>>>> + * else attaches the event to vint corresponding to virq.
>>>> + * When using TISCI within the client drivers, source indexes are always
>>>> + * generated dynamically and cannot be represented in DT. So client
>>>> + * drivers should call this API instead of platform_get_irq().
>>>
>>> NAK. Either this fits in the standard model, or we adapt the standard
>>> model to catter for your particular use case. But we don't define a new,
>>> TI specific API.
>>>
>>> I have a hunch that if the IDs are generated dynamically, then the model
>>> we use for MSIs would fit this thing. I also want to understand what
>>
>> hmm..I haven't thought about using MSI. Will try to explore it. But
>> the "struct msi_msg" is not applicable in this case as device does not
>> write to a specific location.
> 
> It doesn't need to. You can perfectly ignore the address field and
> only be concerned with the data. We already have MSI users that do not
> need programming of the doorbell address, just the data.

Okay. I am reworking towards using MSI for this case. Will post the series once 
it is done.

Once again, Thanks for the clear explanation.

Thanks and regards,
Lokesh

> 
>>
>>> this event is, and how drivers get notified that such an event has fired.
>>
>> As said above, Event is a message being sent by a device using a
>> hardware protocol. This message is sent over an Event Transport
>> Lane(ETL) that understands this protocol. Based on the message ETL re
>> directs the message to a specificed target(In our case it is interrupt
>> Aggregator).
>>
>>  From a client drivers(that generates this event) prespective, the
>> following needs to be done:
>> - Get an index that is free and allocate it to a particular task.
>> - Request INTA driver to assign an irq for this index.
>> - do a request_irq baseed on the return value from the above step.
> 
> All of that can be done in the using the current MSI framework. You
> can either implement your own bus framework or use the platform MSI
> stuff. You can then rewrite the INTA driver to be what it really is,
> an interrupt multiplexer.
> 
>> In case of grouping events, the client drivers has its own mechanism
>> to identify the index that caused an interrupt(at least that is the
>> case for the existing user).
> 
> This simply isn't acceptable. Each event must be the result of a
> single interrupt allocation from the point of view of the driver. If
> events are shared, they should be modelled as a shared interrupt.
> 
> Overall, I'm extremely concerned that you're reinventing the wheel and
> coming up with a new "concept" that seems incredibly similar to what
> we already have everywhere else, just offering an incompatible
> API. This means that your drivers become specialised for your new API,
> and this isn't going to fly.
> 
> I can only urge you to reconsider the way you provide these events,
> and make sure that you use the existing API to its full potential. If
> something is not up to the task, we can then fix it in core code.
> 
> Thanks,
> 
> 	M.
> 
