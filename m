Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CF1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D770B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iOux1LeB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QPBZ+PNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D770B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbeHAVdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:33:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbeHAVdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:33:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 373CD6035F; Wed,  1 Aug 2018 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533152740;
        bh=U8oCh3hlLFxpJw9g2baQ3Rv7nkfa29qldCVGJXUO564=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOux1LeBc73nh9UdD9alTgqk0bARors3k/e+1ZoKNo/WpxhUx4NNphOFVsoRefRes
         J5e9NU2DE0QOzoFVgTcJ2qJqtXMJD2wgX/sfBRo2KP0JjtguPX9SZcfDFaE8RtY8tR
         i/I/QPfUHy3H3rsGv5tdzQijRTT+UhRzeEWikpj8=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDF9F602D7;
        Wed,  1 Aug 2018 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533152739;
        bh=U8oCh3hlLFxpJw9g2baQ3Rv7nkfa29qldCVGJXUO564=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPBZ+PNw9tMMJtccJQuMJNuSDHIp0OmDI3kMppt/NDKybmLbth8n49esJlIccVOgY
         9Kqt+711RXRxYsRC80Do3EHFyhMWA04gyF7NKzLYPVJLCm9eDWHNTpiNs6U9+b9O0+
         M9Iv+2NzfFtLWdGFJGBYzzRU5160FXdiW2OZdByc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDF9F602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 1 Aug 2018 13:45:38 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND RFC 1/4] drivers: pinctrl: qcom: add wakeup
 capability to GPIO
Message-ID: <20180801194538.GA6422@codeaurora.org>
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801020021.9782-2-ilina@codeaurora.org>
 <86600uy4vh.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86600uy4vh.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback, Marc.

On Wed, Aug 01 2018 at 00:31 -0600, Marc Zyngier wrote:
>On Wed, 01 Aug 2018 03:00:18 +0100,
>Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> +static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
>> +{
>> +	struct irq_data *irqd = data;
>> +	struct irq_desc *desc = irq_data_to_desc(irqd);
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>> +	int irq_pin = irq_find_mapping(gc->irq.domain, irqd->hwirq);
>> +
>> +	chained_irq_enter(chip, desc);
>> +	generic_handle_irq(irq_pin);
>> +	chained_irq_exit(chip, desc);
>
>That's crazy. I'm not even commenting on the irq handler vs chained
>irqchip thing, but directly calling into a completely different part
>of the irq hierarchy makes me feel nauseous,
>
I know the sentiment; I am not too happy about it myself. Explanation
below.

>Why isn't the interrupt still pending at the pinctrl level? Looking at
>the diagram in the cover letter, I'd have hoped that the signal routed
>to the PDC would wakeup the GIC, but that by virtue of being *also*
>wired to the TLMM, the interrupt would be handled via the normal path.
>
The short answer: TLMM is not active to sense a wakeup interrupt.

When we enter system sleep mode, the TLMM and the GIC are powered off
and the PDC is the only powered-on interrupt controller. The IRQs
configured at the PDC are the only ones capable of waking the system.
Upon sensing the interrupt, the PDC intiates a system wakeup and replays
the interrupt to the GIC. The GIC relays that to AP. Unfortunately, the
interrupts from the GPIO do not trigger the TLMM summary line. Therefore
this handler needs to figure out what GPIO caused the wakeup and notify
the corresponding driver.

>Why isn't that the case? And if that's because the HW is broken and
>doesn't buffer edge interrupts, why can't you use the resend mechanism
>instead?
>
The PDC hardware can replay the interrupts accurately. However, it will
replay only the pin and its not the TLMM summary IRQ. The handler here,
needs to notify the driver that the wakeup interrupt happened and needs
to take action. If I could trip the summary IRQ in this handler that
would work too. Can it be done?

>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int msm_gpio_pdc_pin_request(struct irq_data *d)
>> +{
>> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>> +	struct platform_device *pdev = to_platform_device(pctrl->dev);
>> +	unsigned pin, npins, irq;
>> +	struct wakeup_gpio_irq_map *p;
>> +	unsigned long flags, trigger;
>> +	const char *pin_name;
>> +	int i, ret;
>> +
>> +	pin = msm_gpio_get_pdc_pin(pctrl, d->hwirq);
>> +	if (pin < 0)
>> +		return 0;
>> +
>> +	npins = platform_irq_count(pdev);
>> +	if (npins <= 0)
>> +		return npins;
>> +
>> +	for (i = 0; i < npins; i++) {
>> +		irq = platform_get_irq(pdev, i);
>> +		if (irq >= 0 && pin == irq_get_irq_data(irq)->hwirq)
>> +			break;
>> +	}
>> +	if (i == npins)
>> +		return 0;
>> +
>> +	pin_name = kasprintf(GFP_KERNEL, "gpio-%lu", d->hwirq);
>> +	if (!pin_name)
>> +		return -ENOMEM;
>> +
>> +	trigger = irqd_get_trigger_type(d) | IRQF_ONESHOT | IRQF_NO_SUSPEND;
>> +	ret = request_irq(irq, wake_irq_gpio_handler, trigger, pin_name, d);
>> +	if (ret) {
>> +		pr_warn("GPIO-%lu could not be set up as wakeup", d->hwirq);
>> +		return ret;
>> +	}
>> +
>> +	p = kzalloc(sizeof(p), GFP_KERNEL);
>> +	if (!p)
>> +		return -ENOMEM;
>> +
>> +	p->pdc_irq = irq;
>> +	p->gpio = d->hwirq;
>> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
>> +	list_add(&p->list, &pctrl->pdc_irqs);
>> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>
>This whole list business seems bizarre. Why don't you use the
>handler_data instead?
>
Ah, sure.

>> +
>> +	return 0;
>> +}
>> +
>> +static int msm_gpio_pdc_pin_release(struct irq_data *d)
>> +{
>> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>> +	struct wakeup_gpio_irq_map *p, *n, *t = NULL;
>> +	unsigned long flags;
>> +
>> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
>> +	list_for_each_entry_safe(p, n, &pctrl->pdc_irqs, list) {
>> +		if (p->gpio == d->hwirq) {
>> +			list_del(&p->list);
>> +			t = p;
>> +			break;
>> +		}
>> +	}
>> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>> +	if (t) {
>> +		free_irq(t->pdc_irq, NULL);
>
>NULL? This should balance with the request_irq call, I believe.
>
Sorry, yes. I forgot to port the change from the test branch to here.

>> +		kfree(t);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int msm_gpio_irq_reqres(struct irq_data *d)
>> +{
>> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> +
>> +	if (gpiochip_lock_as_irq(gc, irqd_to_hwirq(d))) {
>> +		dev_err(gc->parent,"unable to lock HW IRQ %lu for IRQ\n",
>> +			irqd_to_hwirq(d));
>> +		return -EINVAL;
>> +	}
>> +
>> +	return msm_gpio_pdc_pin_request(d);
>> +}
>> +
>> +static void msm_gpio_irq_relres(struct irq_data *d)
>> +{
>> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> +
>> +	msm_gpio_pdc_pin_release(d);
>> +	gpiochip_unlock_as_irq(gc, irqd_to_hwirq(d));
>> +}
>> +
>>  static int msm_gpio_init(struct msm_pinctrl *pctrl)
>>  {
>>  	struct gpio_chip *chip;
>> @@ -887,6 +1047,9 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>>  	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
>>  	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
>>  	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
>> +	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
>> +	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
>> +	INIT_LIST_HEAD(&pctrl->pdc_irqs);
>>
>>  	ret = gpiochip_add_data(&pctrl->chip, pctrl);
>>  	if (ret) {
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
>> index 9b9feea540ff..5b7f3160affe 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
>> @@ -97,6 +97,16 @@ struct msm_pingroup {
>>  	unsigned intr_detection_width:5;
>>  };
>>
>> +/**
>> + * struct msm_pinctrl_pdc_map - Map GPIOs to PDC pins on RPMH based SoCs
>> + * @hwirq:	   The GPIO that is mapped.
>> + * @pdc_pin:	   The PDC pin to with the GPIO IRQ line is routed.
>> + */
>> +struct msm_pinctrl_pdc_map {
>> +	u32 hwirq;
>> +	u32 pdc_pin;
>> +};
>> +
>>  /**
>>   * struct msm_pinctrl_soc_data - Qualcomm pin controller driver configuration
>>   * @pins:	    An array describing all pins the pin controller affects.
>> @@ -107,6 +117,8 @@ struct msm_pingroup {
>>   * @ngroups:	    The numbmer of entries in @groups.
>>   * @ngpio:	    The number of pingroups the driver should expose as GPIOs.
>>   * @pull_no_keeper: The SoC does not support keeper bias.
>> + * @pdc_map:	    The map of GPIOs to the always-on PDC interrupt lines.
>> + * @npdc_pins:	    The number of GPIOs mapped to the PDC pins in @pdc_map.
>>   */
>>  struct msm_pinctrl_soc_data {
>>  	const struct pinctrl_pin_desc *pins;
>> @@ -117,6 +129,8 @@ struct msm_pinctrl_soc_data {
>>  	unsigned ngroups;
>>  	unsigned ngpios;
>>  	bool pull_no_keeper;
>> +	struct msm_pinctrl_pdc_map *pdc_map;
>> +	unsigned npdc_pins;
>>  };
>>
>>  int msm_pinctrl_probe(struct platform_device *pdev,
>
>I find the whole thing terrifying, the most scary part being the
>hand-crafted injection of the interrupt. I'd appreciate some insights
>on how the pinctl HW is supposed to buffer things, and why its
>summary IRQ isn't visible to the GIC after wakeup.
>
Since the TLMM is not powered-on it will not sense the wakeup GPIO. The
summary IRQ is also not triggered. If there is a good way to get the
action->handler from the GPIO's latent IRQ and set it on the PDC IRQ, I
think it might work.

Thanks,
Lina
