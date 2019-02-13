Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050E7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C745B222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afZPOUvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfBMVZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:25:05 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36946 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732849AbfBMVZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:25:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id n23so2938440lfl.4;
        Wed, 13 Feb 2019 13:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YRdfiYY3n826qH3qqJZDZGYBqjSkdsBXaQDs7Xvc9kY=;
        b=afZPOUvbjo40W6iwtu7F1vH9TA2AHjFrZiAlYWLyyddYOXYXtHMi3u0y4te49uK/Wp
         TLq663HcKhGeCzOJ/nIIAytAX39x0FzBRKgmuDCn91+8y2/hFzkeatoD4STKPRzbbbmQ
         iYRgxKzC4B9VtLiaZQt7+2beZw8zsWaPRkUNpqPgZU3wXdsW6sT9s9M/CPzEHXKnuLJ+
         ThnRETHwxaR9lUjHVFi8Vro8ddd/60hJ+TWLjYeBlLnsHDqYbpVj20Lu8mhmFicFd3Eb
         BS9xkeFMowAAlpRxvXgA4Syv4ULOPn3Z1TqwCGBRW+dJHVrynTtsakCOkeoNANDpo6pk
         3HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YRdfiYY3n826qH3qqJZDZGYBqjSkdsBXaQDs7Xvc9kY=;
        b=Y19NGgNPLQADNGfeIyZEl7OGJweSShIb9spuNStxTxx053W0YUi7b3UV7dRprNqriF
         vwKPheJuicy8zy4hWNMnCj0p14DHFTVEr6IGzLdBPmboMJqmp5up+vqtxdEDpdNdlCd9
         FmA5grJe8AaE/f5GOWBZfm98+wTyVVPdY0vyjltZBwiYu0KC8XlQmcqBWRD82/7jMQTO
         DFl2fWVxlBf68UIsysCySZ+C8Obz5Q8NErldGMr44QgkWiFr/PmxZwgpnggkVqy71K0n
         2mjDZVlV0RZAmfsDO8GuJbXh41Q+WsvBOZvJe/Dj/xIp7GEEM7MI5HKMCnhDhEfp9RDR
         lkTQ==
X-Gm-Message-State: AHQUAuaNUbUWVnuaIlHLChjxnmNJ2S7leZ2jvoJzcEYrNuMMUI9B51nL
        A+qYQEilTd/FC80zjgXGgrw=
X-Google-Smtp-Source: AHgI3Ib1rnw/m37mr5wnpDjdYPMvUmXYVG0VUI3uRt9hrvtDG1ib2XWqik9epcYe+liun6vSF0rkTw==
X-Received: by 2002:a19:ee13:: with SMTP id g19mr139536lfb.72.1550093102299;
        Wed, 13 Feb 2019 13:25:02 -0800 (PST)
Received: from [192.168.1.18] (bkp64.neoplus.adsl.tpnet.pl. [83.28.183.64])
        by smtp.gmail.com with ESMTPSA id h85-v6sm74800ljf.68.2019.02.13.13.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:25:01 -0800 (PST)
Subject: Re: [PATCH v2 2/2] mfd: Add leds MFD cell for intel_soc_pmic_chtwc
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-3-jekhor@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <7a27f294-aa91-e742-0c05-f36bece2fba5@gmail.com>
Date:   Wed, 13 Feb 2019 22:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212205901.13037-3-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Lee.

On 2/12/19 9:59 PM, Yauhen Kharuzhy wrote:
> Add MFD cell for LEDs driver to the Intel Cherry Trail Whiskey Cove PMIC
> mfd device driver.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>   drivers/mfd/intel_soc_pmic_chtwc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
> index 64a3aece9c5e..be84bb2aa837 100644
> --- a/drivers/mfd/intel_soc_pmic_chtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_chtwc.c
> @@ -60,6 +60,7 @@ static struct mfd_cell cht_wc_dev[] = {
>   		.resources = cht_wc_ext_charger_resources,
>   	},
>   	{	.name = "cht_wcove_region", },
> +	{	.name = "cht_wcove_leds", },
>   };
>   
>   /*
> 

-- 
Best regards,
Jacek Anaszewski
