Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866BBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F6E218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxmPsvKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfAXVbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:31:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35860 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAXVbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:31:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so3248948pgm.3;
        Thu, 24 Jan 2019 13:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zg1hiDWSkdoKlKrGhoKh9p3u2gfeR+FlyP1bDnEdRyo=;
        b=OxmPsvKrcATLdb75kGcN89Pt9J1rYxKvSAOzOcp6itjXYpXUOb0QkuXe1L9+s+ljop
         ORQWxtLBo4D3NDNVHhNGfrXiqm3gNQAIdPZucM2e5oiLKR5rqiZo9wvZbe0Yz1DZlh0d
         JDVnSGc4HhbPm30CwwF8YpZ++XBncC+8XKjfiIHiKqjL2S4UM3B1GGeLBw4A+mU0yc83
         2WnjWwdyKxSqOHBG7aNhVZz8gG1llpgNNfFrpcOgmt5PjM4UCtcbfn/kuRTW4/ktZWgP
         6rWRysngy2A+QcIaK8IUYwwFrRawNiUmfIo1em+28gnw9TWOL4DgIX485etC8s5sGT+1
         Xovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zg1hiDWSkdoKlKrGhoKh9p3u2gfeR+FlyP1bDnEdRyo=;
        b=p5YYh/3TxJS1Oxnu3Bp79RK6Jo1aHLw1uSjtKYLx5LaJsVAkimmD2QpCr2NnnDFjLM
         70YPzkta9bfZdCaLygfOz29bg12tzu2WCMQnDzvHNJbH8Zd5AIxDWchhftyxHvq/Mc96
         FihTjovTW0ko4Qs5M0DFIk6lUa7vEZ+JPSPALLYR122ejFPBELhLJc2SU5taFgK+jYiL
         Zi6TAQ9gwQ6JPC+mE7XYap0DDDWXZPFj/FCsgmKeX2MuLLtccuTTz6t0OqX851+GR7wX
         eNXPNg1ATV6SDkY0FKlPGStSE2ziEgHQoXozavbuDkbn0ZFPMP7WukX+GzVdqTswitDE
         5jwg==
X-Gm-Message-State: AJcUukelqbK9kj5GRZPpkTikYtjom2UaatVm52MEOdEwZTfCF9oTj4ve
        O/rfW6HTsNER/aRaO6N4dtTnWHue
X-Google-Smtp-Source: ALg8bN4XMel72nu9y7LmKOyyccDL+hLvH54p/9NkgsoBTukVY6nfsoGQa/OZ5/hT6JhrJ6W71curTA==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr7465945pgm.126.1548365506207;
        Thu, 24 Jan 2019 13:31:46 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id z9sm56728900pfd.99.2019.01.24.13.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:31:45 -0800 (PST)
Subject: Re: [PATCH V2 1/4] i2c: tegra: Sort all the include headers
 alphabetically
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e896f4af-1c20-3188-f1f8-253ce4893a50@gmail.com>
Date:   Fri, 25 Jan 2019 00:31:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.01.2019 23:51, Sowjanya Komatineni пишет:
> This patch sorts all the include headers alphabetically for the
> I2C tegra driver
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V2] : Added this in V2 to sort the headers in tegra I2C
> 
>  drivers/i2c/busses/i2c-tegra.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index e417ebf7628c..ef854be4c837 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -6,24 +6,23 @@
>   * Author: Colin Cross <ccross@android.com>
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> +#include <asm/unaligned.h>

What about to clean up the includes as well? Seems <asm/unaligned.h> is not needed by the code.

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
> +#include <linux/slab.h>
>  
>  #define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
>  #define BYTES_PER_FIFO_WORD 4
> 

