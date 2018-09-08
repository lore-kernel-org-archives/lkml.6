Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D3C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2270920844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DirYPGuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2270920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeIIBgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:36:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36009 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeIIBgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:36:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1-v6so9019021wrt.3;
        Sat, 08 Sep 2018 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BqpDjtvaAQ4a/UpqTfDYlkLNzhD2kzMzJp1D0JotkPY=;
        b=DirYPGuz9j9nQcssgAon6TYhLbYDHBxviDWcWNd0//0jiegIhBZRip+x0p6amuKbb7
         WNd19Lx7VD2ey4yFWPtOey2QBUSD9ZRSD5PGREXwRT5c+rwisLefz1P+lz+Ag+HrOMZj
         nXy8VNGSrlMXPnAGcbM0c4rDp0T1pS7m0GvnY/bGt6CRfojqkYpgyemIazyzIxF/OAQh
         oS1AT4x6/oozBOVMZAyhi9Rszk3B6ihuuOTZXIxAWn1nagKtLkLMy4PbVSpggbbCUyV1
         qCUdlbOugH9OVXAhjoXpntRH35ai2aXB1KsfLtZ/7J2ptRMAuyAO66VKtMHk98W6RzW6
         NFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BqpDjtvaAQ4a/UpqTfDYlkLNzhD2kzMzJp1D0JotkPY=;
        b=HJaYwK4IPslFqVcIJYuYo2WXNbH93XOCCyYERNxgIC3MXDfQ6f5Tw2HJm0EBTLnLs7
         S4qb48zQMSA5fqdj1qRLCh6s5EDnWM7NgbGhtUmXDwZiAKGETtDLzGa3wsod+J7Ju5zy
         I+Nr4NfGun3j8d6UMRWnDv8dTwbNA66117J0veUeO7HpITpBxdXBEhOam9SL7s/jigBp
         kMf5hdS/LqX8Y2Cx2LT7flkrakSC9MerPeGxit2PF448w8poUHAQcyuGYEJ74BeuOu//
         /X9hCoye25VH2tWDdaOP2Io/mm9rPbSJxSM5zJDTWiWsbRnuZpOMSL4xMNCJYMAmh+xt
         fDkg==
X-Gm-Message-State: APzg51C4Tr7YauSVm39giUJ1nul0Yp9U+0pMTRIxg1GdDWSCWv4lpb4p
        GMcIPhbvAjn9JUTMf7UdMGWs+NJy
X-Google-Smtp-Source: ANB0VdarlLji1H0ldsVcBbpcEDo+GjJN+Lv+0mkVmH3/fKhEEESOfk6Kbo3Ln/yAxgTUlp42Po2EWw==
X-Received: by 2002:adf:e44e:: with SMTP id t14-v6mr10001343wrm.96.1536439748576;
        Sat, 08 Sep 2018 13:49:08 -0700 (PDT)
Received: from [192.168.1.18] (civ14.neoplus.adsl.tpnet.pl. [83.31.45.14])
        by smtp.gmail.com with ESMTPSA id j2-v6sm19405693wmj.5.2018.09.08.13.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 13:49:07 -0700 (PDT)
Subject: Re: [PATCH] leds: pwm: silently error out on EPROBE_DEFER
To:     Jerome Brunet <jbrunet@baylibre.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180906135904.13803-1-jbrunet@baylibre.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <b9d1e9bf-956a-9560-d223-2b4c5a76b14f@gmail.com>
Date:   Sat, 8 Sep 2018 22:49:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906135904.13803-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

Thank you for the patch.

On 09/06/2018 03:59 PM, Jerome Brunet wrote:
> When probing, if we fail to get the pwm due to probe deferal, we shouldn't
> print an error message. Just be silent in this case.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/leds/leds-pwm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index df80c89ebe7f..5d3faae51d59 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -100,8 +100,9 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>  		led_data->pwm = devm_pwm_get(dev, led->name);
>  	if (IS_ERR(led_data->pwm)) {
>  		ret = PTR_ERR(led_data->pwm);
> -		dev_err(dev, "unable to request PWM for %s: %d\n",
> -			led->name, ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "unable to request PWM for %s: %d\n",
> +				led->name, ret);
>  		return ret;
>  	}
>  
>

Applied.

-- 
Best regards,
Jacek Anaszewski
