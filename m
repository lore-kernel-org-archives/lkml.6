Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6CFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44D218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfA3Nyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:54:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54718 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731180AbfA3Nys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:54:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7922BEBD;
        Wed, 30 Jan 2019 05:54:47 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89DA3F59C;
        Wed, 30 Jan 2019 05:54:43 -0800 (PST)
Subject: Re: [PATCH 2/9] genirq: introduce irq_domain_translate_twocell
To:     Brian Masney <masneyb@onstation.org>, linus.walleij@linaro.org,
        sboyd@kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190125162302.14036-1-masneyb@onstation.org>
 <20190125162302.14036-3-masneyb@onstation.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <8eb0a45e-4bcf-5042-2c16-369854267d80@arm.com>
Date:   Wed, 30 Jan 2019 13:54:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125162302.14036-3-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 25/01/2019 16:22, Brian Masney wrote:
> Add a new function irq_domain_translate_twocell() that is to be used as
> the translate function in struct irq_domain_ops for v2 IRQ interfaces.
> This is based on irq_domain_xlate_twocell().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  include/linux/irqdomain.h |  5 +++++
>  kernel/irq/irqdomain.c    | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 35965f41d7be..fcefe0c7263f 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -419,6 +419,11 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
>  			const u32 *intspec, unsigned int intsize,
>  			irq_hw_number_t *out_hwirq, unsigned int *out_type);
>  
> +int irq_domain_translate_twocell(struct irq_domain *d,
> +				 struct irq_fwspec *fwspec,
> +				 unsigned long *out_hwirq,
> +				 unsigned int *out_type);
> +
>  /* IPI functions */
>  int irq_reserve_ipi(struct irq_domain *domain, const struct cpumask *dest);
>  int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 8b0be4bd6565..15c2a291aa3c 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -968,6 +968,27 @@ const struct irq_domain_ops irq_domain_simple_ops = {
>  };
>  EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
>  
> +/**
> + * irq_domain_translate_twocell() - Generic translate for direct two cell
> + * bindings
> + *
> + * Device Tree IRQ specifier translation function which works with two cell
> + * bindings where the cell values map directly to the hwirq number
> + * and linux irq flags.
> + */
> +int irq_domain_translate_twocell(struct irq_domain *d,
> +				 struct irq_fwspec *fwspec,
> +				 unsigned long *out_hwirq,
> +				 unsigned int *out_type)
> +{
> +	if (WARN_ON(fwspec->param_count < 2))
> +		return -EINVAL;
> +	*out_hwirq = fwspec->param[0];
> +	*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(irq_domain_translate_twocell);
> +
>  int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
>  			   int node, const struct irq_affinity_desc *affinity)
>  {
> 

So why not bite the bullet and rewrite irq_domain_xlate_twocell() in
terms of irq_domain_translate_twocell()? Something like this (untested):

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3366d11c3e02..76d5bc11eea6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -729,16 +729,18 @@ static int irq_domain_translate(struct irq_domain *d,
 	return 0;
 }
 
-static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
+static void of_phandle_args_to_fwspec(struct device_node *np,
+				      const u32 *args,
+				      unsigned int count,
 				      struct irq_fwspec *fwspec)
 {
 	int i;
 
-	fwspec->fwnode = irq_data->np ? &irq_data->np->fwnode : NULL;
-	fwspec->param_count = irq_data->args_count;
+	fwspec->fwnode = np ? &np->fwnode : NULL;
+	fwspec->param_count = count;
 
-	for (i = 0; i < irq_data->args_count; i++)
-		fwspec->param[i] = irq_data->args[i];
+	for (i = 0; i < count; i++)
+		fwspec->param[i] = args[i];
 }
 
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
@@ -836,7 +838,8 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 {
 	struct irq_fwspec fwspec;
 
-	of_phandle_args_to_fwspec(irq_data, &fwspec);
+	of_phandle_args_to_fwspec(irq_data->np, irq_data->args,
+				  irq_data->args_count, &fwspec);
 	return irq_create_fwspec_mapping(&fwspec);
 }
 EXPORT_SYMBOL_GPL(irq_create_of_mapping);
@@ -928,11 +931,10 @@ int irq_domain_xlate_twocell(struct irq_domain *d, struct device_node *ctrlr,
 			const u32 *intspec, unsigned int intsize,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type)
 {
-	if (WARN_ON(intsize < 2))
-		return -EINVAL;
-	*out_hwirq = intspec[0];
-	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
-	return 0;
+	struct irq_fwspec fwspec;
+
+	of_phandle_args_to_fwspec(ctrlr, intspec, intsize, &fwspec);
+	return irq_domain_translate_twocell(d, &fwspec, out_irq, out_type);
 }
 EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
 
I find this more palatable, as it shows the direction of travel for the API.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
