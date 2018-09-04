Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5958C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB0D2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X1CX6Fru";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dr+sMPlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB0D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeIDWRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:17:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDWRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:17:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E5B8460445; Tue,  4 Sep 2018 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536083464;
        bh=9Qh1nWsiu8b0NyuqHgIQSth6IuEw7kSOE/rOv3+Mo+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1CX6FruEzZ7GYiaHcIbMQO0MwDGC+zldVKx1GziMsDtnIYUIlppilMXMeW3no+AD
         rwEmYBMNQpBd3GEH2I5CjAyMR7vKu5fTpfJdgqpv0Kl2yKJcKXFihgRsnueoDr+o/C
         i5HIqeRMpXY90Ts1lvySdzvo78MAsv/w45b8PAVA=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A76D860388;
        Tue,  4 Sep 2018 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536083463;
        bh=9Qh1nWsiu8b0NyuqHgIQSth6IuEw7kSOE/rOv3+Mo+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dr+sMPlzEgPC6SI/+N+HZBCr+6T417QXC9BnH3bot/QvH68D8nNYmXrBMRgJnJ+Ba
         DuG9F6lz5+BtoPzu0Rb3nRzY4vysUrXLcByggK6drM1fvk9YiV6j1uOPgwn4JsflJ/
         GmADwl3h3qrSyZLIQwRhucrsWuQx+mb1r1ftDyXE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A76D860388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 4 Sep 2018 11:51:02 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: Re: [PATCH v2 1/5] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20180904175102.GB3622@codeaurora.org>
References: <20180824200157.9993-1-ilina@codeaurora.org>
 <20180824200157.9993-2-ilina@codeaurora.org>
 <20180827223502.GV160295@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180827223502.GV160295@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27 2018 at 16:35 -0600, Matthias Kaehlcke wrote:
>Hi Lina,
>
>On Fri, Aug 24, 2018 at 02:01:53PM -0600, Lina Iyer wrote:
>> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
>> domain can wakeup the SoC, when interrupts and GPIOs are routed to the
>> its interrupt controller. Only select GPIOs that are deemed wakeup
>
>wording nit: "are routed to the|its interrupt controller"
>
Okay.

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
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v2:
>> 	- Remove IRQF_NO_SUSPEND and IRQF_ONE_SHOT from PDC IRQ
>> Changes in v1:
>> 	- Trigger GPIO in h/w from PDC IRQ handler
>> 	- Avoid big tables for GPIO-PDC map, pick from DT instead
>> 	- Use handler_data
>> ---
>>  drivers/pinctrl/qcom/pinctrl-msm.c | 96 ++++++++++++++++++++++++++++++
>>  1 file changed, 96 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index 0e22f52b2a19..b675ea56a4ff 100644
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
>>
>>  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>> @@ -863,6 +871,92 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
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
>> +	const char *pin_name;
>> +	int irq;
>> +	int ret;
>> +
>> +	pin_name = kasprintf(GFP_KERNEL, "gpio%lu", d->hwirq);
>> +	if (!pin_name)
>> +		return -ENOMEM;
>> +
>> +	irq = platform_get_irq_byname(pdev, pin_name);
>> +	if (irq < 0) {
>> +		kfree(pin_name);
>> +		return 0;
>
>Do I understand correctly that this is the case where the pin isn't
>routed to the PDC?
>
Yes, correct.

>> +	}
>> +
>> +	ret = request_irq(irq, wake_irq_gpio_handler, irqd_get_trigger_type(d),
>> +			  pin_name, d);
>> +	if (ret) {
>> +		pr_warn("GPIO-%lu could not be set up as wakeup", d->hwirq);
>
>'\n' is missing
>
ok.
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
>You need to free 'pin_name' allocated in msm_gpio_pdc_pin_request().
>IIUC it should be available in irq_desc->action->name.
>
Yes, I didn't realize that free_irq returns the name when I posted this
series (noted in the cover letter). Will fix.

-- Lina

