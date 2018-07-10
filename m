Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3808C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEA22098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBOmhhjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEA22098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeGJVg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:36:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33710 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbeGJVg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:36:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so2289147pgv.0;
        Tue, 10 Jul 2018 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LKV21Fl+v2nZYQzvxZIvkHBSN4bgL0UNTBs2GR0iKmU=;
        b=CBOmhhjsGWT6I6FlB3NaIYkT/BpP4aKmyPSpgGfe7sF+AksjCUsGBWh+L47BgROJn6
         bxVi8vQRKx8Vmz6AzMtONNQAA1kgbjlJVFc3N88Vc1SRtiNa/tyiDSLnhRXm7qs2WsgM
         yXiqiwi7Bps/+6ez45367WCJb9hbtfQ6wGVyLx3DQMwFe/BlgBGtT5X6eDMIHkJgpEtG
         a6U+tz0RvXRrmr3a3BQLfQLsjfuZd9UGfjgCEp9eCc7WthNh/WsJSj8yo6/kK602xuEm
         xOYsLfci6N6qcLdjR57tSHl71/GvVTv6yiuPMFu7hsTr3dqgjN60eEGmQlawVzSpQcnr
         e+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LKV21Fl+v2nZYQzvxZIvkHBSN4bgL0UNTBs2GR0iKmU=;
        b=G6ZXctQ2hq93vQTTqlsNbIhPFhlSxGZJyAidVnAwl5lP+JDQL66/lNS261azSgrGjQ
         WymbnB6msbJ9eJTEDhW6VTLCNcUpS9Sr8rgWsKp/a6U9BSUrMLm2oLsymp1jYOYEUK5+
         xveHCfXNNKux1RqQVcEyvnp3CaEJn4/1FoYcXlxRXLtcX0++zYb+no5z18pLN+C1khT6
         4G5a28H+Le2t6UyH+ffNuRpGgO2azBeI3StPx14mGZlB5RvC3KNr9g1ZN2PDdZSMZXct
         wTQQHYZpNDh0YDQs+6ePQZ8cYhKRBl1Bu+0PBnDPmvZeVAPJ/yDSSUfjs2J51qXYphz9
         SA4g==
X-Gm-Message-State: APt69E1otRJzOCXwA002EQMwPeSsRDoOMiEg1tNi/33lCJgnNbt3z/4y
        Rrvr3VW5jQ/llavqo+pkcRM=
X-Google-Smtp-Source: AAOMgpcvptbRk50+0e8W/DeU5OTY2vMxRDB/9FWSZGedUrSklD+9HYLzHgRYFwwYQNvMKUEjDmw67w==
X-Received: by 2002:a62:129a:: with SMTP id 26-v6mr27450041pfs.102.1531258559612;
        Tue, 10 Jul 2018 14:35:59 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d11-v6sm28927544pfo.135.2018.07.10.14.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 14:35:58 -0700 (PDT)
Date:   Tue, 10 Jul 2018 14:35:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     wim@linux-watchdog.org, ray.jui@broadcom.com,
        vladimir.olovyannikov@broadcom.com, vikram.prakash@broadcom.com,
        scott.branden@broadcom.com, sudeep.holla@arm.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
Message-ID: <20180710213557.GC27827@roeck-us.net>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:14:39PM +0530, Srinath Mannam wrote:
> When using ACPI node, binding clock devices are
> not available as device tree, So clock-frequency
> property given in _DSD object of ACPI device is
> used to calculate Watchdog rate.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>

I am ok with the patch itself. All that is missing now is a
reference to the _DSD property documentation. Is that published
somewhere or is it all wild-wild-west ?

Thanks,
Guenter

> ---
>  drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 9849db0..a896b1c 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -11,6 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/device.h>
>  #include <linux/resource.h>
>  #include <linux/amba/bus.h>
> @@ -22,6 +23,7 @@
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -65,6 +67,7 @@ struct sp805_wdt {
>  	spinlock_t			lock;
>  	void __iomem			*base;
>  	struct clk			*clk;
> +	u64				rate;
>  	struct amba_device		*adev;
>  	unsigned int			load_val;
>  };
> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>  	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>  	u64 load, rate;
>  
> -	rate = clk_get_rate(wdt->clk);
> +	rate = wdt->rate;
>  
>  	/*
>  	 * sp805 runs counter with given value twice, after the end of first
> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>  static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>  {
>  	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> -	u64 load, rate;
> -
> -	rate = clk_get_rate(wdt->clk);
> +	u64 load;
>  
>  	spin_lock(&wdt->lock);
>  	load = readl_relaxed(wdt->base + WDTVALUE);
> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>  		load += wdt->load_val + 1;
>  	spin_unlock(&wdt->lock);
>  
> -	return div_u64(load, rate);
> +	return div_u64(load, wdt->rate);
>  }
>  
>  static int
> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (IS_ERR(wdt->base))
>  		return PTR_ERR(wdt->base);
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
>  	}
>  
>  	wdt->adev = adev;
> -- 
> 2.7.4
> 
