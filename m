Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C4C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96FF223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHdEWPGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96FF223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeHJQHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:07:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39258 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbeHJQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:07:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id a11-v6so4424531pgw.6;
        Fri, 10 Aug 2018 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtxEI4l3KMgN+mKQ13uzMgZlocJDJEpYaCFOClNnnEU=;
        b=fHdEWPGqISYB+gPXIuF9SGHcP6XZfCvxW6OiyCSDIPTEEYcfA3cXNegMFb4KTDw2Ah
         tzS1xpzyO3r4r4Vzjn5qoO9xf7n5zFx5pwrc8h2dAteNPl9f1wJOKAMTUYdFDXUVkedR
         iIAxxfbPRrqXZOQqwvH2GUbTFi76AXiIc3XXc1ojfqx0/aVoBLzziwHHusOnJnC7XNjh
         /KZoYPVTbdV73LrpjWB6Sh8u30ZD1LhlA4QxeREaLJRpXoiPh18HAlBQ2qb1YFi+0WAz
         XS74FSaNCKPMWbBdB33Uoder6Wb1rLbEU0CP4VwivWFLMI7Oj1JKboB7bDAK4f/1zozk
         LJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtxEI4l3KMgN+mKQ13uzMgZlocJDJEpYaCFOClNnnEU=;
        b=FoZQAbrN7xwGo91MP2L1ceHWb00rxe2qY2NO/eSR8lGCFlWYYvE8UM8dyGQ6zp3gEL
         y9IUMR9VO3YAsOoOPqJ/4PVs8+zk1VuVRk90IMAjQD5HngGyqefIAS6mjBfBLdV/X+e0
         rBEW8acNlHQsuPYC124q568QhR2DZkecpzEeEZOrvNhuCKQ/ELanVG4pGtNYcZRYd7l7
         lZPRTGsKYJ1UWDOdfmak7sVMfEv8ZZBSPfe/uI+HajWpkBVgtM+Ne0+DZwu0+XetLFho
         Rsq6Mdj3bOBlPCcmMh+giPWyIqJaMuR+e/VazmYUyqBZ3n9aNCPqkymddYmIZKwoeC73
         IkiQ==
X-Gm-Message-State: AOUpUlEkDK2BdOR/WswNc5SpU2xfVl7+2YnXe5YgEdktLQTrKWZYRZEJ
        CBgAUcpSX6JCd3tTATN/cFI=
X-Google-Smtp-Source: AA+uWPyWlyfhKhrqHdFUIHs4pe24NmmOWzHcj5W9qXr6EyufSqUHZg3wKFgzuezZYM5vzdm4jrVKTA==
X-Received: by 2002:a63:a042:: with SMTP id u2-v6mr6429924pgn.80.1533908257018;
        Fri, 10 Aug 2018 06:37:37 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j15-v6sm12160378pfn.52.2018.08.10.06.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:37:36 -0700 (PDT)
Date:   Fri, 10 Aug 2018 06:37:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 10/24] watchdog: jz4740: Avoid starting watchdog in
 set_timeout
Message-ID: <20180810133735.GC29028@roeck-us.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-11-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-11-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 11:44:00PM +0200, Paul Cercueil wrote:
> Previously the jz4740_wdt_set_timeout() function was starting the timer
> unconditionally, even if it was stopped when that function was entered.
> 
> Now, the timer will be restarted only if it was already running before
> this function is called.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/jz4740_wdt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
>  v6: New patch
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 0f54306aee25..45d9495170e5 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -64,13 +64,15 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  {
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
> +	u32 tcer;
>  
> +	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
>  	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>  
>  	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
>  	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>  
> -	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, tcer & TCU_WDT_TCER_TCEN);
>  
>  	wdt_dev->timeout = new_timeout;
>  	return 0;
> @@ -86,6 +88,7 @@ static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
>  		return ret;
>  
>  	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
>  
>  	return 0;
>  }
> -- 
> 2.11.0
> 
