Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A638EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D769208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aixJQRhg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b7pCNZhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D769208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH0Ui2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:38:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeH0Ui2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:38:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45A9A60600; Mon, 27 Aug 2018 16:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535388665;
        bh=Whbt4fBIqSqQ7WtLjW3p/q2rj00GYt0D+RU50P4eZok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aixJQRhg/I3INmt0cDgeqFVWYDFKgxFPulKR7LoDZywylhl1QxbbT4SpdfJltfIfX
         9dCSIDy7BWbwWa5tNXOp2xb3K///Hm9prMKVlvevg316UfmGBcF9SpOksAUX9lhzH1
         bnN4FiZ68Mc1MVJd9PWgOqWgUUwSYM8qLMOwpILM=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24BD460117;
        Mon, 27 Aug 2018 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535388664;
        bh=Whbt4fBIqSqQ7WtLjW3p/q2rj00GYt0D+RU50P4eZok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7pCNZhTUAC47uLIdtsRYgPJAczn+VzwHLm86gTlD04gT9w/+V8Qzx7on2EK/QsFP
         KUWjS/7J6ExHwJVLb4t05ZJudMh1JtTa+kQcvobKo90Ttm5sR8adxv6vHMe8WzznsL
         S4OgBtjX2eGLuE2GjxXY1nsa1r2dcaKlcGkhNDr0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24BD460117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 27 Aug 2018 10:51:03 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     marc.zyngier@arm.com, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
Subject: Re: [PATCH v2 1/5] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20180827165103.GQ5081@codeaurora.org>
References: <20180817163849.30750-1-ilina@codeaurora.org>
 <20180817163849.30750-2-ilina@codeaurora.org>
 <20180821060844.GB5603@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180821060844.GB5603@tuxbook-pro>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20 2018 at 00:05 -0600, Bjorn Andersson wrote:
>On Fri 17 Aug 09:38 PDT 2018, Lina Iyer wrote:
>
>Thanks Lina, I think this looks like a very reasonable approach!
>
>> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
>> domain can wakeup the SoC, when interrupts and GPIOs are routed to the
>> its interrupt controller. Only select GPIOs that are deemed wakeup
>> capable are routed to specific PDC pins. During low power state, the
>> pinmux interrupt controller may be non-functional but the PDC would be.
>> The PDC can detect the wakeup GPIO is triggered and bring the TLMM to an
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
>
>Afaict we can model a driver for the MPM hardware - for previous
>platforms - after your PDC driver and all of this logic will be reused.
>
>As such I think it would be better to use the word "wake" instead of
>"pdc" in the implementation. I don't see a problem with the commit
>message being specific and talking about the PDC though, so keep that.
>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v1:
>> 	- Trigger GPIO in h/w from PDC IRQ handler
>> 	- Avoid big tables for GPIO-PDC map, pick from DT instead
>> 	- Use handler_data
>> ---
>>  drivers/pinctrl/qcom/pinctrl-msm.c | 97 ++++++++++++++++++++++++++++++
>>  1 file changed, 97 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index 0e22f52b2a19..03ef1d29d078 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -687,11 +687,15 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>>  	const struct msm_pingroup *g;
>>  	unsigned long flags;
>>  	u32 val;
>> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>>
>>  	g = &pctrl->soc->groups[d->hwirq];
>>
>>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>>
>> +	if (pdc_irqd)
>> +		irq_set_irq_type(pdc_irqd->irq, type);
>> +
>>  	/*
>>  	 * For hw without possibility of detecting both edges
>>  	 */
>> @@ -779,9 +783,13 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>>  	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>>  	unsigned long flags;
>> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>>
>>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>>
>> +	if (pdc_irqd)
>> +		irq_set_irq_wake(pdc_irqd->irq, on);
>> +
>>  	irq_set_irq_wake(pctrl->irq, on);
>
>Given that the TLMM summary logic isn't powered during a collapse, is
>there really a point in toggling the wake of the summary irq? (I wrote
>this, not sure it is correct)
>
>Also, we're not modifying any tlmm state here, so we shouldn't need that
>spinlock.
>
Okay.
>>
>>  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>> @@ -863,6 +871,93 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
>>  	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
>>  }
>>
>> +static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
>> +{
>> +	struct irq_data *irqd = data;
>> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>> +	const struct msm_pingroup *g;
>> +	unsigned long flags;
>> +	u32 val;
>> +
>> +	if (!irqd_is_level_type(irqd)) {
>
>This deserves a comment in the code as well.
>
Will add.

>> +		g = &pctrl->soc->groups[irqd->hwirq];
>> +		raw_spin_lock_irqsave(&pctrl->lock, flags);
>> +		val = BIT(g->intr_status_bit);
>> +		writel(val, pctrl->regs + g->intr_status_reg);
>> +		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int msm_gpio_pdc_pin_request(struct irq_data *d)
>> +{
>> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>> +	struct platform_device *pdev = to_platform_device(pctrl->dev);
>> +	unsigned irq;
>> +	unsigned long trigger;
>> +	const char *pin_name;
>> +	int ret;
>> +
>> +	pin_name = kasprintf(GFP_KERNEL, "gpio%lu", d->hwirq);
>
>pin_name needs to be released in msm_gpio_pdc_pin_release() as well.
>
>> +	if (!pin_name)
>> +		return -ENOMEM;
>> +
>> +	irq = platform_get_irq_byname(pdev, pin_name);
>> +	if (irq < 0) {
>> +		kfree(pin_name);
>> +		return 0;
>> +	}
>> +
>> +	trigger = irqd_get_trigger_type(d) | IRQF_ONESHOT | IRQF_NO_SUSPEND;
>> +	ret = request_irq(irq, wake_irq_gpio_handler, trigger, pin_name, d);
>> +	if (ret) {
>> +		pr_warn("GPIO-%lu could not be set up as wakeup", d->hwirq);
>> +		kfree(pin_name);
>> +		return ret;
>> +	}
>> +
>> +	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
>> +	disable_irq(irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static int msm_gpio_pdc_pin_release(struct irq_data *d)
>> +{
>> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>> +
>> +	if (pdc_irqd) {
>> +		irq_set_handler_data(d->irq, NULL);
>> +		free_irq(pdc_irqd->irq, d);
>
>free_irq() returns what was "pin_name" in msm_gpio_pdc_pin_request(), so
>you should be able to free that.
>
Just realized the return value. Will fix.

Thanks,
Lina

