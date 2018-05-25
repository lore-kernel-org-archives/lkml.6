Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935885AbeEYDyX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:54:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38383 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935726AbeEYDyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:54:17 -0400
X-Google-Smtp-Source: AB8JxZrKJX2fG1BjSTcVGHtGaEyswZ6L4yRpFbu0XV4DV+D0ISyxc+LUlm9iezGZjiiWEinhQ3Zljg==
Date: Fri, 25 May 2018 09:24:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 1/2] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180525035412.3jjocp7ccmv5u2il@vireshk-i7>
References: <1527174220-13244-1-git-send-email-ilialin@codeaurora.org>
 <1527174220-13244-2-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527174220-13244-2-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-05-18, 18:03, Ilia Lin wrote:
> +static int __init qcom_cpufreq_kryo_init(void)
> +{
> +	struct device_node *np;
> +	struct device *cpu_dev;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (NULL == cpu_dev)
> +		ret = -ENODEV;
> +
> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +	if (IS_ERR(np))
> +		return PTR_ERR(np);
> +
> +	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
> +	of_node_put(np);
> +	if (!ret)
> +		return -ENOENT;
> +

I hate the fact that it is taking so long to get done with this. But can't you
just check machine compatibility instead of this complicated setup to check OPP
node ? Like:

        if (!of_device_is_compatible("qcom,apq8096") &&
            !of_device_is_compatible("qcom,msm8996"))
                return;

And please see if you can add an entry in MAINTAINERS and add your working email
id there.

-- 
viresh
