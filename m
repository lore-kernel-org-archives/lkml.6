Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABDAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E932085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FG4QOPQu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pKjJ5/RX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfAGSyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfAGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CDB2608FD; Mon,  7 Jan 2019 18:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546887279;
        bh=WMbrq3G4089ARexzr475dVmKjXoIOG2WzsbqHGRv5zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FG4QOPQuJfov+Yp8vkZ9V9wYNOVr7hRxk6uBhkUFGioZUtW6vroWDaQ+c+Ym8kxoU
         sfepWeUlCQl4Vl/jPuBBJhuilKwkP2i0wNEi8w/Eu0Fw3NHeYyvgCOo8wRUAjQLk81
         VRrLI8Cjz9/+SLxmUFxDrh/exMjQZ74w3XAaPc/8=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BC61608D2;
        Mon,  7 Jan 2019 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546887276;
        bh=WMbrq3G4089ARexzr475dVmKjXoIOG2WzsbqHGRv5zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKjJ5/RXzGCKxAnIf5Q3X/10RnomAq+zbMaqU6w3H2Eas5bdWCd3CcC7rLzLNg6v8
         o4njy3y7f01PIQ27RFECSi1v7SpX10Y45rkefPl/Kvz0O/VEYo/TE6zTpAMEfh8LyF
         HnzJZIKWpJ5A4avQd6xX/ctrogyW9oMzITcivQ8U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BC61608D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 7 Jan 2019 11:54:35 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH 5/7] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
Message-ID: <20190107185435.GJ14960@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
 <20181219221105.3004-6-ilina@codeaurora.org>
 <154533621302.79149.15228907259643696166@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154533621302.79149.15228907259643696166@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20 2018 at 13:03 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-12-19 14:11:03)
>> To allow GPIOs to wakeup the system from suspend or deep idle, the
>> wakeup capable GPIOs are setup in hierarchy with interrupts from the
>> wakeup-parent irqchip.
>>
>> In older SoC's, the TLMM will handover detection to the parent irqchip
>> and in newer SoC's, the parent irqchip may also be active as well as the
>> TLMM and therefore the GPIOs need to be masked at TLMM to avoid
>> duplicate interrupts. To enable both these configurations to exist,
>> allow the parent irqchip to dictate the TLMM irqchip's behavior when
>> masking/unmasking the interrupt.
>>
>> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>
>I don't think I gave a signed-off-by, so you need to ask to forge my
>sign off here. Please change it to be:
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
>and I'm not sure how much I wrote vs. you wrote anymore so perhaps also
>add a
>
> Co-developed-by: Stephen Boyd <swboyd@chromium.org>
>
I meant to do that. I will add this tag instead. Sorry about that.

>And finally, please just email my chromium.org email for this series
>because I apparently messed up the address once and now it's all going
>to the wrong inbox. Thanks!
>
Sure.

>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>
>Can you Cc Linus Walleij and Bjorn Andersson on the whole patch series
>next time? Would be good to have their review on major pinctrl driver
>changes.
>
Bjorn is already included. Will make sure to include Linus in the next
spin.

>> @@ -967,11 +994,86 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
>>         return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
>>  }
>>
>> +static int msm_gpio_domain_translate(struct irq_domain *d,
>> +                                    struct irq_fwspec *fwspec,
>> +                                    unsigned long *hwirq, unsigned int *type)
>> +{
>> +       if (is_of_node(fwspec->fwnode)) {
>> +               if (fwspec->param_count < 2)
>> +                       return -EINVAL;
>> +               *hwirq = fwspec->param[0];
>> +               *type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>> +               return 0;
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>
>Maybe this can be a generic function in gpiolib?
>
>> +
>> +static int msm_gpio_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +                                unsigned int nr_irqs, void *arg)
>> +{
>> +       int ret;
>> +       irq_hw_number_t hwirq;
>> +       struct gpio_chip *gc = domain->host_data;
>> +       struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>> +       struct irq_fwspec *fwspec = arg;
>> +       struct qcom_irq_fwspec parent = { };
>> +       unsigned int type;
>> +
>> +       ret = msm_gpio_domain_translate(domain, fwspec, &hwirq, &type);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
>> +                                           &pctrl->irq_chip, gc);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       if (!domain->parent)
>> +               return 0;
>> +
>> +       parent.fwspec.fwnode      = domain->parent->fwnode;
>> +       parent.fwspec.param_count = 2;
>> +       parent.fwspec.param[0]    = hwirq;
>> +       parent.fwspec.param[1]    = type;
>> +
>> +       ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (parent.mask)
>> +               set_bit(hwirq, pctrl->wakeup_masked_irqs);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * TODO: Get rid of this and push it into gpiochip_to_irq()
>
>Hmm.. yeah we need to do this still. I think we can have a generic two
>cell function similar to irq_domain_xlate_twocell() that does the fwspec
>creation and uses some of the things that we pass to
>gpiochip_irqchip_add(), like the default level type. This existing
>function is not good to have, so there's work to do to get rid of this.
>
>I was also thinking that maybe we can make the alloc function above take
>a struct gpio_irq_fwspec structure that tells the alloc function what
>gpiochip the irq is for. That would mean that we need to change the
>gpio_to_irq() function below to be generic and stuff the chip inside the
>fwspec wrapper structure:
>
>	struct gpio_irq_fwspec {
>		struct irq_fwspec fwspec;
>		struct gpio_chip *chip;
>		unsigned int offset;
>	};
>
>but I seem to recall that was not working for some reason.
>
I didn't attemp this. I am hoping we can solve this even after this
patch set separately. That said, I will try this.

>> + */
>> +static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       struct irq_fwspec fwspec;
>> +
>> +       fwspec.fwnode = of_node_to_fwnode(chip->of_node);
>> +       fwspec.param[0] = offset;
>> +       fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
>> +       fwspec.param_count = 2;
>> +
>> +       return irq_create_fwspec_mapping(&fwspec);
>> +}
>> +
>> +static const struct irq_domain_ops msm_gpio_domain_ops = {
>> +       .translate = msm_gpio_domain_translate,
>> +       .alloc     = msm_gpio_domain_alloc,
>> +       .free      = irq_domain_free_irqs_top,
>> +};
>> +

Thanks,
Lina
