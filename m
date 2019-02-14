Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B088EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDD9222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kP60hn1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436990AbfBNJUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:20:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55078 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfBNJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:20:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so5465216wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nMz1ymCsOf65DabRL8W9oE+jLUTE0mcGttneun/Pans=;
        b=kP60hn1CevWUmK2N/c9hFJ2i5MN2eDG1ZPAehe4MbQ5LKCAr1Tg2auA8SMbe1Iglm0
         OvHbsbLxrOB8SAZwc8JDqFSk9WIqSu9x3Sz6M+8D5p0FtMwZM1j/1xKXHwYB+51g/oh+
         VivSSDZJbVgQNrQWOOCtnRQcoCAAVbsyN83eVeABmYA0DP0MXwMppQz9efeCjIlyTxeN
         csnyNUY4fEvhMPZ+/OTT+8nzxKF+nQP6OuE1LnVdCv0H+g/4kTjO3syf014ADJF+90QE
         yA0514zPzgQ7MndoJgBIEThrObpJlJpgkpwl0A/GxK6P3hpEUD3FQMNrUhhZJmEZZXoa
         eyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nMz1ymCsOf65DabRL8W9oE+jLUTE0mcGttneun/Pans=;
        b=mdF7jRXCkTvbatPpMo3BXIiDoC9JqtnKAZSJm/dRK4aO1RBQCNg9BmanID1vbPZpTl
         1RK8cYpYfGBYmX+a9MXXOU4vAHl5ySEyLgKCg0I0Q3TFj0Y5VBOL3N2rAQxDYGsgvu+6
         +DDV3R0F2sOeH4eUAJNqa9kwDq0e1Xu3VCSxLemHkfVrV7DN0/mZ4AFg55zpLfenAOQ8
         UdQnfc5FC+1/TZIVcbX7hBf61m4Z/pzDxo07eQn1DxUs59ziXbtRAWkQfwK++b34ODy7
         sCCM7QJ9KYsjKC1yzzIZnr1XKs4WftcsRoX1RRolmGjZkGrh4UK49Psrf9pJSE7LqNJE
         jdHA==
X-Gm-Message-State: AHQUAub3Emj5VCwkbKwMs6svoZkbbnaIHCGW7MFQACQ625rXYT/cC8ii
        lnISxlecCYsxZIfvO6IWOKxWJg==
X-Google-Smtp-Source: AHgI3Iauy0DFL2xJFV8jX/SZgQJHfgRFOewe7ge2fOIeU9erGRO2fGYvsusag7w8ePMUvML+QhU3/w==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr1885612wme.115.1550136047705;
        Thu, 14 Feb 2019 01:20:47 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
        by smtp.gmail.com with ESMTPSA id s5sm1815649wmh.37.2019.02.14.01.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:20:47 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:20:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Florian Vaussard <florian.vaussard@epfl.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mfd: twl6040: Fix device init errors for ACCCTL register
Message-ID: <20190214092045.GD13737@dell>
References: <20190211225726.38355-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211225726.38355-1-tony@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Tony Lindgren wrote:

> I noticed that we can get a -EREMOTEIO errors on at least omap4 duovero:
> 
> twl6040 0-004b: Failed to write 2d = 19: -121
> 
> And then any following register access will produce errors.
> 
> There 2d offset above is register ACCCTL that gets written on twl6040
> powerup. With error checking added to the related regcache_sync() call,
> the -EREMOTEIO error is reproducable on twl6040 powerup at least
> duovero.
> 
> To fix the error, we need to wait until twl6040 is accessible after the
> powerup. Based on tests on omap4 duovero, we need to wait over 8ms after
> powerup before register write will complete without failures. Let's also
> make sure we warn about possible errors too.
> 
> Note that we have twl6040_patch[] reg_sequence with the ACCCTL register
> configuration and regcache_sync() will write the new value to ACCCTL.
> 
> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl6040.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -322,8 +322,19 @@ int twl6040_power(struct twl6040 *twl6040, int on)
>  			}
>  		}
>  
> +		/*
> +		 * Register access can produce errors after power-up unless we
> +		 * wait at least 8ms based on measurements on duovero.
> +		 */
> +		usleep_range(10000, 12000);
> +
>  		/* Sync with the HW */
> -		regcache_sync(twl6040->regmap);
> +		ret = regcache_sync(twl6040->regmap);
> +		if (ret) {
> +			dev_err(twl6040->dev, "%s register write failed: %i\n",
> +				__func__, ret);

Please drop the __func__ and just use the standard format.

Wouldn't something a little more forthcoming be better?

"Failed to sync with the HW" ?

> +			goto out;
> +		}
>  
>  		/* Default PLL configuration after power up */
>  		twl6040->pll = TWL6040_SYSCLK_SEL_LPPLL;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
