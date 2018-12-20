Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3A121852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KoHDhIch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbeLTOfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:35:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbeLTOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:35:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so2007320wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iSBBGKYXoMbAEVaAi+Mds4SNqRv60KJaSLPiiZa6Ui8=;
        b=KoHDhIchrUcTBTszIGVh8c7qEIdRb8CL3TAzTurDHLJV/fd//mdJScLRmVMXSeCt4t
         VTvIkQla7i+Svq0PueG1mpdAmfv4oeguuJrtneqtaXmdkUSv+1JSaA9Qhz+Nxhm746KI
         Gy/J3YRL+xUWLfSysvld1dOa/2quvhPOSfDgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iSBBGKYXoMbAEVaAi+Mds4SNqRv60KJaSLPiiZa6Ui8=;
        b=XnsPwA0IFzZuDKMgplPG0sYn+IbOYiYZxA6PAvFrr2vrO8YMIeLw+hnGtKb9tRYV9n
         OYZcO3KBLxJQVzl8gbcPvVOBLqfjz6v/RmLPnKQhGqjg157IzZ204I8LGdwtd/X2K/Lj
         Iz+2Qa1OZJOrdgKIpZQ/VqiHpR1kWUiDCE2UTxCGBBR5u7ABjA+aulphVZBNaoZwq4Pp
         Z+VqdkjmSergXUV4RwyAxyJPZJBMbwtwUd5xIJWkfph87M7Oiw2eJsottI2Nj4gjabhJ
         9bJQW7/VLZtLC4cCNw1p/F2J1K9UaQsGQDbG/nO8Iuk2Q4iNPr7R5vyzmcYih0N4X8ne
         Mc8g==
X-Gm-Message-State: AA+aEWYoR0iOyUi85J+tmr3sFg7fFxRcH5cdpzPeCH4aOKpEGaJ6EXLE
        sM/3PfPlg5FzVEUPsIAeN92b6ss7WGo=
X-Google-Smtp-Source: AFSGD/XHXzeWvbngiFo4S1TfUwtIhuy3xZYoPe5zaPhBaCg7IMUKPYiT7j/5KT1/KbhHqdvozGGNew==
X-Received: by 2002:adf:9bda:: with SMTP id e26mr21841749wrc.295.1545316549095;
        Thu, 20 Dec 2018 06:35:49 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
        by smtp.googlemail.com with ESMTPSA id h131sm10054013wmd.17.2018.12.20.06.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 06:35:48 -0800 (PST)
Subject: Re: [PATCH v10 18/27] drivers: firmware: psci: Add support for PM
 domains using genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-19-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fa99b1a9-2e4d-e97c-9478-43b4d3ef9819@linaro.org>
Date:   Thu, 20 Dec 2018 15:35:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-19-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> When the hierarchical CPU topology layout is used in DT, we need to setup
> the corresponding PM domain data structures, as to allow a CPU and a group
> of CPUs to be power managed accordingly. Let's enable this by deploying
> support through the genpd interface.
> 
> Additionally, when the OS initiated mode is supported by the PSCI FW, let's
> also parse the domain idle states DT bindings as to make genpd responsible
> for the state selection, when the states are compatible with
> "domain-idle-state". Otherwise, when only Platform Coordinated mode is
> supported, we rely solely on the state selection to be managed through the
> regular cpuidle framework.
> 
> If the initialization of the PM domain data structures succeeds and the OS
> initiated mode is supported, we try to switch to it. In case it fails,
> let's fall back into a degraded mode, rather than bailing out and returning
> an error code.
> 
> Due to that the OS initiated mode may become enabled, we need to adjust to
> maintain backwards compatibility for a kernel started through a kexec call.
> Do this by explicitly switch to Platform Coordinated mode during boot.
> 
> To try to initiate the PM domain data structures, the PSCI driver shall
> call the new function, psci_dt_init_pm_domains(). However, this is done
> from following changes.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in V10:
> 	- Enable the PM domains to be used for both PC and OSI mode.
> 	- Fixup error paths.
> 	- Move the management of kexec started kernels into this patch.
> 	- Rewrite changelog.
> 
> ---
>  drivers/firmware/psci/Makefile         |   2 +-
>  drivers/firmware/psci/psci.c           |   7 +-
>  drivers/firmware/psci/psci.h           |   6 +
>  drivers/firmware/psci/psci_pm_domain.c | 262 +++++++++++++++++++++++++
>  4 files changed, 275 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/firmware/psci/psci_pm_domain.c
> 
> diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> index 1956b882470f..ff300f1fec86 100644
> --- a/drivers/firmware/psci/Makefile
> +++ b/drivers/firmware/psci/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
> -obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> +obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o psci_pm_domain.o

Same comment as 17/27.

+obj-$(CONFIG_PSCI_IDLE) += psci_pm_domain.o

>  obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 623591b541a4..19af2093151b 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -704,9 +704,14 @@ static int __init psci_1_0_init(struct device_node *np)
>  	if (err)
>  		return err;
>  
> -	if (psci_has_osi_support())
> +	if (psci_has_osi_support()) {
>  		pr_info("OSI mode supported.\n");
>  
> +		/* Make sure we default to PC mode. */
> +		invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
> +			       PSCI_1_0_SUSPEND_MODE_PC, 0, 0);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
> index 7d9d38fd57e1..8cf6d7206fab 100644
> --- a/drivers/firmware/psci/psci.h
> +++ b/drivers/firmware/psci/psci.h
> @@ -11,4 +11,10 @@ void psci_set_domain_state(u32 state);
>  bool psci_has_osi_support(void);
>  int psci_dt_parse_state_node(struct device_node *np, u32 *state);
>  
> +#ifdef CONFIG_CPU_IDLE

Same comment as 17/27 for the config option.

> +int psci_dt_init_pm_domains(struct device_node *np);
> +#else
> +static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
> +#endif
> +
>  #endif /* __PSCI_H */
> diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
> new file mode 100644
> index 000000000000..d0dc38e96f85
> --- /dev/null
> +++ b/drivers/firmware/psci/psci_pm_domain.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PM domains for CPUs via genpd - managed by PSCI.
> + *
> + * Copyright (C) 2018 Linaro Ltd.
> + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> + *
> + */
> +
> +#define pr_fmt(fmt) "psci: " fmt
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/pm_domain.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "psci.h"
> +
> +#ifdef CONFIG_CPU_IDLE

Same comment as 17/27 for the config option. This condition should go away.

> +struct psci_pd_provider {
> +	struct list_head link;
> +	struct device_node *node;
> +};
> +
> +static LIST_HEAD(psci_pd_providers);
> +static bool osi_mode_enabled;
> +
> +static int psci_pd_power_off(struct generic_pm_domain *pd)
> +{
> +	struct genpd_power_state *state = &pd->states[pd->state_idx];
> +	u32 *pd_state;
> +	u32 composite_pd_state;
> +
> +	/* If we have failed to enable OSI mode, then abort power off. */
> +	if (psci_has_osi_support() && !osi_mode_enabled)
> +		return -EBUSY;

I'm not sure EBUSY is the best error code to describe this situation.
May be ENOTSUP ?

However, how possible is it to pass in this function if the OSI mode was
not enabled ?

> +	if (!state->data)
> +		return 0;
> +
> +	/* When OSI mode is enabled, set the corresponding domain state. */
> +	pd_state = state->data;
> +	composite_pd_state = *pd_state | psci_get_domain_state();
> +	psci_set_domain_state(composite_pd_state);
> +
> +	return 0;
> +}
> +
> +static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
> +				int state_count)

__init ?

> +{
> +	int i, ret;
> +	u32 psci_state, *psci_state_buf;
> +
> +	for (i = 0; i < state_count; i++) {
> +		ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
> +					&psci_state);
> +		if (ret)
> +			goto free_state;
> +
> +		psci_state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
> +		if (!psci_state_buf) {
> +			ret = -ENOMEM;
> +			goto free_state;
> +		}
> +		*psci_state_buf = psci_state;
> +		states[i].data = psci_state_buf;
> +	}
> +
> +	return 0;
> +
> +free_state:
> +	while (i >= 0) {
> +		kfree(states[i].data);
> +		i--;
> +	}

for (; i >= 0; i--)

> +	return ret;
> +}
> +
> +static int psci_pd_parse_states(struct device_node *np,
> +			struct genpd_power_state **states, int *state_count)

__init ?

> +{
> +	int ret;
> +
> +	/* Parse the domain idle states. */
> +	ret = of_genpd_parse_idle_states(np, states, state_count);
> +	if (ret)
> +		return ret;
> +
> +	/* Fill out the PSCI specifics for each found state. */
> +	ret = psci_pd_parse_state_nodes(*states, *state_count);
> +	if (ret)
> +		kfree(*states);
> +
> +	return ret;
> +}
> +
> +static int psci_pd_init(struct device_node *np)

__init ?

> +{
> +	struct generic_pm_domain *pd;
> +	struct psci_pd_provider *pd_provider;
> +	struct dev_power_governor *pd_gov;
> +	struct genpd_power_state *states = NULL;
> +	int i, ret = -ENOMEM, state_count = 0;
> +
> +	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +	if (!pd)
> +		goto out;
> +
> +	pd_provider = kzalloc(sizeof(*pd_provider), GFP_KERNEL);
> +	if (!pd_provider)
> +		goto free_pd;
> +
> +	pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
> +	if (!pd->name)
> +		goto free_pd_prov;
> +
> +	/*
> +	 * For OSI mode, parse the domain idle states and let genpd manage the
> +	 * state selection for those being compatible with "domain-idle-state".
> +	 */
> +	if (psci_has_osi_support()) {
> +		ret = psci_pd_parse_states(np, &states, &state_count);
> +		if (ret)
> +			goto free_name;
> +	}
> +
> +	pd->name = kbasename(pd->name);
> +	pd->power_off = psci_pd_power_off;
> +	pd->states = states;
> +	pd->state_count = state_count;
> +	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
> +
> +	/* Use governor for CPU PM domains if it has some states to manage. */
> +	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
> +
> +	ret = pm_genpd_init(pd, pd_gov, false);
> +	if (ret)
> +		goto free_state;
> +
> +	ret = of_genpd_add_provider_simple(np, pd);
> +	if (ret)
> +		goto remove_pd;
> +
> +	pd_provider->node = of_node_get(np);
> +	list_add(&pd_provider->link, &psci_pd_providers);
> +
> +	pr_debug("init PM domain %s\n", pd->name);
> +	return 0;
> +
> +remove_pd:
> +	pm_genpd_remove(pd);
> +free_state:
> +	for (i = 0; i < state_count; i++)
> +		kfree(states[i].data);
> +	kfree(states);
> +free_name:
> +	kfree(pd->name);
> +free_pd_prov:
> +	kfree(pd_provider);
> +free_pd:
> +	kfree(pd);
> +out:
> +	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
> +	return ret;
> +}
> +
> +static void psci_pd_remove(void)
> +{
> +	struct psci_pd_provider *pd_provider, *it;
> +	struct generic_pm_domain *genpd;
> +	int i;
> +
> +	list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
> +		of_genpd_del_provider(pd_provider->node);
> +
> +		genpd = of_genpd_remove_last(pd_provider->node);
> +		if (!IS_ERR(genpd)) {
> +			for (i = 0; i < genpd->state_count; i++)
> +				kfree(genpd->states[i].data);
> +			kfree(genpd->states);
> +			kfree(genpd);
> +		}
> +
> +		of_node_put(pd_provider->node);
> +		list_del(&pd_provider->link);
> +		kfree(pd_provider);
> +	}
> +}
> +
> +static int psci_pd_init_topology(struct device_node *np)

__init ?

> +{
> +	struct device_node *node;
> +	struct of_phandle_args child, parent;
> +	int ret;
> +
> +	for_each_child_of_node(np, node) {
> +		if (of_parse_phandle_with_args(node, "power-domains",
> +					"#power-domain-cells", 0, &parent))
> +			continue;
> +
> +		child.np = node;
> +		child.args_count = 0;
> +
> +		ret = of_genpd_add_subdomain(&parent, &child);
> +		of_node_put(parent.np);
> +		if (ret) {
> +			of_node_put(node);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int psci_dt_init_pm_domains(struct device_node *np)

__init ?

> +{
> +	struct device_node *node;
> +	int ret, pd_count = 0;
> +
> +	/*
> +	 * Parse child nodes for the "#power-domain-cells" property and
> +	 * initialize a genpd/genpd-of-provider pair when it's found.
> +	 */
> +	for_each_child_of_node(np, node) {
> +		if (!of_find_property(node, "#power-domain-cells", NULL))
> +			continue;
> +
> +		ret = psci_pd_init(node);
> +		if (ret)
> +			goto put_node;
> +
> +		pd_count++;
> +	}
> +
> +	/* Bail out if not using the hierarchical CPU topology. */
> +	if (!pd_count)
> +		return 0;
> +
> +	/* Link genpd masters/subdomains to model the CPU topology. */
> +	ret = psci_pd_init_topology(np);
> +	if (ret)
> +		goto remove_pd;
> +
> +	/* Try to enable OSI mode if supported. */
> +	if (psci_has_osi_support())
> +		osi_mode_enabled = psci_set_osi_mode();
> +
> +	pr_info("Initialized CPU PM domain topology\n");
> +	return pd_count;
> +
> +put_node:
> +	of_node_put(node);
> +remove_pd:
> +	if (pd_count)
> +		psci_pd_remove();
> +	pr_err("failed to create CPU PM domains ret=%d\n", ret);
> +	return ret;
> +}
> +#endif
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

