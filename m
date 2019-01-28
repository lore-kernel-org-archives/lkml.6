Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1EEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC5420881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8+qsd5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfA1Ifq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:35:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1Ifp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:35:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so17053254wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VkSTnXqzrCMNWST7wMAGuLPTbplmbXYm19BSa7E5KSQ=;
        b=a8+qsd5JDrF9KD0TGir/WgxzdA+0ldUML3QH6W1fZLWT615eYBrrSmDIA1qtXx4TRa
         Mk9poBiNrR0BxBbQ+AmSwp7+7F7qMrCi1AJDZhAPXwRan//YFjwruCtazo7WlCjkWQEf
         eZBcQb0lVGXxhaF2tk6QDsL2nb9AhUdb3HyTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VkSTnXqzrCMNWST7wMAGuLPTbplmbXYm19BSa7E5KSQ=;
        b=GMvBQOwb3LBYnaUGEY8sn2ANjL2F7qGb0qr3WV44G6MmeynDzu6Wi7TrPNNWFYBsBe
         dc53EJ8gZHxbJl2DVp7kc7mCQSig8OrUGy8+deifJ/cF97jce9Q6iVrLwAX2CsJT2btF
         LPK/lFQqrMgVe+Zr76oC5EIJw8gh/ie9tn2ZRp4rVfClcHU/o01aNaguJ4Xshw5JyqA+
         OCpZdU1fGnk2Yefaw+HQsmQfYONcnBStc1jkHD9MhzrMeK+iFAd5QsnQdXXn3tCiYAx4
         og6DN0nfn4Stxx60XOkd/vrUReLwC30B+QBnWhxj9JsJB2eRMgUxsJUbkz8EH22F2uBA
         mefA==
X-Gm-Message-State: AJcUukde4Jb6NyouhpPrlh58QGGBThaILSgR2tc6kw5YcAD8skaAX3IT
        dh7sW3gfng/CTDL2AwWlzalafQ==
X-Google-Smtp-Source: ALg8bN5AzC4FcN1r5NfNLIwowLrcLn9Bj4ZQNfMGO26yZsPyNq7UGxaYi+6aZW6Qw3QFIY1NjcG15Q==
X-Received: by 2002:adf:a28d:: with SMTP id s13mr20024088wra.100.1548664543259;
        Mon, 28 Jan 2019 00:35:43 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
        by smtp.googlemail.com with ESMTPSA id x3sm110660108wrd.19.2019.01.28.00.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:35:42 -0800 (PST)
Subject: Re: [PATCH v4 5/9] cpufreq: cpufreq-dt: Use auto-registration of
 thermal cooling device
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <cb7296e38ec506b008e65ecf5f80ccb356f67fb8.1548654899.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <52fd659d-b5a2-b0dc-b901-9bc33d7d6721@linaro.org>
Date:   Mon, 28 Jan 2019 09:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cb7296e38ec506b008e65ecf5f80ccb356f67fb8.1548654899.git.amit.kucheria@linaro.org>
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
>  drivers/cpufreq/cpufreq-dt.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e58bfcb1169e..2a4c4ea7980b 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -13,7 +13,6 @@
>  
>  #include <linux/clk.h>
>  #include <linux/cpu.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
>  #include <linux/err.h>
> @@ -30,7 +29,6 @@
>  struct private_data {
>  	struct opp_table *opp_table;
>  	struct device *cpu_dev;
> -	struct thermal_cooling_device *cdev;
>  	const char *reg_name;
>  	bool have_static_opps;
>  };
> @@ -301,7 +299,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct private_data *priv = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(priv->cdev);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	if (priv->have_static_opps)
>  		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> @@ -314,21 +311,14 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static void cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	struct private_data *priv = policy->driver_data;
> -
> -	priv->cdev = of_cpufreq_cooling_register(policy);
> -}
> -
>  static struct cpufreq_driver dt_cpufreq_driver = {
> -	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = set_target,
>  	.get = cpufreq_generic_get,
>  	.init = cpufreq_init,
>  	.exit = cpufreq_exit,
> -	.ready = cpufreq_ready,
>  	.name = "cpufreq-dt",
>  	.attr = cpufreq_dt_attr,
>  	.suspend = cpufreq_generic_suspend,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

