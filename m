Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E23C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A3521872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGKE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:04:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34764 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfBGKE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:04:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14601EBD;
        Thu,  7 Feb 2019 02:04:57 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 985153F589;
        Thu,  7 Feb 2019 02:04:52 -0800 (PST)
Subject: Re: [PATCH 4/6] mfd: Add support for the MediaTek MT6358 PMIC
To:     Lee Jones <lee.jones@linaro.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, tglx@linutronix.de,
        jason@lakedaemon.net
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-5-git-send-email-hsin-hsiung.wang@mediatek.com>
 <20190207093450.GH4672@dell>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <345df368-b247-9c4b-a69d-e95f14bff8b6@arm.com>
Date:   Thu, 7 Feb 2019 10:04:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207093450.GH4672@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 07/02/2019 09:34, Lee Jones wrote:
> Thomas, et al.,
> 
> Please could you take a look at this?
> 
> I need some IRQ related guidance.  TIA.
> 
> On Wed, 30 Jan 2019, Hsin-Hsiung Wang wrote:
> 
>> This adds support for the MediaTek MT6358 PMIC. This is a
>> multifunction device with the following sub modules:
>>
>> - Regulator
>> - RTC
>> - Codec
>> - Interrupt
>>
>> It is interfaced to the host controller using SPI interface
>> by a proprietary hardware called PMIC wrapper or pwrap.
>> MT6358 MFD is a child device of the pwrap.
>>
>> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
>> ---
>>  drivers/mfd/Makefile                 |    2 +-
>>  drivers/mfd/mt6358-irq.c             |  236 +++++
>>  drivers/mfd/mt6397-core.c            |   62 +-
>>  include/linux/mfd/mt6358/core.h      |  158 +++
>>  include/linux/mfd/mt6358/registers.h | 1926 ++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/mt6397/core.h      |    3 +
>>  6 files changed, 2385 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/mfd/mt6358-irq.c
>>  create mode 100644 include/linux/mfd/mt6358/core.h
>>  create mode 100644 include/linux/mfd/mt6358/registers.h
>>
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 088e249..50be021 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -230,7 +230,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
>>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
>> -obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o mt6397-irq.o
>> +obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o mt6397-irq.o mt6358-irq.o
>>  
>>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
>>  obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
>> diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
>> new file mode 100644
>> index 0000000..b29fdc1
>> --- /dev/null
>> +++ b/drivers/mfd/mt6358-irq.c
>> @@ -0,0 +1,236 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (c) 2019 MediaTek Inc.
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/mfd/mt6358/core.h>
>> +#include <linux/mfd/mt6358/registers.h>
>> +#include <linux/mfd/mt6397/core.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +static struct irq_top_t mt6358_ints[] = {
>> +	MT6358_TOP_GEN(BUCK),
>> +	MT6358_TOP_GEN(LDO),
>> +	MT6358_TOP_GEN(PSC),
>> +	MT6358_TOP_GEN(SCK),
>> +	MT6358_TOP_GEN(BM),
>> +	MT6358_TOP_GEN(HK),
>> +	MT6358_TOP_GEN(AUD),
>> +	MT6358_TOP_GEN(MISC),
>> +};
> 
> What is a 'top' IRQ?
> 
>> +static int parsing_hwirq_to_top_group(unsigned int hwirq)
>> +{
>> +	int top_group;
>> +
>> +	for (top_group = 1; top_group < ARRAY_SIZE(mt6358_ints); top_group++) {
>> +		if (mt6358_ints[top_group].hwirq_base > hwirq) {
>> +			top_group--;
>> +			break;
>> +		}
>> +	}
>> +	return top_group;
>> +}
> 
> This function is going to need some comments.  Why do you start at LDO
> instead of the top entry, BUCK?

It also begs the question: why isn't that directly associated to the
irq_data structure? Something is fishy here. In general, if you have to
iterate over anything, you're likely to be doing the wrong thing.

> 
>> +static void pmic_irq_enable(struct irq_data *data)
>> +{
>> +	unsigned int hwirq = irqd_to_hwirq(data);
>> +	struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
>> +	struct pmic_irq_data *irq_data = chip->irq_data;
>> +
>> +	irq_data->enable_hwirq[hwirq] = 1;
>> +}
> 
> I see that you're doing your own caching operations.  Is that
> required?  I think I'm going to stop here and as for some IRQ guy's
> input on this.

Dunno either. I thought that's what regmap was for?

> 
>> +static void pmic_irq_disable(struct irq_data *data)
>> +{
>> +	unsigned int hwirq = irqd_to_hwirq(data);
>> +	struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
>> +	struct pmic_irq_data *irq_data = chip->irq_data;
>> +
>> +	irq_data->enable_hwirq[hwirq] = 0;
>> +}
>> +
>> +static void pmic_irq_lock(struct irq_data *data)
>> +{
>> +	struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
>> +
>> +	mutex_lock(&chip->irqlock);
>> +}
>> +
>> +static void pmic_irq_sync_unlock(struct irq_data *data)
>> +{
>> +	unsigned int i, top_gp, en_reg, int_regs, shift;
>> +	struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
>> +	struct pmic_irq_data *irq_data = chip->irq_data;

I really wish you kept the symbol "irq_data" for something that is a
struct irq_data. This is making the code pointlessly obfuscated.

>> +
>> +	for (i = 0; i < irq_data->num_pmic_irqs; i++) {
>> +		if (irq_data->enable_hwirq[i] ==
>> +				irq_data->cache_hwirq[i])
>> +			continue;

Please explain what you are trying to do here. The unlock operation is
supposed to affect exactly one interrupt. Instead, you seem to deal with
a bunch of them at once. Operations are supposed to happen on the "leaf"
IRQs, not on the multiplexing interrupt.

Also, the whole cache thing seems pretty pointless. Why isn't regmap
doing that for you?

>> +
>> +		top_gp = parsing_hwirq_to_top_group(i);
>> +		int_regs = mt6358_ints[top_gp].num_int_bits / MT6358_REG_WIDTH;
>> +		en_reg = mt6358_ints[top_gp].en_reg +
>> +			mt6358_ints[top_gp].en_reg_shift * int_regs;
>> +		shift = (i - mt6358_ints[top_gp].hwirq_base) % MT6358_REG_WIDTH;
>> +		regmap_update_bits(chip->regmap, en_reg, 0x1 << shift,
>> +				   irq_data->enable_hwirq[i] << shift);
>> +		irq_data->cache_hwirq[i] = irq_data->enable_hwirq[i];
>> +	}
>> +	mutex_unlock(&chip->irqlock);
>> +}
>> +
>> +static int pmic_irq_set_type(struct irq_data *data, unsigned int type)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct irq_chip mt6358_irq_chip = {
>> +	.name = "mt6358-irq",
>> +	.irq_enable = pmic_irq_enable,
>> +	.irq_disable = pmic_irq_disable,
>> +	.irq_bus_lock = pmic_irq_lock,
>> +	.irq_bus_sync_unlock = pmic_irq_sync_unlock,
>> +	.irq_set_type = pmic_irq_set_type,
>> +};
>> +
>> +static void mt6358_irq_sp_handler(struct mt6397_chip *chip,
>> +				  unsigned int top_gp)
>> +{
>> +	unsigned int sta_reg, int_status = 0;
>> +	unsigned int hwirq, virq;
>> +	int ret, i, j;
>> +
>> +	for (i = 0; i < mt6358_ints[top_gp].num_int_regs; i++) {
>> +		sta_reg = mt6358_ints[top_gp].sta_reg +
>> +			mt6358_ints[top_gp].sta_reg_shift * i;
>> +		ret = regmap_read(chip->regmap, sta_reg, &int_status);
>> +		if (ret) {
>> +			dev_err(chip->dev,
>> +				"Failed to read irq status: %d\n", ret);
>> +			return;
>> +		}
>> +
>> +		if (!int_status)
>> +			continue;
>> +
>> +		for (j = 0; j < 16 ; j++) {
>> +			if ((int_status & BIT(j)) == 0)
>> +				continue;
>> +			hwirq = mt6358_ints[top_gp].hwirq_base +
>> +				MT6358_REG_WIDTH * i + j;
>> +			virq = irq_find_mapping(chip->irq_domain, hwirq);
>> +			if (virq)
>> +				handle_nested_irq(virq);
>> +		}
>> +
>> +		regmap_write(chip->regmap, sta_reg, int_status);
>> +	}
>> +}
>> +
>> +static irqreturn_t mt6358_irq_handler(int irq, void *data)
>> +{
>> +	struct mt6397_chip *chip = data;
>> +	struct pmic_irq_data *mt6358_irq_data = chip->irq_data;
>> +	unsigned int top_int_status = 0;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	ret = regmap_read(chip->regmap,
>> +			  mt6358_irq_data->top_int_status_reg,
>> +			  &top_int_status);
>> +	if (ret) {
>> +		dev_err(chip->dev, "Can't read TOP_INT_STATUS ret=%d\n", ret);
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	for (i = 0; i < mt6358_irq_data->num_top; i++) {
>> +		if (top_int_status & BIT(mt6358_ints[i].top_offset))
>> +			mt6358_irq_sp_handler(chip, i);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}

Why isn't this a normal chained irq flow, instead of a homegrown irq
handler? Is that because this is a threaded handler?

>> +
>> +static int pmic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>> +			       irq_hw_number_t hw)
>> +{
>> +	struct mt6397_chip *mt6397 = d->host_data;
>> +
>> +	irq_set_chip_data(irq, mt6397);
>> +	irq_set_chip_and_handler(irq, &mt6358_irq_chip, handle_level_irq);
>> +	irq_set_nested_thread(irq, 1);
>> +	irq_set_noprobe(irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops mt6358_irq_domain_ops = {
>> +	.map = pmic_irq_domain_map,
>> +	.xlate = irq_domain_xlate_twocell,
>> +};
>> +
>> +int mt6358_irq_init(struct mt6397_chip *chip)
>> +{
>> +	int i, j, ret;
>> +	struct pmic_irq_data *irq_data;
>> +
>> +	irq_data = devm_kzalloc(chip->dev, sizeof(struct pmic_irq_data *),
>> +				GFP_KERNEL);
>> +	if (!irq_data)
>> +		return -ENOMEM;
>> +
>> +	chip->irq_data = irq_data;
>> +
>> +	mutex_init(&chip->irqlock);
>> +	irq_data->top_int_status_reg = MT6358_TOP_INT_STATUS0;
>> +	irq_data->num_pmic_irqs = MT6358_IRQ_NR;
>> +	irq_data->num_top = ARRAY_SIZE(mt6358_ints);
>> +
>> +	irq_data->enable_hwirq = devm_kcalloc(chip->dev,
>> +					      irq_data->num_pmic_irqs,
>> +					      sizeof(unsigned int),
>> +					      GFP_KERNEL);
>> +	if (!irq_data->enable_hwirq)
>> +		return -ENOMEM;
>> +
>> +	irq_data->cache_hwirq = devm_kcalloc(chip->dev,
>> +					     irq_data->num_pmic_irqs,
>> +					     sizeof(unsigned int),
>> +					     GFP_KERNEL);
>> +	if (!irq_data->cache_hwirq)
>> +		return -ENOMEM;
>> +
>> +	/* Disable all interrupt for initializing */
>> +	for (i = 0; i < irq_data->num_top; i++) {
>> +		for (j = 0; j < mt6358_ints[i].num_int_regs; j++)
>> +			regmap_write(chip->regmap,
>> +				     mt6358_ints[i].en_reg +
>> +				     mt6358_ints[i].en_reg_shift * j, 0);
>> +	}
>> +
>> +	chip->irq_domain = irq_domain_add_linear(chip->dev->of_node,
>> +						 irq_data->num_pmic_irqs,
>> +						 &mt6358_irq_domain_ops, chip);
>> +	if (!chip->irq_domain) {
>> +		dev_err(chip->dev, "could not create irq domain\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL,
>> +					mt6358_irq_handler, IRQF_ONESHOT,
>> +					mt6358_irq_chip.name, chip);
>> +	if (ret) {
>> +		dev_err(chip->dev, "failed to register irq=%d; err: %d\n",
>> +			chip->irq, ret);
>> +		return ret;
>> +	}
>> +
>> +	enable_irq_wake(chip->irq);

Why is that decided at probe time, from kernel space?

>> +	return ret;
>> +}

Anyway, I've stopped here. This definitely needs clarification.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
