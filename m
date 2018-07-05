Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119B2C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC195240FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0fCPbny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC195240FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeGEP2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:28:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44400 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGEP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:28:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id j3-v6so5727647pfh.11;
        Thu, 05 Jul 2018 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sdgs/l3XKAOtbYzN81w+hM57m4MurP5elLAO95Wh3hk=;
        b=m0fCPbnyjzU8a+xplC0S29+PbL/I/DBU7fs9KUwkJgGqz3rcqVq3LaSLGwvIxJS8yw
         ZfF/hgVJtiY+0XwFEAop68zg8UdYH1wLHpm/o97sGnHuk87+Gf7mrVI4yX09azKriroO
         bsYy+LJ3G5nytMhGK2XH3TkuCtNZunv25Uy2/M/w+jw0lKgHWWpd3nLzwla0vCN9lj5H
         1JauqUN3i2xq/uVFave0As4qObFnrFWm9bNALUegnj3klN4/pD3G5R73ctmuLE2G8CG7
         QZxyF5Qp2Trts+iUUWTNDkrzKs/SR4LDUIDu+rB/LbKVagxOxN8mI200j2GCS0jeyMUB
         Nxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sdgs/l3XKAOtbYzN81w+hM57m4MurP5elLAO95Wh3hk=;
        b=DqVP+Jff92n0pPKSSP6OqboRkhBUtIDhD7hdG06zrZSiWCeXPM26RLNq5q4r9yLpjk
         wnkB7V9/rFDEVaLqqq+adRwWcnNCxhgbqOvzn70EFicOqso4yFMNYsodrdq3R3GoWWJE
         RSRzKDSDZcjcwnyPeBXSsROl1JFktPcvy4N9x1g3X34iv7p79uoF/o9XdlIIVK+gshmC
         vK3qfEpFvzisFTAvrfpxEN4DswRyJlb9iBEmcNDhP62Ik8KuHoZJ8bpsnGLVUKJtlCX0
         kgPQ7u9T/HNHDV9N7lYX1ke3c0x2iBsybIs71RV8VNENljvdztxZAqW8NuqwCT9FQgv/
         8/Zw==
X-Gm-Message-State: APt69E0CniyHI4jftxw0pOuK+F5tOc7F9tE/DAxfZYaP7g4OfZqePPoo
        stLL0xLwI2k4OibtsUe5pi6P2g==
X-Google-Smtp-Source: AAOMgpd62RtnP2jvjAFS2ejQgGqhk47N9kcNgFE83OD+rqwSlNy0HLlM+ihVAlrbAkj5go8rhduQlA==
X-Received: by 2002:a62:1d97:: with SMTP id d145-v6mr7013699pfd.101.1530804492049;
        Thu, 05 Jul 2018 08:28:12 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u2-v6sm8671649pfn.59.2018.07.05.08.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 08:28:10 -0700 (PDT)
Subject: Re: [RFC PATCH] watchdog: sp805: Add clock-frequency property
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        wim@linux-watchdog.org
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        sudeep.holla@arm.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1530760968-13104-1-git-send-email-srinath.mannam@broadcom.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f29c486a-2ac8-55e7-86ed-90e3cf71bcea@roeck-us.net>
Date:   Thu, 5 Jul 2018 08:28:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530760968-13104-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 08:22 PM, Srinath Mannam wrote:
> When using ACPI node, binding clock devices are
> not available as device tree, So clock-frequency
> property given in _DSD object of ACPI device is
> used to calculate Watchdog rate.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>   drivers/watchdog/sp805_wdt.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 9849db0..d830dbc 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -22,6 +22,7 @@
>   #include <linux/math64.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> +#include <linux/of.h>
>   #include <linux/pm.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> @@ -65,6 +66,7 @@ struct sp805_wdt {
>   	spinlock_t			lock;
>   	void __iomem			*base;
>   	struct clk			*clk;
> +	u64				rate;
>   	struct amba_device		*adev;
>   	unsigned int			load_val;
>   };
> @@ -80,7 +82,10 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>   	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>   	u64 load, rate;
>   
> -	rate = clk_get_rate(wdt->clk);
> +	if (wdt->rate)
> +		rate = wdt->rate;
> +	else
> +		rate = clk_get_rate(wdt->clk);

No. Get the rate once during probe and store it in wdt->rate.

>   
>   	/*
>   	 * sp805 runs counter with given value twice, after the end of first
> @@ -108,7 +113,10 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>   	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>   	u64 load, rate;
>   
> -	rate = clk_get_rate(wdt->clk);
> +	if (wdt->rate)
> +		rate = wdt->rate;
> +	else
> +		rate = clk_get_rate(wdt->clk);

Same here.

>   
>   	spin_lock(&wdt->lock);
>   	load = readl_relaxed(wdt->base + WDTVALUE);
> @@ -230,11 +238,22 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   
>   	wdt->clk = devm_clk_get(&adev->dev, NULL);
>   	if (IS_ERR(wdt->clk)) {
> -		dev_warn(&adev->dev, "Clock not found\n");
> -		ret = PTR_ERR(wdt->clk);
> -		goto err;
> +		dev_warn(&adev->dev, "Clock device not found\n");

"Clock _device_" ? Why this change ? And why retain that warning unconditionally ?

> +		wdt->clk = NULL;
> +		/*
> +		 * When Driver probe with ACPI device, clock devices
> +		 * are not available, so watchdog rate get from
> +		 * clock-frequency property given in _DSD object.
> +		 */
> +		device_property_read_u64(&adev->dev, "clock-frequency",
> +					 &wdt->rate);
> +		if (!wdt->rate) {
> +			ret = -ENODEV;

This unconditionally overrides the original error.

> +			goto err;
> +		}
>   	}
>   
> +

No whitespace changes, please.

Does that mean that ACPI doesn't support the clock subsystem and that each driver
supporting ACPI must do this ? That would be messy. Also, the above does not check
if the device was probed through ACPI. It just tries to find an undocumented
"clock-frequency" property which is quite different and would apply to
(probably mis-configured) devicetree files as well.

Either case, I would rather have this addressed through the clock subsystem.
Otherwise, someone with subject knowledge will have to confirm that this is the
appropriate solution. If so, the new property will have to be documented as an
alternative to clock specifiers and accepted by devicetree maintainers.

Guenter

>   	wdt->adev = adev;
>   	wdt->wdd.info = &wdt_info;
>   	wdt->wdd.ops = &wdt_ops;
> 

