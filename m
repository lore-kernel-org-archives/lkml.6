Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB609C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FA320881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="To047cwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfA1IhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:37:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38290 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfA1IhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:37:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so12920982wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k1lcqYBnFAgxOzBCUuFKwVUkEDF/OrdjAUhRMXm0UH0=;
        b=To047cwBW40bx/zOhcj3gnlH+6vyHNeuNlIRzIvwR1Z/OVgTLgPinSwLdd/UdMLhUK
         WJ3D6O+1+R6WczuPc6afEhOYe+R4q9cXq5OpfIcVUOazqh3Eh5OG1p9vR+AAAnKkKQEH
         7/5qJSakePYQqLubgQjdP1ZxBOVLru8d/BRPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k1lcqYBnFAgxOzBCUuFKwVUkEDF/OrdjAUhRMXm0UH0=;
        b=JqWosSGUaf9LsCe31OqwOb1vU/fclqOVADIqJ3obxulgvdfJug8m5amh+KPmqxibkA
         Waz5sDWatxWGvWlgHaGb60U9UwzKrLOepPaqUsb2Dx+mJk9mX5+IpEtICAnRj8/+9xwF
         nbb57NZssfm/NIUX+zwhbl84Zjp+OwsNWAPPHanwETgFE1O2hpzZgkvKICc9GTEiMrK1
         m9FCM+6wRfPfjc8Q+XQq8S+nMoIu/47Biwv7duivGz8xdnduloYRNyta4AXhLAwurw42
         m4x84xdED1pon7FYsphmrvvHvrehqtIG1uyN6bUZvK69UZ0ngHcfFRRbZYujsWlgI/NS
         Qm6g==
X-Gm-Message-State: AJcUuke7mQDw4UYZlH0QQZ+XVTIAUdEqxFII+2UVeW23ebbK9+VvRfon
        QKP7iceJHbzsFzCCkFe6Qx5uAw==
X-Google-Smtp-Source: ALg8bN4Vbk7pPwU1IMMktW5ZQjFTG00iGYek+PrEtyQwsgHmQSFc9nO5Q4b6NQmlpguGAmHoHTVM5w==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr16554013wma.85.1548664620978;
        Mon, 28 Jan 2019 00:37:00 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
        by smtp.googlemail.com with ESMTPSA id a12sm125686093wro.18.2019.01.28.00.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:37:00 -0800 (PST)
Subject: Re: [PATCH v4 6/9] cpufreq: mediatek: Use auto-registration of
 thermal cooling device
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <f4d658bcbc428f6fb9bd70bcd9c7a0b00a20cd08.1548654899.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <11c4bde4-a113-6588-be6a-0904be1974d5@linaro.org>
Date:   Mon, 28 Jan 2019 09:36:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f4d658bcbc428f6fb9bd70bcd9c7a0b00a20cd08.1548654899.git.amit.kucheria@linaro.org>
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
>  drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index eb8920d39818..9a937f4c63e7 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -14,7 +14,6 @@
>  
>  #include <linux/clk.h>
>  #include <linux/cpu.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
>  #include <linux/module.h>
> @@ -48,7 +47,6 @@ struct mtk_cpu_dvfs_info {
>  	struct regulator *sram_reg;
>  	struct clk *cpu_clk;
>  	struct clk *inter_clk;
> -	struct thermal_cooling_device *cdev;
>  	struct list_head list_head;
>  	int intermediate_voltage;
>  	bool need_voltage_tracking;
> @@ -307,13 +305,6 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  #define DYNAMIC_POWER "dynamic-power-coefficient"
>  
> -static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	struct mtk_cpu_dvfs_info *info = policy->driver_data;
> -
> -	info->cdev = of_cpufreq_cooling_register(policy);
> -}
> -
>  static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  {
>  	struct device *cpu_dev;
> @@ -472,7 +463,6 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(info->cdev);
>  	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
>  
>  	return 0;
> @@ -480,13 +470,13 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>  
>  static struct cpufreq_driver mtk_cpufreq_driver = {
>  	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> -		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> +		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = mtk_cpufreq_set_target,
>  	.get = cpufreq_generic_get,
>  	.init = mtk_cpufreq_init,
>  	.exit = mtk_cpufreq_exit,
> -	.ready = mtk_cpufreq_ready,
>  	.name = "mtk-cpufreq",
>  	.attr = cpufreq_generic_attr,
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

