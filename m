Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CEBC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE610259E3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="px3LbynD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE610259E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeGBNQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:16:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35837 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbeGBNQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:16:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id a24-v6so3864942pfo.2;
        Mon, 02 Jul 2018 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=odczwiBlE0QFdwF2OJAStRlRWQh4xEUDEVC3dvDIjZk=;
        b=px3LbynD8ylwMkStL816nxwtUcUmrDrVLobmhVWm1lF/6QO8goIVF4g+rF0XSD86qw
         M0YPz8XHMD7q3K1fCXjGLE0s/ZEKgQEeATgzyl+jzMZ83ScKRPkMteTuxqojSrSFiC52
         Kkp5CmaWRqioej2EO+Pa0XTV+2ia28T2wCDhJWpOpq3n+w/z9UhmPgqQrzvpxzxSvg91
         a17siGnIT3ySyS01JpMXrcvM6B4IxPw1wnjSsjX3HvXmvCGBRIwCEr0YcVggmNvEwhtI
         MPhWWJ3E0KraLrGGgDbnwVteoW79nXBMQVT8ENq0cAC1SE3rUz/IhNU8oVVVwsXP1mIH
         QjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odczwiBlE0QFdwF2OJAStRlRWQh4xEUDEVC3dvDIjZk=;
        b=DuFxqqRXUgDsFDvmHoT21zSGFdz7TUpV6ILsta03gxkGlF6hnV8EIjFP376NPOwnll
         FvokDQ4i1YS0TWnrZXS3/zzms5sDh09gI6oqfBmu8LkAPJF01HnBcGyMLQwODA6kZd9i
         W8a+pkZUsgZ+DyJI8fK9dqYsxO4GA4lyI49X+9MBoOsi0aVsP1mCBZOVZ3tN4BOJ6p9+
         /ekpGWdbriH9Vwr0rEFb0eP6jBSpylFesI0sQigD44qpobwX+h/c8O2T7Oy/To98I4zY
         JqOzr2OGautrHOUZHBFsdwucMQj8Ru5121waYOKJl2muaoAVmOb/92jJrkqmlhHqNCKo
         TX2w==
X-Gm-Message-State: APt69E0e5PG61HH16gCyq4jbfFf0zKQNKFyqVBF2rT/kuS9wk+m16EaV
        8E+WI1LZzIwXzFQMZVnIqJNIfg==
X-Google-Smtp-Source: AAOMgpfiZyR1ET8pldReHd7n4DCkdOvwBkor9kmXNRHOESkv/v1tp9E9c9tvAVjsyrLfzrV7qXRdrA==
X-Received: by 2002:a62:930c:: with SMTP id b12-v6mr25247557pfe.193.1530537411990;
        Mon, 02 Jul 2018 06:16:51 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g2-v6sm29060106pgn.92.2018.07.02.06.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 06:16:50 -0700 (PDT)
Subject: Re: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
To:     "Tian, Baofeng" <baofeng.tian@intel.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0038B620BAC72941BCBF48AEB892976C02CADE91@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1C084@shsmsx102.ccr.corp.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2029ee35-c1c6-86ab-8986-2d79eb5b4d8c@roeck-us.net>
Date:   Mon, 2 Jul 2018 06:16:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E1C084@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 01:18 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
> 
> tristate will allow kernel config it to M and build ko file,
> this will cause build allmodconfig errors as necessary
> symbols have not been exported.
> change it to bool, only allow config ITCO_WDT to yes/no.
> 
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com <mailto:baofeng.tian@intel.com>>

This works today. I don't see a point changing it, and I am wary doing so.
There are systems where the iTCO watchdog doesn't work (I own one of those),
even though it instantiates, and I am wary of force-loading it.

Besides, you don't explain which "necessary symbols have not been exported".
I do not plan to spend time trying to find out what those symbols are, and
why this would suddenly be a problem.

Guenter

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9af07fd..f991e93 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1049,7 +1049,7 @@ config INTEL_MID_WATCHDOG
>          To compile this driver as a module, choose M here.
> 
>   config ITCO_WDT
> -     tristate "Intel TCO Timer/Watchdog"
> +     bool "Intel TCO Timer/Watchdog"
>        depends on (X86 || IA64) && PCI
>        select WATCHDOG_CORE
>        depends on I2C || I2C=n
> -- 
> 2.7.4
> 

