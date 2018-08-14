Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884FFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423D52089E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9ykRKIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423D52089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732858AbeHNQTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:19:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42858 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:19:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so9245963pff.9;
        Tue, 14 Aug 2018 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2q2jDX5igTZvGZO8aFchwJLGD6xO1ItJ/FhL/49e5E=;
        b=D9ykRKIigwM6nB0EbhftppJLlgVXTs2M81ubPCAgsm90kCYbDbuYVedR0eKR5uGdM/
         cxNyeZ3hxWu0Bz5ecTi51YwdTJwtkkUw1VzHm8B3pxjMH3wQV2iqOP/W6dixvZPUR+WL
         llQRNMnZuZJW8ZrmDLKwqHcEA9Rc91GLOyAdh7uXkr85is47CmeMHm71bJAiGkD7PpFc
         fj8gan3OwqooCpe1ta3WE1zV1lkG/ubaq7hs/TUzAeeAW0db0En9ygZh/Z/86wsWrdoa
         P0CYTLLxnllh29BwoTnOR83vE/YIeCthhTNwqdaZVmg8i7I+Rob7Y/c/tX1Mr7jSSPXQ
         SULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2q2jDX5igTZvGZO8aFchwJLGD6xO1ItJ/FhL/49e5E=;
        b=g2zWJissWsfcRL2/dbiCGqHk6zWVPeQKNSXIMBQnd5k6dDglW97PvuRG4zAsFeS+9I
         ojzf1+mu0BKkpZ0gkkPRIn3JWbkp56vYyJ8HgHFwYBajYrnvHobu0lYz92qXHZBgYLB+
         xzaj2AL4ZlKRNDb7K8DyI5lQhkpqN7Si54PcFI3nJ4kXdPEu776W2zJxEle4j3UUHMvu
         dWwI/UkQTIfN1veiDrfMfADyAx482cMYAuISlKgkEmzzl1nF11CikYh35UkDfLYYE4Kx
         GYva+M2FIEUSM3QOvEXN7xn4zO/vF8z+aQDCo+BzgdJw+78MbRjWYZDOM3ttxcyfZg9N
         Wm9A==
X-Gm-Message-State: AOUpUlGdCSkHY3Sl2flKLtPg0tuTjWX97Hgj8WD0Jw/BTdp8NgAt6ygk
        IkFgZenui8KlwrUKDxJo2UHpGleI
X-Google-Smtp-Source: AA+uWPxh8lPRFgRk2w/nvpDw+WOPspIuMFy39ilM6czo5EIpsRWG16AghMiJApUdpCBP7eoZQlI+Yg==
X-Received: by 2002:a65:62d8:: with SMTP id m24-v6mr21396421pgv.307.1534253524868;
        Tue, 14 Aug 2018 06:32:04 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u11-v6sm35711065pgj.71.2018.08.14.06.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 06:32:04 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] watchdog: hpwdt: Update version number.
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-6-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <39fe61eb-52b1-7234-8b02-ecf41f1efdbe@roeck-us.net>
Date:   Tue, 14 Aug 2018 06:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-6-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> Bump version number to reflect recent bug fixes.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index eb947bc..7af358b 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -26,7 +26,7 @@
>   #include <linux/watchdog.h>
>   #include <asm/nmi.h>
>   
> -#define HPWDT_VERSION			"2.0.0"
> +#define HPWDT_VERSION			"2.0.1"
>   #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
>   #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
>   #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
> 

