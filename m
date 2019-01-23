Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32977C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC28821850
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lSHkO1gU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfAWSU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:20:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34058 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfAWSU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:20:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so1583362plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 10:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zcKz6GgsyC/6+bsI0gm7ytrwe5pfnLKT11ktKXpTX7I=;
        b=lSHkO1gUij8ucXI5VboJ2MlSh1iP5z4WIiTjPpkqT88XWs3VSLY9ulUBCF8wTTgw/l
         9YX38rVVoBwmJUVPSHbuty0DovngVxx1oGNYMJOoUjc+dTBwz4krmAT2TFjSf5oTwYMM
         JQaBVnf8b0lrXbMzaGiP9+gST/dV9sUN2v6PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcKz6GgsyC/6+bsI0gm7ytrwe5pfnLKT11ktKXpTX7I=;
        b=SSCgJnLvoBaFtpegXFTuRN7tWfMOLhXQXCoQ4gzLK8EsqinOuh+yFKLavTmpoaZ6k7
         AxVZ99Kqrd0lnGMalXpviX6F9JJTa9tp4vUmTVMm4Vl14TPi1wCn60/Qsg2SAMH4+YXG
         jLrKQixFI7QkHES+ZiDKtXSb3cTmlCNtE2lcJWnfwdA/rAg3zDgbNUZrbVfVJ1vrzwLy
         OBxDnDqzePqhRHn+DosRTN7oNYGtYrWDhQdJ3Wf0yV2YNETrFaBW/T66T+39qLGEpBPA
         MmhhBIb0ThTu2J5PMzDotL1L9oMVgHlkSFn7EisJEXPWw5Bfd5YzFDr1LEhiGj2ItLiC
         GZqg==
X-Gm-Message-State: AJcUukd9dU7JotLOKHONA4gSI1jPuqDpoygevk0Hyl03480oM4pK87fb
        VbTmYXOtOWj5KCG4BYcM5wevJZur3p4=
X-Google-Smtp-Source: ALg8bN7sxF6Kq/+aqmOHos3xjks4Di/TIDYcifkA0A81YSOS4GL4ECE78o1/iTKG0StHM+eVn5gzDg==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr3187160plz.174.1548267656051;
        Wed, 23 Jan 2019 10:20:56 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t185sm29015368pgd.90.2019.01.23.10.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 10:20:55 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:20:54 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
Subject: Re: [PATCH v5] cpufreq: qcom: Read voltage LUT and populate OPP
Message-ID: <20190123182054.GK261387@google.com>
References: <1548242520-13773-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1548242520-13773-1-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

On Wed, Jan 23, 2019 at 04:52:00PM +0530, Taniya Das wrote:
> Add support to read the voltage look up table and populate OPP for all
> corresponding CPUS for consumers like the energy model could use the
> frequency and voltage from the OPP tables. Also update the logic to not add
> duplicate OPPs.
> 
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 46 +++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d83939a..402ce81 100644
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
> @@ -83,23 +87,28 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
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
> -			table[i].frequency = CPUFREQ_ENTRY_INVALID;
> -		} else {
> +		if (freq != prev_freq && core_count == max_cores) {
>  			table[i].frequency = freq;
> -			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
> +			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
> +			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>  				freq, core_count);
> +		} else {
> +			table[i].frequency = CPUFREQ_ENTRY_INVALID;
>  		}
> 
>  		/*
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
> @@ -199,12 +218,19 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
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
> +		ret = -EINVAL;

nit: in seems -ENODEV would be more correct, it's also what
dev_pm_opp_get_opp_count() would return if the device had no OPP table:
https://elixir.bootlin.com/linux/v4.20.4/source/drivers/opp/core.c#L65

> +		goto error;
> +	}
> +
>  	policy->fast_switch_possible = true;
> 
>  	return 0;
> @@ -215,8 +241,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> 
>  static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  {
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
>  	void __iomem *base = policy->driver_data - REG_PERF_STATE;
> 
> +	dev_pm_opp_remove_all_dynamic(cpu_dev);
>  	kfree(policy->freq_table);
>  	devm_iounmap(&global_pdev->dev, base);

Other than the nit about the return value:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Also re-tested it, so the earlier Tested-by tag is applicable again :)

Thanks

Matthias
