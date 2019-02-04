Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFAAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873BB2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F/MuCsy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfBDSDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:03:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40310 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfBDSDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:03:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so271601plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 10:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pa+Vc7SY0LoQnG2/tXw6TGPTX86UGYys3lkAel8SuIw=;
        b=F/MuCsy04csfh0tIaC4dehv6E2hS3A6dyoUz+BDIet6FsoHnz/ZVJfYL56jG0munBE
         4yDLI2XKbL03jrxzf9D/SWU9YYTxS1taQFIFyXdpXQSMhaNeoFnuLIVXRyLtms+kxhZk
         qaOC/b3Tbd53oYDt4b58JtHSAyDRDvzcwdLuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pa+Vc7SY0LoQnG2/tXw6TGPTX86UGYys3lkAel8SuIw=;
        b=untxXzBwN2NCO6+ZVTNLqO3X4KGj0m01CIZkOp1vi2O9Js6Bgisl9li3WtLFAkktzi
         2F1svEwWy3Avbrwuy3dPKVvjnBwaWWHMdtrSmE4+LVzSDhvV3HgoOVwjwlYg/5x7grpz
         JefZ/uQfL4A+nd4+2lZEEuaySGT1beGOThvNhuVovswsyUvYAjtyMB/BDr9Cz97tIrZK
         Vi2BSJebz5Dz6AytmBtQetBi1dv9+3hyhVAcgeEDZ001bhim8g8NgTGGeh+H5WTOlsAS
         AWZpMK+vFNX8rrhJN0H37LHbkBcAbRS49ytBCjhhpdVQdKsAwYrrDfxUQEdtbvuYTrNT
         U8xQ==
X-Gm-Message-State: AHQUAuZS9kGGHlCMKRxgHd+cUc5wwn08ARPdBLTQNWzLssIS9fW306MV
        moSDB20maslkJM3UaZ2dWnrKLbHoBiY=
X-Google-Smtp-Source: AHgI3Ia2MdcklPsX7BhkL3jYEmVjX2yyZgFn3/yfyAoM614ZdmlSLjM/F1zdgeg+EbFgvgjrjNZmIg==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32mr632085plj.318.1549303384891;
        Mon, 04 Feb 2019 10:03:04 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d129sm966231pfc.31.2019.02.04.10.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:03:04 -0800 (PST)
Date:   Mon, 4 Feb 2019 10:03:03 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v4 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190204180303.GD117604@google.com>
References: <20190204110952.16025-1-quentin.perret@arm.com>
 <20190204110952.16025-2-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190204110952.16025-2-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:09:48AM +0000, Quentin Perret wrote:
> The Energy Model (EM) framework provides an API to let drivers register
> the active power of CPUs. The drivers are expected to provide a callback
> method which estimates the power consumed by a CPU at each available
> performance levels. How exactly this should be implemented, however,
> depends on the platform.
> 
> On some systems, PM_OPP knows the voltage and frequency at which CPUs
> can run. When coupled with the CPU 'capacitance' (as provided by the
> 'dynamic-power-coefficient' devicetree binding), it is possible to
> estimate the dynamic power consumption of a CPU as P = C * V^2 * f, with
> C its capacitance and V and f respectively the voltage and frequency of
> the OPP. The Intelligent Power Allocator (IPA) thermal governor already
> implements that estimation method, in the thermal framework.
> 
> However, this power estimation method can be applied to any platform
> where all the parameters are known (C, V and f), and not only those
> suffering thermal issues. As such, the code implementing this feature
> can be re-used to also populate the EM framework now used by EAS.
> 
> As a first step, introduce in PM_OPP a helper function which CPUFreq
> drivers can use to register into the EM framework. This duplicates the
> power estimation done in IPA until it can be migrated to using the EM
> framework. This will be done later, once the EM framework has support
> for at least all platforms currently supported by IPA.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/opp/of.c       | 99 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 +++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 06f0f632ec47..cd58959e5158 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
> +#include <linux/energy_model.h>
>  
>  #include "opp.h"
>  
> @@ -1047,3 +1048,101 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  	return of_node_get(opp->np);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
> +
> +/*
> + * Callback function provided to the Energy Model framework upon registration.
> + * This computes the power estimated by @CPU at @kHz if it is the frequency
> + * of an existing OPP, or at the frequency of the first OPP above @kHz otherwise
> + * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
> + * frequency and @mW to the associated power. The power is estimated as
> + * P = C * V^2 * f with C being the CPU's capacitance and V and f respectively
> + * the voltage and frequency of the OPP.
> + *
> + * Returns -ENODEV if the CPU device cannot be found, -EINVAL if the power
> + * calculation failed because of missing parameters, 0 otherwise.
> + */
> +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> +					 int cpu)
> +{
> +	struct device *cpu_dev;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	unsigned long mV, Hz;
> +	u32 cap;
> +	u64 tmp;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> +	of_node_put(np);
> +	if (ret)
> +		return -EINVAL;
> +
> +	Hz = *kHz * 1000;
> +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> +	dev_pm_opp_put(opp);
> +	if (!mV)
> +		return -EINVAL;
> +
> +	tmp = (u64)cap * mV * mV * (Hz / 1000000);
> +	do_div(tmp, 1000000000);
> +
> +	*mW = (unsigned long)tmp;
> +	*kHz = Hz / 1000;
> +
> +	return 0;
> +}
> +
> +/**
> + * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
> + * @cpus	: CPUs for which an Energy Model has to be registered
> + *
> + * This checks whether the "dynamic-power-coefficient" devicetree property has
> + * been specified, and tries to register an Energy Model with it if it has.
> + */
> +void dev_pm_opp_of_register_em(struct cpumask *cpus)
> +{
> +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> +	int ret, nr_opp, cpu = cpumask_first(cpus);
> +	struct device *cpu_dev;
> +	struct device_node *np;
> +	u32 cap;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev)
> +		return;
> +
> +	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (nr_opp <= 0)
> +		return;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np)
> +		return;
> +
> +	/*
> +	 * Register an EM only if the 'dynamic-power-coefficient' property is
> +	 * set in devicetree. It is assumed the voltage values are known if that
> +	 * property is set since it is useless otherwise. If voltages are not
> +	 * known, just let the EM registration fail with an error to alert the
> +	 * user about the inconsistent configuration.
> +	 */
> +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> +	of_node_put(np);
> +	if (ret || !cap)
> +		return;
> +
> +	em_register_perf_domain(cpus, nr_opp, &em_cb);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index b895f4e79868..c9c76310865a 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -327,6 +327,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
>  int of_get_required_opp_performance_state(struct device_node *np, int index);
> +void dev_pm_opp_of_register_em(struct cpumask *cpus);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -365,6 +366,11 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  {
>  	return NULL;
>  }
> +
> +static inline void dev_pm_opp_of_register_em(struct cpumask *cpus)
> +{
> +}
> +
>  static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
>  {
>  	return -ENOTSUPP;

There is the option to remove the OPP check from the cpufreq drivers
and instead return an error from dev_pm_opp_of_register_em(), but with
the more complex error handling it might be more hassle than it's
worth.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
