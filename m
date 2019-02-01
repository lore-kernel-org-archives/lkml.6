Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E94C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7BB21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoUV1l8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbfBATFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:05:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39984 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfBATFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:05:31 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so5849206lfe.7;
        Fri, 01 Feb 2019 11:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N+sVxrM6h+UZCwaTYbwmGG3yCO3i6Ud5DrB7XtdRzto=;
        b=YoUV1l8qUB5WIvRbMB2zvrTv+y4324cQG8wtAsl+BLFs43nH+uio2neHrmgUREH7QZ
         SEAjpwuoVET9/J5H+NiGDxrY/yfdcPhOtpgsmRGQYQ4eqyKyDsnTiM1ocvnYDfIUek42
         W3g3vUpWalhBefcaDGQuo6Vnuk4hnG6UXwJPuaqT8mP3B2u7MCM+KYtfedirQH8/ofs+
         5djFFF5bXnmoeUuO83YK23eSzLR9qGzkzLRppXqmjaud4YAaVaFLLsiXaeTwRFuA0wYf
         8/t9IHbpyF9m0LdBIN5nA6rjLmLbFr1wIe0kV5j3WLjGFkOcYpRgBndz0ARjlpyXmMa7
         1hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N+sVxrM6h+UZCwaTYbwmGG3yCO3i6Ud5DrB7XtdRzto=;
        b=pwSdgZw32oJblD2NY9xKjxwJMSu+QzhuQtJOJal6kY4PFKzFExCeINQBoOtDjt9kHA
         VTw1NINRewC4E/Yz/+wHpW1y4TMTHb6dY1e9tSgHQTRPaRJOz/dcFoBs/Lf12NRXQriY
         0U3zpaOHcujiVlHcVVT2i3l7g4GI/vZn4Raf1mgYvj2SJbsrszeYaPPGYIpfLqtylvtc
         1WaXxXza+yDQbjg8Row8kGeSV6RZZ8igcgaOKu6iKjEfYlDU7x7IMsNPy3uz/avwpU8t
         q5ljf50Dsp23POYm4PZJHkKkSjPJJRda9nM06NYK/j3DbwZckbf+yGoG6HYm/+3W2Jln
         GFcg==
X-Gm-Message-State: AHQUAuY0oAJu6JTJRNlBfaOLIAZ3VleheBD9iuyZAX0iuwoi8Z+gw64l
        4TUYAd2/SFhu/4CG8nW90PFhz14X
X-Google-Smtp-Source: AHgI3IZ803ysM8W/7e3WDSEUwX8e1XyAvsyR52PjhiepU9e5vtDnarUDUpN+L5LM0rrQ0ZXwatVoBw==
X-Received: by 2002:a19:1d87:: with SMTP id d129mr346218lfd.106.1549047928621;
        Fri, 01 Feb 2019 11:05:28 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id j25-v6sm1407413lji.77.2019.02.01.11.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:05:27 -0800 (PST)
Subject: Re: [PATCH V9 1/5] i2c: tegra: sort all the include headers
 alphabetically
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8769ec28-ac09-797a-ae5b-5289717dbcc0@gmail.com>
Date:   Fri, 1 Feb 2019 22:05:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 20:07, Sowjanya Komatineni пишет:
> This patch sorts all the include headers alphabetically for the
> I2C Tegra driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  [V9] : Rebased to 5.0-rc4
>  [V3/V4/V5/V7/V8] : Removed unsued headers in tegra I2C
>  [V2] : Added this in V2 to sort the headers in tegra I2C
> 
>  drivers/i2c/busses/i2c-tegra.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index c77adbbea0c7..79c6aa87499b 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -6,24 +6,21 @@
>   * Author: Colin Cross <ccross@android.com>
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> -#include <linux/io.h>
> +#include <linux/init.h>
>  #include <linux/interrupt.h>
> -#include <linux/delay.h>
> -#include <linux/slab.h>
> -#include <linux/of_device.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/reset.h>
> +#include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/iopoll.h>
> -
> -#include <asm/unaligned.h>
> +#include <linux/reset.h>
>  
>  #define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
>  #define BYTES_PER_FIFO_WORD 4
> 

I gave couple R-B's in v8, please don't shy to add them to the patches.

Also a small hint for the future: if somebody makes a review of your patches and you want that person to take a look at the next versions, you should add that person to email's CC because sometime patches are getting delayed by mailing list for a very substantial time (days) or even getting lost. 


Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
