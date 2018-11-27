Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC10C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23895208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23895208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeK0Mi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:38:58 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41184 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeK0Mi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:38:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so17842743oii.8;
        Mon, 26 Nov 2018 17:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o2Hd4o4Sm+vFnSrCajknYBXU89D4Z/ZUfBVjtzkQ0NI=;
        b=Ibq7LizDJmGjs5CpN2C3zPXS7s7vg/y7fZi98zGIGWBRb5t+DDxfrbdAJJlGDTVw5I
         AjNbjv0fHVl+OpbROxjtiZq0FgwpZ/q1bsQD3tZVzp4XeDUhRjM9k0PpC3d6V/KjfmxH
         BeWMZJMkAh8VreEDI8s9jBPSLTXxM0HnX4gqPm2dhlmtmVij/x1GmTWX/HyLdpoHf1c4
         LhdCJQuDaZfYcWyNrGLGGbhJ/6+rSRNBoSxtOV8iAXmWLUnmTq1a9QNtmmS1fwXQqkyM
         l6Gi8ba2TaBBHqnFRf5ZCbm4CtN76HYQ4nfhB7E3zxw23IajfkOJAAmrg/OwbI00azF9
         3KjA==
X-Gm-Message-State: AGRZ1gIzO1m+/YwxK583wnL9ED96HpMpeEhn6NZBntKggOaR55RhfeIa
        Rbk/AbjmPq9Uzn9YQRzdpA==
X-Google-Smtp-Source: AJdET5fOHpeU1WhlXKUlAUPbBysVTRfyQXJMllx/6/3yGbZLy4+bh7BLCN62TUz1iUcVEXEi/UlB/w==
X-Received: by 2002:aca:cc:: with SMTP id 195mr17287036oia.297.1543282968785;
        Mon, 26 Nov 2018 17:42:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x9sm598150otq.73.2018.11.26.17.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 17:42:48 -0800 (PST)
Date:   Mon, 26 Nov 2018 19:42:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH V4 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181127014247.GA26233@bogus>
References: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
 <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 01:20:43PM +0100, Daniel Lezcano wrote:
> In the case of asymmetric SoC with the same micro-architecture, we
> have a group of CPUs with smaller OPPs than the other group. One
> example is the 96boards dragonboard 820c. There is no dmips/MHz
> difference between both groups, so no need to specify the values in
> the DT. Unfortunately, without these defined, there is no scaling
> capacity computation triggered, so we need to write
> 'capacity-dmips-mhz' for each CPU with the same value in order to
> force the scaled capacity computation.
> 
> In order to fix this situation, allocate 'raw_capacity' so the pointer
> is set and the init_cpu_capacity_callback() function can be called.
> 
> This was tested on db820c:
>  - specified values in the DT (correct results)
>  - partial values defined in the DT (error + fallback to defaults)
>  - no specified values in the DT (correct results)
> 
> correct results are:
>   cat /sys/devices/system/cpu/cpu*/cpu_capacity
>    758
>    758
>   1024
>   1024
> 
>   ... respectively for CPU0, CPU1, CPU2 and CPU3.
> 
> That reflects the capacity for the max frequencies 1593600 and 2150400.
> 
> Cc: Chris Redpath <chris.redpath@linaro.org>
> Cc: Quentin Perret <quentin.perret@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpu-capacity.txt |  6 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/base/arch_topology.c                           | 13 ++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> index 84262cd..f53a3c9 100644
> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> @@ -54,6 +54,12 @@ fall back to the default capacity value for every CPU. If cpufreq is not
>  available, final capacities are calculated by directly using capacity-dmips-
>  mhz values (normalized w.r.t. the highest value found while parsing the DT).
>  
> +If capacity-dmips-mhz is not specified or if the parsing fails, the
> +default capacity value will be computed against the highest frequency.
> +When all CPUs have the same OPP, they will have the same capacity
> +value otherwise the capacity will be scaled down for CPUs having lower
> +frequencies.
> +
>  ===========================================
>  4 - Examples
>  ===========================================
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index fd5325b..e0c5b60 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -243,9 +243,20 @@ static int __init register_cpufreq_notifier(void)
>  	 * until we have the necessary code to parse the cpu capacity, so
>  	 * skip registering cpufreq notifier.
>  	 */
> -	if (!acpi_disabled || !raw_capacity)
> +	if (!acpi_disabled)
>  		return -EINVAL;
>  
> +	if (!raw_capacity) {
> +
> +		pr_info("cpu_capacity: No capacity defined in DT, set default "
> +		       "values to %ld\n", SCHED_CAPACITY_SCALE);
> +
> +		raw_capacity = kmalloc_array(num_possible_cpus(),
> +					     sizeof(*raw_capacity), GFP_KERNEL);
> +		if (!raw_capacity)
> +			return -ENOMEM;
> +	}
> +
>  	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
>  		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
>  		return -ENOMEM;
> -- 
> 2.7.4
> 
