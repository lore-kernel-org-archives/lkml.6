Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A35C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 05:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB4F20855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 05:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQNDh/mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfBIFK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 00:10:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37839 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfBIFKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 00:10:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so2652060pfb.4;
        Fri, 08 Feb 2019 21:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LyeF4S+KpnMX6aFUJwIVzFd4RBQdNcQNYZAqpXdqF/Q=;
        b=sQNDh/mERO68nhm7FMzjQswCVwPxYbOUa4bxg/YQDPnyr22WboLWyfpXKFsXz1jtqT
         Gqsb4VmX2jp4F/2yhZ2DxOzO86QU/cPRI83s0AbXB68YyOnDcDXPtVH8YBPL6U7ImZ6E
         DeAQ+BiRRDaPKd/doTr7dAWhd63GT6hn72y3Ie1s+Ixps3dOYcZrmQb85Wt6nIr2mniD
         m2fhyg0ZR3xptU58f7DsCKsVktYusIEZyrgoauFJTDcbBKPPz9OZwuv46YmGuXk5bYY1
         IDr28gJNai/lMlRjBfZ5Uk9+kcTqvz+Nj9i9nEBOFPXVOdQU1PZORnfJfamaaqMMV3Qk
         HZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LyeF4S+KpnMX6aFUJwIVzFd4RBQdNcQNYZAqpXdqF/Q=;
        b=g80Lw1CBtWEPNER7fz96b2PNEt4Fmgsdwx/ZW2bX4CoeIRgCJlhLANyfiogTXQQqBI
         CoK43FUhFienAG7MkLw6E3slnOZgjNKmf5lyi+hYpzBKqDzffDjMPdxHuN6/y/A8B6wt
         BqceD+lvkr8rOxsqu3jaaaf9d0MuGaA37CMq/KXmtS/0fjILN/mAqbyEaGMlSoq/dbdQ
         MZ3vnxM9/q9l6+QC64iPYzIKvYtCXt+3TLebGbQhooKEL4lBvHGkUCoANYDoCuFSG8oK
         d2ZqmbI7tYUXbQxHVThqItXNJx5eT5Rt7+mct2B/RhbclWwF25irvVIKYy4MzgapNZLW
         Fvrw==
X-Gm-Message-State: AHQUAuZi4hPyJABwrVWnS3hjfXGuRTh8+uOS2q+xE4t5d75KlQt+jAfy
        kqJ6KuQtXHEMevDwgi3mc9dHMCC2
X-Google-Smtp-Source: AHgI3IZ68JSVdg6lXSQHYva1AAifak53KWgQfq3mYpMUHVPwZz5tYyxli3YZxKZnbtVNO/WcfC+oyQ==
X-Received: by 2002:a63:9809:: with SMTP id q9mr24119070pgd.109.1549689054354;
        Fri, 08 Feb 2019 21:10:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u186sm5168827pfu.51.2019.02.08.21.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 21:10:53 -0800 (PST)
Subject: Re: [PATCH] watchdog/hpwdt: Update Kconfig documentation
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1549648083-9501-1-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a20685a2-1f30-5088-7ad5-fe4d590e3a37@roeck-us.net>
Date:   Fri, 8 Feb 2019 21:10:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1549648083-9501-1-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 9:48 AM, Jerry Hoemann wrote:
> Update documentation relating to HPWDT_NMI_DECODING to reflect its
> current usage.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 57f017d..846dd07 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1145,7 +1145,7 @@ config HP_WATCHDOG
>   	select WATCHDOG_CORE
>   	depends on X86 && PCI
>   	help
> -	  A software monitoring watchdog and NMI sourcing driver. This driver
> +	  A software monitoring watchdog and NMI handling driver. This driver
>   	  will detect lockups and provide a stack trace. This is a driver that
>   	  will only load on an HP ProLiant system with a minimum of iLO2 support.
>   	  To compile this driver as a module, choose M here: the module will be
> @@ -1163,12 +1163,13 @@ config KEMPLD_WDT
>   	  called kempld_wdt.
>   
>   config HPWDT_NMI_DECODING
> -	bool "NMI decoding support for the HP ProLiant iLO2+ Hardware Watchdog Timer"
> +	bool "NMI support for the HP ProLiant iLO2+ Hardware Watchdog Timer"
>   	depends on HP_WATCHDOG
>   	default y
>   	help
> -	  When an NMI occurs this feature will make the necessary BIOS calls to
> -	  log the cause of the NMI.
> +	  Enables the NMI handler for the watchdog pretimeout NMI and the iLO
> +	  "Generate NMI to System" virtual button.  When an NMI is claimed
> +	  by the driver, panic is called.
>   
>   config SC1200_WDT
>   	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
> 

