Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D1DC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CFD20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIGiBero"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CFD20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeK3KsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:48:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33045 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3KsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:48:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so1828932pfb.0;
        Thu, 29 Nov 2018 15:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rRpFjgOd86ffvjOaKtc7YCesyTzDcQmkoH65E5+aykk=;
        b=aIGiBeroO+P7c87dlnc+Rbu4gCE8AXOdDrgsY1iWYZQLygTBv5h/7hbs2/AmGKq8k0
         HKjOnr+H+oWGc0wX/XM0iE0sAQQweDV0Ds6e8is0NvewCbsFIxFW8u9rUqxJRYTFrQ39
         cEwovp7fwwWIwWcYfMfJHWSVgvi0FZsN+W6zOahPhmy8D8Q+FCDnZOBRZ6GWzz09jAK2
         kxhadbHqAzL4CHcrO4z+roS64BOAx41kaeB+7rWbyLRlDSR6jya2mkAVzz0lgRRxNCO3
         mT7gDKwT0525sR+7LkkbiE4SMiCbLsRvAApN1E29VNfA3u7ZXxgdfGvfVwWZKJQsbw7u
         VJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rRpFjgOd86ffvjOaKtc7YCesyTzDcQmkoH65E5+aykk=;
        b=D1YMRdlGZV+aBGny9wwta4wt4N5gD6tBHWwacC4dpFrfydPgzRFsFqhMWD/ato6+S2
         4pNFg7YArYYaVL/dT5gxbd1YnY1nZUCDwIMTfZPmKwFXXCR6Fa1UHFC4g10fD3o65TWo
         6mjvbBRlxMPq4jG3GhYnFn9P16pU9dwZ4I6lSUwhZTA8ttNGv5VewZjk7jqcmYiv9cVD
         /70CMYDGVpXql+56rS8EWQwPtxrMOcHIupsJ7Q8uyTvtgV3/jFKpK/fHdzB+Ii+DROo2
         5nLypkY9A2VwFyMrbdN1oRjiRU9EbauByz6Y1i/ymhKv89k2lCK3b4yUQQPp1Ts5o4Ca
         KpMQ==
X-Gm-Message-State: AA+aEWbC1qlPkVvk8ksaX0rB2FVqr2qQ8UQ+dhnPPnTWrvfgG1rfBMcM
        Vu7rnGYfVwUIR+lfEQSiFbQ=
X-Google-Smtp-Source: AFSGD/VOJ5Xwl0CKyWBxAceoLXtX643qkX3YkMGwD+HVAhpQcSWnzaX8JbH3wV/0BIc/wWPR1ft6eA==
X-Received: by 2002:a62:644:: with SMTP id 65mr3391492pfg.161.1543534849279;
        Thu, 29 Nov 2018 15:40:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1sm3771996pgb.46.2018.11.29.15.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 15:40:48 -0800 (PST)
Date:   Thu, 29 Nov 2018 15:40:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: asm9260_wdt: make array mode_name static,
 shrinks object size
Message-ID: <20181129234046.GA19718@roeck-us.net>
References: <20181129232500.5039-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129232500.5039-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:25:00PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const array mode_name on the stack but instead
> make it static. Makes the object code smaller by 41 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    7699	   1872	      0	   9571	   2563	drivers/watchdog/asm9260_wdt.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    7594	   1936	      0	   9530	   253a	drivers/watchdog/asm9260_wdt.o
> 
> (gcc version 8.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/asm9260_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
> index 2cf56b459d84..9768e44ffeb8 100644
> --- a/drivers/watchdog/asm9260_wdt.c
> +++ b/drivers/watchdog/asm9260_wdt.c
> @@ -278,7 +278,7 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
>  	struct watchdog_device *wdd;
>  	struct resource *res;
>  	int ret;
> -	const char * const mode_name[] = { "hw", "sw", "debug", };
> +	static const char * const mode_name[] = { "hw", "sw", "debug", };
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(struct asm9260_wdt_priv),
>  			    GFP_KERNEL);
> -- 
> 2.19.1
> 
