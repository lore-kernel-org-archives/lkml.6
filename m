Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104B1ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36402086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36402086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJRA0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:26:49 -0400
Received: from foss.arm.com ([217.140.101.70]:54536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbeJRA0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:26:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14017A78;
        Wed, 17 Oct 2018 09:30:21 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 290793F71A;
        Wed, 17 Oct 2018 09:30:20 -0700 (PDT)
Subject: Re: [PATCH 3/4] irqchip/mbigen: add support for a MBIGEN generating
 SPIs
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, guohanjun@huawei.com
References: <1539681316-19300-1-git-send-email-yangyingliang@huawei.com>
 <1539681316-19300-4-git-send-email-yangyingliang@huawei.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <a8ea3f08-8d60-13bf-edcc-03298a9cfb0d@arm.com>
Date:   Wed, 17 Oct 2018 17:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539681316-19300-4-git-send-email-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/18 10:15, Yang Yingliang wrote:
> Now with
> 5052875 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller"),
> we can support MBIGEN to generate message based SPIs by writing GICD_SETSPIR.
> 
> The first 64-pins of each MBIGEN chip is used to generate SPIs, and each
> MBIGEN chip has several MBIGEN nodes, every node has 128 pins for generating
> LPIs. The total pins are: 64(SPIs) + 128 * node_nr(LPIs). So we can translate
> the pin index in a unified way in mbigen_domain_translate().
> 
> Also Add TYPE and VEC registers that used by generating SPIs, the driver can
> access them when MBIGEN is used to generate SPIs.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index f05998f..37c1932 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -48,6 +48,7 @@
>  #define MBIGEN_NODE_OFFSET		0x1000
>  
>  /* offset of vector register in mbigen node */
> +#define REG_MBIGEN_SPI_VEC_OFFSET	0x500
>  #define REG_MBIGEN_LPI_VEC_OFFSET	0x200
>  
>  /**
> @@ -62,6 +63,7 @@
>   * This register is used to configure interrupt
>   * trigger type
>   */
> +#define REG_MBIGEN_SPI_TYPE_OFFSET	0x400
>  #define REG_MBIGEN_LPI_TYPE_OFFSET	0x0
>  
>  /**
> @@ -79,6 +81,9 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
>  {
>  	unsigned int nid, pin;
>  
> +	if (hwirq < SPI_NUM_PER_MBIGEN_CHIP)
> +		return (hwirq * 4 + REG_MBIGEN_SPI_VEC_OFFSET);
> +
>  	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
>  	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
>  	pin = hwirq % IRQS_PER_MBIGEN_NODE;
> @@ -92,6 +97,13 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
>  {
>  	unsigned int nid, irq_ofst, ofst;
>  
> +	if (hwirq < SPI_NUM_PER_MBIGEN_CHIP) {
> +		*mask = 1 << (hwirq % 32);
> +		ofst = hwirq / 32 * 4;
> +		*addr = ofst + REG_MBIGEN_SPI_TYPE_OFFSET;
> +		return;
> +	}
> +
>  	hwirq -= SPI_NUM_PER_MBIGEN_CHIP;
>  	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
>  	irq_ofst = hwirq % IRQS_PER_MBIGEN_NODE;
> @@ -162,6 +174,12 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	u32 val;
>  
>  	base += get_mbigen_vec_reg(d->hwirq);
> +
> +	if (d->hwirq < SPI_NUM_PER_MBIGEN_CHIP) {
> +		writel_relaxed(msg->data, base);
> +		return;
> +	}

How is the GICD_SETSPI_NSR base address programmed if you're ignoring
the address stored in the message?

How do you deal with level interrupts, as you don't seem to use the
level MSI framework either?

> +
>  	val = readl_relaxed(base);
>  
>  	val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
> @@ -182,8 +200,7 @@ static int mbigen_domain_translate(struct irq_domain *d,
>  		if (fwspec->param_count != 2)
>  			return -EINVAL;
>  
> -		if ((fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM) ||
> -			(fwspec->param[0] < SPI_NUM_PER_MBIGEN_CHIP))
> +		if (fwspec->param[0] > MAXIMUM_IRQ_PIN_NUM)
>  			return -EINVAL;
>  		else
>  			*hwirq = fwspec->param[0];
> 

Now, the biggest question of them all: how does it work with ACPI? Last
time I checked, there was no DT support for platforms using the MBIGEN.

My gut feeling is that it would be so much better if the SPIs generated
by the MBIGEN were configured in firmware, and the devices behind it
would just describe the corresponding SPI...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
