Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D43FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FB520875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKvP4a76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FB520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJEPEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:04:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38354 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJEPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:04:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so12544956wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xH4c+Ki6odkD1uwXJUCHqMycesxOq8zsgQEswIR4f/Y=;
        b=jKvP4a76V4A8vB3sX/nWrDlx5an2AYjPFK8aJ2NHwkbWb4BKyDZkLs3k668Z+5YtQ4
         /gM0akBfSX1snGp4ZzsORuDp/M1RQdb02bUkdowSjkldiZka5WGm+NotPaRdUkPzJyQw
         Yo9tBnXcc5SSrOlYBxi1lpKZQJOJKLQOhf948=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xH4c+Ki6odkD1uwXJUCHqMycesxOq8zsgQEswIR4f/Y=;
        b=r3UUYL1tY9FAvojw6cwROKv7C7H+QCUffiBpm2P4PRHtzKleitnmYgcWgSFaPIndOF
         x8Kj65hV5RxKpAeLH3XIClyAdU8jcJoblzsjTa/7Ekf63PJWtCVEMTIt7ixHp8L6Nnp3
         wXriungOZlTR99a2kIMED+fxN1tFogHx3TLx7p+zTbgYdPtloVbev3cjdLpeKdIPOEK1
         Ox8E2aCul8lqWM7TN4qLDcK+8oLN27GD1GLs0J3xJsULuxDOf0MY4SsdGexnsuoDPFyc
         5KBkfITRN311unt+6GOerj0uf3LQeoyVzFlAlQAXsXeNXupuKLeZGhRqOaQrxAjM5tlt
         PJag==
X-Gm-Message-State: ABuFfogF4hKJlV0bepCnWtjohBXpvclealYZ9IGxHYwbr5SAjxX02XbQ
        zgVm76Hq+Z0CSnONkCnKRbckxWlgxa4=
X-Google-Smtp-Source: ACcGV639QsgwseBk95kRKdCNulSzOPuj+5yY+xCJoKy6nI7SnXZW8sMluOm8Veguw6YLCuw1Y+2zVw==
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr7664541wrb.283.1538726788506;
        Fri, 05 Oct 2018 01:06:28 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 140-v6sm2381720wmx.34.2018.10.05.01.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:06:27 -0700 (PDT)
Subject: Re: [PATCH] nvmem: lpc18xx_eeprom: fix compile warning
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joachim Eastwood <manabian@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181005070313.GA2217@embeddedor.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cbd5708c-e06a-acfd-80af-34222bc2be1f@linaro.org>
Date:   Fri, 5 Oct 2018 09:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181005070313.GA2217@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/18 08:03, Gustavo A. R. Silva wrote:
> Fix the following warning by removing unused variable ret:
> 
> drivers/nvmem/lpc18xx_eeprom.c: In function ‘lpc18xx_eeprom_remove’:
> drivers/nvmem/lpc18xx_eeprom.c:258:6: warning: unused variable ‘ret’
> [-Wunused-variable]
>    int ret;
>        ^~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

There is already a patch submitted fix this

  https://lore.kernel.org/patchwork/patch/995032/


-srini

> ---
>   drivers/nvmem/lpc18xx_eeprom.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
> index b42dbad..66cff1e 100644
> --- a/drivers/nvmem/lpc18xx_eeprom.c
> +++ b/drivers/nvmem/lpc18xx_eeprom.c
> @@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
>   static int lpc18xx_eeprom_remove(struct platform_device *pdev)
>   {
>   	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
> -	int ret;
>   
>   	clk_disable_unprepare(eeprom->clk);
>   
> 
