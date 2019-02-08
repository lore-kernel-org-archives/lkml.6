Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C08BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZRYItNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBHMrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:47:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33099 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfBHMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:47:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id f24-v6so2920603ljk.0;
        Fri, 08 Feb 2019 04:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=95U820mf8/Ka3mh831g94dsdfh75NSrWnmOqCTDSOY8=;
        b=VZRYItNpOzxoBfJHtPSHbRT96uwmhlaxRrFhHGH/NqFJOzeayLHuHKfMfS2o3DWOU4
         lZmpyEQnOHe2YRY/5A3NpctiuzyROQoSchVhWn/jV9gLvmEKuaAcAdY3n3qOpqGSAZqN
         5uIuNAYSD4En1EmVzP/vdrG/DSeHsUvkRYFrUhiJ8wGmipL9HAwGoPrM8AOg7FcejqdM
         uymuFgLPjHJVrSuU8vvqFnYdrUY8Nnyz0SChnlzus37UgKPmAUdjBsYB4Rxt+DkBAj6T
         lm00HNKJp0Xb2CuoAzZ0SXyRqiGut40RCs8tQhwj/T4tGFV4SbIpvdk9xXlbrLWj6Rcb
         2cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95U820mf8/Ka3mh831g94dsdfh75NSrWnmOqCTDSOY8=;
        b=jDZavCccCvCQ0/YOSec6KR/gUxs3C0AyjszpkNMm132p/nSPkZYLRuou2BquyBnOKC
         7Qi26a9t2Vhdvc+I4vgWDV9XFwDREYkJsVafmExLhksXJmIKQi8Gy7zs5vxvCbtIhMtc
         Rzo0ACP657SWvpd22BT//hO5LSZak8jt81DmAQHmq1BXx0AtWWrHacP9qxotuh5jrEai
         +D0skKSD7xBsJcTgbOPU/IqysybPfawa/3NF/ee5VWvrRYpGs2gysf+/jAj+LO+gADkR
         o6MKaSU2xyKym0uBVTw21q8CbfMC3KJH5sNs6sPmpwN/as/5Aa3c4+a2FgdyV2JQwBF6
         hkSg==
X-Gm-Message-State: AHQUAua7+UYzAJNxO8nd3DryQO+6jHDEIqQWvJFGK+zJ736PhpzD/Zdw
        cIf2z/c4SGifPP9BDRMwepcATBxU
X-Google-Smtp-Source: AHgI3IbPzmp+NypQggIynOswP+U1BF4yZeaPLmWirx6BFBMeGWH+Mf0V9fl3dma8CGI4yZc1uXQoqw==
X-Received: by 2002:a2e:999a:: with SMTP id w26-v6mr5802741lji.169.1549630057753;
        Fri, 08 Feb 2019 04:47:37 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id k68-v6sm359195ljb.35.2019.02.08.04.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 04:47:37 -0800 (PST)
Subject: Re: [PATCH V15 4/6] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-4-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7806f2cd-72b4-6ae3-b75f-0fc74fb62b95@gmail.com>
Date:   Fri, 8 Feb 2019 15:47:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1549576040-15907-4-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 0:47, Sowjanya Komatineni пишет:
> This patch adds DMA support for Tegra I2C.
> 
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
> 
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
> 
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---


[snip]

>  	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
>  						TEGRA_I2C_TIMEOUT);
>  	tegra_i2c_mask_irq(i2c_dev, int_mask);
> -

Let's keep this newline in place.

[snip]

> +	ret = tegra_i2c_init_dma(i2c_dev);
> +	if (ret < 0)
> +		goto disable_div_clk;
> +
>  	ret = tegra_i2c_init(i2c_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
> @@ -1160,6 +1500,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  disable_div_clk:
>  	if (i2c_dev->is_multimaster_mode)
>  		clk_disable(i2c_dev->div_clk);
> +	tegra_i2c_release_dma(i2c_dev);

Please use "release_dma:" variant that I suggested in the comment to v14 because:

1) It's just a good (and common-style in kernel) tone to unwind errors handling in the opposite order, it makes code more straight forward and helps to avoid silly mistakes.

2) It keeps the current code consistent in regards to probe error-handling.

>  
>  disable_rpm:
>  	pm_runtime_disable(&pdev->dev);


[snip]

Please also address my comment to the "fix maximum transfer size" patch. And please add Wolfram Sang to the CC list.

Looks like v16 should be the final, so with everything being addressed:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
