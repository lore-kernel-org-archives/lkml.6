Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC380C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6705720883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm1iYYuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6705720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeGZF5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:57:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33228 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeGZF5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:57:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so240533plb.0;
        Wed, 25 Jul 2018 21:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DPn+mes8dhdbGxFqa4jrzCn7MTj0YA5kPu/TqygKnCQ=;
        b=Vm1iYYuugYK23sJf9rUgvGexvBL/wysQ/gNFz+DpBzXwLxiufBWQ/8T3VQGBWXdC9Y
         a/cSyokSfdUpP0BwabkcJdcT51wwJ1KLtC6bGWWBt1VNB6IBCs9E3fVXSYYSwvloOVhH
         wTHjpbyxJeKLYN3Q06wuFfFWQTM8sNE+VKe5FYhXX8PnQ5BgisiEwF58Nq2Oxf25lr3K
         FxGB1NgZv4ml2PjJMB7YfpDXuaew1idOAoq1DrO/mBfBVTjZQuVGyr++L26JiIFOGdhO
         Cffl9vFmk9WoqJDfgK5gDuPZxY3rwIVT29k913b6P+AmBTEhT8hebZttjrj49USTDTrn
         Ikfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DPn+mes8dhdbGxFqa4jrzCn7MTj0YA5kPu/TqygKnCQ=;
        b=SJWhbhMYw/W++/xrUiJ6zslJeF0aajz47Ko/IYhWi5+EwCjecLT368MPz3ooJv4+R8
         b+2N7Dhe5ucz88fucm2/PDIAJ6MrTlo1w7cDxga+ZMdBIqSndzvA+vME1Wm/TTOLI53O
         3XNi6tJ7rCyf7xRAshvYpSdft+SrTSILs8t/scSNOsmYGLLrVF8/HGdKU30UnnXHlfkl
         ytr2Y17LXWRk3KqLks5pZaHNNhWcJCtUSrB+j9whpeVOmu5n9nDefix2UvwxkySf4DAe
         UENY6OxF+5/zfZOW26ZaJnUMVa1wzSFvC2MLgSN/ma2k3tnKsg6ovhh5P62ikGG1noOY
         +xIg==
X-Gm-Message-State: AOUpUlHhb4whQTWY9KQVHJ21f6lS3UfZhoJ2jRhUGl7W9aIQ4SPmbQII
        Rh8dfCv1IEFWRCCtaLcK0GY=
X-Google-Smtp-Source: AAOMgpeDqPWpYga9fYCQfA5wq+xCbCy5aEHjmzocc0sMilfDoNZqbRY1dSIvsa/OYzL4H6IP9zk6gQ==
X-Received: by 2002:a17:902:b693:: with SMTP id c19-v6mr486785pls.114.1532580176572;
        Wed, 25 Jul 2018 21:42:56 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i62-v6sm411992pge.66.2018.07.25.21.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 21:42:55 -0700 (PDT)
Subject: Re: [PATCH] watchdog: sp805: Add clock-frequency property
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        wim@linux-watchdog.org
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1532335060-686-1-git-send-email-srinath.mannam@broadcom.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f6095ab0-5916-99c7-09eb-0bfde335bc38@roeck-us.net>
Date:   Wed, 25 Jul 2018 21:42:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532335060-686-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 01:37 AM, Srinath Mannam wrote:
> Use clock-frequency property given in _DSD object
> of ACPI device to calculate Watchdog rate as binding
> clock devices are not available as device tree.
> 
> Note: There is no formal review process for _DSD
> properties
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I just noticed this. This is completely inappropriate. It is
the equivalent of forging a signature on a check.

_Never_ add a Signed-off-by: statement for anyone but yourself.

Guenter

> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>   1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 9849db0..a896b1c 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -11,6 +11,7 @@
>    * warranty of any kind, whether express or implied.
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/device.h>
>   #include <linux/resource.h>
>   #include <linux/amba/bus.h>
> @@ -22,6 +23,7 @@
>   #include <linux/math64.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> +#include <linux/of.h>
>   #include <linux/pm.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> @@ -65,6 +67,7 @@ struct sp805_wdt {
>   	spinlock_t			lock;
>   	void __iomem			*base;
>   	struct clk			*clk;
> +	u64				rate;
>   	struct amba_device		*adev;
>   	unsigned int			load_val;
>   };
> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>   	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>   	u64 load, rate;
>   
> -	rate = clk_get_rate(wdt->clk);
> +	rate = wdt->rate;
>   
>   	/*
>   	 * sp805 runs counter with given value twice, after the end of first
> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>   static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>   {
>   	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> -	u64 load, rate;
> -
> -	rate = clk_get_rate(wdt->clk);
> +	u64 load;
>   
>   	spin_lock(&wdt->lock);
>   	load = readl_relaxed(wdt->base + WDTVALUE);
> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>   		load += wdt->load_val + 1;
>   	spin_unlock(&wdt->lock);
>   
> -	return div_u64(load, rate);
> +	return div_u64(load, wdt->rate);
>   }
>   
>   static int
> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   	if (IS_ERR(wdt->base))
>   		return PTR_ERR(wdt->base);
>   
> -	wdt->clk = devm_clk_get(&adev->dev, NULL);
> -	if (IS_ERR(wdt->clk)) {
> -		dev_warn(&adev->dev, "Clock not found\n");
> -		ret = PTR_ERR(wdt->clk);
> -		goto err;
> +	if (adev->dev.of_node) {
> +		wdt->clk = devm_clk_get(&adev->dev, NULL);
> +		if (IS_ERR(wdt->clk)) {
> +			dev_err(&adev->dev, "Clock not found\n");
> +			return PTR_ERR(wdt->clk);
> +		}
> +		wdt->rate = clk_get_rate(wdt->clk);
> +	} else if (has_acpi_companion(&adev->dev)) {
> +		/*
> +		 * When Driver probe with ACPI device, clock devices
> +		 * are not available, so watchdog rate get from
> +		 * clock-frequency property given in _DSD object.
> +		 */
> +		device_property_read_u64(&adev->dev, "clock-frequency",
> +					 &wdt->rate);
> +		if (!wdt->rate) {
> +			dev_err(&adev->dev, "no clock-frequency property\n");
> +			return -ENODEV;
> +		}
>   	}
>   
>   	wdt->adev = adev;
> 

