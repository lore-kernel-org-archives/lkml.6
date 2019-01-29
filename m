Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ED820989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBdEth4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbfA2FKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:10:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37069 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfA2FKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:10:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so9121507pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cghF4RrrqxX5D1y/VJFr26feFrzLaLgJa3F7VF8MXHc=;
        b=fBdEth4GbH8Q26/lRA8cz1HUih9W9HBiWo9QgeF0/PtdWSDITv4a1Y71IXu4gEJh04
         qlTYMElanHGaoi8Rz8VV5MRHG2inGs1ECehu7+Whla87oKhtMxomJLGEklfdxMankJ8N
         q+8pJKH+zceNlQanZJyl5bVoS9cAEqCIcd+WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cghF4RrrqxX5D1y/VJFr26feFrzLaLgJa3F7VF8MXHc=;
        b=cZaXsW4DSktSLWxV7ckpvcszZnjND8jeuXhOs53E3XHSbkLKIcw7EI3bYDnwMo0fz7
         J+7rzrgtZVufDLHAGc4+kQmvi3ulYyD6G/IIUq6TN6/FXfMADEVMIBZSEDvRUp0Yfxf0
         lNC84WO87DPUnoxxCVM0NMcFfv0nUvuW6ot/6FX+wnukT8FG5eUsiV8xXVDBKdJbe88l
         bUmWsp3aRo5afvEOVQ37HRXLVx0TKadFtoCMUovokxUAoopnpDznutxEWKKk1nSvUqRz
         2FDdulia8z8j5d9oFOepkwAc0JLDKvuxndJI7+bMrk+0vF5iLoPR5WB3WcWHZSpUwFwY
         +Cmg==
X-Gm-Message-State: AJcUukeC2q3MxhQ+qcoQdcsyBBeN6Q5SM4yBKnTVQ4odrIriZx/q31WW
        krcoEnY3a+j34XnfdFXvhb+IiA==
X-Google-Smtp-Source: ALg8bN5v50+LDKkZA9h892m1xO1UFoDhY+EPYK/xKnHB2z5Tqi2p6qbs7WDQ89hGhGhZ0VRL6Iw5pA==
X-Received: by 2002:a62:b80a:: with SMTP id p10mr24585184pfe.32.1548738634323;
        Mon, 28 Jan 2019 21:10:34 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id z191sm41901766pgd.74.2019.01.28.21.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 21:10:32 -0800 (PST)
Date:   Tue, 29 Jan 2019 10:40:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Message-ID: <20190129051030.gu5nhr6vmcd35bzk@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-2-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-19, 16:55, Quentin Perret wrote:
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 06f0f632ec47..7572a2eb2fd4 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1047,3 +1047,63 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  	return of_node_get(opp->np);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
> +
> +/**
> + * of_dev_pm_opp_get_cpu_power() - Estimates the power of a CPU
> + * @mW:		pointer to the power estimate in milli-watts
> + * @KHz:	pointer to the OPP's frequency, in kilo-hertz
> + * @cpu:	CPU for which power needs to be estimated
> + *
> + * Computes the power estimated by @CPU at the first OPP above @KHz (ceil),
> + * and updates @KHz and @mW accordingly.
> + *
> + * The power is estimated as P = C * V^2 * f, with C the CPU's capacitance
> + * (read from the 'dynamic-power-coefficient' devicetree binding) and V and f
> + * respectively the voltage and frequency of the OPP.
> + *
> + * Return: -ENODEV if the CPU device cannot be found, -EINVAL if the power
> + * calculation failed because of missing parameters, 0 otherwise.
> + */
> +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)

I would suggest to change the return type to unsigned long and return 0 for
errors and positive values for mW.

> +{
> +	unsigned long mV, Hz, MHz;

MHz is used only once, I think you can get rid of it just open code the division
by 1000000. Maybe remove Hz as well and directly use kHz.

> +	struct device *cpu_dev;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	u32 cap;
> +	u64 tmp;

Name this mW with the above changes.

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
> +	Hz = *KHz * 1000;
> +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> +	dev_pm_opp_put(opp);
> +	if (!mV)
> +		return -EINVAL;
> +
> +	MHz = Hz / 1000000;
> +	tmp = (u64)cap * mV * mV * MHz;
> +	do_div(tmp, 1000000000);
> +
> +	*mW = (unsigned long)tmp;
> +	*KHz = Hz / 1000;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_dev_pm_opp_get_cpu_power);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 0a2a88e5a383..fedde14f5187 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -322,6 +322,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
>  int of_get_required_opp_performance_state(struct device_node *np, int index);
> +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -364,6 +365,10 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
>  {
>  	return -ENOTSUPP;
>  }

Add a blank line here. We missed adding the same before
of_get_required_opp_performance_state() earlier, maybe add the new routine
before of_get_required_opp_performance_state() and add blank line before and
after it :)

> +static inline int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif
>  
>  #endif		/* __LINUX_OPP_H__ */
> -- 
> 2.20.1

-- 
viresh
