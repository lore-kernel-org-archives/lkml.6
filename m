Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAA2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB24218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLXrwg64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfAaPOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:14:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33714 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:14:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so3024194ljd.0;
        Thu, 31 Jan 2019 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uitxmf+MrnfK8R875wRPS8JynutuVcG2LBmmq0C5QVM=;
        b=pLXrwg64/Gjt/MQzAH+scJVKZ1a2TZjYmjtgiVse/+Dk4bbCjSEM/FuwMBwU2Un7CG
         Lq2xzn/Ml9/9pJRQy58kRubaD49Lcd/JDRvy8x5oxCr68xCPDPabNV3RxsIqaE5l+tW7
         2vPmNuGz+CSmPaWvzVdfe10pNSMwYSnd6VIGD4xiDAXbr5tUC5R+WkdYuIqYKpbwdKCL
         H3nPpYgwg9lO48PQM1LXcfEvnb9+IYE32sC2a5iUNi48TfrB42j8e3CJP0Urv71Cxu3R
         /RyI2MF4lLFjiUFMdLV6UrLmtZYkhD71qavI3b/NuNyKbzPd+EeXFKtqFpkGvCcpnLMt
         5weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uitxmf+MrnfK8R875wRPS8JynutuVcG2LBmmq0C5QVM=;
        b=pqg+Xt4wqjheMNwER32+jxKxI3OZgB6g2VyQLawPL2KwgsHZOXKfi9ZTcIfI99NlW/
         aB5ThxiHYfQHp6EZxMY5JLIsavaf3q8CRtyQ254MHeze8VZcgSmbCt3Y+xQHX0LYdjL/
         MD9L6FibVSpnEii90TIHcl9ucTtG5ELK1/o9C0Jgg65toS0S4qksDFQ6JwOdkqEfcL/E
         7jETipluTWXkEDGy/R5cuDBltGBiiZIOyS/pf7cjxh6M/ZqPNYLXxjFPj+M1DWbFv+1n
         5LNxMb/jAWrIqnbMBjrZ1okV550ivh7zmD9Fk3kg9OYzB4BzSx0WJ74n+IUiO/0o1EVL
         r7cQ==
X-Gm-Message-State: AJcUukdkT7LfIy3w2SCsRWbbGtlJotAWRjnC0eYQbn8mqug1xr0LI0uQ
        9dwaK4E3waqWv5iByuwEx/4LgsrY
X-Google-Smtp-Source: ALg8bN6Ecj1I4lehue2Vyzk049l56G85neJbJSLHJnxwvlMR/hbpVELC6ZJrXKJWvhoamU0ZvyYlWw==
X-Received: by 2002:a2e:8719:: with SMTP id m25-v6mr30588449lji.121.1548947651203;
        Thu, 31 Jan 2019 07:14:11 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id s62sm887857lfg.34.2019.01.31.07.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:14:10 -0800 (PST)
Subject: Re: [PATCH V8 1/5] i2c: tegra: Sort all the include headers
 alphabetically
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d0e603e2-6bc5-971d-52e2-44ba8d45c9ad@gmail.com>
Date:   Thu, 31 Jan 2019 18:14:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 9:16, Sowjanya Komatineni пишет:
> This patch sorts all the include headers alphabetically for the
> I2C tegra driver
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V3/V4/V5/V7/V8] : Removed unsued headers in tegra I2C
>  [V2] : Added this in V2 to sort the headers in tegra I2C
> 
>  drivers/i2c/busses/i2c-tegra.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index e417ebf7628c..15806c984859 100644
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

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
