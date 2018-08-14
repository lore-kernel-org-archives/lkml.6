Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095ECC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D7B2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8ysF+hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D7B2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbeHNQRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:17:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37180 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:17:39 -0400
Received: by mail-pl0-f65.google.com with SMTP id d5-v6so8326720pll.4;
        Tue, 14 Aug 2018 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VsbFdzYCcs491JP8ORadeaCle5bvETGItjiIdSPrIiI=;
        b=n8ysF+hyaYpBmJJwiVYSHUyItJ04hDhbKivKgFMvekRaIdX54umaeG9A4yMPk0nM5T
         3VDTShdNU0r7D1O/vrHxuPCA7BrZgB2FlFWvear6cyyI6xLD69l57bYo7X+9Zc8m30uY
         3UgtpmdGg+1cbnkDORHAUgKszXOF11VcMi71QFFsVyH5u0MYxB+SOegiQqGIR3BZgJVC
         5Q9PchAnvt+nfD6DvW3GtZQea/s6LzMBsBWXRoyQGM+JGjByTAQe3esRE3KNutVSY5TC
         wVpEQQXey4bt0UIzzyDdaI2IqRkUMpLWqEt3qmodZmxEpUd/G4iWTxs7+tCSbgkzWqPC
         e9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VsbFdzYCcs491JP8ORadeaCle5bvETGItjiIdSPrIiI=;
        b=YQd/F3Eo/naNGPTZinkhcwiFpyQQo/7lz7dPU2ENnw4I2Ud8Osm5tmzQKK0kIYUWfr
         S0Zk99Ug1xsJKrHslMLf2A8ISokWIyERxrRLlF613qnT8h8rFgsXH//qpc2yOW1m/eTE
         8QHXCxTPW7TtdEWYzF/DIV8HAvV4K9dxbmIKKMC82WzFu9XAWMT/fWCrrjCZM7hol7o+
         sO9N1l5/fHyMzcW8LLHCeR9mczte8WApg9M++uwrVbZhKv6VtvpMdOTeaahX7aBTQaft
         G6EVAVWWNKVJCJMpHfztfsdGzAoU+rKielhfl9++Ake/RDA/WuO/3KrOjZ/1zxJ+nuHX
         h4Kg==
X-Gm-Message-State: AOUpUlFCpQDzDD66MZS4sPWHFfN3dT04h8wXFdxN2J4m4kKlkqnDxBSy
        qH14Zt74/J/A3Ku7PODp0K4UJsrj
X-Google-Smtp-Source: AA+uWPxYOiTSYzqwo9upfMKgfDEG/0AWEisKJ0wao198F73CwvNsWSnatABHNbSxBzfsE6+AD7Kojg==
X-Received: by 2002:a17:902:bd82:: with SMTP id q2-v6mr20488577pls.178.1534253427539;
        Tue, 14 Aug 2018 06:30:27 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z184-v6sm27863016pgd.83.2018.08.14.06.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 06:30:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] watchdog: hpwdt: Initialize pretimeout from module
 parameter.
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
 <1533755607-71418-2-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <088155d8-3e9e-51b1-d6e4-390cf74977f6@roeck-us.net>
Date:   Tue, 14 Aug 2018 06:30:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533755607-71418-2-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 12:13 PM, Jerry Hoemann wrote:
> When the pretimeout is specified as a module parameter, the
> value should be reflected in hpwdt_dev.pretimeout.  The default
> (on) case is correct.  But, when disabling pretimeout, the value
> should be set to zero in hpwdt_dev.
> 
> When compiling w/o CONFIG_HPWDT_NMI_DECODING defined, the pretimeout
> module parameter is ignored and the value internally will be 0.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 9dc62a4..fae9364 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -205,9 +205,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   	.min_timeout	= 1,
>   	.max_timeout	= HPWDT_MAX_TIMER,
>   	.timeout	= DEFAULT_MARGIN,
> -#ifdef CONFIG_HPWDT_NMI_DECODING
>   	.pretimeout	= PRETIMEOUT_SEC,
> -#endif
>   };
>   
>   
> @@ -313,6 +311,8 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
>   		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
>   
> +	hpwdt_dev.pretimeout = pretimeout ? PRETIMEOUT_SEC : 0;
> +
>   	hpwdt_dev.parent = &dev->dev;
>   	retval = watchdog_register_device(&hpwdt_dev);
>   	if (retval < 0) {
> 

