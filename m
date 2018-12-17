Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35222C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36C72133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbeLQKcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:32:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52940 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731826AbeLQKcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:32:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36D61EBD;
        Mon, 17 Dec 2018 02:32:10 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D9F43F6A8;
        Mon, 17 Dec 2018 02:32:08 -0800 (PST)
Subject: Re: [PATCH v2 2/2] irqchip: add driver for imx-irqsteer controller
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181214102244.21509-1-l.stach@pengutronix.de>
 <20181214102244.21509-3-l.stach@pengutronix.de>
 <86r2ejaztt.wl-marc.zyngier@arm.com> <1545041393.5874.1.camel@pengutronix.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <98217822-208a-9a92-e80b-b0b73111e527@arm.com>
Date:   Mon, 17 Dec 2018 10:32:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1545041393.5874.1.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On 17/12/2018 10:09, Lucas Stach wrote:
> Hi Marc,
> 
> Am Samstag, den 15.12.2018, 09:45 +0000 schrieb Marc Zyngier:
>> Hi Lucas,
>>
>> On Fri, 14 Dec 2018 10:22:44 +0000,
>>> Lucas Stach <l.stach@pengutronix.de> wrote:
>>>
>>> The irqsteer block is a interrupt multiplexer/remapper found on the
>>> i.MX8 line of SoCs.
>>>
>>>>> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
>>>>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>> ---
>>> v2:
>>>  - use raw_spinlock
>>>  - add proper clk error handling
>>>  - align register offset calculation with reality
>>>  - use correct SPDX identifier
>>>  - simplify DT configuration
>>> ---
> 
> [...]
> 
>>> +static const struct irq_domain_ops imx_irqsteer_domain_ops = {
>>>>>>> +	.map		= imx_irqsteer_irq_map,
>>> +	.xlate		= irq_domain_xlate_twocell,
>>
>> I've tried to understand why you are using two cells, but couldn't
>> find an explanation from the DT binding. As far as I can see, you only
>> support LEVEL_HIGH signalling, meaning that you could perfectly
>> encode this in a single cell. What am I missing?
> 
> Nothing. At this point I'm sure that the controller only support level-
> high IRQs. Will switch to a single cell in the next spin.

OK, good.

> 
> [...]
> 
>>> +static int imx_irqsteer_probe(struct platform_device *pdev)
>>> +{
>>>>> +	struct device_node *np = pdev->dev.of_node;
>>>>> +	struct irqsteer_data *data;
>>>>> +	struct resource *res;
>>>>> +	int ret;
>>> +
>>>>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>>>>> +	if (!data)
>>>>> +		return -ENOMEM;
>>> +
>>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>> +	data->regs = devm_ioremap_resource(&pdev->dev, res);
>>>>> +	if (IS_ERR(data->regs)) {
>>>>> +		dev_err(&pdev->dev, "failed to initialize reg\n");
>>>>> +		return PTR_ERR(data->regs);
>>>>> +	}
>>> +
>>>>> +	data->irq = platform_get_irq(pdev, 0);
>>>>> +	if (data->irq <= 0) {
>>>>> +		dev_err(&pdev->dev, "failed to get irq\n");
>>>>> +		return -ENODEV;
>>>>> +	}
>>> +
>>>>> +	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
>>>>> +	if (IS_ERR(data->ipg_clk)) {
>>>>> +		ret = PTR_ERR(data->ipg_clk);
>>>>> +		if (ret != -EPROBE_DEFER)
>>>>> +			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>> +
>>>>> +	raw_spin_lock_init(&data->lock);
>>> +
>>>>> +	of_property_read_u32(np, "fsl,irq-groups", &data->irq_groups);
>>>>> +	of_property_read_u32(np, "fsl,channel", &data->channel);
>>> +
>>>>> +	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
>>>>> +		data->saved_reg = devm_kzalloc(&pdev->dev,
>>>>> +					sizeof(u32) * data->irq_groups * 2,
>>>>> +					GFP_KERNEL);
>>>>> +		if (!data->saved_reg)
>>>>> +			return -ENOMEM;
>>>>> +	}
>>> +
>>>>> +	ret = clk_prepare_enable(data->ipg_clk);
>>>>> +	if (ret) {
>>>>> +		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>> +
>>>>> +	/* steer all IRQs into configured channel */
>>> +	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
>>
>> Could you explain what this channel is exactly?
> 
> I've tired in the cover letter, but seems I still failed, so let me try
> again. ;)
> 
> Each irqsteer instance can be connected to multiple upstream IRQ lines,
> but only one of them can be used at runtime. This register controls
> which output IRQ line will be used by this controller instance. With
> multiple controller instances in the system it's a way to offload the
> decision of the IRQ routing from the hardware to the software guys.
> 
> Let's try to add an example: Suppose there are 2 instances of the
> irqsteer controller. Both are connected to upstream GIC IRQs 20 and 21.
> The channel controls which of those IRQs are used by each instance, so
> there are 2 valid DT configurations in this scenario:
> 
> This is valid:
> 
> irqsteer@0 {
> 	interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>
> 	fsl,channel = <0>;
> };
> 
> irqsteer@1 {
> 	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>
> 	fsl,channel = <1>;
> };
> 
> As well as this:
> 
> irqsteer@0 {
> 	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>
> 	fsl,channel = <1>;
> };
> 
> irqsteer@1 {
> 	interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>
> 	fsl,channel = <0>;
> };

OK, this is now making sense, thanks for that. I'm wondering if it'd
make sense to expose both IRQs in the DT for each irqsteer, and use
fsl,channel as the selector? It doesn't change much in the driver, but
seems to describe the HW in a more complete way.

I don't care much either way, and I'll leave it for you and the DT folks
to decide.

> 	
> [...]
>>> +#ifdef CONFIG_PM_SLEEP
>>> +static void imx_irqsteer_save_regs(struct irqsteer_data *data)
>>> +{
>>>>> +	int num;
>>> +
>>>>> +	for (num = 0; num < data->irq_groups; num++)
>>>>> +		data->saved_reg[num + 1] = readl_relaxed(data->regs +
>>> +						CHANMASK(num, data->irq_groups));
>>
>> You seem to only use one u32 per IRQ group. Yet, you've allocated
>> twice as much memory to that effect. Why? Also, you're avoiding to use
>> index 0, which I find rather odd.
>>
>> Given that the DT binding states that each group manages 64
>> interrupts, I have the feeling that you're missing some interrupt
>> enable state.
> 
> And you are right with this observation. I failed to properly rework
> this part of the code when switching to the irq-group indexing.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
