Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C3C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1722085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="idrwkyPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1722085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeKFA1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:27:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51710 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbeKFA1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:27:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id w7-v6so8688350wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y/02XrycPs554AGD+omIrqDk+d5kh24rPmt72xB31Z4=;
        b=idrwkyPzuQDOPXIrdD0nrhyeCOEOoPhDK8sSm4e8NfPHIhvmHe3j+McbOsQ/BXOySF
         E3Kmv2WhBcODXyuk4O3dwUORt4eJjcMx90tQbtgPGiJoBefip5ErF6fN59SyBAuX2qNk
         3kSKUNlTyzi2MNePsumh2ez/xVHdLT66fL+xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/02XrycPs554AGD+omIrqDk+d5kh24rPmt72xB31Z4=;
        b=CGcOFaGi5fMFzcfVNBahoGI1fNZtPzanD2w9+V3v/JCDHqG3+5TxQmNpJ9YcoMUZ6c
         e/vp5/KF3sd9CEJuwJEII3SYdAsxvkFtwAKKb08ojXuYSCnoKaVsWcwF4wEhfg2E5BqH
         AO0lZIpTlXQiKaEx87/unjpMJfnfGAY81h/ySgGk3H/WHF5TIy9O4TqcQ88RaIvJCIDT
         fLs2+uwHMs9enMC6jt9yY0BnmVMKhpiNBEzoWrjThV8SvqERs7za2bXc+ZajuJO3zvJN
         LpqwXgbuLgABhhI2JYDwRPyHRFRnIe4/SArGrXdWIep1vXT/dTI0/27wLwP0ocsuF7lz
         ND1A==
X-Gm-Message-State: AGRZ1gJiLfBshhWsgYSrsqmsYkHdW4ezLfLOlM28AOeOjYQE+88Iaewj
        6yz+BhiU7FqxTo1J9M+z7HuYLg==
X-Google-Smtp-Source: AJdET5c/ar5VLtxIZXhOh0kgu7UnMsaH4dnhuHKVFcNUoA62NY7Hdp/rjhoeOqHIdX4jU7SQSH+Gow==
X-Received: by 2002:a1c:3288:: with SMTP id y130-v6mr6498311wmy.11.1541430441952;
        Mon, 05 Nov 2018 07:07:21 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id 137-v6sm8117890wmo.43.2018.11.05.07.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 07:07:21 -0800 (PST)
Subject: Re: [PATCH 5/5] thermal: zx2967_thermal: simplify getting
 .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-6-wsa+renesas@sang-engineering.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1de46d0b-a241-8ee6-7bf3-eb8ae4c22251@linaro.org>
Date:   Mon, 5 Nov 2018 16:07:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181021200053.2194-6-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2018 22:00, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/thermal/zx2967_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
> index 6acce0bce7c0..145ebf371598 100644
> --- a/drivers/thermal/zx2967_thermal.c
> +++ b/drivers/thermal/zx2967_thermal.c
> @@ -207,8 +207,7 @@ MODULE_DEVICE_TABLE(of, zx2967_thermal_id_table);
>  #ifdef CONFIG_PM_SLEEP
>  static int zx2967_thermal_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct zx2967_thermal_priv *priv = dev_get_drvdata(dev);
>  
>  	if (priv && priv->clk_topcrm)
>  		clk_disable_unprepare(priv->clk_topcrm);
> @@ -221,8 +220,7 @@ static int zx2967_thermal_suspend(struct device *dev)
>  
>  static int zx2967_thermal_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct zx2967_thermal_priv *priv = dev_get_drvdata(dev);
>  	int error;
>  
>  	error = clk_prepare_enable(priv->clk_topcrm);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

