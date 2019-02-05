Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D1FC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F7C2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQuPy4KY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfBEGJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:09:01 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56234 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfBEGJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:09:00 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so5609769ith.5;
        Mon, 04 Feb 2019 22:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3uFjf1wFbSViIkWzvRm5MQBpTGTSpZZvMrviq74HOAE=;
        b=rQuPy4KYb47jAy7sTgqmrHmmAPDacHRXEhMuVjmg8XEQZfWjCH+/vb0gwz+m9tUBKs
         QAPhRbFaqZBxsVsIROlKEJtWjB4+2s+8RHXZJvJGOKwvdYl8N2/SlKdoaLEnGFAdfD98
         /ERBOVKapqLrhn0+4g5D/t2alyRY6ySECPJhCXvQ9dCCT7WvdHv7n+CO9wtBfXS0vh1I
         cPZNPGBcwIGX0TXByCZIU7nDVmYHhhYNqpX8wgf97gOPNto3hD2SoIFOu885TuyXG5Kq
         JoIkmOb8fUUijK7HRgxtp+e15xzNPKYblC0OBjQBocO4uU2soJr/dc4QYbmauvChW5Am
         Oetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3uFjf1wFbSViIkWzvRm5MQBpTGTSpZZvMrviq74HOAE=;
        b=laOtlfJMFDdxBTPdEnYd8qM79pEQQdk6awgMZYxXIDh/FBVBjHN59FqqJUMPlxJt0I
         kRZObfAiJwv+lMI0rjwtwTvfikeO1vYoJUMCa0LDv+3+WgOiCyf6nFKWzYuTWooKhhI6
         oujmmm3rvW8uMfWmQN/RXAnhYHC6tRzE2Txo4CPkTCcDTqPttnejoKMWmwEk+GgiN4zY
         BWhTCqKPPioCkvMHgXA25RIrDpjO2Ino5NMhW/5ZQcntLxE+dmD2oiEpMKkqJO7cgpLQ
         AsYDb/oqAtCBZSppAImIkUiEMRCEOc1mVCaT4Golzx6yk1rqiCZnUxzgLyxHsLmVL0gJ
         9DhA==
X-Gm-Message-State: AHQUAubk5Nbix0LNGg7pQyj8dus4C2i9oiZxp+RcMlZuCrPeS6sEoHkx
        Qwb0LrzW0vhTe1fWBJPbkjJduYBK
X-Google-Smtp-Source: AHgI3IZlNYF0Kvvkr5urAtHqqs8bogHLhMHEtlMh55ZZE768sX9/rWxdzdEwD6Xd2yLpSECX/HjYqQ==
X-Received: by 2002:a24:750f:: with SMTP id y15mr1533938itc.177.1549346939320;
        Mon, 04 Feb 2019 22:08:59 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id j133sm1261747itj.16.2019.02.04.22.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:08:58 -0800 (PST)
Subject: Re: [PATCH V10 4/5] i2c: tegra: update transfer timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549330167-8690-1-git-send-email-skomatineni@nvidia.com>
 <1549330167-8690-4-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3c51edfb-ca40-b696-db03-bf73677f06fd@gmail.com>
Date:   Tue, 5 Feb 2019 09:08:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549330167-8690-4-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.02.2019 4:29, Sowjanya Komatineni пишет:
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
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  [V10] : Reduced the timeout for bus clear operation
> 	Added adapter timeout to cover worst case transfer rate (max transfer
> 	size at STD speed) incase if ARB LOST happens during middle/end of 
> 	the transaction.
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
>  drivers/i2c/busses/i2c-tegra.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 658cf01e3f59..341475204cb6 100644
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
> @@ -936,8 +935,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
>  		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
>  		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
>  
> -		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> -							TEGRA_I2C_TIMEOUT);
> +		time_left = wait_for_completion_timeout(
> +						&i2c_dev->msg_complete,
> +						msecs_to_jiffies(50));
>  		if (time_left == 0) {
>  			dev_err(i2c_dev->dev, "timed out for bus clear\n");
>  			return -ETIMEDOUT;
> @@ -964,6 +964,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	u32 *buffer = NULL;
>  	int err = 0;
>  	bool dma = false;
> +	u16 xfer_time = 100;
>  
>  	tegra_i2c_flush_fifos(i2c_dev);
>  
> @@ -982,6 +983,13 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	dma = (xfer_size > I2C_PIO_MODE_MAX_LEN) && i2c_dev->dma_buf;
>  	i2c_dev->is_curr_dma_xfer = dma;
>  
> +	/*
> +	 * Transfer time in mSec = Total bits / transfer rate
> +	 * Total bits = 9 bits per byte (including ACK bit) + Start & stop bits
> +	 */
> +	xfer_time += DIV_ROUND_CLOSEST(((xfer_size * 9) + 2) * MSEC_PER_SEC,
> +					i2c_dev->bus_clk_rate);
> +
>  	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
>  
>  	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> @@ -1089,7 +1097,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  
>  		time_left = wait_for_completion_timeout(
>  						&i2c_dev->dma_complete,
> -						TEGRA_I2C_TIMEOUT);
> +						msecs_to_jiffies(xfer_time));
>  
>  		if (time_left == 0) {
>  			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
> @@ -1110,8 +1118,9 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  		}
>  	}
>  
> -	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> -						TEGRA_I2C_TIMEOUT);
> +	time_left = wait_for_completion_timeout(
> +					&i2c_dev->msg_complete,
> +					msecs_to_jiffies(xfer_time));
>  	tegra_i2c_mask_irq(i2c_dev, int_mask);
>  
>  	if (time_left == 0) {
> @@ -1367,6 +1376,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  	i2c_dev->div_clk = div_clk;
>  	i2c_dev->adapter.algo = &tegra_i2c_algo;
>  	i2c_dev->adapter.retries = 1;
> +	i2c_dev->adapter.timeout = msecs_to_jiffies(6 * MSEC_PER_SEC);

There is a "HZ" constant in kernel which is equal to a number of jiffies per second. It's a common practice to use it where appropriate, in this case it will be:

	i2c_dev->adapter.timeout = 6 * HZ;

>  	i2c_dev->irq = irq;
>  	i2c_dev->cont_id = pdev->id;
>  	i2c_dev->dev = &pdev->dev;
> 

