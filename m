Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4905EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1605F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUQLRnwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfAQOsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:48:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33504 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfAQOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:48:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so11363306wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 06:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7e3Hc3JsHtEigHMcPcgMXjhVFHPtnc6gQZOtrESjsiQ=;
        b=IUQLRnwE9JYG7n8hBTfVapn0BEp5+urK6cGXOc2S/gPrj9RPS856ZLfTOFW5IOjdDf
         N5zdl55HlnShOLFAxNd5L4YTeRtPWBweQoAENVXJpxWYcD12vykxpK1v3mCS6JOM8ISR
         dt/cicnZUjM569Jx95cjs0Tb8Pcl05fpSTPWsvUJjXO4B5Z2nCcAr8mxbWKSf4/ymXft
         9tsePF46pYC/pAeEnEQs84zP3JfPK5UcgAZbRNi7/8JrWX7zJNZEMQmzTmAXLzD6C/CF
         v8FCVR+05+ifZ3eOpWumc6k2nNYGpg60gyc89+3dzUVCKWqvOeQ5dqBpX6ZG/bYmmMMY
         fJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7e3Hc3JsHtEigHMcPcgMXjhVFHPtnc6gQZOtrESjsiQ=;
        b=Vd4kAqS0S8qu6hjHCODvoCn+xMWp//oKfdYb6JGjJZdPrVsaZ1BXRDEGaLgUkxvu2a
         nhudcevZ7Gev4mgtCP/zXJjVbBuvZ3U4TXhCw+ZxjYrUbaQecjwYHgSG73eFOTgEYTct
         KLRAMtlM6CtCjxyERzqo9JquzVl5+xjmI7SnVz1PCYQ4wJNuhW/2eldFOYqOOgKF+TyC
         gwztyiWXPLsPKfeBZ+saFuPgbK76PA7YjtIozq+Ib4qN/cxv73azoZke6otNDrh3RqZ2
         6ssBYQLW9SLRaY52XAheWNX6jLFiG6guno9YblM6Xn7yoOE2hHYiIqPM/HdWucnWbE0l
         B81A==
X-Gm-Message-State: AJcUukeam67LvtyMGn1f4U/w9qOyp4jkNHCA9/taNmnOLQ0EUTykoln5
        q8TghkXbTv88MitYZ+wVcWc=
X-Google-Smtp-Source: ALg8bN56zBJuFhGfeoLAnU/WX3LV5ITzmIITweeHtTZk0zRaK4bWWSbiHZvDv76OAn9B6YcpsWvymw==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr12530433wrc.168.1547736493002;
        Thu, 17 Jan 2019 06:48:13 -0800 (PST)
Received: from [192.168.1.221] ([195.245.38.234])
        by smtp.gmail.com with ESMTPSA id d2sm70555202wrs.97.2019.01.17.06.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 06:48:12 -0800 (PST)
Subject: Re: [PATCH] arch/arm/mach-ep93xx: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>, lukma@denx.de,
        hsweeten@visionengravers.com, linux@armlinux.org.uk,
        Arnd Bergmann <arnd@arndb.de>
Cc:     jrdr.linux@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
References: <20190117143751.GA3462@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <12f44672-ff9a-20cd-0f4c-44cf1c18bb5b@gmail.com>
Date:   Thu, 17 Jan 2019 15:47:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190117143751.GA3462@hp-pavilion-15-notebook-pc-brajeswar>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2019 15:37, Brajeswar Ghosh wrote:
> Remove mach/gpio-ep93xx.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Arnd, would you take it into one of your ARM trees?

> ---
>  arch/arm/mach-ep93xx/ts72xx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index c6a533699b00..85b74ac943f0 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -26,7 +26,6 @@
>  #include <mach/gpio-ep93xx.h>
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> -#include <mach/gpio-ep93xx.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
