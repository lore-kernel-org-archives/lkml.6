Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA82DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573A720852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTLiiJLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573A720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeGINpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:45:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43852 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754508AbeGINpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:45:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so13716724pfm.10;
        Mon, 09 Jul 2018 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zbpS9o1JPvpRAmHQXbbxbmUag7fIyBcvY6/yNsiQwRw=;
        b=eTLiiJLhUojWV5TkwdYQIdIah3TMpYHYjULmT1vHCbA+nPT8nEyf00rTC62m6U/xtw
         z80i7pIdGr3w7q/6udu+dEBKd8TVWLAB51+kVama2swMGDOCxLjIRYbGdsyMXjBWCg1E
         i/EBS0yE7SAR7J/i1npH9pSYaPkpSSi6nu0ly5eO4RUHyh+Sp+yCOQ9nLmmCQa7u5T4b
         Omn/WqA38G1xB+ZIWp3Yep31Km0KiCd8oFWBp1NTW1eVRSvulVt6ipD5KdXHF/yuTKfQ
         b4bLotzMxpPPO5W5V78tDbh7gEdAb15Z/McD8bdaUhQ1jGSBZyYhUKdyypygiqu/LZ+v
         uCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zbpS9o1JPvpRAmHQXbbxbmUag7fIyBcvY6/yNsiQwRw=;
        b=Gk8KGuqj+2YZgKU7otSoRTncnJ//2P76am1F/Ega7WF4mzP8nTyJiIHpLI+JiXCvC3
         Gt+ZY3bQ2JVZyY1DI91i15g9tR5QXlsY/OxS7F/UrGf0+GTFZaAoXDp10B+b3rY1vDe7
         zxAXIUMbjzsSDhGvA50LcG+ZtvjY69aoVWq7xGz0c+JbvQFboww7CLXTO3koUvfaB96U
         k986VqTojpysJI3hVZxLWdTknyte7cgBugNlh5ap8B/XRJ1dT/Cn47+zEAGbqEXWCvKy
         LrucqoF2b5Dorxq3kfN4yDhsDwPJqKQN4Pd4nPg8WhJ7wy/qkLwxBWSDrzSEUSswYMxt
         PeAg==
X-Gm-Message-State: APt69E2UIQ/WVs4VXfeZzUvwHvnus9bt8oegCyu06UbRI1UHAinXJmwG
        abJ3a/ZlQLYw8oas1CsjG1hczw==
X-Google-Smtp-Source: AAOMgpc9KWlSp5ZcpGKPv+TukQOK+ZHmejbQYPayoexOYtBdAohaKMpiptbi8GJ4F+nTAKjTptBi0A==
X-Received: by 2002:a65:57c9:: with SMTP id q9-v6mr19261774pgr.128.1531143911943;
        Mon, 09 Jul 2018 06:45:11 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d17-v6sm21370846pgp.50.2018.07.09.06.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 06:45:10 -0700 (PDT)
Subject: Re: [RFC PATCH v2] watchdog: sp805: Add clock-frequency property
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        wim@linux-watchdog.org
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        sudeep.holla@arm.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1531131569-13727-1-git-send-email-srinath.mannam@broadcom.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <055f7c8a-c3c9-af3a-d762-a26329270e4d@roeck-us.net>
Date:   Mon, 9 Jul 2018 06:45:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531131569-13727-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 03:19 AM, Srinath Mannam wrote:
> When using ACPI node, binding clock devices are
> not available as device tree, So clock-frequency
> property given in _DSD object of ACPI device is
> used to calculate Watchdog rate.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>   drivers/watchdog/sp805_wdt.c | 34 ++++++++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 9849db0..ad5ed64 100644
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
> @@ -228,10 +229,27 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   	if (IS_ERR(wdt->base))
>   		return PTR_ERR(wdt->base);
>   
> -	wdt->clk = devm_clk_get(&adev->dev, NULL);
> -	if (IS_ERR(wdt->clk)) {
> +	if (adev->dev.of_node) {
> +		wdt->clk = devm_clk_get(&adev->dev, NULL);
> +		if (IS_ERR(wdt->clk)) {
> +			ret = PTR_ERR(wdt->clk);
> +			wdt->clk = NULL;

Clearing wdt->clk is useless.

> +		} else
> +			wdt->rate = clk_get_rate(wdt->clk);

The else branch should be in { } as well per coding style.

> +	} else if (has_acpi_companion(&adev->dev)) {
> +		/*
> +		 * When Driver probe with ACPI device, clock devices
> +		 * are not available, so watchdog rate get from
> +		 * clock-frequency property given in _DSD object.
> +		 */
> +		device_property_read_u64(&adev->dev, "clock-frequency",
> +				&wdt->rate);

Continuation line alignment is off.

Still not documented. Maybe that is common for ACPI devices nowadays.
If so, I'll need at least a pointer to a document or something declaring
that ACPI devices do not use well documented properties, and a confirmation
that using such properties is acceptable in the Linux kernel.

> +		if (!wdt->rate)
> +			ret = -ENODEV;
> +	}
> +
> +	if (ret) {
>   		dev_warn(&adev->dev, "Clock not found\n");
> -		ret = PTR_ERR(wdt->clk);
>   		goto err;
>   	}

Please move the error handling to where the error occurs. While doing that,
please change the message to dev_err() - this is an error, not a warning -
and change the second error message to match the error (it did not find
the property).

Also, return directly - the goto just generates another error message
which is ridiculous.

Thanks,
Guenter
