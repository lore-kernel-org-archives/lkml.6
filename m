Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A5720857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bvb02Crc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MFX67/ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A5720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeIEWGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:06:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIEWGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:06:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 668A9607B5; Wed,  5 Sep 2018 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536168896;
        bh=an1W/mdjmqJJe7AceQs88nCkRKpvn3jrksWF4bbUzOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bvb02Crc6QhXO2X7JABmAsVMrpCDmzyfG7y+LXKYqhrtQfhxhJdZAejxD2z7CCJCn
         JoO8M6DNcuBIaHQUUk5mifgQXXxINUqUijeX556pNDwEuthm6A+9PkYGRu5u+Y/f30
         gq1CmwBlehfvgkzVRaSUZZaIEjw/S0TtKhqAXHnU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30F0C601D9;
        Wed,  5 Sep 2018 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536168895;
        bh=an1W/mdjmqJJe7AceQs88nCkRKpvn3jrksWF4bbUzOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFX67/yeyBvHyp/bhpg9CjGwPM8/DN34ZSPi6F9/4BDBu1ttVLlRGK9B7RptB5NJv
         +NM2qo0ojEnwzMp8Rkack8/mlLEfQMb7+z3e+r/SEyCif9GCXVwJzo7vB3HgeDqmWh
         rho7uChdlfI05LaJQcpc17XNj/qWcRJeScWQp6a4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30F0C601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 5 Sep 2018 11:34:54 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: Re: [PATCH v3 1/5] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20180905173454.GB28215@codeaurora.org>
References: <20180904211810.5506-1-ilina@codeaurora.org>
 <20180904211810.5506-2-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180904211810.5506-2-ilina@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04 2018 at 15:18 -0600, Lina Iyer wrote:
>QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
>domain can wakeup the SoC, when interrupts and GPIOs are routed to its
>interrupt controller. Only select GPIOs that are deemed wakeup capable
>are routed to specific PDC pins. During low power state, the pinmux
>interrupt controller may be non-functional but the PDC would be. The PDC
>can detect the wakeup GPIO is triggered and bring the TLMM to an
>operational state.
>
>Interrupts that are level triggered will be detected at the TLMM when
>the controller becomes operational. Edge interrupts however need to be
>replayed again.
>
>Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
>but keep it disabled. During suspend, we can enable the PDC IRQ instead
>of the GPIO IRQ, which may or not be detected.
>
>Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>---
>Changes in v3:
>	- free action->name
>Changes in v2:
>	- Remove IRQF_NO_SUSPEND and IRQF_ONE_SHOT from PDC IRQ
>Changes in v1:
>	- Trigger GPIO in h/w from PDC IRQ handler
>	- Avoid big tables for GPIO-PDC map, pick from DT instead
>	- Use handler_data
>---
> drivers/pinctrl/qcom/pinctrl-msm.c | 98 ++++++++++++++++++++++++++++++
> 1 file changed, 98 insertions(+)
>
>diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>index 0e22f52b2a19..6527a0a9edd1 100644
>--- a/drivers/pinctrl/qcom/pinctrl-msm.c
>+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>@@ -687,11 +687,15 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> 	const struct msm_pingroup *g;
> 	unsigned long flags;
> 	u32 val;
>+	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>
> 	g = &pctrl->soc->groups[d->hwirq];
>
> 	raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>+	if (pdc_irqd)
>+		irq_set_irq_type(pdc_irqd->irq, type);
>+
> 	/*
> 	 * For hw without possibility of detecting both edges
> 	 */
>@@ -779,9 +783,13 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
> 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> 	unsigned long flags;
>+	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>
> 	raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>+	if (pdc_irqd)
>+		irq_set_irq_wake(pdc_irqd->irq, on);
>+
> 	irq_set_irq_wake(pctrl->irq, on);
>
> 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>@@ -863,6 +871,94 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
> 	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
> }
>
>+static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
>+{
>+	struct irq_data *irqd = data;
>+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>+	const struct msm_pingroup *g;
>+	unsigned long flags;
>+	u32 val;
>+
>+	if (!irqd_is_level_type(irqd)) {
>+		g = &pctrl->soc->groups[irqd->hwirq];
>+		raw_spin_lock_irqsave(&pctrl->lock, flags);
>+		val = BIT(g->intr_status_bit);
>+		writel(val, pctrl->regs + g->intr_status_reg);
>+		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>+	}
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static int msm_gpio_pdc_pin_request(struct irq_data *d)
>+{
>+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>+	struct platform_device *pdev = to_platform_device(pctrl->dev);
>+	const char *pin_name;
>+	int irq;
>+	int ret;
>+
>+	pin_name = kasprintf(GFP_KERNEL, "gpio%lu", d->hwirq);
>+	if (!pin_name)
>+		return -ENOMEM;
>+
>+	irq = platform_get_irq_byname(pdev, pin_name);
>+	if (irq < 0) {
>+		kfree(pin_name);
>+		return 0;
>+	}
>+
>+	ret = request_irq(irq, wake_irq_gpio_handler, irqd_get_trigger_type(d),
>+			  pin_name, d);
>+	if (ret) {
>+		pr_warn("GPIO-%lu could not be set up as wakeup", d->hwirq);
Need to end with '\n'.

>+		kfree(pin_name);
>+		return ret;
>+	}
>+
>+	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
>+	disable_irq(irq);
>+
>+	return 0;
>+}
>+
>+static int msm_gpio_pdc_pin_release(struct irq_data *d)
>+{
>+	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>+	const void *name;
>+
>+	if (pdc_irqd) {
>+		irq_set_handler_data(d->irq, NULL);
>+		name = free_irq(pdc_irqd->irq, d);
>+		kfree(name);
>+	}
>+
>+	return 0;
>+}
>+
>+static int msm_gpio_irq_reqres(struct irq_data *d)
>+{
>+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>+
>+	if (gpiochip_lock_as_irq(gc, irqd_to_hwirq(d))) {
>+		dev_err(gc->parent, "unable to lock HW IRQ %lu for IRQ\n",
>+			irqd_to_hwirq(d));
>+		return -EINVAL;
>+	}
>+
>+	return msm_gpio_pdc_pin_request(d);
>+}
>+
>+static void msm_gpio_irq_relres(struct irq_data *d)
>+{
>+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>+
>+	msm_gpio_pdc_pin_release(d);
>+	gpiochip_unlock_as_irq(gc, irqd_to_hwirq(d));
>+}
>+
> static int msm_gpio_init(struct msm_pinctrl *pctrl)
> {
> 	struct gpio_chip *chip;
>@@ -887,6 +983,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
> 	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
> 	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
> 	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
>+	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
>+	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
>
> 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
> 	if (ret) {
>--
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
