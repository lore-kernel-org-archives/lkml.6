Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F511C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFD320881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D20g2JoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfA1Ie7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:34:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39998 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfA1Ie7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:34:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so16983511wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vECWysAQwMTzD/v7QsHss+btOnUKdafIfBPM3+i2WAU=;
        b=D20g2JoLJVUhI1kqjVHnjTo4xklEyoSELd0hsk2lGNA6k6aJ9ELikUlE4g5SL1LHl7
         pcnkaLymn2jawV/DsYXh/GJwutNW+sZ7HCi1lqoPsxkibyWy3+GrhpvFKNhWc2RkmQhG
         DDzF1YXzK0h7I2Lvoga6/lgXDQ8P3AeNlMbAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vECWysAQwMTzD/v7QsHss+btOnUKdafIfBPM3+i2WAU=;
        b=Or5mBTnI1FWdYF6Z9oa/n4K5avvcnfiVE0QB60TvzTjZT5iVMmhMnSKD4hDb+oqNIF
         ZY4vV/IHWno5eskNfPFjnr/SeHJOIkdjTHupg8cnM5ulalfr7+amrAkoRsA0eFX4h587
         8d7pjOX4DP60fHoUqZ7lwMzGJlowCKJmOOi343mI+Wlg6d8O0YSXTIH21eSUpgdwe7xD
         Bvc47fueKIK60943NqWNc/nrT3wW+gykZ126PDYn6Bs01ls2SDDcAuOrRi1zcXMvvFN+
         px65YJp81OjxJID+t/Usab7i92iRoPFhGAz80+w2Grx2azeGNxBsRBCsvs1bDAJ3xKMR
         yJQw==
X-Gm-Message-State: AJcUukeox+A/6o4lZ9AczvYYjQ4qoZlwtc1Rr0YyOV3lkDhvSPtST0hP
        Td756IViVz5BspNUaemHVsEBmw==
X-Google-Smtp-Source: ALg8bN4bdFO11SE2yAOTNKV2WNhd4ZpGkOigQ5kr8cSOLnMcW8NKYqdkRC5agBjsy6jk+FS3dali2w==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr20359262wrr.155.1548664496833;
        Mon, 28 Jan 2019 00:34:56 -0800 (PST)
Received: from [192.168.0.41] (20.36.129.77.rev.sfr.net. [77.129.36.20])
        by smtp.googlemail.com with ESMTPSA id a1sm97375419wrw.76.2019.01.28.00.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 00:34:56 -0800 (PST)
Subject: Re: [PATCH v4 4/9] cpufreq: imx6q: Use auto-registration of thermal
 cooling device
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Bastian Stender <bst@pengutronix.de>, linux-pm@vger.kernel.org
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <6e8ab1213d82b6de5294c0f579a24150aafaf558.1548654899.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b9a74679-eaf9-626e-f6c5-1112351275b0@linaro.org>
Date:   Mon, 28 Jan 2019 09:34:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6e8ab1213d82b6de5294c0f579a24150aafaf558.1548654899.git.amit.kucheria@linaro.org>
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
>  drivers/cpufreq/imx6q-cpufreq.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 9fedf627e000..9935df234fa1 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -9,7 +9,6 @@
>  #include <linux/clk.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> @@ -52,7 +51,6 @@ static struct clk_bulk_data clks[] = {
>  };
>  
>  static struct device *cpu_dev;
> -static struct thermal_cooling_device *cdev;
>  static bool free_opp;
>  static struct cpufreq_frequency_table *freq_table;
>  static unsigned int max_freq;
> @@ -193,16 +191,6 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	return 0;
>  }
>  
> -static void imx6q_cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	cdev = of_cpufreq_cooling_register(policy);
> -
> -	if (!cdev)
> -		dev_err(cpu_dev,
> -			"running cpufreq without cooling device: %ld\n",
> -			PTR_ERR(cdev));
> -}
> -
>  static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	int ret;
> @@ -214,22 +202,14 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> -static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
> -{
> -	cpufreq_cooling_unregister(cdev);
> -
> -	return 0;
> -}
> -
>  static struct cpufreq_driver imx6q_cpufreq_driver = {
> -	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = imx6q_set_target,
>  	.get = cpufreq_generic_get,
>  	.init = imx6q_cpufreq_init,
> -	.exit = imx6q_cpufreq_exit,
>  	.name = "imx6q-cpufreq",
> -	.ready = imx6q_cpufreq_ready,
>  	.attr = cpufreq_generic_attr,
>  	.suspend = cpufreq_generic_suspend,
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

