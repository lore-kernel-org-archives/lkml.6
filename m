Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D415C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1DC218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzLjlqR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfBATQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:16:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32847 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfBATQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:16:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so6780559ljd.0;
        Fri, 01 Feb 2019 11:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjvXQzMjCgMnQDepPeoMQT4T3WFswV6LECt730N2idA=;
        b=CzLjlqR1kIViY0OmExr3I7ysYfEtNmqfQ0WQoYqSppUYJIAdOE/5G25kjbIVxSDQ1q
         B656/Fti6SlSTXSIn2uFZR59qUOP2CG/dO6DY+Tfz2J2TquUHfDePJRR+dZXv8U9VnB0
         S7SFcibJs8Oph9pJl7DTKSctLXdbIeOQs6u+PvIszZSifCVEoPeU9xtALv0YR0vFltk5
         w5YVQOMqZYygepMRouCPOn2U47TnABwCwWM/lF+TFq2vm9ppbTnMgoimbvZzM2kEhVoi
         fiGpO+MDWQ8ASZ4+EoUJFBKmAORKB0Opgzk8vXiKPuw4kRSyI6OSjRDNpobPjP63FTu2
         Z8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjvXQzMjCgMnQDepPeoMQT4T3WFswV6LECt730N2idA=;
        b=M52WfLazlS0m0a+I0AFZ3Yxor6NnSbOedUE+YfP2EryglL4OhFmOM5abrq2MVQp/ii
         AZL8UJBmi0z+D+zfQw42TIy1+2I9sQd3MvfK+3jdbW6dfIZB2Zc1FLC/d6EME6PUfvE+
         ZCMDRt7O+UptRRj6zKnFPyHPyjbmwybUpwpxtaleIDpWQ9BNbEqbUhJ8UX9CZWojwtau
         9vXYUQSlsBmh3gRXlRUI7M7M56Sddblt+vKsnkpE84oREqI8vRaQQJnwS+IBGvZhFhzf
         xmyeSUUP3H2nOYCI8/jIYJ4ybblHql2MHSjFKT3SzvyG95DU3N739R9mbVluYUJLebaE
         WtQg==
X-Gm-Message-State: AJcUukf6/EFqs1UiZZ6ZT+JgiSD6FmkvnzyN4ww6ccCPVU4R/bESm9CN
        4DCn+h+AjQtGXrgHTGR1Aw+a8qV0
X-Google-Smtp-Source: ALg8bN7/K5hN6HBKwIezBwzMcdrGnMUAx+fyUwIa1zigiPOmwJk85u671J2ywrvcScEoS+VpFmvwQw==
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr28542061lja.19.1549048569294;
        Fri, 01 Feb 2019 11:16:09 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id m12sm1514530lfc.30.2019.02.01.11.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:16:08 -0800 (PST)
Subject: Re: [PATCH V9 4/5] i2c: tegra: update transfer timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-4-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <53b3f00f-b3a8-e1ef-b04b-1bdd5f5473ce@gmail.com>
Date:   Fri, 1 Feb 2019 22:16:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549040867-18149-4-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 20:07, Sowjanya Komatineni пишет:
> Tegra194 allows max of 64K bytes and Tegra186 and prior allows
> max of 4K bytes of transfer per packet.
> 
> one sec timeout is not enough for transfers more than 10K bytes
> at STD bus rate.
> 
> This patch updates I2C transfer timeout based on the transfer size
> and I2C bus rate to allow enough time during max transfer size at
> lower bus speed.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  [V9] : Rebased to 5.0-rc4
> 	Minor updates for readability of xfer time
>  [V8] : Added comment with explaination of xfer time calculation
>  [V5/V6/V7] : Same as V4
>  [V4] : V4 series includes bus clear support and this patch is updated with
> 	fixed timeout of 1sec for bus clear operation.
>  [V3] : Same as V2
>  [V2] : Added this patch in V2 series to allow enough time for data transfer
> 	to happen.
> 	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
> 	takes argument with this patch.
> 
>  drivers/i2c/busses/i2c-tegra.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index ac8009c35863..43449495bfaa 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -25,7 +25,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  
> -#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
>  #define BYTES_PER_FIFO_WORD 4
>  
>  #define I2C_CNFG				0x000
> @@ -893,8 +892,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
>  		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
>  		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
>  
> -		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> -							TEGRA_I2C_TIMEOUT);
> +		time_left = wait_for_completion_timeout(
> +						&i2c_dev->msg_complete,
> +						msecs_to_jiffies(1000));

So potentially tegra_i2c_xfer_msg() could take more than 1 second and then fail with -EAGAIN, correct? In that case we should set adapter.timeout in probe to a larger value:

  i2c_dev->adapter.timeout = 3 * HZ;



Otherwise looks good to me:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
