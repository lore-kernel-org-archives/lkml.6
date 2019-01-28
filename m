Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13438C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51F220881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDg/7oUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfA1Ikn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:40:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34733 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfA1Ikm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:40:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so9832261wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SdSKv6edgZBVQ7WdEt1pcKrXPGSSgiq6CrZoSJ1FdME=;
        b=BDg/7oUgcbal0s32SJD5LAtc7/I6ZSXId8xCadLINpGSKHphRvhBCj81kUYEqXqogN
         HZaHfvVHlOyl4LDT1eIAAdXAw9F0+sXHTCenFep07Jj+jqvgCWbPKSqlE/+Go9dw1h1Z
         BnLNToG9q10+9kMTKIR6t6hJNHF5AelgjL/ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SdSKv6edgZBVQ7WdEt1pcKrXPGSSgiq6CrZoSJ1FdME=;
        b=rx7QfTdN+CLBTr8M6S/HgeMEnoZ3tm0LTgMcRp/tl0hXsrRcMua2XTihRL79y4uFTj
         No1Mb9b59he6cUsEWRyKfrJmyCRtzUu9vP8S/EKeib0M47k1Shnt1a2HeIqQ6fIV/XGm
         7jnuw8XZGxNpdIhRoDomq0n2CTZnvJkjMfQ0ddTcWZND8ZXz/xfedQevrbON+Wj09nga
         Tq4gV9m+hAwDs92GP+kHmFNhr9je/hbZNPpL35FjSbWrPsjxCdVvcIXK4kQUBeHirBcj
         u8qTXiEZfpkX5vTlRcnLx1lXxL33DMF1JUNgBSpl8SvwQofE7MkWYTZs1hLVi3aiuiN9
         VIkQ==
X-Gm-Message-State: AJcUukedm9gz+JyOkXd8VGo6YPs6p8MgHwzznTllQKkk1vRRKs3i/LsM
        mSCQ7/7CpzGdwWU4Fyqz6kfkhg==
X-Google-Smtp-Source: ALg8bN51Sx3K8B2gOLwM1NMf68ZErwghiuv5Q5YB0GbQL7uOvcNwGoQyssPDr9P/3HCv5ih5W36qig==
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr15517889wmf.125.1548664840835;
        Mon, 28 Jan 2019 00:40:40 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
        by smtp.googlemail.com with ESMTPSA id k128sm102490157wmd.37.2019.01.28.00.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:40:40 -0800 (PST)
Subject: Re: [PATCH v4 9/9] cpufreq: scpi: Use auto-registration of thermal
 cooling device
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <d8626e4c69e7b33a49c1545a9b97eadc7c2b0c2e.1548654899.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5e1d4915-3c87-ea02-7acf-35b4f1ad3644@linaro.org>
Date:   Mon, 28 Jan 2019 09:40:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d8626e4c69e7b33a49c1545a9b97eadc7c2b0c2e.1548654899.git.amit.kucheria@linaro.org>
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
>  drivers/cpufreq/scpi-cpufreq.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 99449738faa4..82420e8e5f0d 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -22,7 +22,6 @@
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
> @@ -34,7 +33,6 @@
>  struct scpi_data {
>  	struct clk *clk;
>  	struct device *cpu_dev;
> -	struct thermal_cooling_device *cdev;
>  };
>  
>  static struct scpi_ops *scpi_ops;
> @@ -186,7 +184,6 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct scpi_data *priv = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(priv->cdev);
>  	clk_put(priv->clk);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	kfree(priv);
> @@ -195,23 +192,16 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static void scpi_cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	struct scpi_data *priv = policy->driver_data;
> -
> -	priv->cdev = of_cpufreq_cooling_register(policy);
> -}
> -
>  static struct cpufreq_driver scpi_cpufreq_driver = {
>  	.name	= "scpi-cpufreq",
>  	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> -		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +		  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify	= cpufreq_generic_frequency_table_verify,
>  	.attr	= cpufreq_generic_attr,
>  	.get	= scpi_cpufreq_get_rate,
>  	.init	= scpi_cpufreq_init,
>  	.exit	= scpi_cpufreq_exit,
> -	.ready	= scpi_cpufreq_ready,
>  	.target_index	= scpi_cpufreq_set_target,
>  };
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

