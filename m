Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB796C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801062089E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro0Pfifw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801062089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbeHNQSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:18:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37990 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:18:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so9256168pfh.5;
        Tue, 14 Aug 2018 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UArVVw7rGOpykGPThcG++oU+0ElIXGTKZYFlrk5Z3Wo=;
        b=ro0PfifwjPhw/utFe/TjdJEHaLBxnADqLuBnwI4BNyqjx9ZBAdV7c4FilTg4m1XrSt
         JLiYRvspTluViA5j/4laNq+zkQKhKDrNvAqeMwq1RX1Bya9jviDU/8CTzizivLLckJFw
         Q5HlR0vuOWgM0VP4Y3yITpilQ0NbW1kbkr5kVCyZiTjUCL/SiX7S4S04l3atnJhGznrF
         70Ex2uL5+8V6EdNu0NvTK9/VpPT3Zy4SE0lb/22W0lYLqWqMAqIEj7ogkPeaAExve33z
         ULtee+4+i09QejRc+dmS3ATm0v5hM17V8itMKDNd1Su5O/HrIE3ZrZt5yUW+LAee135m
         eUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UArVVw7rGOpykGPThcG++oU+0ElIXGTKZYFlrk5Z3Wo=;
        b=Jw0wjtKa9iqGbWuZO1oLOubquc6Fd1KvNbv5u8ePHN5kh0lhfsUpCCiL1vrHq/yDmh
         gXVXnHMWhXHDQq669JTnaSDEGyHt2TNs6tgrNPXy4RUm0UNVUHw31MFA90vJHpncC61o
         s5IouHuN+wbAN7H9lMEDc8/cczMcs6g5R1GcEB63kZphD2gEVAmZVG8E2FT31BOdpNFF
         GiNdpKVsLLvY8xZvJih9uavaUgWcCD/DPdt0NyivoOLC0J23LhtXWY1jEZe2++me5iJS
         gi8abDZOVX1M3M8CCofOxv0X7FC0EARGX5hQA0qPemi2jJm4S/kWcrnhOZUuGanL4tOU
         ECdw==
X-Gm-Message-State: AOUpUlH4mgLMq+rD816YcPSX9bzoMKoNu7k0NpP37jakOl9fibrF+OKe
        9Shoq9VbmHyyrc+Kk+pRpB68NtJW
X-Google-Smtp-Source: AA+uWPxFEkkqJqCSb+ulstPR7kcBoyho/fL99gHPByiOi9vOtoZ64Qts9KG47GIrNlmpjG/n5Mxcjg==
X-Received: by 2002:a62:c0a:: with SMTP id u10-v6mr23287231pfi.43.1534253483092;
        Tue, 14 Aug 2018 06:31:23 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n22-v6sm43779677pfj.68.2018.08.14.06.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 06:31:22 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] watchdog: hpwdt: Display module parameters.
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-4-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e8113ab1-f8a3-aef8-6b7e-46b2ef29f93c@roeck-us.net>
Date:   Tue, 14 Aug 2018 06:31:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-4-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> Print module parameters when the driver is loaded.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index bb41714..69a88b1 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -320,9 +320,12 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   		goto error_wd_register;
>   	}
>   
> -	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
> -			", timer margin: %d seconds (nowayout=%d).\n",
> -			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
> +	dev_info(&dev->dev, "HPE Watchdog Timer Driver: Version: %s\n",
> +				HPWDT_VERSION);
> +	dev_info(&dev->dev, "timeout: %d seconds (nowayout=%d)\n",
> +				hpwdt_dev.timeout, nowayout);
> +	dev_info(&dev->dev, "pretimeout: %s.\n",
> +				pretimeout ? "on" : "off");
>   
>   	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
>   		ilo5 = true;
> 

