Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 64255C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1375E208BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Xr1hYw2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1375E208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933945AbeFLIzS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:55:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37276 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933857AbeFLIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:55:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21-v6so32808555lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nYNRHA42EcASS3/6XHKUsdYlCMp9OvXIbZbySr/3NIM=;
        b=Xr1hYw2ziEui+NLnr4Lxl8bTmrF2kiij8unvAt5rkD1cH4LR9aV8PvJ0p4NpzJP5ip
         qOhO6N944GAiFby8onUWk95G0Kg4CoDNQSlvfxp8GrwLWXpeJK4CIp8rWzc0NtbL80Jx
         Ja0OGu6+LfwdoWhag0wIsGvjlA2v9+3DvNOcyDaYQ83PnItvywlzgcGEeAmj3o55VdnJ
         eH5h8zn2tdWXkTIEGsSdsqOfVlm6dpbLFfJj7ebUWanKGWpS0db2u6Qq+R8D7sOPXes/
         NncvDk5qcVh+a/SWQm671pZEO3YMmRjq7s5lncUAHC4+CTqblo7Eh2EQH77TtRUiGb1j
         iXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYNRHA42EcASS3/6XHKUsdYlCMp9OvXIbZbySr/3NIM=;
        b=K9mvWaBaNrePbulATrtYG1y9PvJI48S0Az6omFZ8XxCnBgzUtbBHQEQRo+3HflEvWo
         fpm/Uz6rWmTS8pNR7EUKlchD5vvzryTJxOI+haM2DcaeMTmJfnAWxbK/PC8GGDuhNVU5
         Kis8RnFWQq9pNZ5mDrA3asWvWw0I+szIuxjgnrxVMLjrOhBl8NG7fku8N5OwjeN6XrPp
         AbjF6lSf452ZOa4DiY7WJhs99p/Vjd3aA8ReZx6DAI7ODxvNVlwIuUJSOGryOh4a5vCc
         dRQTJg/z5p10wVIdZ0CddQvdkMGl638PmeKVSqoa5y9y3JS2ee6jBz6TNMx4Xq5TUF0Q
         bIEQ==
X-Gm-Message-State: APt69E0swaahd1Xt7tXh2BfnEwxS5Cw7tod3UVR84vcVkfCB7ub8pCGO
        4FLEnfhFLyp9fqWmxAlqPf2lMbil6fI=
X-Google-Smtp-Source: ADUXVKKGeuO6BdoD+cD36nsGScGIOGjroPGRa51SLKe1GMun/fr0OseOEhqA+EPEZ/ESMH41Vt1mYg==
X-Received: by 2002:a19:e82c:: with SMTP id f44-v6mr1515212lfh.19.1528793714256;
        Tue, 12 Jun 2018 01:55:14 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.81.249])
        by smtp.gmail.com with ESMTPSA id x17-v6sm95224lfa.10.2018.06.12.01.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 01:55:12 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: add error handling for
 platform_get_resource_byname
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Kees Cook <keescook@chromium.org>,
        Allen Pais <allen.lkml@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1528777942-40876-1-git-send-email-jiazhouyang09@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e6291d56-477e-980a-a8b4-de86e85d3851@cogentembedded.com>
Date:   Tue, 12 Jun 2018 11:55:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528777942-40876-1-git-send-email-jiazhouyang09@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/12/2018 7:32 AM, Zhouyang Jia wrote:

> When platform_get_resource_byname fails, the lack of error-handling code may
> cause unexpected results.

    What results?

> This patch adds error-handling code after calling platform_get_resource_byname.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>   drivers/usb/gadget/udc/r8a66597-udc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
> index a3ecce6..a7bd5e7 100644
> --- a/drivers/usb/gadget/udc/r8a66597-udc.c
> +++ b/drivers/usb/gadget/udc/r8a66597-udc.c
> @@ -1830,6 +1830,11 @@ static int r8a66597_sudmac_ioremap(struct r8a66597 *r8a66597,
>   	struct resource *res;
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sudmac");
> +	if (!res) {
> +		dev_err(&pdev->dev, "could not allocate resource.\n");
> +		return -ENODEV;
> +	}
> +
>   	r8a66597->sudmac_reg = devm_ioremap_resource(&pdev->dev, res);

    This function checks for 'res == NULL', no?

>   	return PTR_ERR_OR_ZERO(r8a66597->sudmac_reg);
>   }

MBR, Sergei
