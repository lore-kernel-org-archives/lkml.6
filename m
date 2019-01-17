Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507FBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105C420851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KJSd1kHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfAQVEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:04:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34252 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbfAQVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:04:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so5433222pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHZiIP0BjSWSA4LlgTXGKW2XEVcjpSpy7v+tElPKv0Y=;
        b=KJSd1kHIhTxAYyAq/1vkyLId29ifr4kqfdVhSu+sz8lJTrnQMqtmDBd6Di6sA2KuDn
         Y5YgpPifSecQjMSUL1OPrzKwjYmj3gIEE1oTQeM2iFs+L804NyKr9/NjEB7VQJmapPG5
         Pe1VqXCpH8vR8aQ83eAf/uXR3NbQrPQ87ynJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHZiIP0BjSWSA4LlgTXGKW2XEVcjpSpy7v+tElPKv0Y=;
        b=jEF9B61xGxVQ5BuzAtN+a6Ge1i4VnnRm9YoIW+5sgrwKMC1zl1qzmAmxEmcPZdCADs
         UB4LmzYq6vBIC4NYYMFCvenSuDVXKC5sLp9BnXosSJhu5GpVbAi67/mKmR/ebjb+5ZJx
         ikc3vOmPBwLu07JY01sxarkAF1ndO14plrg5dGNvKqkZcfmp+DsueE+jsQAgb/s0BT8D
         QGSaFR/NjLk501EeoWz+kS/Ur6r+Flf/ZU3oIeheoTAL9UOtpITQSfF5WLk0vZe3nPHh
         CSSrupfpuHg8ZF2lc9YP4XHE3s09SR8T+qPN0qo+e6h05EpeCPQ1ylGPhSDCjq0RayTa
         IvaQ==
X-Gm-Message-State: AJcUukduhM9h86vcHMrCRd1z2t7L2DTGfhzneUSThRnPmIJO+lFsFXGC
        veSPyjlia3csmqoZdF4KR3+WQA==
X-Google-Smtp-Source: ALg8bN4uisSQr7o77THHEsB47A1SZb6HFpsjKWy9WQkGZSjYUUnvo/+4aPUUWezXEq2Gy/0Lp8vZSQ==
X-Received: by 2002:a63:b543:: with SMTP id u3mr14863432pgo.420.1547759059317;
        Thu, 17 Jan 2019 13:04:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y29sm3825197pga.59.2019.01.17.13.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 13:04:18 -0800 (PST)
Date:   Thu, 17 Jan 2019 13:04:17 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
Subject: Re: [PATCH v4] cpufreq: qcom: Read voltage LUT and populate OPP
Message-ID: <20190117210417.GW261387@google.com>
References: <1547722798-8455-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547722798-8455-1-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanyia,

On Thu, Jan 17, 2019 at 04:29:58PM +0530, Taniya Das wrote:
> Add support to read the voltage look up table and populate OPP for all
> corresponding CPUS for consumers like the energy model could use the
> frequency and voltage from the OPP tables. Also update the logic to not add
> duplicate OPPs.
> 
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 41 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d83939a..e006938 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -10,18 +10,21 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/pm_opp.h>
>  #include <linux/slab.h>
> 
>  #define LUT_MAX_ENTRIES			40U
>  #define LUT_SRC				GENMASK(31, 30)
>  #define LUT_L_VAL			GENMASK(7, 0)
>  #define LUT_CORE_COUNT			GENMASK(18, 16)
> +#define LUT_VOLT			GENMASK(11, 0)
>  #define LUT_ROW_SIZE			32
>  #define CLK_HW_DIV			2
> 
>  /* Register offsets */
>  #define REG_ENABLE			0x0
> -#define REG_LUT_TABLE			0x110
> +#define REG_FREQ_LUT			0x110
> +#define REG_VOLT_LUT			0x114
>  #define REG_PERF_STATE			0x920
> 
>  static unsigned long cpu_hw_rate, xo_rate;
> @@ -70,11 +73,12 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>  	return policy->freq_table[index].frequency;
>  }
> 
> -static int qcom_cpufreq_hw_read_lut(struct device *dev,
> +static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  				    struct cpufreq_policy *policy,
>  				    void __iomem *base)
>  {
>  	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
> +	u32 volt;
>  	unsigned int max_cores = cpumask_weight(policy->cpus);
>  	struct cpufreq_frequency_table	*table;
> 
> @@ -83,22 +87,27 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>  		return -ENOMEM;
> 
>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> -		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
> +		data = readl_relaxed(base + REG_FREQ_LUT +
> +				      i * LUT_ROW_SIZE);
>  		src = FIELD_GET(LUT_SRC, data);
>  		lval = FIELD_GET(LUT_L_VAL, data);
>  		core_count = FIELD_GET(LUT_CORE_COUNT, data);
> 
> +		data = readl_relaxed(base + REG_VOLT_LUT +
> +				      i * LUT_ROW_SIZE);
> +		volt = FIELD_GET(LUT_VOLT, data) * 1000;
> +
>  		if (src)
>  			freq = xo_rate * lval / 1000;
>  		else
>  			freq = cpu_hw_rate / 1000;
> 
> -		/* Ignore boosts in the middle of the table */
> -		if (core_count != max_cores) {
> +		if (freq != prev_freq && core_count == max_cores) {
>  			table[i].frequency = CPUFREQ_ENTRY_INVALID;
>  		} else {
>  			table[i].frequency = freq;
> -			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
> +			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
> +			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>  				freq, core_count);
>  		}

This marks normal entries as invalid and tries to add (potential)
boost frequencies to the OPP table. Note that the patch I posted on
https://lore.kernel.org/patchwork/patch/1030239/#1218724 does not only
change the condition, but also the order of the 'if' and 'else'
branches.

> @@ -116,6 +125,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>  			if (prev_cc != max_cores) {
>  				prev->frequency = prev_freq;
>  				prev->flags = CPUFREQ_BOOST_FREQ;
> +				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
>  			}
> 
>  			break;
> @@ -127,6 +137,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
> 
>  	table[i].frequency = CPUFREQ_TABLE_END;
>  	policy->freq_table = table;
> +	dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> 
>  	return 0;
>  }
> @@ -159,10 +170,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  	struct device *dev = &global_pdev->dev;
>  	struct of_phandle_args args;
>  	struct device_node *cpu_np;
> +	struct device *cpu_dev;
>  	struct resource *res;
>  	void __iomem *base;
>  	int ret, index;
> 
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_err("%s: failed to get cpu%d device\n", __func__,
> +		       policy->cpu);
> +		return -ENODEV;
> +	}
> +
>  	cpu_np = of_cpu_device_node_get(policy->cpu);
>  	if (!cpu_np)
>  		return -EINVAL;
> @@ -199,12 +218,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> 
>  	policy->driver_data = base + REG_PERF_STATE;
> 
> -	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
> +	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy, base);
>  	if (ret) {
>  		dev_err(dev, "Domain-%d failed to read LUT\n", index);
>  		goto error;
>  	}
> 
> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (ret <= 0) {
> +		dev_err(cpu_dev, "Failed to add OPPs\n");
> +		goto error;

This will return 0 (success) if the OPP count is zero, which probably
is not intended.

Cheers

Matthias

