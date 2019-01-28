Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC3C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059F020881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2G/UtDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA1Ihx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:37:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55234 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfA1Ihw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:37:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so12967129wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SO5+bXuAqPyJH922wYcVV3iI/pHeR6WqGnn2Q+wNYMI=;
        b=b2G/UtDhDLURhsdW/SLzkLP9DH9j+mUmD0iYx/FKTSMm/twiCLZcKx/UQ7knz0KMhq
         oHE2a7db2lgXrVpbeDxwksgsPsMd5+a+qP34sSMqDFUD7GgK4nu9XZumI3Vm9BAAOY5R
         IeAB3AzGUFiDE/JD/Umwqjp1T6ikpfCvV+Awc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SO5+bXuAqPyJH922wYcVV3iI/pHeR6WqGnn2Q+wNYMI=;
        b=ImES4mKvr1f0x6MXgT2g6bYaSJdxKz1uOwhmhfPvR7Xkt3N/uJJl7z03OVD1vw7wtK
         I7Zr33UOQg5XxcOPPOwx8DklNS1e1j1TWgAjSBG0m6tJkhkS3ylYyQr6P7fH0hyXOVHb
         JTWzDkRlWPluU59jEBNkxnDRcSQDLJJn7ephdfEoSctbaXSFHX2ea6HPp0CsHN9BRAv6
         jqVgsMvHRCcWIeHNUuUM0or91X5qQ2LsfQg4by2kWU1pBgfw00w5B4CvvlKcjuqBdNO/
         WvBSyLqgl8jNi8juoKQNv0md/kPMvXx17Ix5/8zjukjaZ+HWaArU4Dqa0i5bU3zvp4O1
         4SQQ==
X-Gm-Message-State: AJcUukdIJvWXBhlaEGWqWfoccEG3cfiu73mUdRCQyPjdi/qHetvAC7jZ
        lNqlyGFmI95/N0+9IabfHR77o5PD6kQ=
X-Google-Smtp-Source: ALg8bN4f9nSYB3LoUSxUea6LRCY72niwr/FgRhes3NErOwOdt3CqkLrM0J1m07TNeyzPuvIU8od5Xg==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr16682140wmj.0.1548664670509;
        Mon, 28 Jan 2019 00:37:50 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
        by smtp.googlemail.com with ESMTPSA id w10sm8399019wmb.1.2019.01.28.00.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:37:49 -0800 (PST)
Subject: Re: [PATCH v4 7/9] cpufreq: qoriq: Use auto-registration of thermal
 cooling device
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linux-pm@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <f33f279a20f9125ffbec96bfbf1aa9153baebab8.1548654899.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1b5ecceb-f7b4-903b-4158-394618fab8d3@linaro.org>
Date:   Mon, 28 Jan 2019 09:37:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f33f279a20f9125ffbec96bfbf1aa9153baebab8.1548654899.git.amit.kucheria@linaro.org>
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

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 3d773f64b4df..b206e6cb55f0 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -13,7 +13,6 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/cpufreq.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -31,7 +30,6 @@
>  struct cpu_data {
>  	struct clk **pclk;
>  	struct cpufreq_frequency_table *table;
> -	struct thermal_cooling_device *cdev;
>  };
>  
>  /*
> @@ -239,7 +237,6 @@ static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cpu_data *data = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(data->cdev);
>  	kfree(data->pclk);
>  	kfree(data->table);
>  	kfree(data);
> @@ -258,23 +255,15 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
>  	return clk_set_parent(policy->clk, parent);
>  }
>  
> -
> -static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	struct cpu_data *cpud = policy->driver_data;
> -
> -	cpud->cdev = of_cpufreq_cooling_register(policy);
> -}
> -
>  static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.name		= "qoriq_cpufreq",
> -	.flags		= CPUFREQ_CONST_LOOPS,
> +	.flags		= CPUFREQ_CONST_LOOPS |
> +			  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.init		= qoriq_cpufreq_cpu_init,
>  	.exit		= qoriq_cpufreq_cpu_exit,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qoriq_cpufreq_target,
>  	.get		= cpufreq_generic_get,
> -	.ready		= qoriq_cpufreq_ready,
>  	.attr		= cpufreq_generic_attr,
>  };
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

