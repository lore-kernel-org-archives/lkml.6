Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C72C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4FC2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGXut0Lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4FC2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeI1HhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:37:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42971 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeI1HhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:37:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id b11-v6so4522414wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 18:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ql+uz9UBZ5a9CnjJSPXp7ea3dKb8x2qU8+2IBmkCGoU=;
        b=LGXut0LbLkCeOcwjXjYWEnU+2/p1I/5ur+9olqVfld8E220ry2muoEOIQuYzzLaMwW
         plugbY2IHhglewCflZe7fj22vB8NPM/uEynquf51Q2PYGqgoBx7FqCFmJLAl68Bwkzq6
         496inUEfKV7hecA8JSP592LDRXvuey2Q3CN9LMOE2BV/qoFamdO2WK/MFY1In4MMqNy+
         ezFAswvDeZaE3QGYj8QMhliM4rMR2HhTbhQksplYhURNEamEqsFZlOBn0z2SCd6NOMvK
         X9i5kp6e18MlJatYUWh6cuqYBMVCfw4+KSASkFkFx+nFqu5YTwj1fLylfkqMU+FfH0eL
         9hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ql+uz9UBZ5a9CnjJSPXp7ea3dKb8x2qU8+2IBmkCGoU=;
        b=CWs9ymJ2BjgJnl6adiNTdtZfUWGOJt0ib2536V5ORoFO+zNH8Gv7pm5cSH8JptFi5y
         gWQ1mEqN8vGisQnb1yMBTQpvojWUW71rPx14dCSCDo4DyD1cDuxgnjClfdHoZJZckPgt
         pTI6AoamPh06ls7v7nOURsQb7lb0W/9O1d4bvJFTbbPRcHbgcBHPigCZIIyls58b1mcz
         99eBQ1E1dKPx+1Rb8nIzlG1PGvVZeBGqy+u1PHhSh9rtJYDrNkVJZd+/8Ngq6edwkHFI
         saWcNPR2GZbIOWc7aqLSvdI/8gF3G3u0GLBNFQ3lnwKMOw1D2psYbNvN8fKfS8vEL8t3
         O5Tw==
X-Gm-Message-State: ABuFfojsl6P9v1GoOUrX4eyDpTLI28ZJ0cW0Bern0NXrWduMnk55N95p
        41x/6uz5MhVCr8eFf0kbWHuXIbBjO7SFqQ==
X-Google-Smtp-Source: ACcGV62BIOyPSiyMGrP8J7fwt8sl5TyTkzDiagR9F4s8llRHQ+7ikclMsGzeSMs0V9NHHjyIF/pgMg==
X-Received: by 2002:a5d:42ca:: with SMTP id t10-v6mr7425898wrr.104.1538097376580;
        Thu, 27 Sep 2018 18:16:16 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id i125-v6sm654679wmd.23.2018.09.27.18.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:16:15 -0700 (PDT)
Date:   Thu, 27 Sep 2018 18:16:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] mfd: cros_ec: Avoid unneeded internal declaration warning
Message-ID: <20180928011614.GA3681@flashbox>
References: <20180927033316.9784-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927033316.9784-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:33:17PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/mfd/cros_ec_dev.c:509:40: warning: variable 'cros_ec_id' is not
> needed and will not be emitted [-Wunneeded-internal-declaration]
> static const struct platform_device_id cros_ec_id[] = {
>                                        ^
> 1 warning generated.
> 
> Avoid this warning by adding it to the cros_ec_dev_driver definition
> under the id_table member like all other platform drivers.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> I looked at several drivers with platform_device_id defintions and I
> didn't really find any where the definition wasn't then added to the
> platform_driver so I'm not sure if this was just missed in commit
> afbf8ec7c4f9 ("platform/chrome: cros_ec_dev - Add a platform
> device ID table") or if it was an intentional omission. I'm not super
> familiar with the inner workings of platform devices.
> 
> Should this commit be undesirable, the warning can be silenced with the
> __used attribute but this seemed like a more proper first commit.
> 
>  drivers/mfd/cros_ec_dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 999dac752bcc..8f9d6964173e 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -546,6 +546,7 @@ static struct platform_driver cros_ec_dev_driver = {
>  		.name = DRV_NAME,
>  		.pm = &cros_ec_dev_pm_ops,
>  	},
> +	.id_table = cros_ec_id,
>  	.probe = ec_device_probe,
>  	.remove = ec_device_remove,
>  	.shutdown = ec_device_shutdown,
> -- 
> 2.19.0
> 

It just occurred to me I probably should have added some of the Chromium
guys who have modified this driver to this patch. I've done that now.

Nathan
