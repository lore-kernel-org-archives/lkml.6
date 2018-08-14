Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307D8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01042089E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTL+ti/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01042089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbeHNQTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:19:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44099 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:19:02 -0400
Received: by mail-pl0-f65.google.com with SMTP id ba4-v6so8312326plb.11;
        Tue, 14 Aug 2018 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=38jK2EjNLkQCsLlbc7/Wyw0SIxLKjnYNb8YceXv78Ak=;
        b=uTL+ti/VB0H1JnoybQu5dOYA61Ilq4WQGq7I8o+EdHBMr1+Db/MbvXXAKgfTRwNrVK
         iq/ISgG3pK83S9y5123/xTcB6/YTt5fdeCV+r9lCdzBbq+8seeVex6yIWtWPjOmgoUZy
         N59olF/tF1Sz9guQ0la9jDsIMx51Y/l983Hw16hiFxjd8vL+itnL9xyGTXP1akG/gd7E
         Qcmq4nbWaT4nuSN8i+HXMopbyvumv+jji53kZASwuvL6Ip7MVgSU/7Jqo/tUhnsEeJFK
         qUPgziOw71MT6VqEEABQjA3mpP5qkdNuK19WIqpAbLJorJrRn2Wt03q1+4w1wspi220Z
         mnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=38jK2EjNLkQCsLlbc7/Wyw0SIxLKjnYNb8YceXv78Ak=;
        b=cnhbWfGPzx3tiVtPyLVCqt9ACJUmHfLMaFvzuqpkZmXx58TIVndqQ6oLQui+d54O0V
         v9NEGme9UvEduET0FDPb0FO4njGfNlyZrNET8SIvxW8BXb9YOFFCU9E/tM9Hfy+27Ywn
         cXksRQ7ekOrlXr1EIeVStuLVqkpYU78qjSZ/YKESLvHi1sg6C5GZE7I3KUPHlk2an+Fr
         mxYcDuL0ynmN+W1qeMLeMdz7Y4lEXKamabHqHORXPsjWTrM6C0732gW/RPqWV2AwtIS7
         VCSPBmTXp68OvFZ2EaL/vtuj0v3GRnlVJWlkGaHc7+DO8mKBM6VyJA+zaMjKdGjrrA45
         7E6Q==
X-Gm-Message-State: AOUpUlFAmvo/MkXi9CDTT92+39ipgLqMQcO7HNXTxCtofMu+odRlZl2A
        6eqX4NNVOZSiDtf6c0XyLI2pNqYY
X-Google-Smtp-Source: AA+uWPyckkCCvr0A0ZFHHQ0q4xgMLId/pGxLX98KjYtvziLMoThkFGKBIOzs4qtX7K1FfB3FlzdpAw==
X-Received: by 2002:a17:902:7586:: with SMTP id j6-v6mr20512374pll.295.1534253509938;
        Tue, 14 Aug 2018 06:31:49 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r64-v6sm36553862pfk.157.2018.08.14.06.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 06:31:49 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] watchdog: hpwdt: Module paramerter alias.
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-5-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d4e2d7cc-77ea-36c7-ca1d-89803450cf2a@roeck-us.net>
Date:   Tue, 14 Aug 2018 06:31:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-5-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> Add module parameter "timeout" as an alias to "soft_margin."
> This aligns hpwdt usage more closely with other WDT while
> retaining backwards compatibility.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 69a88b1..eb947bc 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -367,6 +367,9 @@ static void hpwdt_exit(struct pci_dev *dev)
>   module_param(soft_margin, int, 0);
>   MODULE_PARM_DESC(soft_margin, "Watchdog timeout in seconds");
>   
> +module_param_named(timeout, soft_margin, int, 0);
> +MODULE_PARM_DESC(timeout, "Alias of soft_margin");
> +
>   module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>   		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> 

