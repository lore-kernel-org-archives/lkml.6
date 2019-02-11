Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA2DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA23520823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVaCHRjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfBKIrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:47:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43861 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:47:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id f90so4756718plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lKJkfvRf9vZMrT9r23qvKmpAYOOgMVXkF3jA/6qcIEw=;
        b=zVaCHRjC3u5C92M1H48msWf5zOPUu7RuXY/ZnbtPCNUTSLGn4Ec5Zl1UknqpPLTf+B
         NvrlLk9M/U/kWwV/bbN6C21fiGpvZLGPowGXrNO1h647Txd/VRZ1+Zdx6u+cOJPH8adf
         8tz1qphN8ucv7hl5LebdH1sUZ5PxxD71eJKHlRQFmWmiRI32NuqBjntB7eK0XRa7HDZz
         YGn+kzEutvULGlv/e61yQAHAIXsKTbshACVVqsRfvRRtvpK+nUVzxRjAaiRGx6qi+NdH
         UiaQy+Kft0pGOS9mnszHsdtV3VNmI+jdozogJoFwv8HDRt0RmLFojJnN3uQhCrK5wOxb
         NjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lKJkfvRf9vZMrT9r23qvKmpAYOOgMVXkF3jA/6qcIEw=;
        b=NTd0dAAVOg29tP6QhIT+lo265iZj4FgCn50hwG6VxXD7GLCaRBMg+13fTTyzdIW/z0
         2E8rnk1dNoH8L6N9NzbrBAJ4vhrmsYxLsKFPG31HKf3fE9dUWE+vbYfMJDx1eUYggOJ5
         o3kjt8jm/TsOdpnzJ72i2eOGtOKgW59lZDPmQDFiruCWBp8O+6VWqfqUwhF4ci47Slsh
         zfFNGQphv9yPfFtfs4msCkNPUXKvCkNXdC8GEJWeZLrvOJPm7Ih+lTdsbon6rvzjRXSl
         ZcQvUKmRtgnvD98illoctIX6lw0yQoQIO5R3pTqan7f+9RVqpgr+uRXREFoffjuBxj1n
         xleg==
X-Gm-Message-State: AHQUAuamxbvI7UY4BGYwiGWlXynQGt9iCnLcD5r3YBRLETno+ZUAw3Zf
        l3nIn8awTPXLkKiVVA7HG/dJyQ==
X-Google-Smtp-Source: AHgI3IaMOxV/idnC+E8HMaF7+P4uXWLkgRt4wl754lIvM9Eu8gYl9OZYVZtF6IKQq1As6U3krHX3dA==
X-Received: by 2002:a17:902:c05:: with SMTP id 5mr36554098pls.155.1549874836898;
        Mon, 11 Feb 2019 00:47:16 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id f6sm16689612pfc.88.2019.02.11.00.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 00:47:16 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:17:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190211084714.nq3wqxk66dbrfqvy@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208110053.GA7913@e107155-lin>
 <87302853-74cc-8eeb-6bd4-6338746e0738@samsung.com>
 <20190208115122.GA13043@e107155-lin>
 <66b33c07-4970-b60a-d924-d4baba79c836@samsung.com>
 <20190208174131.GB22401@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208174131.GB22401@e107155-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-19, 17:41, Sudeep Holla wrote:
> Based on Rafael's suggestion, I cooked up something. See if this helps ?
> The policy to cpu dance can be removed and we can just run through the
> online cpumask I think.
> 
> Regards,
> Sudeep
> 
> -->8
> 
> diff --git i/drivers/cpufreq/cpufreq.c w/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..03d65a02a542 100644
> --- i/drivers/cpufreq/cpufreq.c
> +++ w/drivers/cpufreq/cpufreq.c
> @@ -1640,6 +1640,7 @@ EXPORT_SYMBOL(cpufreq_generic_suspend);
>  void cpufreq_suspend(void)
>  {
>  	struct cpufreq_policy *policy;
> +	int cpu;
>  
>  	if (!cpufreq_driver)
>  		return;
> @@ -1662,6 +1663,11 @@ void cpufreq_suspend(void)
>  	}
>  
>  suspend:
> +	if (cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME)
> +		for_each_active_policy(policy)
> +			for_each_cpu(cpu, policy->cpus)
> +				cpufreq_offline(cpu);

You will offline boot-cpu as well :)

> +
>  	cpufreq_suspended = true;
>  }
>  
> @@ -1674,7 +1680,7 @@ void cpufreq_suspend(void)
>  void cpufreq_resume(void)
>  {
>  	struct cpufreq_policy *policy;
> -	int ret;
> +	int ret, cpu;
>  
>  	if (!cpufreq_driver)
>  		return;
> @@ -1682,6 +1688,11 @@ void cpufreq_resume(void)
>  	if (unlikely(!cpufreq_suspended))
>  		return;
>  
> +	if (cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME)
> +		for_each_active_policy(policy)
> +			for_each_cpu(cpu, policy->cpus)
> +				cpufreq_online(cpu);
> +
>  	cpufreq_suspended = false;
>  
>  	if (!has_target() && !cpufreq_driver->resume)
> @@ -2444,14 +2455,16 @@ static enum cpuhp_state hp_online;
>  
>  static int cpuhp_cpufreq_online(unsigned int cpu)
>  {
> -	cpufreq_online(cpu);
> +	if (!(cpufreq_driver->flags & CPUFREQ_DEFER_INIT_DURING_RESUME))
> +		cpufreq_online(cpu);

This isn't correct as we can offline the CPUs without suspend as well
and cpufreq_online/offline should always be called in such cases.

Anyways, I have cc'd you on another series which may end up fixing
this problem as well.

-- 
viresh
