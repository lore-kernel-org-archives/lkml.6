Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E880C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF082075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ddp9f9Fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfAIIyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:54:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34861 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfAIIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:54:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so3356324pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 00:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yq+eVxiIvzW0p5cvnB/kkWpo99iFszmaXW7UrzHXeDU=;
        b=Ddp9f9FuepDZgyH3XqH90h1slMQN8AVN7JGsrzKxLhcQNglVCQqWLGgtCjVVlMev4L
         UKS90ier5vSuCO/DM9o3B7YsFV9EPHv+fbZ8rCv3o5kpgPLFXTuCMqNziM8+3Y4/Kr5z
         j96TvHovR43nWO+bg4CYHNFx5XIoFsWJCLCKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yq+eVxiIvzW0p5cvnB/kkWpo99iFszmaXW7UrzHXeDU=;
        b=q+LYxPVuUj0msFGlatz7bJNg4A4XDdfHGdUsh6D8mTZ/rLaxZfS/cfiD8vBaEqbTIo
         EMR8Rd4g5AWkuKgb5P5pKyRhTJpV6VkMlaBpKStG6AvfE7W76SCQkW6VzLsm+8a/n2ZY
         TNiqtMTXfwIFdlZ46S3taFy9mAl6/eL5nmX6QQEkc+VUUn3+P99ME3Iw2Npp3z/DUrfP
         pkrEiO/O03kt6fLEE0YvtSW8fHNLWFyFMObGEsCp+fgbVleYBOq42owD+Mu5//E4yKtw
         e6u1jtGhuAC4jqeZjTDIiMMFcGbA7EDm/0ZNeCO3dxu75XKaxCRMPNVxed53xZe94hRr
         l92A==
X-Gm-Message-State: AJcUukexSJca3KqWy+9UoPvDJ/+0VnKDQw9kfl45pcEQ7MCuQfzerwwn
        XzdC53lRg45txnPEuo2yp026Zw==
X-Google-Smtp-Source: ALg8bN42s5cbnKm7O1OrYEPx2gDAmrVVOXuW+3J9MDZ8WlSDY9zCSFusLUb/QLfK2f+hgvzuHYTb4Q==
X-Received: by 2002:a62:6204:: with SMTP id w4mr5162525pfb.5.1547024044474;
        Wed, 09 Jan 2019 00:54:04 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id z186sm109137507pfz.119.2019.01.09.00.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 00:54:03 -0800 (PST)
Date:   Wed, 9 Jan 2019 14:24:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, Matthias Kaehlcke <mka@chromium.org>,
        evgreen@google.com
Subject: Re: [PATCH v2] cpufreq: qcom: Read voltage LUT and populate OPP
Message-ID: <20190109085400.mscuzezwxta4fpfh@vireshk-i7>
References: <1547021248-27258-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547021248-27258-1-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-19, 13:37, Taniya Das wrote:
> @@ -98,6 +107,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,

You are only using this "dev" parameter for dev_dbg(), instead of that
pass cpu_dev pointer.

>  			table[i].frequency = CPUFREQ_ENTRY_INVALID;
>  		} else {
>  			table[i].frequency = freq;
> +			dev_pm_opp_add(get_cpu_device(policy->cpu),
> +					freq * 1000, volt);
>  			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
>  				freq, core_count);
>  		}
> @@ -116,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>  			if (prev_cc != max_cores) {
>  				prev->frequency = prev_freq;
>  				prev->flags = CPUFREQ_BOOST_FREQ;
> +				dev_pm_opp_add(get_cpu_device(policy->cpu),
> +						prev_freq * 1000, volt);
>  			}
> 
>  			break;
> @@ -127,6 +140,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
> 
>  	table[i].frequency = CPUFREQ_TABLE_END;
>  	policy->freq_table = table;
> +	dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu), policy->cpus);

and then all the above sites can be simplified a bit.

>  	return 0;
>  }
> @@ -159,10 +173,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
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
> @@ -205,6 +227,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		goto error;
>  	}
> 
> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (ret <= 0) {
> +		dev_err(cpu_dev, "OPP table is not ready\n");

Rather say "Failed to add OPPs\n".

> +		goto error;
> +	}
> +
>  	policy->fast_switch_possible = true;
> 
>  	return 0;
> @@ -217,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	void __iomem *base = policy->driver_data - REG_PERF_STATE;
> 
> +	dev_pm_opp_remove_all_dynamic(&global_pdev->dev);

This is platform device's device structure, while you added the OPPs
using cpu_dev. You sure this will work ?

>  	kfree(policy->freq_table);
>  	devm_iounmap(&global_pdev->dev, base);
> 
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.

-- 
viresh
