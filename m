Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B507321872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9w/m4JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfBGOwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:52:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35756 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBGOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:52:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id l142so98546lfe.2;
        Thu, 07 Feb 2019 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=raiyBvxmbYM9e83/F8N9dhGooSKmxudcowTBfDqbEGM=;
        b=h9w/m4JR/3ds29SZRyfNO8RL4xFYyMdr6i3EkxyBZmbIEPbB8eQXN8mlNb+B/NUPZn
         MV1V4UU1vq7PoueTnAbv0M/4W2Nml9/UbQHb/raxajvBQG2ntXoxHNCePIXd4J9p6kay
         PpUosF/Iux/hFCMq/ozJ8pLie4Jc1yGKIkX+pdTW9f1ecbM7Nh6alR4a9d2fdIqMtDGD
         QpxU86OSE/OJ2eZVeDB/wjJr8mT/VKJrLMaCrVMxtGU7O6k4LTJTQcQhll6ep5wKuUR3
         2A8y62MeFTj4IZeFrUA8D7JS2wvZs/PKwM64eocXHK8OHY7vmCGZqQwrLPe+AaO/gr7l
         K4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=raiyBvxmbYM9e83/F8N9dhGooSKmxudcowTBfDqbEGM=;
        b=hmsYj/a0RL73G1HkoAyleqhRi3ByssifqRZl/zWDNnDpocHtVfgZWGoGzU4YxRfgrQ
         3e6jxvhyXawtYAZvY9WKDO7Jpkksu/kaXqNwPc20uzsUoM8WzrstDCYQJrSwc0UV2WaA
         7ZQBk8/vejyIPGoeYV+DkmVU9wWDYWldOL7Cb4GJiE9ZNHWOvG34XddRfdrPAck2zsKb
         gwdOR7cc6kMLwzmhyzDy1SYxhDu4aSW8m7BzWpgoP4/CAc34TPLh2zgzowmnRG5sjF5a
         Se8C4L/wdfbOjJwD/lmV1DcFNPD9WQLEt7cI0Mdw0YdBWxaFgPBcPs+ZnuDPXLUzyB+Y
         gYvw==
X-Gm-Message-State: AHQUAuaY5v5eDhNdKBxipvTEkPSJjEpOKJzaUMaJrHquTkPmoGUpSmRH
        wujRQi3eNrJN0RC9nPHdqFvMUruC
X-Google-Smtp-Source: AHgI3Ib0VjXOJmLZYxyxOsDmwsmm8757MZe+10UOnIXMwlUAEiGEU422rwZs5zjCKTPfu55VyhBbFA==
X-Received: by 2002:a19:e601:: with SMTP id d1mr10991730lfh.71.1549551137843;
        Thu, 07 Feb 2019 06:52:17 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id c12sm4243073lfh.48.2019.02.07.06.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 06:52:17 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a6b1acbd-9be0-62b7-29bb-081d93ee92fb@gmail.com>
Date:   Thu, 7 Feb 2019 17:52:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 22:16, Sowjanya Komatineni пишет:
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
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---


[snip]

> @@ -1124,6 +1453,10 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	ret = tegra_i2c_init_dma(i2c_dev);
> +	if (ret < 0)
> +		goto disable_div_clk;
> +
>  	ret = tegra_i2c_init(i2c_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");


Missing DMA resourcing release on probe failure.


diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 7921d3e6237d..11f25357b843 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1612,14 +1612,14 @@ static int tegra_i2c_probe(struct platform_device *pdev)
        ret = tegra_i2c_init(i2c_dev, false);
        if (ret) {
                dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
-               goto disable_div_clk;
+               goto release_dma;
        }
 
        ret = devm_request_irq(&pdev->dev, i2c_dev->irq,
                        tegra_i2c_isr, 0, dev_name(&pdev->dev), i2c_dev);
        if (ret) {
                dev_err(&pdev->dev, "Failed to request irq %i\n", i2c_dev->irq);
-               goto disable_div_clk;
+               goto release_dma;
        }
 
        i2c_set_adapdata(&i2c_dev->adapter, i2c_dev);
@@ -1633,10 +1633,13 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 
        ret = i2c_add_numbered_adapter(&i2c_dev->adapter);
        if (ret)
-               goto disable_div_clk;
+               goto release_dma;
 
        return 0;
 
+release_dma:
+       tegra_i2c_release_dma(i2c_dev);
+
 disable_div_clk:
        if (i2c_dev->is_multimaster_mode)
                clk_disable(i2c_dev->div_clk);
