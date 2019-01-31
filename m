Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7712EC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C2A20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5wOARGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfAaBiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:38:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37255 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfAaBiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:38:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so1090423lfj.4;
        Wed, 30 Jan 2019 17:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kUuOw4fFoiE8PZh9sthB+A3XZIWmU6c9UsbDiDGVH0M=;
        b=p5wOARGKAbYe0/JhQ5LeEC/12vxUUVQ2wcz41MZnB1/7kKYZzgw4U4YuJKorHw10/w
         I43NbyWtQty7KRsawYQ9hXFe11Hc064KzCAlA1WDfEQ5h3CoK1NbYhukroVcckvOalQA
         X1jdfHs1cFoxuipa3jRbFSoEuqszQHslispt/XZJ6J1NkxzLNJr0QIdxmNrF8dPFjt7s
         CkrQdrJM6QuY7rP+h7UevCUdSHMRnjibEzlYCV1d0u5WAs409BSSd5kg4Ybtt8YON9F5
         VNv9JsKa07fu1iwA8TP3NHuD4KHDzAvpG9v/1DzQcYu5/JMgxx/2BIopiURvh/xKwshV
         QBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUuOw4fFoiE8PZh9sthB+A3XZIWmU6c9UsbDiDGVH0M=;
        b=lt+KtS+lqsaFP9bZW+uup3TIwV91t7EUG6ihSWoaXjNFWcG8l9vITeT7dGgmwE4gOG
         y5lAY/oO0OLfkmolAINOZkQx46o//DQPesh+Koxd0sEpVrINz82Aiptqnbm2Ig/E4si+
         B6jloa6If4auYvxDch1f1pIavBYXZ2b3K1j/n9Ot59RW/uxArXSP7hZamYPaQyGZ8b65
         RTyQXXU7y4J1uupAXVMpzP2dfZ9ga3kRZ1tz/mz2YOOEF36ZXZ8/KazWi4Ii4tAXXtKo
         2I1CJd2T2RTjUTBiIh3fFsMfX96IKIaXJfWX5T3TyU26E327PEFGbUN3zNsSYKvtlr2H
         jiOg==
X-Gm-Message-State: AJcUukdExAkuyeNMk0q98O+97odGfBtjZkJQ4n52K80PzfCrfdUzDsjD
        fXOzlbeAYRZZjpodk3o1CMCSKmuj
X-Google-Smtp-Source: ALg8bN4u00Crv5tuV7rQl/pQdCnOKNAAWPI45sDqb1xnPgvBRUGhcWKHeEo408XX85RKJhjGHw2XfQ==
X-Received: by 2002:a19:26ce:: with SMTP id m197mr25277284lfm.23.1548898683738;
        Wed, 30 Jan 2019 17:38:03 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id b17-v6sm526992ljj.93.2019.01.30.17.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 17:38:02 -0800 (PST)
Subject: Re: [PATCH V7 4/5] i2c: tegra: Update transfer timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-4-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <80d5072c-b8b8-c263-bcda-ad008597469e@gmail.com>
Date:   Thu, 31 Jan 2019 04:38:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548864096-20974-4-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2019 19:01, Sowjanya Komatineni пишет:
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
> ---
>  [V5/V6/V7] : Same as V4
>  [V4] : V4 series includes bus clear support and this patch is updated with
> 	fixed timeout of 1sec for bus clear operation.
>  [V3] : Same as V2
>  [V2] : Added this patch in V2 series to allow enough time for data transfer
> 	to happen.
> 	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
> 	takes argument with this patch.
> 
>  drivers/i2c/busses/i2c-tegra.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index b30b5da5ce6b..623bf4f275cd 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -25,7 +25,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  
> -#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
> +#define TEGRA_I2C_TIMEOUT(ms) (msecs_to_jiffies(ms))
>  #define BYTES_PER_FIFO_WORD 4
>  
>  #define I2C_CNFG				0x000
> @@ -901,8 +901,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
>  		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
>  		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
>  
> -		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> -							TEGRA_I2C_TIMEOUT);
> +		time_left = wait_for_completion_timeout(
> +						&i2c_dev->msg_complete,
> +						TEGRA_I2C_TIMEOUT(1000));
>  		if (time_left == 0) {
>  			dev_err(i2c_dev->dev, "timed out for bus clear\n");
>  			return -ETIMEDOUT;
> @@ -929,6 +930,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	u32 *buffer = 0;
>  	int ret = 0;
>  	bool dma = false;
> +	u16 xfer_time = 100;
>  
>  	if (msg->flags & I2C_M_RD)
>  		xfer_size = msg->len;
> @@ -936,6 +938,9 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
>  
>  	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> +	xfer_time += DIV_ROUND_CLOSEST((xfer_size * 9) * 1000,
> +					i2c_dev->bus_clk_rate);

Could you please add a clarifying comment for the equation?

Shouldn't it be something like this?

xfer_time = (P clocks) * DIV_ROUND_UP(xfer_size, (N bytes per P clocks)) / (bus_clk_rate / 1000)

