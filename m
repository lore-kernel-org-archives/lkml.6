Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9FFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF6620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B723pNcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfA1IjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:39:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44296 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1IjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:39:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so16959442wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HvCmuadj0C3VfhNvieaFfPciyvU0URb0jZw5i6fE1eQ=;
        b=B723pNczchkl703bz0+GZNNPX2lJFzG8gZsIagGCv3zYMg3H/R9MEc43d/KYfhl0mr
         JPEsFKac5+VoU4GB5GerekvdiXsOGHBTzSRk++ZDcIFHzH1uGtDgwYp0lSZt79KqqcwN
         AjLdtThJWUCe+y7CxqyhUZm/OyYkhjskKfNaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HvCmuadj0C3VfhNvieaFfPciyvU0URb0jZw5i6fE1eQ=;
        b=qkC2D+loApULcXOIXxTYf+xDtiODWhRJN4x5sLlcS6TEm+OAuKsuFN12B3ZnrYnFfd
         cVPGZh9SziAmLgEO1/4QQr93rB54AB/4noG7evfGPyaf69OBOzwgiaF8qjBfp2ofNmZ8
         XjFJOu822ZovrLc4kNCOpbpmzpyangH4ygAgf/hnz95x8/2DB2NifbgTRa4q85cxlK2B
         4kh0Xzdlod65ydyyi9ErbpHgb7BbZskm8Oi0NAQy1B4UT6rusjToBH8KQ7Dilxb1bVCT
         YTL1JD3oV43BBa+8ruLSX+GQ0xUKCSFzCp/PjrJnKaq+psZDTIKR6WWFpu+YYiwtBr6Z
         5Qkg==
X-Gm-Message-State: AJcUukfSdyldDe+IOLG2qd7x0KZb66cMmpUpNisxVQBRK8Nt5x4m2Dj9
        th1/1AaPyv2vbPkZG8PeQZftZg==
X-Google-Smtp-Source: ALg8bN4GsfEOEZMdbH2rQdepzEv/eAgIC8pJQISLyRASTjC6hqDe5KIKs9lW02JxCDrBkpqRJidnwQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr20530227wro.35.1548664761341;
        Mon, 28 Jan 2019 00:39:21 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
        by smtp.googlemail.com with ESMTPSA id h2sm128227075wrv.87.2019.01.28.00.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:39:20 -0800 (PST)
Subject: Re: [PATCH v4 8/9] cpufreq: scmi: Use auto-registration of thermal
 cooling device
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <81d81c0016fb275728b7b604020c22d8f53991b1.1548654899.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <49b6cb24-6f38-750d-e652-cc4e47f96db0@linaro.org>
Date:   Mon, 28 Jan 2019 09:39:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <81d81c0016fb275728b7b604020c22d8f53991b1.1548654899.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2019 07:41, Amit Kucheria wrote:
> Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
> automatically register as a thermal cooling device.
> 
> This allows removal of boiler plate code from the driver.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpufreq/scmi-cpufreq.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 242c3370544e..b19e9d129f8f 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -11,7 +11,6 @@
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/pm_opp.h>
> @@ -22,7 +21,6 @@
>  struct scmi_data {
>  	int domain_id;
>  	struct device *cpu_dev;
> -	struct thermal_cooling_device *cdev;
>  };
>  
>  static const struct scmi_handle *handle;
> @@ -185,7 +183,6 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct scmi_data *priv = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(priv->cdev);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	kfree(priv);
>  	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
> @@ -193,17 +190,11 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static void scmi_cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	struct scmi_data *priv = policy->driver_data;
> -
> -	priv->cdev = of_cpufreq_cooling_register(policy);
> -}
> -
>  static struct cpufreq_driver scmi_cpufreq_driver = {
>  	.name	= "scmi",
>  	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> -		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +		  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify	= cpufreq_generic_frequency_table_verify,
>  	.attr	= cpufreq_generic_attr,
>  	.target_index	= scmi_cpufreq_set_target,
> @@ -211,7 +202,6 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
>  	.get	= scmi_cpufreq_get_rate,
>  	.init	= scmi_cpufreq_init,
>  	.exit	= scmi_cpufreq_exit,
> -	.ready	= scmi_cpufreq_ready,
>  };
>  
>  static int scmi_cpufreq_probe(struct scmi_device *sdev)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

