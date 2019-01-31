Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056D6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D122D2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCIt3mQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfAaH0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:26:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32858 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfAaH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:26:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so1107650plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 23:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UnrYeubApCq/+0X7gGe4NXl9ZaHuao0U3/2CArPUokc=;
        b=aCIt3mQd6UL5e+OqkpGMLrqT6JTN9FEoEs4eXoSzVyjDr6l8jRas7N+dCEKaK05CHj
         7Mrspf4epo0lt+rfkMIhJS7h/5F5sQtivF5jKbmVyewgH+Wj8tEc6uz2Dqr7MG3PoOL5
         svxZDzC4C6LS6unq34KyrnJZ0XZ/+SHBMyF3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UnrYeubApCq/+0X7gGe4NXl9ZaHuao0U3/2CArPUokc=;
        b=Q1zL+3ppnbZijg2dZj2G6Pm+dhZcpGRUSPjHiOrf09Netny89sWdEgtIhREHifke0g
         oCdBgrQrh3KoU5vKm9CfCeT1AxcEJ4gL74h2NJFP92WnbdKz/AEs/KlXuvwrvpAUl4P9
         Ad4QpzdBSlqXdH6edoAPmKL57G8lzKFDaru3/br0j8mRIZVSPoe4rLIM5yCkNF0pUbSe
         FRBQzVnS5cAwN7PugxSDOc4yxpRiC3RrsQ4YY2d/+5vb0BpFV8UKm0h8SVGOk42yTsbL
         Zym5BEt+rwVAslmK8pw59A4nBHys/OIP/b2zaLkT0HWLiQK+ELdSF6owOtyg8ZUWCsDa
         jQkg==
X-Gm-Message-State: AJcUukeReIDshOI37saTc6mQB+rVTGwy1XRjJpmplZbXZOu3PLz8FMGQ
        d2VQf+R6QuTZ3xU4RWPukCUlQw==
X-Google-Smtp-Source: ALg8bN5Yu2fhJvbbNMdhN2xDmQJK0Q2QimJ2AuBY9WHuBzUGxKsYmBZGYc6+I9/YZ4NSSwl9aATViw==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr34117301pld.181.1548919595981;
        Wed, 30 Jan 2019 23:26:35 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id p77sm7546037pfi.85.2019.01.30.23.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 23:26:35 -0800 (PST)
Date:   Thu, 31 Jan 2019 12:56:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131072633.bcqc75s6jmyt7fgx@vireshk-i7>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130170506.20450-2-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-01-19, 17:05, Quentin Perret wrote:
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

The voltage is also stored as triplet now a days and we must consider
the higher value for these calculations. Also what about the case of
multiple regulators here or performance-states ?

> +	dev_pm_opp_put(opp);
> +	if (!mV)
> +		return -EINVAL;
> +
> +	tmp = (u64)cap * mV * mV * (Hz / 1000000);
> +	do_div(tmp, 1000000000);
> +
> +	*mW = (unsigned long)tmp;

I was thinking will it be better if we just save this information in
opp->power field during init, so we can just read a value here
instead. But I am still not sure :(

> +	*kHz = Hz / 1000;
> +
> +	return 0;
> +}
> +
> +/**
> + * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
> + * @cpus	: CPUs for which an Energy Model has to be registered
> + * @nr_opp	: Number of OPPs to register in the Energy Model
> + *
> + * This checks whether the "dynamic-power-coefficient" devicetree binding has
> + * been specified, and tries to register an Energy Model with it if it has.
> + */
> +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> +{
> +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> +	int ret, cpu = cpumask_first(cpus);
> +	struct device *cpu_dev;
> +	struct device_node *np;
> +	u32 cap;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev)
> +		return;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np)
> +		return;
> +
> +	/* Don't register an EM without the right DT binding */
> +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> +	of_node_put(np);
> +	if (ret || !cap)
> +		return;

What if no voltage is supplied in DT ?

> +
> +	em_register_perf_domain(cpus, nr_opp, &em_cb);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index b895f4e79868..58ae08b024bd 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -327,6 +327,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
>  int of_get_required_opp_performance_state(struct device_node *np, int index);
> +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -365,6 +366,11 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  {
>  	return NULL;
>  }
> +
> +static inline void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> +{
> +}
> +
>  static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
>  {
>  	return -ENOTSUPP;
> -- 
> 2.20.1

-- 
viresh
