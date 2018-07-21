Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AE2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538E920856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 14:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9LNjedB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538E920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeGUPbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:31:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34161 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeGUPbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:31:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so9147097pgv.1;
        Sat, 21 Jul 2018 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1G8wvxE5WaH2HmUeK6gSneIJTTPuFfg+m0WFqDpnAvw=;
        b=O9LNjedB7hU4yJt6UOMGUzW9KNXfvsgzitOZ01GCD4mxXzwOtSUs/HywjgK2LZwKu5
         UFQIsK3d31vebRIuE1NibWNu0SIsVl6wFn6S82DuJsAlZ29W3MUCBQSA0d9APCQjNhe2
         i9zyZNiPdaA1iLJVwBUvqSLC9uhbYWWl5SnWOZBnkgMkXuoyuUK2bAvP7UVpVOUCHWip
         82paoYM2lHhjrdSGYmWD45tF6WILHLyOFQY63EmKRGTLDzwgCeEy+blrWE17jtYcWKpq
         nugJWAJY5bAJn4xa226wvmRhcDRYuo6GI/zrGOuIrgW4JIGstBY39tpL+FX2MsHtgvgE
         o+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1G8wvxE5WaH2HmUeK6gSneIJTTPuFfg+m0WFqDpnAvw=;
        b=AbYaPSu/uzJ8rI8cBeGr/MaMKYk6Aeb42mQs/QYEExRcZC0rt5+SFPa/TqqQYN6QZo
         u0M7M6ZDOg/h1/EeoOkX53Bh5seHFFRd19gOcRpdxpmSLFV40WZTOfPRZq4g/Bj7Wdju
         NO06mwyh93+FkWZQZLwTqkM7l4ZYYF5mXRbvCTTCBN6hhYyOFT2WJ+uIUJTdkACKVojA
         ODs8No8owzzkPFBDkcN9ijwis1FUoRhpTdcKGkGPvRsJgWbqCzjDrjxmnjmJXQeDh+O2
         Ba1fa7VFpcATGO2q8QWdDAWPM8CV4hfAPPebDMkvI8AjAl25ygBC6mPlifLKK/s2gkrY
         NR9g==
X-Gm-Message-State: AOUpUlErmv1viNWxFj3i8ZziY9IquFy8aOMCQnwIyJSdvFwjW5I16H0y
        GvpNvTfssJoxmQiJMUrrxNXUU+HF
X-Google-Smtp-Source: AAOMgpdzwQN26vCnjBw0/JSDWGXV4iQeL1Bg99AeyZ5pM88TBZJAXt7xQy7n9OTGK/2Z6wa68WoysQ==
X-Received: by 2002:a62:6eca:: with SMTP id j193-v6mr6337534pfc.256.1532183894441;
        Sat, 21 Jul 2018 07:38:14 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z90-v6sm8796102pfk.85.2018.07.21.07.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 07:38:13 -0700 (PDT)
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        wim@linux-watchdog.org
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        sudeep.holla@arm.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <efe2211a-932d-fff8-ff82-2cda2e3a61ee@roeck-us.net>
Date:   Sat, 21 Jul 2018 07:38:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 01:44 AM, Srinath Mannam wrote:
> When using ACPI node, binding clock devices are
> not available as device tree, So clock-frequency
> property given in _DSD object of ACPI device is
> used to calculate Watchdog rate.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>

Please resend as non-RFC and add a note in the description indicating
that there is no formal review process for _DSD properties.

Thanks,
Guenter

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

