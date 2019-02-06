Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E8AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAECD2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmaBTdsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfBFM70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:59:26 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42250 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfBFM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:59:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so5236024lfh.9;
        Wed, 06 Feb 2019 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8GB9BzsqzznYQNj66WgfYwgVXd2MYdMkYnPVJGXc27A=;
        b=ZmaBTdsQH26IVkpQ2ekJNf47qEtVpjuLRXUEKQ4qTVu3TL5uC23AHzjVh44pwc33uC
         HOnwLd0MbyqpcF/upQqa4As6awrVAvWVTKMWA9aefoKia8CAOUcWVcnDLvS68MYf232h
         gIHOp1+hnk0IGkI9oCPUW4jbRPfB6p11SKfWxzFnnk+ozWmOOeZyfpcShEJjjaQRimG7
         0NRnxOX8eicgZE0tEz0pdutf8iXpzR4G4g/YY3ur/ncAii31s6eTsZwOqtC7EEtzkp+m
         vhstR3idYwoubjBYgjHjIi75qg69eQq7a8WdYbCNtDVGeFS1hrZX+CfsE+4yRtjCXbba
         +yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8GB9BzsqzznYQNj66WgfYwgVXd2MYdMkYnPVJGXc27A=;
        b=OqYL8E7SkMKnNs7KDTEoL9NiMvVvugLkdVy5N/3rwMWW/+l7p0juLW/Ic+1ytgdOAa
         Us1Ic/rlnp2W7CC3MOI+E4TMHhiv32Sf1dWtfDOdHxj4Ce2T0kyDujJpl1ijvYLRjMO/
         jGAS3lhFsfIWzecLe/1/xZQu11tkFWBzsjiVD9ejyNod3EAlSOU07LS3PEjFvjG2xvU/
         g3O/QigI4FAgsLhfpbB9Ddscma4HVW2cbCUIQMkbbqLYD3Z3fwunowKSLucJmkSv/xDW
         o4oao/Q76maPPsNXEsReFDCHZQq5n0zUQqa0C79U+A5ymFtoOx6u0Ii+M2VMLXX2S+t7
         iyxg==
X-Gm-Message-State: AHQUAuZypoBoW4aOXYmrxg7Ia3vVC6hDG38/rnE39sYNfuBlaD8mQMWG
        eSXEOFOOnIpGHt61lRSpgHYG4JPR
X-Google-Smtp-Source: AHgI3Ia0t+XCBztlCswABYwRThdoDNWexFwABdbydKs5lS5aZcEFhHAMCUxhO9yk1JbHTlb7px3G/A==
X-Received: by 2002:ac2:5145:: with SMTP id q5mr6879892lfd.46.1549457958639;
        Wed, 06 Feb 2019 04:59:18 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id m18sm613773lfh.43.2019.02.06.04.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 04:59:17 -0800 (PST)
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
Message-ID: <c4f67e39-df72-cc56-216b-8e6014891b52@gmail.com>
Date:   Wed, 6 Feb 2019 15:59:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 14:55, Dmitry Osipenko пишет:
> 06.02.2019 1:46, Sowjanya Komatineni пишет:
>> This patch adds DMA support for Tegra I2C.
>>
>> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
>> transfer size of the max FIFO depth and DMA mode is used for
>> transfer size higher than max FIFO depth to save CPU overhead.
>>
>> PIO mode needs full intervention of CPU to fill or empty FIFO's
>> and also need to service multiple data requests interrupt for the
>> same transaction. This adds delay between data bytes of the same
>> transfer when CPU is fully loaded and some slave devices has
>> internal timeout for no bus activity and stops transaction to
>> avoid bus hang. DMA mode is helpful in such cases.
>>
>> DMA mode is also helpful for Large transfers during downloading or
>> uploading FW over I2C to some external devices.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  [V12] : Replaced dma_alloc_coherent with dma_alloc_attrs to force the allocated
>> 	 buffer to be contiguous also in physical memory as Tegra194 supports max
>> 	 64K and dma_alloc_coherent doesnt guarentee contiguous memory.
>> 	 Changed return code from EIO to EINVAL incase of failure to obtain dma
>> 	 descriptor.
>> 	 Fixed coding style check issues.	 
>>  [V11] : Replaced deprecated dmaengine_terminate_all with dmaengine_termine_async
>> 	 from non-atomic context and dmaengine_terminate_sync from atomic context.
>> 	 Fixed to program fifo trigger levels properly when transfer falls back to
>> 	 pio mode in case of dma slave configuration failure and other minor fixes.
>>  [V10] : APBDMA is replaced with GPCDMA on Tegra186 and Tegra194 designs.
>> 	 Added apbdma hw support flag to now allow Tegra186 and later use
>> 	 APBDMA driver.
>> 	 Added explicit flow control enable for DMA slave config and error handling.
>> 	 Moved releasing DMA resources to seperate function to reuse in
>> 	 multiple places.
>> 	 Updated to register tegra_i2c_driver from module level rather than subsys
>> 	 level.
>> 	 Other minor feedback
>>  [V9] :  Rebased to 5.0-rc4
>> 	 Removed dependency of APB DMA in Kconfig and added conditional check
>>  	 in I2C driver to decide on using DMA mode.
>> 	 Changed back the allocation of dma buffer during i2c probe.
>> 	 Fixed FIFO triggers depending on DMA Vs PIO.
>>  [V8] :  Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLETE
>> 	 interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
>> 	 other fixes
>> 	 Updated Kconfig for APB_DMA dependency
>>  [V7] :  Same as V6
>>  [V6] :  Updated for proper buffer allocation/freeing, channel release.
>> 	 Updated to use exact xfer size for syncing dma buffer.
>>  [V5] :  Same as V4
>>  [V4] :  Updated to allocate DMA buffer only when DMA mode.
>> 	 Updated to fall back to PIO mode when DMA channel request or
>> 	 buffer allocation fails.
>>  [V3] :  Updated without additional buffer allocation.
>>  [V2] :  Updated based on V1 review feedback along with code cleanup for
>> 	 proper implementation of DMA.
>>
>>
>>  drivers/i2c/busses/i2c-tegra.c | 413 ++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 369 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
>> index 118b7023a0f4..77277a09e485 100644
>> --- a/drivers/i2c/busses/i2c-tegra.c
>> +++ b/drivers/i2c/busses/i2c-tegra.c
>> @@ -8,6 +8,9 @@
>>  
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dmapool.h>
> 
> We are not using DMA pools anywhere in the code, <linux/dmapool.h> isn't needed. Let's remove it.
> 
>> +#include <linux/dma-mapping.h>
>>  #include <linux/err.h>
>>  #include <linux/i2c.h>
>>  #include <linux/init.h>
>> @@ -44,6 +47,8 @@
>>  #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
>>  #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
>>  #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
>> +#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
>> +#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) << 2)
>>  #define I2C_FIFO_STATUS				0x060
>>  #define I2C_FIFO_STATUS_TX_MASK			0xF0
>>  #define I2C_FIFO_STATUS_TX_SHIFT		4
>> @@ -125,6 +130,19 @@
>>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
>>  
>> +/* Packet header size in bytes */
>> +#define I2C_PACKET_HEADER_SIZE			12
>> +
>> +#define DATA_DMA_DIR_TX				BIT(0)
>> +#define DATA_DMA_DIR_RX				BIT(1)
> 
> The DATA_DMA_DIR_TX/RX are not used anywhere in the code, let's remove them.
> 
> [snip]
> 
> 		TEGRA_I2C_TIMEOUT);
>>  	tegra_i2c_mask_irq(i2c_dev, int_mask);
>> @@ -814,6 +1133,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>>  		time_left, completion_done(&i2c_dev->msg_complete),
>>  		i2c_dev->msg_err);
>>  
>> +	i2c_dev->is_curr_dma_xfer = false;
> 
> This line could be removed because there is no need to clear "is_curr_dma_xfer" at this point.
> 
>>  	if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
>>  		return 0;
> [snip]
> 
> 
> Sowjanya, I tried to enforce DMA transferring + setting DMA burst to a one word and this combination doesn't work well while it should, if I'm not missing something. Could you please take a look at the problem or explain why that happens?
> 
> Here is the change I made:
> 
> -----------------
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index c538ed5f8e2c..59e245d4417d 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -6,6 +6,8 @@
>   * Author: Colin Cross <ccross@android.com>
>   */
>  
> +#define DEBUG
> +
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
> @@ -929,12 +931,7 @@ static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
>         val = i2c_readl(i2c_dev, reg);
>  
>         if (i2c_dev->is_curr_dma_xfer) {
> -               if (len & 0xF)
>                         dma_burst = 1;
> -               else if (len & 0x10)
> -                       dma_burst = 4;
> -               else
> -                       dma_burst = 8;
>  
>                 if (i2c_dev->msg_read) {
>                         chan = i2c_dev->rx_dma_chan;
> @@ -1046,8 +1043,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>                 xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
>  
>         xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> -       i2c_dev->is_curr_dma_xfer = (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
> -                                   i2c_dev->dma_buf;
> +       i2c_dev->is_curr_dma_xfer = !!i2c_dev->dma_buf;
>         tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
>         dma = i2c_dev->is_curr_dma_xfer
> -----------------
> 
> And here what happens:
> 
> -----------------
> ...
> [    0.761144] tegra_rtc 7000e000.rtc: registered as rtc1
> [    0.761199] tegra_rtc 7000e000.rtc: Tegra internal Real Time Clock
> [    0.761406] i2c /dev entries driver
> [    0.919233] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.919246] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.919345] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.919355] tegra-i2c 7000c000.i2c: starting DMA for length: 8
> [    0.919363] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.919628] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.919641] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.919649] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.919746] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.919755] tegra-i2c 7000c000.i2c: starting DMA for length: 112
> [    0.919763] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.923140] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    0.923150] atmel_mxt_ts 0-004c: Family: 160 Variant: 0 Firmware V1.0.AA Objects: 18
> [    0.923208] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.923217] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.923314] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.923323] tegra-i2c 7000c000.i2c: starting DMA for length: 224
> [    0.923331] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.933564] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    0.933599] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.933609] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.933760] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.933770] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    0.933779] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.934284] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.934309] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.934317] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.934500] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.934509] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    0.934518] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.935023] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.935081] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.935091] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.935240] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.935249] tegra-i2c 7000c000.i2c: starting DMA for length: 4
> [    0.935258] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.935399] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.935416] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.935424] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.935655] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.945445] tegra-i2c 7000d000.i2c: starting DMA for length: 16
> [    0.945456] tegra-i2c 7000d000.i2c: unmasked irq: 0c
> [    0.969236] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.969245] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.969361] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.969370] tegra-i2c 7000c000.i2c: starting DMA for length: 4
> [    0.969379] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.969462] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.982587] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.982596] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.982722] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.982731] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    0.982740] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.983071] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.983090] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.983098] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.983252] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.983261] tegra-i2c 7000c000.i2c: starting DMA for length: 136
> [    0.983269] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.987605] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    0.987623] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.987631] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.987800] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.987809] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    0.987817] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.988324] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.009227] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    1.009236] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.009374] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.009383] tegra-i2c 7000c000.i2c: starting DMA for length: 4
> [    1.009391] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.009479] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.009497] atmel_mxt_ts 0-004c: Warning: Info CRC error - device=0xF436DC file=0x000000
> [    1.009588] tegra-i2c 7000c000.i2c: starting DMA for length: 272
> [    1.009597] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.017483] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    1.017496] tegra-i2c 7000c000.i2c: starting DMA for length: 120
> [    1.017504] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.020896] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    1.020909] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    1.020918] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.021055] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.032230] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    1.032239] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.032359] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.032368] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    1.032376] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.032704] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.049224] tegra-i2c 7000d000.i2c: i2c transfer timed out
> [    1.049253] tps6586x 3-0034: Chip ID read failed: -110
> [    1.049281] tps6586x: probe of 3-0034 failed with error -5
> ...
> -----------------
> 

BTW, I'm seeing "atmel_mxt_ts 0-004c: Warning: Info CRC error - device=0xF436DC file=0x000000" whithout making any modifications to the original patch as well and it shall not happen, hence there is bug somewhere. Probably FIFO triggers are still not set up correctly... ?


[    0.750883] tegra_rtc 7000e000.rtc: registered as rtc1
[    0.750937] tegra_rtc 7000e000.rtc: Tegra internal Real Time Clock
[    0.751137] i2c /dev entries driver
[    0.919076] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.919172] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.919181] tegra-i2c 7000c000.i2c: unmasked irq: 0d
[    0.919439] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.919453] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.919548] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.919559] tegra-i2c 7000c000.i2c: starting DMA for length: 112
[    0.919570] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.922934] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    0.922945] atmel_mxt_ts 0-004c: Family: 160 Variant: 0 Firmware V1.0.AA Objects: 18
[    0.923001] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.923098] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.923108] tegra-i2c 7000c000.i2c: starting DMA for length: 224
[    0.923116] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.933362] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    0.933397] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.933570] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.933581] tegra-i2c 7000c000.i2c: unmasked irq: 0d
[    0.934085] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.934108] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.934313] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.934323] tegra-i2c 7000c000.i2c: unmasked irq: 0d
[    0.934828] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.934875] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.935056] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.935066] tegra-i2c 7000c000.i2c: unmasked irq: 0d
[    0.935204] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.935221] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.935352] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.935436] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.935509] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.935518] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.935589] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.935599] tps6586x 3-0034: Found TPS658621C/D, VERSIONCRC is 2c
[    0.935712] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.935812] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.935827] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.935926] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.935939] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.936038] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.936051] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.936150] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.936163] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.936262] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.936275] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.936346] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.936355] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.936501] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.937319] REG-SYS: supplied by vdd_5v0
[    0.937505] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.937580] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.937589] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.937661] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.937674] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.937745] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.937754] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.937824] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.937843] REG-SM_0: supplied by vdd_sys
[    0.937900] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.937972] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.937981] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.938051] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938071] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.938142] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938151] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.938221] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938237] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.938308] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938317] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.938387] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938438] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.938511] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938520] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.938590] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938696] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.938767] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938776] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.938847] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938860] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.938931] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.938939] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.939010] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939029] REG-SM_1: supplied by vdd_sys
[    0.939124] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.939196] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939204] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.939276] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939294] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.939365] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939374] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.939445] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939459] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.939530] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939539] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.939610] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939656] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.939727] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939736] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.939806] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939897] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.939968] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.939977] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.940048] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940061] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.940132] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940140] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.940211] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940224] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.940295] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940304] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.940374] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940386] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.940485] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940504] REG-SM_2: supplied by vdd_sys
[    0.940561] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.940633] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940642] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.940713] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940731] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.940802] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940811] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.940881] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.940926] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.940997] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941006] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.941076] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941176] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.941247] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941256] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.941327] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941340] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.941411] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941420] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.941490] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941510] REG-LDO_0: supplied by vdd_sm2,vin_ldo*
[    0.941584] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.941657] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941666] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.941737] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941752] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.941823] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941832] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.941902] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.941943] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.942014] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942023] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.942094] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942180] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.942251] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942260] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.942331] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942344] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.942415] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942424] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.942494] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942506] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.942577] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942586] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.942656] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942668] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.942767] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942787] REG-LDO_1: supplied by vdd_sm2,vin_ldo*
[    0.942843] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.942914] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.942923] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.942994] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943008] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.943079] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943088] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.943158] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943177] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.943248] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943256] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.943327] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943379] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.943450] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943459] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.943530] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943627] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.943699] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943708] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.943780] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943792] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.943863] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943872] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.943943] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.943963] REG-LDO_2: supplied by vdd_sm2,vin_ldo*
[    0.944019] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.944091] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944100] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.944171] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944186] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.944257] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944265] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.944336] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944355] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.944426] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944434] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.944505] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944517] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.944616] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944631] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.944702] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944711] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.944783] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944834] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.944905] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.944914] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.944985] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945107] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.945178] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945187] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.945258] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945271] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.945341] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945350] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.945421] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945434] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.945504] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945513] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.945583] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945595] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.945694] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945714] REG-LDO_3: supplied by vdd_sm2,vin_ldo*
[    0.945776] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.945848] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945857] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.945928] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.945942] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.946013] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946022] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.946092] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946110] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.946181] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946189] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.946260] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946304] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.946376] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946384] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.946455] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946556] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.946628] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946637] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.946707] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946720] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.946791] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946800] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.946870] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946883] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.946954] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.946962] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.947033] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.947045] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.947144] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.947164] REG-LDO_4: supplied by vdd_sm2,vin_ldo*
[    0.947219] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.947291] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.947300] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.947371] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.947385] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.947456] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.947465] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.947536] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.947555] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.947625] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.947634] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.947704] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.947749] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.947820] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.947829] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.947900] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948015] REG-LDO_5: supplied by vdd_sys
[    0.948086] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.948157] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948166] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.948237] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948254] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.948325] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948334] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.948405] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948420] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.948491] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948500] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.948571] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948622] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.948693] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948702] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.948773] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948867] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.948938] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.948947] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.949019] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949032] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.949100] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949109] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.949177] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949198] REG-LDO_6: supplied by vdd_sm2,vin_ldo*
[    0.949254] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.949322] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949331] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.949399] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949413] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.949481] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949490] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.949557] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949564] vdd_ldo6,avdd_vdac: Bringing 2850000uV into 1800000-1800000uV
[    0.949591] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.949659] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949668] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.949735] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949748] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.949816] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949824] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.949892] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949905] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.949973] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.949981] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.950050] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950063] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.950130] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950139] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.950206] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950218] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.950314] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950359] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.950427] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950436] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.950503] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950602] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.950671] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950680] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.950748] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950760] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.950827] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950836] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.950903] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.950923] REG-LDO_7: supplied by vdd_sm2,vin_ldo*
[    0.950995] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.951064] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951073] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.951141] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951155] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.951223] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951231] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.951299] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951351] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.951418] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951427] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.951495] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951588] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.951657] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951666] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.951725] random: fast init done
[    0.951734] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951751] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.951820] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951829] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.951897] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.951917] REG-LDO_8: supplied by vdd_sm2,vin_ldo*
[    0.951975] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.952044] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952053] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.952122] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952136] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.952204] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952213] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.952280] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952324] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.952393] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952401] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.952469] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952574] REG-LDO_9: supplied by vdd_sm2,vin_ldo*
[    0.952630] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.952699] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952708] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.952775] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952797] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.952865] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952874] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.952941] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.952958] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.953026] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.953035] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.953102] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.953147] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.953216] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.953225] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.953292] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.953423] REG-LDO_RTC: supplied by vdd_sys
[    0.953486] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.953554] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.953563] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.953631] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.953675] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.953743] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.953752] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.953820] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.953985] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.954082] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.954096] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.954191] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.954203] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.954300] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.954312] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.954407] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.954419] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.954515] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.954682] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.954750] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.954759] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.954826] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.954883] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.954979] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.954991] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.955087] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.955099] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.955195] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.955208] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.955304] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.955316] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.955412] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.955453] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.955549] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.955561] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.955657] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.955669] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.955765] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.955777] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.955873] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.955885] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.955981] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.955996] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.956063] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.956072] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.956262] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.956277] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.956346] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.956355] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.956471] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.956487] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.956554] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.956563] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.956754] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.956910] tps6586x-rtc tps6586x-rtc: registered as rtc0
[    0.958265] i2c i2c-1: Added multiplexed i2c bus 4
[    0.958663] i2c i2c-1: Added multiplexed i2c bus 5
[    0.958804] usbcore: registered new interface driver uvcvideo
[    0.958822] USB Video Class driver (1.1.1)
[    0.958836] gspca_main: v2.14.0 registered
[    0.960393] lm90 3-004c: 3-004c supply vcc not found, using dummy regulator
[    0.960464] lm90 3-004c: Linked as a consumer to regulator.0
[    0.960504] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.960577] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.960587] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.960655] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.960667] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.960763] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.960774] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.960842] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.960850] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.960918] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961182] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.961251] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961260] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.961329] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961340] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.961408] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961417] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.961484] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961495] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.961564] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961572] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.961640] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961650] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.961718] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961727] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.961794] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961805] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.961873] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961881] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.961948] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.961959] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.962026] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962035] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.962103] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962114] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.962182] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962190] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.962258] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962269] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.962336] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962345] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.962412] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962423] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.962490] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962499] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.962566] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962576] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.962645] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962654] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.962722] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962733] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.962801] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962809] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.962877] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962888] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.962955] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.962963] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.963031] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963042] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.963110] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963118] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.963185] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963196] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.963264] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963272] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.963340] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963350] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.963418] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963426] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.963493] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963504] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.963571] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963579] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.963647] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963657] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.963725] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.963733] tegra-i2c 7000d000.i2c: unmasked irq: 0d
[    0.963801] tegra-i2c 7000d000.i2c: transfer complete: 10 0 0
[    0.964667] sdhci: Secure Digital Host Controller Interface driver
[    0.964689] sdhci: Copyright(c) Pierre Ossman
[    0.964703] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.965011] sdhci-tegra c8000000.sdhci: allocated mmc-pwrseq
[    0.969090] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.969244] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.969253] tegra-i2c 7000c000.i2c: unmasked irq: 0d
[    0.969341] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.973187] sdhci-tegra c8000000.sdhci: Linked as a consumer to regulator.4
[    0.973328] mmc0: Invalid maximum block size, assuming 512 bytes
[    0.982401] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.982536] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.982545] tegra-i2c 7000c000.i2c: unmasked irq: 0d
[    0.982874] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.982895] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.983067] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.983078] tegra-i2c 7000c000.i2c: starting DMA for length: 136
[    0.983088] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.987427] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    0.987446] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.987613] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.987622] tegra-i2c 7000c000.i2c: unmasked irq: 0d
[    0.988127] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.009076] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.009224] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.009233] tegra-i2c 7000c000.i2c: unmasked irq: 0d
[    1.009322] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.009339] atmel_mxt_ts 0-004c: Warning: Info CRC error - device=0xF436DC file=0x000000
[    1.009428] tegra-i2c 7000c000.i2c: starting DMA for length: 272
[    1.009437] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.017331] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    1.017345] tegra-i2c 7000c000.i2c: starting DMA for length: 120

