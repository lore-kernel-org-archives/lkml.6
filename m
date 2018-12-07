Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D88EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3329620672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3329620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeLGSaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:30:25 -0500
Received: from foss.arm.com ([217.140.101.70]:51592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbeLGSaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:30:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 191C0EBD;
        Fri,  7 Dec 2018 10:30:24 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3A73F5AF;
        Fri,  7 Dec 2018 10:30:21 -0800 (PST)
Subject: Re: [RFC PATCH v3 3/4] irqchip: gic-v3: Add quirk for msm8996 secured
 registers
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org
References: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
 <20181112103340.24702-4-srinivas.kandagatla@linaro.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <f102b487-d53b-07b3-d85b-460ea223267f@arm.com>
Date:   Fri, 7 Dec 2018 18:30:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181112103340.24702-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 10:33, Srinivas Kandagatla wrote:
> Access to GICR_WAKER is restricted on msm8996 SoC in Hypervisor.
> Its been more than 2+ years of wait for this to be fixed, which has
> no hopes to be fixed. This change was introduced for the "lead device"
> on msm8996 platform. It looks like all publicly available msm8996 and
> other qcom SoCs have this implementation.

s/qcom/Qualcomm/

> 
> So add a quirk to not access this register on msm8996.
> 
> With this quirk MSM8996 can at least boot out of mainline,
> which can help community to work with boards based on MSM8996 and other
> SoCs with have this restrictions. This Quirk is based on device tree
> compatible string.
> 
> Without this patch Qualcomm DB820c board reboots when GICR_WAKER
> is accessed.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 8f87f40c9460..4bd3bbe1b7ce 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -41,6 +41,8 @@
>  
>  #include "irq-gic-common.h"
>  
> +#define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
> +
>  struct redist_region {
>  	void __iomem		*redist_base;
>  	phys_addr_t		phys_base;
> @@ -55,6 +57,7 @@ struct gic_chip_data {
>  	struct irq_domain	*domain;
>  	u64			redist_stride;
>  	u32			nr_redist_regions;
> +	u64			flags;
>  	bool			has_rss;
>  	unsigned int		irq_nr;
>  	struct partition_desc	*ppi_descs[16];
> @@ -139,6 +142,9 @@ static void gic_enable_redist(bool enable)
>  	u32 count = 1000000;	/* 1s! */
>  	u32 val;
>  
> +	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
> +		return;
> +
>  	rbase = gic_data_rdist_rd_base();
>  
>  	val = readl_relaxed(rbase + GICR_WAKER);
> @@ -1067,6 +1073,23 @@ static const struct irq_domain_ops partition_domain_ops = {
>  	.select = gic_irq_domain_select,
>  };
>  
> +static bool __maybe_unused gic_enable_quirk_msm8996(void *data)

Why __maybe_unused? It is referenced in the quirk table, right?

> +{
> +	struct gic_chip_data *d = data;
> +
> +	d->flags |= FLAGS_WORKAROUND_GICR_WAKER_MSM8996;
> +
> +	return true;
> +}
> +
> +static const struct gic_quirk gic_quirks[] = {
> +	{
> +		.desc	= "GICv3: Qualcomm MSM8996 skip GICR_WAKER Read/Write",

This should read "GICv3: Qualcomm MSM8996 broken firmware". Nobody knows
what GICR_WAKER is, but people do understand that they run buggy software.

> +		.compatible = "qcom,msm8996-gic-v3", /* MSM8996 */

Drop this comment, it doesn't add anything.

> +		.init	= gic_enable_quirk_msm8996,
> +	},
> +};
> +
>  static int __init gic_init_bases(void __iomem *dist_base,
>  				 struct redist_region *rdist_regs,
>  				 u32 nr_redist_regions,
> @@ -1126,6 +1149,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  
>  	gic_update_vlpi_properties();
>  
> +	if (is_of_node(handle))
> +		gic_enable_of_quirks(to_of_node(handle), gic_quirks, &gic_data);
> +

Please move this as early as possible. Actually, given that this is DT
only, it should be done in gic_of_init. It should also be moved to the
previous patch, with gic_quirks being an empty array.

>  	gic_smp_init();
>  	gic_dist_init();
>  	gic_cpu_init();
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
