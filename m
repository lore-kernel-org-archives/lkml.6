Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882B2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D672133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpFXuSCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfAKDq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:46:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44551 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfAKDq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:46:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so6133826plt.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 19:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ky/hb8cXarOC1ywvT6QlLtEpqRPamwVEP09iZrqPpdo=;
        b=QpFXuSCrQ3oFn7e7D9CiUv+eIPDdXT8N6c+yJYDsOQsG7zZzbQGTMsN0hzQHQDu9Vg
         fqbc3DNjtC7kCJPeyI2JecN9L6Tk6hKBcBS4q5Ss7J7o4uURyUtehyIqADNhJqmkvgEK
         gx7PuqjjiZhgsKm7WiU5iya4wY3ZzRZYuG7BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ky/hb8cXarOC1ywvT6QlLtEpqRPamwVEP09iZrqPpdo=;
        b=WJ5s2bOvDQHPgRZKzmaWe3OJ7ymoBF3kP7qyIhSQCrKXwy7u5b7l06Rov7oF4BIlv7
         Sqfdj7AL7GYWX4cxkCt0w4WevxzYEoLgh8C2cjgz1jr/W3IPKILu8KxO6Bg4EmpqnBEt
         5ySB2UVoOcc54SqQk1ys3JVlo847sqh2vEBfixtCaodRUFJqnR9RcF/3EhcHe/bOiMZv
         jVRpmVDyZcHTIu6YEDZjPw7ObJ/KtQ23Zptcs/Os+fBf1opc+c/f4Xywu65QimeJ7E3y
         +93BzZgwoUeQRDl/uGXJji1sm1+Gn2pTpdi8oQF9oXEEGfwevbpEhnDy6nrhjuY7cOZt
         cjMw==
X-Gm-Message-State: AJcUuke9XpGkpPjNhqLHW3SCawvSmGCKJUwaEavVV3cXUxIiPnBxq6Iv
        Fv/veFsBLN/sj9An7Ax5MoBp4Q==
X-Google-Smtp-Source: ALg8bN47nyEnEINdok0i/PpFTJJIb6H8KfIHqA6Njn0N82kTqx0KwB65MkapFrqVgbNx9s3Pudifnw==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr12508243pln.224.1547178416006;
        Thu, 10 Jan 2019 19:46:56 -0800 (PST)
Received: from localhost ([122.172.34.203])
        by smtp.gmail.com with ESMTPSA id d3sm97350958pgl.64.2019.01.10.19.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 19:46:55 -0800 (PST)
Date:   Fri, 11 Jan 2019 09:16:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190111034653.6dstox4c6hpjum4f@vireshk-i7>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
 <20190110022217.GX261387@google.com>
 <20190110062359.aea3tic5aw3iuocr@vireshk-i7>
 <20190110184241.GY261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110184241.GY261387@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-19, 10:42, Matthias Kaehlcke wrote:
> Thanks for the pointer, there's always something new to learn!
> 
> Ok, so the policy CPU and hence the CPU registered as cooling
> device may vary. I understand that this requires to list all possible
> cooling devices,

I won't say that I changed DT because of a design issue with kernel,
rather the DT shall be complete by itself and that's why that change
was made.

And then we can have more things going on. For example with cpuidle
cooling, we can individually control each CPU (and force idle on that)
even if all CPUs are part of the same freq-domain. Each CPU shall
expose its capabilities.

> even though only one will be active at any given
> time. However I wonder if we could change this:

I won't say it that way. I see it as all the CPUs are active during a
cooling state, i.e. they are all participating.
 
> >From 103703a46495ff210a521b5b6fbf32632053c64f Mon Sep 17 00:00:00 2001
> From: Matthias Kaehlcke <mka@chromium.org>
> Date: Thu, 10 Jan 2019 09:48:38 -0800
> Subject: [PATCH] thermal: cpu_cooling: always use first CPU of a freq domain
>  as cooling device
> 
> For all CPUs of a frequency domain a single cooling device is
> registered, since the CPUs can't switch their frequencies
> independently from each other. The cpufreq policy CPU is used to
> represent cooling device of the frequency domain. Which CPU is the
> policy CPU may vary based on the order of initialization or CPU
> hotplug.
> 
> For device tree based platform the above implies that cooling maps
> must include a list of all possible cooling devices of a frequency
> domain, even though only one of them will exist at any given time.
> 
> For example:
> 
> cooling-maps {
> 	map0 {
> 		trip = <&cpu_alert0>;
> 		cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
> 				 <&CPU1 THERMAL_NO_LIMIT 4>,
> 				 <&CPU2 THERMAL_NO_LIMIT 4>,
> 				 <&CPU3 THERMAL_NO_LIMIT 4>;
> 	};
> 	map1 {
> 		trip = <&cpu_crit0>;
> 		cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> 				 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> 				 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> 				 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

This is the right thing to do hardware description wise, no matter
what the kernel does.

> 	};
> };
> 
> This can be avoided by using always the first CPU of a frequency
> domain as cooling device. It may happen that the first CPU is offline
> when the cooling device is registered (e.g. CPU2 is initialized
> first in the above example), hence the nominal cooling device might
> be offline. This may seem odd, however it is not really different from
> the current behavior: when the policy CPU is taking offline the cooling
> device corresponding to it remains active, unless it is unregistered
> because all other CPUs of the frequency domain are offline too.
> 
> A single cooling device associated with a specific CPU of the frequency
> domain reduces redundant device tree clutter in CPU nodes and cooling
> maps.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/cpu_cooling.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index dfd23245f778a..bb5ea06f893a2 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -758,13 +758,14 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
>  struct thermal_cooling_device *
>  of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
> -	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
> +	unsigned int first_cpu = cpumask_first(policy->related_cpus);
> +	struct device_node *np = of_get_cpu_node(first_cpu, NULL);
>  	struct thermal_cooling_device *cdev = NULL;
>  	u32 capacitance = 0;
>  
>  	if (!np) {
>  		pr_err("cpu_cooling: OF node not available for cpu%d\n",
> -		       policy->cpu);
> +		       first_cpu);
>  		return NULL;
>  	}
>  
> @@ -775,7 +776,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  		cdev = __cpufreq_cooling_register(np, policy, capacitance);
>  		if (IS_ERR(cdev)) {
>  			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
> -			       policy->cpu, PTR_ERR(cdev));
> +			       first_cpu, PTR_ERR(cdev));
>  			cdev = NULL;
>  		}
>  	}
> 
> 
> Would that make sense or is there something I'm overlooking?

I don't see any benefits of this to be honest. Even if we make this
change, the DT should remain in its current form.

-- 
viresh
