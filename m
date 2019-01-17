Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B79C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499672054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfAQLXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:23:05 -0500
Received: from foss.arm.com ([217.140.101.70]:38092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfAQLXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:23:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2599580D;
        Thu, 17 Jan 2019 03:23:04 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 573D13F557;
        Thu, 17 Jan 2019 03:23:01 -0800 (PST)
Subject: Re: [PATCH v5 04/14] spmi: pmic-arb: convert to v2 irq interfaces to
 support hierarchical IRQ chips
To:     Brian Masney <masneyb@onstation.org>, linus.walleij@linaro.org,
        sboyd@kernel.org, bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190117003234.22127-1-masneyb@onstation.org>
 <20190117003234.22127-5-masneyb@onstation.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <d2e3c91c-2a54-e130-7512-e4a65bf2794d@arm.com>
Date:   Thu, 17 Jan 2019 11:22:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117003234.22127-5-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 17/01/2019 00:32, Brian Masney wrote:
> Convert the spmi-pmic-arb IRQ code to use the version 2 IRQ interface
> in order to support hierarchical IRQ chips. This is necessary so that
> spmi-gpio can be setup as a hierarchical IRQ chip with pmic-arb as the
> parent. IRQ chips in device tree should be usable from the start without
> the consumer having to make an additional call to gpio[d]_to_irq() to
> get the proper IRQ on the parent. Driver was tested on a LG Nexus 5
> (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v4:
> - None
> 
> Changes since v3:
> - None
> 
> Changes since v2:
> - Don't move pmic_gpio_of_match block. Use device_get_match_data instead
>   of of_match_device.
> - Correct build warning on arm64: warning: cast from pointer to integer
>   of different size
> 
>  drivers/spmi/spmi-pmic-arb.c | 58 +++++++++++++++++++++++-------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 360b8218f322..356bc3f66e22 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -666,7 +666,8 @@ static int qpnpint_get_irqchip_state(struct irq_data *d,
>  	return 0;
>  }
>  
> -static int qpnpint_irq_request_resources(struct irq_data *d)
> +static int qpnpint_irq_domain_activate(struct irq_domain *domain,
> +				       struct irq_data *d, bool reserve)
>  {
>  	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
>  	u16 periph = hwirq_to_per(d->hwirq);
> @@ -692,27 +693,25 @@ static struct irq_chip pmic_arb_irqchip = {
>  	.irq_set_type	= qpnpint_irq_set_type,
>  	.irq_set_wake	= qpnpint_irq_set_wake,
>  	.irq_get_irqchip_state	= qpnpint_get_irqchip_state,
> -	.irq_request_resources = qpnpint_irq_request_resources,
>  	.flags		= IRQCHIP_MASK_ON_SUSPEND,
>  };
>  
> -static int qpnpint_irq_domain_dt_translate(struct irq_domain *d,
> -					   struct device_node *controller,
> -					   const u32 *intspec,
> -					   unsigned int intsize,
> -					   unsigned long *out_hwirq,
> -					   unsigned int *out_type)
> +static int qpnpint_irq_domain_translate(struct irq_domain *d,
> +					struct irq_fwspec *fwspec,
> +					unsigned long *out_hwirq,
> +					unsigned int *out_type)
>  {
>  	struct spmi_pmic_arb *pmic_arb = d->host_data;
> +	u32 *intspec = fwspec->param;
>  	u16 apid, ppid;
>  	int rc;
>  
>  	dev_dbg(&pmic_arb->spmic->dev, "intspec[0] 0x%1x intspec[1] 0x%02x intspec[2] 0x%02x\n",
>  		intspec[0], intspec[1], intspec[2]);
>  
> -	if (irq_domain_get_of_node(d) != controller)
> +	if (irq_domain_get_of_node(d) != pmic_arb->spmic->dev.of_node)
>  		return -EINVAL;
> -	if (intsize != 4)
> +	if (fwspec->param_count != 4)
>  		return -EINVAL;
>  	if (intspec[0] > 0xF || intspec[1] > 0xFF || intspec[2] > 0x7)
>  		return -EINVAL;
> @@ -740,17 +739,34 @@ static int qpnpint_irq_domain_dt_translate(struct irq_domain *d,
>  	return 0;
>  }
>  
> -static int qpnpint_irq_domain_map(struct irq_domain *d,
> -				  unsigned int virq,
> -				  irq_hw_number_t hwirq)
> -{
> -	struct spmi_pmic_arb *pmic_arb = d->host_data;
>  
> +static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
> +				   struct irq_domain *domain, unsigned int virq,
> +				   irq_hw_number_t hwirq)
> +{
>  	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu\n", virq, hwirq);
>  
> -	irq_set_chip_and_handler(virq, &pmic_arb_irqchip, handle_level_irq);
> -	irq_set_chip_data(virq, d->host_data);
> -	irq_set_noprobe(virq);
> +	irq_domain_set_info(domain, virq, hwirq, &pmic_arb_irqchip, pmic_arb,
> +			    handle_level_irq, NULL, NULL);

I understand you haven't changed the existing semantic here by always
setting the handler to handle_level_irq. But is that guaranteed to
always be the case? See below.

> +}
> +
> +static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
> +				    unsigned int virq, unsigned int nr_irqs,
> +				    void *data)
> +{
> +	struct spmi_pmic_arb *pmic_arb = domain->host_data;
> +	struct irq_fwspec *fwspec = data;
> +	irq_hw_number_t hwirq;
> +	unsigned int type;
> +	int ret, i;
> +
> +	ret = qpnpint_irq_domain_translate(domain, fwspec, &hwirq, &type);

Here, you extract the trigger from DT.

> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nr_irqs; i++)
> +		qpnpint_irq_domain_map(pmic_arb, domain, virq + i, hwirq + i);

Shouldn't you propagate it into the mapping function so that the handler
can be selected accordingly? Or does the interrupt controller convert
edge signals to level somehow?

> +
>  	return 0;
>  }
>  
> @@ -1126,8 +1142,10 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
>  };
>  
>  static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
> -	.map	= qpnpint_irq_domain_map,
> -	.xlate	= qpnpint_irq_domain_dt_translate,
> +	.activate = qpnpint_irq_domain_activate,
> +	.alloc = qpnpint_irq_domain_alloc,
> +	.free = irq_domain_free_irqs_common,
> +	.translate = qpnpint_irq_domain_translate,
>  };
>  
>  static int spmi_pmic_arb_probe(struct platform_device *pdev)
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
