Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAF9C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 04:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128C22077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 04:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbEmsO+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128C22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeJNLr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 07:47:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37506 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeJNLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 07:47:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so8043876pfi.4;
        Sat, 13 Oct 2018 21:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vS3Q0if/BfSH7o2BBLLuv76ds/PmTzkjqBdR1hkMYB0=;
        b=mbEmsO+kr23r5BsX1R0m8a0+yE3P/Tiw6hhOfbCDRZ432dRUFDmSiob7paEbqupdfp
         7qplHIxgRc7oErjTZb5iBoOtwjyNECWD0F+uKfN2E/M47XVEGrHco6Svba5++xVElJiX
         vAi56b9D7A7WaC18ZnLiQ3Sy9BfO4mlkz62FgJfFdvPJ5AU7fZDQwuFFKnWHcFhWENHB
         lYsEgW592iYeRBDtTQiSfntZfHN6pDFnCD8AMcyi08CBqr5W3YVwo+B2EO5mOL5YTyiu
         kgA4CxDRsm2DKK1bZws/2VFQT25UrXbCZc4zv5iEus+rGJxMXdb+XE82mMLXIv9ynIjp
         f6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vS3Q0if/BfSH7o2BBLLuv76ds/PmTzkjqBdR1hkMYB0=;
        b=G293GDRdubA9VxUkGbpkPbNuzs4fGgMkiZe6wAmuHI6VNDlDADHo3VKBOCMs+NL/tG
         Yy2BNGZyw7mM95iv4m9srUUSECj6jA7Io4cIgSLZbcGJj2V5FEn5oINyLV5rwdu6I3gp
         PyzbL5JXCPgzB2CZ0148EL84JniEFN7zB6RQrU/53ic8cyywa4pRlizdz7WFEfMB8J+p
         Hgkm+K+8ZUYYLe/3gUI7aJUqWTlYieLZZBuZRGEgdbDXv7s9g9Kcsh/2+KvRTSK6YjzG
         He9MLudhYl/jXwU22+pfzdxn0JNBUjG3sGPvz1MkBM2/+AjH80Q0pD0lg1RTAYKtpRMs
         30DQ==
X-Gm-Message-State: ABuFfoim8i0yFGh1v92lg9eKXucUHEBMaM3FGI+cxUYCxa2HqpjUw/qw
        GUll/lqVaH9blnH4/paaa48=
X-Google-Smtp-Source: ACcGV61YwD6+idiihw8RfWnrHMu3ix81DkZRN0wLbpA/eNnBo/tL1i9/6NddcbOZJ7JVVYI2qA5o/w==
X-Received: by 2002:a63:9f0a:: with SMTP id g10-v6mr10860018pge.232.1539490104937;
        Sat, 13 Oct 2018 21:08:24 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h75-v6sm3823891pfe.146.2018.10.13.21.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 21:08:23 -0700 (PDT)
Subject: Re: [PATCH] watchdog: ts4800: release syscon device node in
 ts4800_wdt_probe()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Damien Riegel <damien.riegel@savoirfairelinux.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <1539463863-21867-1-git-send-email-khoroshilov@ispras.ru>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5817b7ed-1480-6499-9074-58c47f29221f@roeck-us.net>
Date:   Sat, 13 Oct 2018 21:08:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539463863-21867-1-git-send-email-khoroshilov@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2018 01:51 PM, Alexey Khoroshilov wrote:
> Put syscon device node when it is not needed anymore.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/ts4800_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
> index 2b8de8602b67..89843b16b04a 100644
> --- a/drivers/watchdog/ts4800_wdt.c
> +++ b/drivers/watchdog/ts4800_wdt.c
> @@ -135,6 +135,7 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
>   	/* set regmap and offset to know where to write */
>   	wdt->feed_offset = reg;
>   	wdt->regmap = syscon_node_to_regmap(syscon_np);
> +	of_node_put(syscon_np);
>   	if (IS_ERR(wdt->regmap)) {
>   		dev_err(&pdev->dev, "cannot get parent's regmap\n");
>   		return PTR_ERR(wdt->regmap);
> 

