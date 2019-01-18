Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D819C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2478120823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfARJcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:32:10 -0500
Received: from foss.arm.com ([217.140.101.70]:53384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfARJcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:32:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DC6080D;
        Fri, 18 Jan 2019 01:32:06 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02DF43F5C1;
        Fri, 18 Jan 2019 01:32:04 -0800 (PST)
Subject: Re: [PATCH] irqchip/irq-csky-mpintc: Add triger type and priority
 setting
To:     Guo Ren <guoren@kernel.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
References: <1547570199-25944-1-git-send-email-guoren@kernel.org>
 <9c531bec-263c-070d-fed8-d953b42aa185@arm.com>
 <20190118062811.GA19835@guoren-Inspiron-7460>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <bb80062f-28ac-b41c-5d56-90ede82037a2@arm.com>
Date:   Fri, 18 Jan 2019 09:32:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118062811.GA19835@guoren-Inspiron-7460>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2019 06:28, Guo Ren wrote:
> Thx Marc,
> 
> On Thu, Jan 17, 2019 at 05:17:45PM +0000, Marc Zyngier wrote:
>> Hi Guo,
>>
>> On 15/01/2019 16:36, guoren@kernel.org wrote:
>>> From: Guo Ren <ren_guo@c-sky.com>
>>>
>>> Support 4 triger types:
>>>  - IRQ_TYPE_LEVEL_HIGH
>>>  - IRQ_TYPE_LEVEL_LOW
>>>  - IRQ_TYPE_EDGE_RISING
>>>  - IRQ_TYPE_EDGE_FALLING
>>>
>>> Support 0-255 priority setting for each irq.
>>>
>>> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
>>> ---
>>>  .../bindings/interrupt-controller/csky,mpintc.txt  | 24 ++++++-
>>>  drivers/irqchip/irq-csky-mpintc.c                  | 78 +++++++++++++++++++++-
>>>  2 files changed, 99 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
>>> index ab921f1..364b789 100644
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
>>> @@ -11,6 +11,14 @@ Interrupt number definition:
>>>   16-31  : private  irq, and we use 16 as the co-processor timer.
>>>   31-1024: common irq for soc ip.
>>>  
>>> +Interrupt triger mode:
>>> +  IRQ_TYPE_LEVEL_HIGH (default)
>>> +  IRQ_TYPE_LEVEL_LOW
>>> +  IRQ_TYPE_EDGE_RISING
>>> +  IRQ_TYPE_EDGE_FALLING
>>> +
>>> +Interrupt priority range: 0-255
>>> +
>>>  =============================
>>>  intc node bindings definition
>>>  =============================
>>> @@ -26,7 +34,7 @@ intc node bindings definition
>>>  	- #interrupt-cells
>>>  		Usage: required
>>>  		Value type: <u32>
>>> -		Definition: must be <1>
>>> +		Definition: could be <1> or <2>
>>>  	- interrupt-controller:
>>>  		Usage: required
>>>  
>>> @@ -35,6 +43,18 @@ Examples:
>>>  
>>>  	intc: interrupt-controller {
>>>  		compatible = "csky,mpintc";
>>> -		#interrupt-cells = <1>;
>>> +		#interrupt-cells = <2>;
>>>  		interrupt-controller;
>>>  	};
>>> +
>>> +	0: device-example {
>>> +		...
>>> +		interrupts = <33 IRQ_TYPE_EDGE_RISING>;
>>> +		interrupt-parent = <&intc>;
>>> +	};
>>> +
>>> +	1: device-example {
>>> +		...
>>> +		interrupts = <34 ((priority << 4) | IRQ_TYPE_EDGE_RISING)>;
>>> +		interrupt-parent = <&intc>;
>>> +	};
>>> diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
>>> index c67c961..9edc6d3 100644
>>> --- a/drivers/irqchip/irq-csky-mpintc.c
>>> +++ b/drivers/irqchip/irq-csky-mpintc.c
>>> @@ -29,9 +29,12 @@ static void __iomem *INTCL_base;
>>>  
>>>  #define INTCG_ICTLR	0x0
>>>  #define INTCG_CICFGR	0x100
>>> +#define INTCG_CIPRTR	0x200
>>>  #define INTCG_CIDSTR	0x1000
>>>  
>>>  #define INTCL_PICTLR	0x0
>>> +#define INTCL_CFGR	0x14
>>> +#define INTCL_PRTR	0x20
>>>  #define INTCL_SIGR	0x60
>>>  #define INTCL_HPPIR	0x68
>>>  #define INTCL_RDYIR	0x6c
>>> @@ -73,6 +76,78 @@ static void csky_mpintc_eoi(struct irq_data *d)
>>>  	writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
>>>  }
>>>  
>>> +static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
>>> +{
>>> +	unsigned int priority, triger;
>>
>> nit: s/triger/trigger/ everywhere.
> Ok
> 
>>
>>> +	unsigned int offset, bit_offset;
>>> +	void __iomem *reg_base;
>>> +
>>> +	/*
>>> +	 * type Bit field: | 32 - 12  |  11 - 4  |   3 - 0    |
>>> +	 *                   reserved   priority   triger type
>>> +	 */
>>> +	triger	 = type & IRQ_TYPE_SENSE_MASK;
>>> +	priority = (type >> 4) & 0xff;
>>
>> Definitely not. The Linux API to set the trigger does not carry any
>> priority information, nor should it. Priorities should be set
>> statically, and no driver should ever be able to change it.
> Currently priority in dts is:
> 
> 	interrupts = <34 ((priority << 4) | IRQ_TYPE_EDGE_RISING)>;
> 
> change it to:
> 
> 	interrupts = <34 IRQ_TYPE_EDGE_RISING priority>;
> 

I don't think you need to change the DT format, as this is quite painful
for users.

> Implement csky own csky_irq_domain_xlate_cells() ...
> 
> int csky_irq_domain_xlate_cells(struct irq_domain *d, struct device_node *ctrlr,
> 			const u32 *intspec, unsigned int intsize,
> 			irq_hw_number_t *out_hwirq, unsigned int *out_type)
> {
> 	if (WARN_ON(intsize < 1))
> 		return -EINVAL;
> 	*out_hwirq = intspec[0];
> 	if (intsize > 1)
> 		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
> 	else
> 		*out_type = IRQ_TYPE_NONE;
> 
> 	if (intsize > 2)
> 		setup_priority(d->hwirq, intspec[2]);

That's still a problem. Linux doesn't expect interrupts to have
different priorities. All interrupts are equal in that respect, and
interrupt nesting is not something we expect.

I'd be more confident if you programmed a default priority at boot time,
and completely ignored the DT information.

> 
> 	return 0;
> }
> Hmm?
> 
>>
>>> +
>>> +	switch (triger) {
>>> +	case IRQ_TYPE_LEVEL_HIGH:
>>> +		triger = 0;
>>> +		break;
>>> +	case IRQ_TYPE_LEVEL_LOW:
>>> +		triger = 1;
>>> +		break;
>>> +	case IRQ_TYPE_EDGE_RISING:
>>> +		triger = 2;
>>> +		break;
>>> +	case IRQ_TYPE_EDGE_FALLING:
>>> +		triger = 3;
>>
>> Can you define some macros that represent these magic values?
> OK.
>>
>>> +		break;
>>> +	default:
>>> +		triger = 0;
>>> +		break;
>>
>> If you get an invalid combination, you shouldn't blindly accept it, but
>> instead return an error.
> OK.
> 
>>
>>> +	}
>>> +
>>> +	if (d->hwirq < COMM_IRQ_BASE) {
>>> +		reg_base = this_cpu_read(intcl_reg);
>>
>> Are you guaranteed to be in a non-preemptible section here? I can see
>> things going wrong if not.
> 
> ???
> In percpu-def.h, I see this_cpu_read is safe() for preemption or
> interrupt.

Sorry, I wasn't clear, see below.

> What's the wrong with preemption?

The problem is that if the driver calls irq_set_type() on a per-CPU
interrupt without preemption being disabled, it can be preempted at any
point and migrated anywhere before the call to this_cpu_read() takes
place. This means you can never know which CPU you've programmed.

One possible approach is to mandate these interrupts to be only changed
in non-preemptible context, which is what the various ARM GICs do for
their per-CPU interrupts.


> 
>>> +
>>> +		if (triger) {
>>> +			offset = ((d->hwirq * 2) / 32) * 4;
>>> +			bit_offset = (d->hwirq * 2) % 32;
>>
>> This needs to be turned into a set of macros so that the non-percpu code
>> can reuse it.
> 
> 
> #define IRQ_OFFSET(irq) \
> 	((irq < COMM_IRQ_BASE) ? irq : irq - COMM_IRQ_BASE) 
> 
> #define TRIG_VAL(trigger, irq) \
> 	(trigger << ((IRQ_OFFSET(irq) * 2) % 32))
> 
> #define TRIG_VAL_MSK(irq) \
> 	(3 << ((IRQ_OFFSET(irq) * 2) % 32))
> 
> #define TRIG_BASE(irq) \
> 	((((IRQ_OFFSET(irq) * 2) / 32) * 4) + \
> 	((irq < COMM_IRQ_BASE) ? this_cpu_read(intcl_reg) : INTCG_base))
> 
> tmp = readl_relaxed(TRIG_BASE(d->hwirq)) & (~TRIG_VAL_MSK(d->hwirq));
> writel_relaxed(tmp | TRIG_VAL(triger, d->hwirq), TRIG_BASE(d->hwirq));
> 
> Hmm?

I was only looking for something that abstract the offsets, such as:

#define BYTE_OFFSET(i) (((i) * 2) / 32) * 4)
#define BIT_OFFSET(i)  ((i) * 2) % 32)

and keep the rest of the structure as is.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
