Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27B4C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 06:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A500223F8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 06:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8AAgL1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A500223F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeHKIn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 04:43:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35372 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeHKIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 04:43:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10-v6so5326520pgv.2;
        Fri, 10 Aug 2018 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=W/PBxhm58S9GesjcpGCqwH9TArQc/CnGTDtnMEyGEWU=;
        b=J8AAgL1vtEmPA1t+HyRLuv2t3+3f2PPCB3DnjrvNqtc0Do4q+JjJGFDHiAhhaHADvz
         GX6UoX1tx0rdQAsJ7i03v55oQj/uScOESA+ICJ+/nHOb0s2NJorDY2ZsH2mszcBApwPz
         ja3S1qJJUKjS0/Pt94hVny0PDTnYC14YaoRATsq6bODM+EK5Op+xk4oisyIRKiIXJRL6
         HzQRHHX1lc1H+l+4WLZZny/66Xlf4xryVq/dOdVox+Vu8ZvKVwc8+BByW+aISnzm1xTW
         EFrNzAt+Jvk3p2mUHiUOuyz1k3IZK/FJM2a38cjO+KQ5BT4E8VvR1h+QV9zbbkVMZTE+
         Pqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W/PBxhm58S9GesjcpGCqwH9TArQc/CnGTDtnMEyGEWU=;
        b=BHIxnKkF7u3SJfKq/Dcu/NVBbos3/zt+PQX6vmQITHdxov04dNjR/DAYcp48LDKYPp
         WHB766Y9dZDu0nSoC3v8ZIqVKA7QTzBfgKl43iIOOEUfDBttGkwSRhK6fGBH/u9X1Asp
         HE+CVNtfdk65CgIx1Wh/XzKFRnqeVb5B81HRsaM0rbegq3ZKY2P7ffCjrIbgEVrjen9y
         eiwBEuQMdgsjO6CW9o2dJyMVfyUgWY4CVdMF7XbpobLaYtTqgl/1VhCk7nSry5hM8aoM
         FPstD7uDcJ3NxthoHrXpPfgbGZ0mXfaV5Mtubj8DqDX6rcalHI+ZbGx4f0YHSWFPcAUU
         f0eQ==
X-Gm-Message-State: AOUpUlEiJ0sGqaM5Kcj3WOREO04FLTnDNOl0WbiIAt1sQEnU9gPWrkw4
        LolQE4eXjkwnxMEsPEJEKT8dsYSv
X-Google-Smtp-Source: AA+uWPwxjEEQ2/Z8VFJZdWaKuGpQV1XH1fxMWH6WrTVrkL89nC1x7z32K8Z8yT7FAOUNQ7F3qk5ETg==
X-Received: by 2002:a63:9311:: with SMTP id b17-v6mr9126394pge.261.1533967824277;
        Fri, 10 Aug 2018 23:10:24 -0700 (PDT)
Received: from [192.168.219.100] ([116.36.201.74])
        by smtp.gmail.com with ESMTPSA id 22-v6sm20210097pfl.126.2018.08.10.23.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 23:10:23 -0700 (PDT)
Subject: Re: [PATCH v2] media: i2c: lm3560: use conservative defaults
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        m.chehab@samsung.com, sakari.ailus@iki.fi,
        linux-media@vger.kernel.org
References: <20180506080250.GA24114@amd> <20180716090814.GA4505@amd>
From:   Daniel Jeong <gshark.jeong@gmail.com>
Message-ID: <3a9ece34-baad-a19d-c3bd-96aa458ea70b@gmail.com>
Date:   Sat, 11 Aug 2018 15:10:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180716090814.GA4505@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

I think if there is not exist pdata, it should be set to the value of power on reset (POR) to sync with the chip.

According to the LM3560 datasheet, Flash Timeout is 512ms, Flash current is 875mA and Torch Current is 93.75mA.

Daniel Jeong.

On 07/016/2018 18:08 PM, Pavel Machek wrote:

> If no pdata is found, we should use lowest current settings, not highest.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> ---
>
> v2: I got notification from patchwork that patch no longer applies, so
> I'm rediffing the patch.
>
> diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
> index b600e03a..c4e5ed5 100644
> --- a/drivers/media/i2c/lm3560.c
> +++ b/drivers/media/i2c/lm3560.c
> @@ -420,14 +434,14 @@ static int lm3560_probe(struct i2c_client *client,
>   		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
>   		if (pdata == NULL)
>   			return -ENODEV;
> -		pdata->peak = LM3560_PEAK_3600mA;
> -		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MAX;
> +		pdata->peak = LM3560_PEAK_1600mA;
> +		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MIN;
>   		/* led 1 */
> -		pdata->max_flash_brt[LM3560_LED0] = LM3560_FLASH_BRT_MAX;
> -		pdata->max_torch_brt[LM3560_LED0] = LM3560_TORCH_BRT_MAX;
> +		pdata->max_flash_brt[LM3560_LED0] = LM3560_FLASH_BRT_MIN;
> +		pdata->max_torch_brt[LM3560_LED0] = LM3560_TORCH_BRT_MIN;
>   		/* led 2 */
> -		pdata->max_flash_brt[LM3560_LED1] = LM3560_FLASH_BRT_MAX;
> -		pdata->max_torch_brt[LM3560_LED1] = LM3560_TORCH_BRT_MAX;
> +		pdata->max_flash_brt[LM3560_LED1] = LM3560_FLASH_BRT_MIN;
> +		pdata->max_torch_brt[LM3560_LED1] = LM3560_TORCH_BRT_MIN;
>   	}
>   	flash->pdata = pdata;
>   	flash->dev = &client->dev;
>
>
>

