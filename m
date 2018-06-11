Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CE5D9C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CA920869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0/23YRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CA920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933627AbeFKRaY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:30:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44186 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932363AbeFKRaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:30:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so10599305pfk.11;
        Mon, 11 Jun 2018 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXFA91cckladqvygrR1sZpTyZck11jAB/ancBeRHwPQ=;
        b=p0/23YRS3HMf8Ffnvi0HxNV3gUZ+8SbU3JJqYLMhNtwFIBwiqgjvDden2aJkUmepS6
         w3aG/Yjv11GnBSgvHHDYE4u+oNxEgEbpxFeFlpcDwQXrcPeFHjyvonx7nC5lhkGf6WfC
         s93Lv97c+MwSD+wCTDxW9rUW9zZ+Wve/6IQfDdZBDfVLq4VFdB8UDp4byfIhvz0C8VrL
         0kONCIe8kyB//L+J+lv6aVwJVCiZ+916RT3WPHB2pfHusE0g1Zkt/92xgVJNeRQOMV8l
         TWpmej8d/08ll/+7+H0nwagy5bSnlAqrpq6YkvhugNGAKzN+SdLI+IXHjQ1lNwLKTrqh
         784Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXFA91cckladqvygrR1sZpTyZck11jAB/ancBeRHwPQ=;
        b=QcmH536jTHpJvHuZcwdGiJ1Yro8qY/vBhW1C5i/HdXzvw+xlrCJWGaKo4yX4Eo/p2J
         CNvSNg1xqIYvsaUTc4ZtoBTiLrzT2F+WjuOzFr/nt/Ls6MsbsR0n8DtiRAguSgOWjsUm
         58TfD5DMJPnypnTagdPpOebGduLabCEBd4ubLFL6JkgQuXppcDot/LCW8nXEb6ifhEvM
         3EBW0W7ZYwebpxvutok7iX69qR9ymPS9C8G30Hpa0DzBE+/nEn4dDbvwNXDum6JF8FkT
         fKa4JhAeEA/Sc+eQe6dOlLPM2RH0QuSneoRtwf2h6AwJijC8m5TWBP8mw+iFu5i5GXPu
         mURw==
X-Gm-Message-State: APt69E2+79Z0Dm4SCw+VD868Qu8Rd4ZPCN0UF3i4tBVjusxYzUwGGgDg
        UKq5/QsGZHx+K/Bmid6GUjE=
X-Google-Smtp-Source: ADUXVKIukfR06dHOXl0yih2H4RJGaJ+G8ubTT5TuTPlpeGLwjXAH/HQo0qM6jEwSMNg+nKDSQfZarw==
X-Received: by 2002:a65:602c:: with SMTP id p12-v6mr65458pgu.209.1528738220741;
        Mon, 11 Jun 2018 10:30:20 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id h78-v6sm9511071pfh.141.2018.06.11.10.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 10:30:19 -0700 (PDT)
Date:   Mon, 11 Jun 2018 10:30:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: add error handling for da9052_reg_write
Message-ID: <20180611173017.GD251078@dtor-ws>
References: <1528694619-31889-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528694619-31889-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhouyang,

On Mon, Jun 11, 2018 at 01:23:39PM +0800, Zhouyang Jia wrote:
> When da9052_reg_write fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling da9052_reg_write.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/input/touchscreen/da9052_tsi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
> index b5dfd594..60c82a0 100644
> --- a/drivers/input/touchscreen/da9052_tsi.c
> +++ b/drivers/input/touchscreen/da9052_tsi.c
> @@ -319,8 +319,11 @@ static int da9052_ts_probe(struct platform_device *pdev)
>  static int  da9052_ts_remove(struct platform_device *pdev)
>  {
>  	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
> +	int error;
>  
> -	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> +	error = da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> +	if (error < 0)
> +		return error;

No, this does not help anything. The remove() action must not fail
(really, having it return an int and not void was an API mistake made
long time ago), and thus returning early in and event of error failing
to communicate with the device is a mistake. You really want to release
the interrupts and memory and unregister input device before returning.

>  
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
