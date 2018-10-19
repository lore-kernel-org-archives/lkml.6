Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB10ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6D621470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6D621470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJTAA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:00:26 -0400
Received: from foss.arm.com ([217.140.101.70]:55338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbeJTAA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:00:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C1C80D;
        Fri, 19 Oct 2018 08:53:44 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8F053F71A;
        Fri, 19 Oct 2018 08:53:43 -0700 (PDT)
Subject: Re: [PATCH RFC 1/1] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
To:     Lina Iyer <ilina@codeaurora.org>, sboyd@kernel.org,
        evgreen@chromium.org
Cc:     linux-kernel@vger.kernel.org
References: <20181011002958.2597-1-ilina@codeaurora.org>
 <20181011002958.2597-2-ilina@codeaurora.org>
 <20181019153222.GA17444@codeaurora.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <ad6e314b-2d68-2a77-b77c-54cade0fe0b2@arm.com>
Date:   Fri, 19 Oct 2018 16:53:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019153222.GA17444@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On 19/10/18 16:32, Lina Iyer wrote:
> Hi folks,
> 
> On Wed, Oct 10 2018 at 18:30 -0600, Lina Iyer wrote:
>> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
>> domain can wakeup the SoC, when interrupts and GPIOs are routed to its
>> interrupt controller. Only select GPIOs that are deemed wakeup capable
>> are routed to specific PDC pins. During low power state, the pinmux
>> interrupt controller may be non-functional but the PDC would be. The PDC
>> can detect the wakeup GPIO is triggered and bring the TLMM to an
>> operational state.
>>
>> Interrupts that are level triggered will be detected at the TLMM when
>> the controller becomes operational. Edge interrupts however need to be
>> replayed again.
>>
>> Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
>> but keep it disabled. During suspend, we can enable the PDC IRQ instead
>> of the GPIO IRQ, which may or not be detected.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v4:
>> 	- Redesign to use PDC interrupts instead of TLMM interrupt
>> Changes in v3:
>> 	- free action->name
>> Changes in v2:
>> 	- Remove IRQF_NO_SUSPEND and IRQF_ONE_SHOT from PDC IRQ
>> Changes in v1:
>> 	- Trigger GPIO in h/w from PDC IRQ handler
>> 	- Avoid big tables for GPIO-PDC map, pick from DT instead
>> 	- Use handler_data
>> ---
>> drivers/pinctrl/qcom/pinctrl-msm.c | 91 +++++++++++++++++++++++++++++-
>> 1 file changed, 90 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index 5d72ffad32c2..70b9178eba30 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -719,6 +719,12 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>> 	const struct msm_pingroup *g;
>> 	unsigned long flags;
>> 	u32 val;
>> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>> +
>> +	if (pdc_irqd) {
>> +		irq_set_irq_type(pdc_irqd->irq, type);
>> +		goto handler;
>> +	}
>>
>> 	g = &pctrl->soc->groups[d->hwirq];
>>
>> @@ -798,6 +804,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>>
>> 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>>
>> +handler:
>> 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
>> 		irq_set_handler_locked(d, handle_level_irq);
>> 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>> @@ -811,9 +818,13 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>> 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>> 	unsigned long flags;
>> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>>
>> 	raw_spin_lock_irqsave(&pctrl->lock, flags);
>>
>> +	if (pdc_irqd)
>> +		irq_set_irq_wake(pdc_irqd->irq, on);
>> +
>> 	irq_set_irq_wake(pctrl->irq, on);
>>
>> 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>> @@ -895,6 +906,83 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
>> 	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
>> }
>>
>> +static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
>> +{
>> +	struct irq_data *irqd = data;
>> +	struct irq_desc *desc = irq_to_desc(irqd->irq);
>> +
>> +	desc->handle_irq(desc);
> Do we see any problem calling handle_irq()?

Good timing, I was just looking at this.

One thing I can see is that you will end-up calling the EOI callback on
the root interrupt controller (the GIC), thus writing to ICC_EOIR1_EL1.

But you've never acked this interrupt the first place by reading
ICC_IAR1_EL1, and that puts you violently out of spec, according to the
GICv3 spec (8.2.10), which reads:

"A write to this register must correspond to the most recent valid read
by this PE from an Interrupt Acknowledge Register, and must correspond
to the INTID that was read from ICC_IAR1_EL1, otherwise the system
behavior is UNPREDICTABLE."

Here, you definitely risk the sanity of the CPU interface state machine.

So stepping back a bit: At some point, you had a version that just
relied on regenerating edge interrupts by writing to some register
(knowing that level interrupts are safe by definition). Why isn't that
the right solution? It'd avoid the above minefield by just letting the
HW do its thing...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
