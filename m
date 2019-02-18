Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE28C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFABB20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF9bG9HN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbfBRQIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:08:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47015 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfBRQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:08:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so8659773pgp.13;
        Mon, 18 Feb 2019 08:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ym4aVNV4+Bh3UkUva4Br9bSSCixwDn+0xNcam5VhODI=;
        b=aF9bG9HNZ4VF1Z4Q/puKyufeKIv6T7qNVVBK52BXPyjKx2xVcHZ6Ov1w1Pm6Yq+z/E
         yxjtV6U38TtOQ6NaSyzPy6UGXTrJUtlF2x0v6v9NJE5MmNseHgicq9K5MgWKBWGpqrMS
         vRETciYVw+KHNXzEszSCv4h+oMkgK+Ke82Op9ed3XBGuVmi2jxL0cfOOioQZCZAOb7Mr
         iU7Q9QrWFppBaAd2n3mcao/gyEwNlH/8AF2IikvSV3JT2ESH7+X54qTMGUl9wBgf99+e
         TWrUo4Qy/mjp0yZn16xm+KxiWkvAoE11mEVh1Qi89KHqbeZbho9JaKMEbUCBImYL/oSZ
         3GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ym4aVNV4+Bh3UkUva4Br9bSSCixwDn+0xNcam5VhODI=;
        b=No1QX2HGeUeA5+ajP6KqXWyTXsj+MEk2/MfAfZ2QTrHwcK2/Z+t4/3e8IjUV5ejqan
         IkPQEriHBEc2SW4Tie9RinJOXESf5JIGXD2aVJxM0l2xCfmELkZCvyyN0ZtpHThK9wWa
         yJKG+GrnhQBFzgGb+U72MbLJWh4BFLIvoAapvIG6HTfFGk0HXif5CZkPC4Abi4scVtpV
         TsYwBUXOl8saMM37y2gMH31JqEkNfEIHKSI4Hu00Lyqk2VhlilZNE8Vxx9LrzPVnKFkY
         WdMOEySVwJPKEIToQenmkfI6p9ixPo6UHz5mzcclVjPArBV0a0/1yIr2XCai+PDVr6aS
         G0mg==
X-Gm-Message-State: AHQUAua8gIYk2ZJhDk+ZyyADdPZzzyb1sPlbNWtrHEHze9l19aMQ+cMN
        5s6x+2Nos8UCQ0iDsthUOe4=
X-Google-Smtp-Source: AHgI3Ia49c8kcU7G7FUSyPcAbmzpYI3uKuhVZsS9kw7UAlZ+z7uzsa6OUyRyW/6hLSrLC3cwfcXJGQ==
X-Received: by 2002:a63:3fc8:: with SMTP id m191mr23507115pga.240.1550506092893;
        Mon, 18 Feb 2019 08:08:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t5sm23169100pfb.60.2019.02.18.08.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:08:12 -0800 (PST)
Subject: Re: [PATCH] watchdog: smsc37b787_wdt: Mark expected switch
 fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190214201601.GA13098@embeddedor>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b914131b-fd1d-2a99-4903-856e2808034d@roeck-us.net>
Date:   Mon, 18 Feb 2019 08:08:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214201601.GA13098@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 12:16 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/watchdog/smsc37b787_wdt.c: In function ‘wb_smsc_wdt_ioctl’:
> drivers/watchdog/smsc37b787_wdt.c:480:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     wb_smsc_wdt_set_timeout(timeout);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/watchdog/smsc37b787_wdt.c:482:2: note: here
>    case WDIOC_GETTIMEOUT:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/smsc37b787_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/smsc37b787_wdt.c b/drivers/watchdog/smsc37b787_wdt.c
> index 445ea1ad1fa9..c768dcd53034 100644
> --- a/drivers/watchdog/smsc37b787_wdt.c
> +++ b/drivers/watchdog/smsc37b787_wdt.c
> @@ -478,7 +478,7 @@ static long wb_smsc_wdt_ioctl(struct file *file,
>   			return -EINVAL;
>   		timeout = new_timeout;
>   		wb_smsc_wdt_set_timeout(timeout);
> -		/* fall through and return the new timeout... */
> +		/* fall through - and return the new timeout... */
>   	case WDIOC_GETTIMEOUT:
>   		new_timeout = timeout;
>   		if (unit == UNIT_MINUTE)
> 

