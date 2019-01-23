Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F29C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B0220861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VG3H6m+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfAWKg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:36:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40643 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfAWKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:36:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so982260pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mKX+YDoL325ftgriTJ+Ow6+u+fYvncfqfFhxgAypaso=;
        b=VG3H6m+QAVHbk3H628dRgLOvkOaj+eBBsBnze5cT8SGISzw02MlNs+tnKrCP1xGsi4
         MN8CYm0l7WMq5B/yP3+p/Yb/LaHQ6TrF4UPpo/M6fTBluvAp+ea/SDrVwjUT8yGmij8r
         YrfzlPuG8g7Y7KFoLZUYOsXcWWN6hjGhSE8rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKX+YDoL325ftgriTJ+Ow6+u+fYvncfqfFhxgAypaso=;
        b=U1uJB0dbcaDncy2vnihQiCdcu8LXd23dQKC380k4lOdzrBB6KHslLCSvYArUwV574I
         7YUD7Xw1Sv8oYU36KaLcjzvGf3ONX2L+jEzmhtnEyQ7i1z8wQEI14LtJLT72BW3cXXbk
         hYqaQmIVQU/2LRViN5yqVYJnVhRh3BVgY2/RE9RHAl51yesHDN2rvCkf9TOFwL+HVpGE
         6FFcPbWYxSKGE2UD+Q3wQP3NyPNSWyN0PVJKJWfj2Urrr1p8mhOtWXWrDG+225kaSkhA
         bllrR3yoLlXm1Gdz8ydedXIRt1h4YXYPWWbJiK8T68vjArGkG2K6ej8MO7LHyfFYw0l7
         u7Kw==
X-Gm-Message-State: AJcUuke24CJwnqjER9YUftB6IaCE8UQizKWefuPWvdTswo+URSwTChTS
        Gzwiao5SQBqASLDlkXyrqh4PyA==
X-Google-Smtp-Source: ALg8bN6PYf6i2Gp6wmO7BSPifN5z2x7EZwZzPUq09NAqhtzdtqH9oAzgjjm/licYK0j0EcUusrRbwA==
X-Received: by 2002:a63:4d:: with SMTP id 74mr1524951pga.248.1548239786968;
        Wed, 23 Jan 2019 02:36:26 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id b2sm34193097pfm.3.2019.01.23.02.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:36:26 -0800 (PST)
Date:   Wed, 23 Jan 2019 16:06:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Message-ID: <20190123103624.t4b2ij3bfvpezgjf@vireshk-i7>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-19, 21:10, Amit Kucheria wrote:
> @@ -151,6 +152,11 @@ struct cpufreq_policy {
>  
>  	/* For cpufreq driver's internal use */
>  	void			*driver_data;
> +
> +#ifdef CONFIG_CPU_THERMAL
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cdev;
> +#endif
>  };
>  
>  /* Only for ACPI */
> @@ -386,6 +392,12 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
>  
> +/*
> + * Set by drivers that want the core to automatically register the cpufreq
> + * driver as a thermal cooling device.
> + */
> +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
> +
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>  
> @@ -415,6 +427,19 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
>  			policy->cpuinfo.max_freq);
>  }
>  
> +#ifdef CONFIG_CPU_THERMAL
> +static inline void register_cooling_device(struct cpufreq_policy *policy) {
> +	policy->cdev = of_cpufreq_cooling_register(policy);
> +}
> +
> +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {
> +	cpufreq_cooling_unregister(policy->cdev);
> +	policy->cdev = NULL;
> +}
> +#else
> +static inline void register_cooling_device(struct cpufreq_policy *policy) {}
> +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {}
> +#endif

The whole ifdef hackery here saves space for a pointer per policy.
Just get rid of it, it isn't worth it.

-- 
viresh
