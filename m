Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185C4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4C72184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPfq8J1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfBFLzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:55:14 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55846 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfBFLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:55:13 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so5584261ith.5;
        Wed, 06 Feb 2019 03:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vzz1KTEwenW6QHyFfutZeMrCHgh3NfK8fbj2fnhQT4I=;
        b=MPfq8J1fyG4aEb20kk7DhPVt7cepS36zAaN/oNbIcud8GSe2NHQ7KvQ1f4ASMaJxz3
         w5cTX6eLu9nCAmUe8tEhsr5OqWD2icrhEpflM4+wjmcOvwj3oq8eVdJBcLGFPen+rL7O
         yUWo7iKD9k8jRjldv3xU6+OxI1B+s+UUubOpDwFTnErN+nSDfhmuM/CF0I2tr5OQaJ+t
         NZxWDRqpUwQ8As+u8qLwiuW6PbHT6RyhWHvVpH8AN/md1sNMp0YLCxoDJXR8mcLTGAml
         8jbwVo/lD/ojFyFp6UNOQ+gRALAUGZ1BX56e/bLIV/PsezsBqQVfKjHcZ289ueGPYFJa
         Lw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vzz1KTEwenW6QHyFfutZeMrCHgh3NfK8fbj2fnhQT4I=;
        b=KINeSeVNGRCrI8fnXIdzlLbH0EgmIfAyCWD5LyA9hMe2Mtm73S8VCNLKGUloBfAhci
         veK7wG/hKII/t2rO675xw6pEMJ/dyAuO/etwLAZGuyYOu3eG6SsxXzrR08ZzS9oOXFc7
         kfRuF2e7UM57KgJEWut+CzW0B/pY4eZFQ7KqTBLasBPH2nUN/FNIS9zavi0PuVHal1Zs
         yhtEcI37Yf6n/1LxOXuRq7ZZsz02mIjZz55RFgRsQ0Tg5L7fqGMaxuxuw4DiwJ/6gMoB
         Uld+vEQkBWvrNyGR2q/kW8rGX+RVFORZlwE15WpM6kmTbRBiEnoVJvhCdGzsO1UODxNK
         JN0A==
X-Gm-Message-State: AHQUAubd2l2Jx5W5xiMB1FAxG3/g7XnUvJ/ELAuQSXEFaHnz+L6lWGVy
        ooYoe0zC4TVQY766LznHHhSZ5Kqu
X-Google-Smtp-Source: AHgI3IYk+NzwTX3JzrNVMCWnSy+AfdA1gCdpx2pO/ulL2N6dFC5spgigDpx6l4wDd7xxqYVJThd8Aw==
X-Received: by 2002:a5d:81c3:: with SMTP id t3mr6081718iol.93.1549454111918;
        Wed, 06 Feb 2019 03:55:11 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id d199sm3863599itd.31.2019.02.06.03.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 03:55:11 -0800 (PST)
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
Date:   Wed, 6 Feb 2019 14:55:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 1:46, Sowjanya Komatineni пишет:
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
>  [V12] : Replaced dma_alloc_coherent with dma_alloc_attrs to force the allocated
> 	 buffer to be contiguous also in physical memory as Tegra194 supports max
> 	 64K and dma_alloc_coherent doesnt guarentee contiguous memory.
> 	 Changed return code from EIO to EINVAL incase of failure to obtain dma
> 	 descriptor.
> 	 Fixed coding style check issues.	 
>  [V11] : Replaced deprecated dmaengine_terminate_all with dmaengine_termine_async
> 	 from non-atomic context and dmaengine_terminate_sync from atomic context.
> 	 Fixed to program fifo trigger levels properly when transfer falls back to
> 	 pio mode in case of dma slave configuration failure and other minor fixes.
>  [V10] : APBDMA is replaced with GPCDMA on Tegra186 and Tegra194 designs.
> 	 Added apbdma hw support flag to now allow Tegra186 and later use
> 	 APBDMA driver.
> 	 Added explicit flow control enable for DMA slave config and error handling.
> 	 Moved releasing DMA resources to seperate function to reuse in
> 	 multiple places.
> 	 Updated to register tegra_i2c_driver from module level rather than subsys
> 	 level.
> 	 Other minor feedback
>  [V9] :  Rebased to 5.0-rc4
> 	 Removed dependency of APB DMA in Kconfig and added conditional check
>  	 in I2C driver to decide on using DMA mode.
> 	 Changed back the allocation of dma buffer during i2c probe.
> 	 Fixed FIFO triggers depending on DMA Vs PIO.
>  [V8] :  Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLETE
> 	 interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
> 	 other fixes
> 	 Updated Kconfig for APB_DMA dependency
>  [V7] :  Same as V6
>  [V6] :  Updated for proper buffer allocation/freeing, channel release.
> 	 Updated to use exact xfer size for syncing dma buffer.
>  [V5] :  Same as V4
>  [V4] :  Updated to allocate DMA buffer only when DMA mode.
> 	 Updated to fall back to PIO mode when DMA channel request or
> 	 buffer allocation fails.
>  [V3] :  Updated without additional buffer allocation.
>  [V2] :  Updated based on V1 review feedback along with code cleanup for
> 	 proper implementation of DMA.
> 
> 
>  drivers/i2c/busses/i2c-tegra.c | 413 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 369 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 118b7023a0f4..77277a09e485 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -8,6 +8,9 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dmapool.h>

We are not using DMA pools anywhere in the code, <linux/dmapool.h> isn't needed. Let's remove it.

> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -44,6 +47,8 @@
>  #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
>  #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
>  #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
> +#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
> +#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) << 2)
>  #define I2C_FIFO_STATUS				0x060
>  #define I2C_FIFO_STATUS_TX_MASK			0xF0
>  #define I2C_FIFO_STATUS_TX_SHIFT		4
> @@ -125,6 +130,19 @@
>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
>  
> +/* Packet header size in bytes */
> +#define I2C_PACKET_HEADER_SIZE			12
> +
> +#define DATA_DMA_DIR_TX				BIT(0)
> +#define DATA_DMA_DIR_RX				BIT(1)

The DATA_DMA_DIR_TX/RX are not used anywhere in the code, let's remove them.

[snip]

		TEGRA_I2C_TIMEOUT);
>  	tegra_i2c_mask_irq(i2c_dev, int_mask);
> @@ -814,6 +1133,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  		time_left, completion_done(&i2c_dev->msg_complete),
>  		i2c_dev->msg_err);
>  
> +	i2c_dev->is_curr_dma_xfer = false;

This line could be removed because there is no need to clear "is_curr_dma_xfer" at this point.

>  	if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
>  		return 0;
[snip]


Sowjanya, I tried to enforce DMA transferring + setting DMA burst to a one word and this combination doesn't work well while it should, if I'm not missing something. Could you please take a look at the problem or explain why that happens?

Here is the change I made:

-----------------
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c538ed5f8e2c..59e245d4417d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -6,6 +6,8 @@
  * Author: Colin Cross <ccross@android.com>
  */
 
+#define DEBUG
+
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -929,12 +931,7 @@ static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
        val = i2c_readl(i2c_dev, reg);
 
        if (i2c_dev->is_curr_dma_xfer) {
-               if (len & 0xF)
                        dma_burst = 1;
-               else if (len & 0x10)
-                       dma_burst = 4;
-               else
-                       dma_burst = 8;
 
                if (i2c_dev->msg_read) {
                        chan = i2c_dev->rx_dma_chan;
@@ -1046,8 +1043,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
                xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
 
        xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
-       i2c_dev->is_curr_dma_xfer = (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
-                                   i2c_dev->dma_buf;
+       i2c_dev->is_curr_dma_xfer = !!i2c_dev->dma_buf;
        tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
        dma = i2c_dev->is_curr_dma_xfer
-----------------

And here what happens:

-----------------
...
[    0.761144] tegra_rtc 7000e000.rtc: registered as rtc1
[    0.761199] tegra_rtc 7000e000.rtc: Tegra internal Real Time Clock
[    0.761406] i2c /dev entries driver
[    0.919233] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.919246] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.919345] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.919355] tegra-i2c 7000c000.i2c: starting DMA for length: 8
[    0.919363] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.919628] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.919641] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.919649] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.919746] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.919755] tegra-i2c 7000c000.i2c: starting DMA for length: 112
[    0.919763] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.923140] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    0.923150] atmel_mxt_ts 0-004c: Family: 160 Variant: 0 Firmware V1.0.AA Objects: 18
[    0.923208] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.923217] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.923314] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.923323] tegra-i2c 7000c000.i2c: starting DMA for length: 224
[    0.923331] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.933564] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    0.933599] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.933609] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.933760] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.933770] tegra-i2c 7000c000.i2c: starting DMA for length: 12
[    0.933779] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.934284] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.934309] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.934317] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.934500] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.934509] tegra-i2c 7000c000.i2c: starting DMA for length: 12
[    0.934518] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.935023] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.935081] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.935091] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.935240] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.935249] tegra-i2c 7000c000.i2c: starting DMA for length: 4
[    0.935258] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.935399] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.935416] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.935424] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.935655] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.945445] tegra-i2c 7000d000.i2c: starting DMA for length: 16
[    0.945456] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    0.969236] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.969245] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.969361] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.969370] tegra-i2c 7000c000.i2c: starting DMA for length: 4
[    0.969379] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.969462] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.982587] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.982596] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.982722] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.982731] tegra-i2c 7000c000.i2c: starting DMA for length: 12
[    0.982740] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.983071] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.983090] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.983098] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.983252] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.983261] tegra-i2c 7000c000.i2c: starting DMA for length: 136
[    0.983269] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.987605] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    0.987623] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.987631] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.987800] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.987809] tegra-i2c 7000c000.i2c: starting DMA for length: 12
[    0.987817] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.988324] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.009227] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    1.009236] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.009374] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.009383] tegra-i2c 7000c000.i2c: starting DMA for length: 4
[    1.009391] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.009479] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.009497] atmel_mxt_ts 0-004c: Warning: Info CRC error - device=0xF436DC file=0x000000
[    1.009588] tegra-i2c 7000c000.i2c: starting DMA for length: 272
[    1.009597] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.017483] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    1.017496] tegra-i2c 7000c000.i2c: starting DMA for length: 120
[    1.017504] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.020896] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    1.020909] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    1.020918] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.021055] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.032230] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    1.032239] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.032359] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.032368] tegra-i2c 7000c000.i2c: starting DMA for length: 12
[    1.032376] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.032704] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.049224] tegra-i2c 7000d000.i2c: i2c transfer timed out
[    1.049253] tps6586x 3-0034: Chip ID read failed: -110
[    1.049281] tps6586x: probe of 3-0034 failed with error -5
...
-----------------
