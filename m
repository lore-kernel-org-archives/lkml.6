Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943E3ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3497221479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ1fNQDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3497221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeINWka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:40:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39638 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeINWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:40:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id i190-v6so4708846pgc.6;
        Fri, 14 Sep 2018 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R6fNdbvgNvj5Zo6+NK1QCr7s2ibYi26EIoCWy6SNLFI=;
        b=UQ1fNQDcXmnUBmbyg8a77Ym4WaEqnnopYmIsYp/9RLUwGR7CPisJxSwbI/nXZ1PVi0
         APoi/MfpMYhxksnbygKMRpP2O+JQPvkoOaebzS+pNrhCoA8b8rTQdKaC9aBS0ypz8x++
         Vw1i5lAt7g4ptWzp3HGPmlWTIVtPNNavmuOqJYuJgzkKLBEG24aBLBqyVtPUeeZUiWXP
         EAl6AizngDTYWzmPMbDJ/ThWi2KUbkF3vo7lWIzvB5kLZ/4gLZGrMQ6Qdi6Vb7J9dWlT
         9RdOsz/Ee718jTzF9oSY3ht6iAuylOjuqvHYrxug4mhU6nJEFnuTrcX9VxmHRVWUg/0K
         0nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R6fNdbvgNvj5Zo6+NK1QCr7s2ibYi26EIoCWy6SNLFI=;
        b=aZ1+JbOEfLwdYu5iHenKLlyLKP+Yp9MG1rX1S1lkpjJA+FJaGgNWcoBOCU4GCC2kSy
         mQpAuFXjjOtRPnnI/mi2TfZZ87jVlR7VK+pNb59UQz+SxMcbjuHGTTqwCstsLCVuDBGl
         HP4Ka3xT+cSqRTOZ6y2UzHCvUG2scTstT8T0KNdg/XP6FKx/4i8YGY6+E8dCzorAwL2R
         IEVThLmzAi0PmG1cfHNQjaUt729UJh+HFBerEYCr0+6y8C9zdasnlvgkA82PiFVXi3Vl
         Al+hnuFnztET1u+QjoeIYKGx4q7y0UbxxdW1D+dSFmekKRoQI7Csx45RZBUa3iiw1s4/
         76Ng==
X-Gm-Message-State: APzg51BkeV+QsOPTuIwfzOJBbjvOv0kZsWjRTWPGfCfU1IlTqkauze0N
        fdWIgnVHakclmCaNTqb+oBw=
X-Google-Smtp-Source: ANB0Vda1em5ExvDE3gQhwqZ9ooXBeRYG/Iw3ut3d0iVKQ3zLMwY5YyYbEcgF7Tkasd5PacePNav/7Q==
X-Received: by 2002:a65:49cc:: with SMTP id t12-v6mr12730649pgs.27.1536945903315;
        Fri, 14 Sep 2018 10:25:03 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c1-v6sm9494991pfi.142.2018.09.14.10.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 10:25:02 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:25:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog: mpc8xxx: use dev_xxxx() instead of
 pr_xxxx()
Message-ID: <20180914172501.GE26861@roeck-us.net>
References: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 01:31:59PM +0000, Christophe Leroy wrote:
> mpc8xxx watchdog driver is a platform device drivers, it is
> therefore possible to use dev_xxx() messaging rather than pr_xxx()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mpc8xxx_wdt.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index aca2d6323f8a..1dcf5f10cdd9 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -17,8 +17,6 @@
>   * option) any later version.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/fs.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -137,26 +135,27 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  	struct mpc8xxx_wdt_ddata *ddata;
>  	u32 freq = fsl_get_sys_freq();
>  	bool enabled;
> +	struct device *dev = &ofdev->dev;
>  
> -	wdt_type = of_device_get_match_data(&ofdev->dev);
> +	wdt_type = of_device_get_match_data(dev);
>  	if (!wdt_type)
>  		return -EINVAL;
>  
>  	if (!freq || freq == -1)
>  		return -EINVAL;
>  
> -	ddata = devm_kzalloc(&ofdev->dev, sizeof(*ddata), GFP_KERNEL);
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> -	ddata->base = devm_ioremap_resource(&ofdev->dev, res);
> +	ddata->base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(ddata->base))
>  		return PTR_ERR(ddata->base);
>  
>  	enabled = in_be32(&ddata->base->swcrr) & SWCRR_SWEN;
>  	if (!enabled && wdt_type->hw_enabled) {
> -		pr_info("could not be enabled in software\n");
> +		dev_info(dev, "could not be enabled in software\n");
>  		return -ENODEV;
>  	}
>  
> @@ -166,7 +165,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  	ddata->wdd.ops = &mpc8xxx_wdt_ops,
>  
>  	ddata->wdd.timeout = WATCHDOG_TIMEOUT;
> -	watchdog_init_timeout(&ddata->wdd, timeout, &ofdev->dev);
> +	watchdog_init_timeout(&ddata->wdd, timeout, dev);
>  
>  	watchdog_set_nowayout(&ddata->wdd, nowayout);
>  
> @@ -189,12 +188,13 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  
>  	ret = watchdog_register_device(&ddata->wdd);
>  	if (ret) {
> -		pr_err("cannot register watchdog device (err=%d)\n", ret);
> +		dev_err(dev, "cannot register watchdog device (err=%d)\n", ret);
>  		return ret;
>  	}
>  
> -	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d sec\n",
> -		reset ? "reset" : "interrupt", ddata->wdd.timeout);
> +	dev_info(dev,
> +		 "WDT driver for MPC8xxx initialized. mode:%s timeout=%d sec\n",
> +		 reset ? "reset" : "interrupt", ddata->wdd.timeout);
>  
>  	platform_set_drvdata(ofdev, ddata);
>  	return 0;
> @@ -204,8 +204,8 @@ static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
>  {
>  	struct mpc8xxx_wdt_ddata *ddata = platform_get_drvdata(ofdev);
>  
> -	pr_crit("Watchdog removed, expect the %s soon!\n",
> -		reset ? "reset" : "machine check exception");
> +	dev_crit(&ofdev->dev, "Watchdog removed, expect the %s soon!\n",
> +		 reset ? "reset" : "machine check exception");
>  	watchdog_unregister_device(&ddata->wdd);
>  
>  	return 0;
> -- 
> 2.13.3
> 
