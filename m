Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E252CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A750206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyVmsij7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A750206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeINSvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:51:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36319 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeINSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:51:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so4338882pfo.3;
        Fri, 14 Sep 2018 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YUlKWKvUP55wiDo2wPb9ZZSzdJXneXdtyM8E2LuyUfM=;
        b=SyVmsij7k+pxgELGieyvXoPfadYjvq23MwkCzUvYs5Jyu2/VMXUZJRnxxxsyellUVO
         R/rvabVMCK4+gfydLYWBxA6NId/c307YtnpIWs2KsEEkmzUrnMoTMCvLdoVnKN0QEpLq
         53lfi4yjz/8z2K6+bSL7cDfpx0AWMyOEXNe9lZ8O8n7PynbMaxfykw5nPurQVgUnzJVX
         vGfKH3N1CZkl6+mPXwm7uRk0OJAW0bKehySoMwhW/fevtqy9up/uDukBKGyrrGxEonTt
         1bCWToaACS7CVjEJTX4SxOK9CH/2ZXQcAZJkAXQkWe70dXjFAfJhacYO9cF94Niv+xVL
         aRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YUlKWKvUP55wiDo2wPb9ZZSzdJXneXdtyM8E2LuyUfM=;
        b=aWA6C45N3WnRPJbnplo1gcXY4FcA3/zqCT/iTbOy9WaaIICbwYABFln2at2J7XuWYx
         tSTxwLhrBmIdgHL+ZXgSOltu0O4Ezeabd5bPJEVJ9gFgOPs3NjDeUDOd/MMtM4R6//g7
         nzC9Oxjkncm5rPKGFYpg2dqkYJBPVYmej3kyhjgP1iL43NBajD4U76X9fENRNN1z9cYI
         qIQdSzkqBPf3BOwBwhEU2YIlUMM38Au/6a2ZGE9MasgBD3iFT6S0daM4NXpVN6NRnp8M
         aG8XmeGEn3bJWRg9I9tIO9QFGRGhLm3PzKpjTdYP3eozQOyrWUtmRtTBVjUUGuJI/AGz
         wKpw==
X-Gm-Message-State: APzg51ASQsKWXfRMQPDeb2g1a0dD+cpTQp9c2ByLSmYW8UQNCwUbIklG
        np6k0nAU2X+SWpxUzly9ouX8owC+
X-Google-Smtp-Source: ANB0Vdbql8eE1ume6goocQFfZZXmyAhegWI/OC+zuPIEHUj7w7r0gChWvaLTiCjdIeyT7iidP9ntcA==
X-Received: by 2002:a62:3241:: with SMTP id y62-v6mr12721320pfy.4.1536932226665;
        Fri, 14 Sep 2018 06:37:06 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k8-v6sm20886207pga.80.2018.09.14.06.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:37:06 -0700 (PDT)
Subject: Re: [PATCH 1/2] watchdog: sama5d4: fix timeout-sec usage
To:     Romain Izard <romain.izard.pro@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-2-romain.izard.pro@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0953b2f9-83b1-b57b-2a26-fa0527c8a548@roeck-us.net>
Date:   Fri, 14 Sep 2018 06:37:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914101339.7382-2-romain.izard.pro@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 03:13 AM, Romain Izard wrote:
> When using watchdog_init_timeout to update the default timeout value,
> an error means that there is no "timeout-sec" in the relevant device
> tree node.
> 
> This should not prevent binding of the driver to the device.
> 
> Fixes: 976932e40036 ("watchdog: sama5d4: make use of timeout-secs provided in devicetree")
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sama5d4_wdt.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 255169916dbb..1e93c1b0e3cf 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -247,11 +247,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	ret = watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "unable to set timeout value\n");
> -		return ret;
> -	}
> +	watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
>   
>   	timeout = WDT_SEC2TICKS(wdd->timeout);
>   
> 

