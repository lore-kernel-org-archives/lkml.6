Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824CAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1932148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQ58uiGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfA2FgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:36:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46390 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfA2FgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:36:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so8842268ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L6IMIFHciaapq4tpOMKVSs8TpkfE6uQccFKDHWEWimk=;
        b=hQ58uiGYvtxY3puREmQgzxGPHYI7YyTPNmAZHdhcFUq7IbF1CMn1cQfq1ovzz25qLt
         biOa1ib8yuSjNVDzfi/Qn92GRyrKMM3JB5MiifEzhqqEH1l+z1RJ83VvGDVHC1ePCp+u
         y7g84nsecQuYqzPyjZHX24dDiJ/u9RzJB97dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L6IMIFHciaapq4tpOMKVSs8TpkfE6uQccFKDHWEWimk=;
        b=Gvdgav79xM+v4ZSxlVvGUYTunCQki7JJ39otCzFAWMBPGa7E9wPhO50OSK/UAw3Uou
         J9IM4hbC14FCZjfMXBhEmzsX3m80k7FblpqD/YltlehtLVlvUNFCTpYBX72OtLUsN2qP
         0IuejK5cvEqEgemFWWIgAeqDpRWfo2Qjg8Fiqkz5znbxVaaKJ4xsz+PGsIhEozPtyicq
         h3Qix1i7CDCUndLSqBGRw7+2M0in3OgCFRoh0rao8a974XSTtdpajuF94H4bz1TR6jjd
         s8GPGD4K2KVGRnQLrHCLHaynuZwENViXzEX7beo5NKjc4Dg8XqdXMiF0JOi0qabwKWX9
         sRbQ==
X-Gm-Message-State: AJcUukfvOF/BSRnth+O8NmkVLcbHlKd4XIb5cX9vuoo+zrVCyR/+wU7F
        9g8YWwqyegB2d0Yvdh4jt3pcFw==
X-Google-Smtp-Source: ALg8bN7AfuNoNrXg/QUf+naQkXLqynXlrzEVqzV3339bocqBfOMUa7pkGVXzQ+hrqEqXoUqhqNx8nA==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr25157341plb.332.1548740180975;
        Mon, 28 Jan 2019 21:36:20 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id q5sm58658173pfi.165.2019.01.28.21.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 21:36:20 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:06:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Message-ID: <20190129053618.laa6nscfvlmhhkb5@vireshk-i7>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-19, 10:25, Amit Kucheria wrote:
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
> 
> In order to allow this, we add a struct thermal_cooling_device pointer
> to struct cpufreq_policy so that drivers don't need to store it in a
> private data structure.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
>  include/linux/cpufreq.h   |  9 +++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..0f9b50d3ee91 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -19,6 +19,7 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> @@ -1318,6 +1319,11 @@ static int cpufreq_online(unsigned int cpu)
>  	if (cpufreq_driver->ready)
>  		cpufreq_driver->ready(policy);
>  
> +#if IS_ENABLED(CONFIG_CPU_THERMAL)
> +	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> +		policy->cdev = of_cpufreq_cooling_register(policy);
> +#endif

I am not sure if Rafael wanted it this way but maybe something like this:

        if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
            cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV))
		policy->cdev = of_cpufreq_cooling_register(policy);

We never wanted ifdef hackery to be in there :)

-- 
viresh
