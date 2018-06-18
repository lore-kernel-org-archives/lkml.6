Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61A8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C33A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdGRU8KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C33A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbeFREzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:55:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35558 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbeFREzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:55:53 -0400
Received: by mail-pf0-f196.google.com with SMTP id c22-v6so7546879pfi.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 21:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6u3yZ7Cj65X3U+9M/ZE5PBwvfXMC0mKj3RvEBT81vY=;
        b=WdGRU8KFFON+1wRNcKETxhzLtEp3pnZSwgmYqNcPr3cti05EvddYqhEJiifJN0opmM
         sDE2Aeuu9HWq6j4WoT5W1qho6FolEP7vqoFvmnpEN4gevKAQ4IQrSeHbGYigwwL/aB7w
         2xXrh6mdBakMoioc5qBPMNS2E7Ys2V+ilaHfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6u3yZ7Cj65X3U+9M/ZE5PBwvfXMC0mKj3RvEBT81vY=;
        b=HMtSPSJXAzX9GncwDaR/1F0XBge25Aw6akyC9w96uS2HV511vtVqFo7wqVywmZeWQ8
         8CNakgLIuboV+Es/9OGSSOLN7cVhXSmPgQsE81SZKGEqI87wXnsHdDD6hrm9D5xaPD8p
         dFdWmbnM/mw2C/NNyXfKY9CprG2qgA4z8/9WHL1qgxC6prs8b7pvcJGtPZ8r/GLpoI6n
         MLrXguCgL+eS4amgi5s1hGQvsqQ2JUB4PZUi0BQCceGTggf2jtsoXEEGsRwwr8SnvOU1
         hpuHglLhVwTWzOx4fgsUB8Pr4aWbcw9Ifblo/Z/7gCjh434A45kVVz2bEJlft7dAsuv9
         l2KA==
X-Gm-Message-State: APt69E1m1YsCp2CidhqGY8iQl6c6JLY9Ej4zw/tVCTSv6IoUivpvpTjy
        Y+vfhPQCedBC7zh5kZsGDnxQIA==
X-Google-Smtp-Source: ADUXVKJn0opfeVmSN+DyMwRrjo9SuCMbjdiqpb+4FmN1nvlt58+TwM7PNFgZgdp8T5q3swoiYIWGMw==
X-Received: by 2002:aa7:8510:: with SMTP id v16-v6mr11930426pfn.77.1529297752853;
        Sun, 17 Jun 2018 21:55:52 -0700 (PDT)
Received: from localhost ([122.172.130.27])
        by smtp.gmail.com with ESMTPSA id h124-v6sm30896325pfc.100.2018.06.17.21.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 21:55:52 -0700 (PDT)
Date:   Mon, 18 Jun 2018 10:25:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ilia.lin@gmail.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: kryo: Add module remove and exit
Message-ID: <20180618045550.sasilydvnlsmxzpk@vireshk-i7>
References: <20180614204212.2028-1-ilia.lin@gmail.com>
 <20180617200146.16425-1-ilia.lin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617200146.16425-1-ilia.lin@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-06-18, 22:01, ilia.lin@gmail.com wrote:
> From: Ilia Lin <ilia.lin@gmail.com>
> 
> Add device remove and module exit code to make the driver
> functioning as a loadable module.
> 
> Fixes: ac28927659be (cpufreq: kryo: allow building as a loadable module)
> Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 74b9b93d511b..01bddacf5c3b 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -42,6 +42,8 @@ enum _msm8996_version {
>  	NUM_OF_MSM8996_VERSIONS,
>  };
>  
> +struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
> +
>  static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
>  {
>  	size_t len;
> @@ -74,7 +76,6 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
>  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
>  	struct opp_table *opp_tables[NR_CPUS] = {0};
> -	struct platform_device *cpufreq_dt_pdev;
>  	enum _msm8996_version msm8996_version;
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
> @@ -165,8 +166,15 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
> +{
> +	platform_device_unregister(cpufreq_dt_pdev);
> +	return 0;
> +}
> +
>  static struct platform_driver qcom_cpufreq_kryo_driver = {
>  	.probe = qcom_cpufreq_kryo_probe,
> +	.remove = qcom_cpufreq_kryo_remove,
>  	.driver = {
>  		.name = "qcom-cpufreq-kryo",
>  	},
> @@ -201,8 +209,9 @@ static int __init qcom_cpufreq_kryo_init(void)
>  	if (unlikely(ret < 0))
>  		return ret;
>  
> -	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
> -		"qcom-cpufreq-kryo", -1, NULL, 0));
> +	kryo_cpufreq_pdev = platform_device_register_simple(
> +		"qcom-cpufreq-kryo", -1, NULL, 0);
> +	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
>  	if (0 == ret)
>  		return 0;
>  
> @@ -211,5 +220,12 @@ static int __init qcom_cpufreq_kryo_init(void)
>  }
>  module_init(qcom_cpufreq_kryo_init);
>  
> +static void __init qcom_cpufreq_kryo_exit(void)
> +{
> +	platform_device_unregister(kryo_cpufreq_pdev);
> +	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
> +}
> +module_exit(qcom_cpufreq_kryo_exit);
> +
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
>  MODULE_LICENSE("GPL v2");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
