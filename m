Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2121C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB552175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTkBFcCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBGN5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:57:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42399 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBGN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:57:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so9349538lja.9;
        Thu, 07 Feb 2019 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H8eun2gZF0tIUTZHXU9a/GtSajz9edw7PikIRV6bDlI=;
        b=aTkBFcCH2nJjtTmM3YfNkaPfOlRZyGAyL89FkSzhlM9xtFxbMDJtpDu1RNTNiLE3uG
         byEJngBzfAQq7n2pB2nFNxkZSYDQ7kGpuH0kBkf0uQDbLt+M0+IZFYz/V5Mx4m6PGMMh
         pGTfDSuK7JXVjwRarfrnXvRyFLFGRehgqFLLFCyVHridy+B8o1jcMM/kF+pym4ckUPZy
         IHlZ0jnACOAFhjidg2jGmOsSaOgBJN9P9rjvwxPPIpDKEL+DDaYejfNlBEgFyi7nx18m
         5VXpMy77YRva2SH8yZy6gswhcqmUiqG1s4sx1SIHGoy1g/gRs+1rZ4rLwp149XWWqmjq
         2i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H8eun2gZF0tIUTZHXU9a/GtSajz9edw7PikIRV6bDlI=;
        b=nyccpUx5xg80obHKnY9LNPSbdg/l0f+2juxIxmPvReVgbuxH/a9tu0SP7A/OllJ2mr
         jm+1UYWpdx4CSlHWfsbsEHYlUY6M3c/+hrCQ8LTkLe2lzO5/9ApLomFUIovZVeMsvR7I
         VqHvTkMhmdDEBDINnFd0hKmKee5/H0iLgplEPhKmcQP6IclpFUKDWBiwa0iZhMiFMb8m
         zBjvNNSfb4caSnntQoGmHKvtm1D+zBK/n5KDglF03lLVomqoOJSZK0UpwrHISeXPcvMA
         CBkYl8tbBPNL7hBrcqOI7pwS5xRamgFltLzN90Om+sr4umRpC4cWhSPIP0z32O1aA7ed
         kTow==
X-Gm-Message-State: AHQUAubIJFRiHrtg/eCxX2JWp/IHmMTCM2oA2VrgNypWPuLKLLuJcCMg
        Dw1OAqH6bGH0T1Mq6KBzYl5UhdSd
X-Google-Smtp-Source: AHgI3IZt5HkkxGK62KsD86khqaZaNTChN/JVNTqU373h0A7MCjjd9tunZGWEdV09Q7hXL566UMyQ5g==
X-Received: by 2002:a2e:b1cb:: with SMTP id e11-v6mr6683351lja.67.1549547862564;
        Thu, 07 Feb 2019 05:57:42 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id p13sm2065521lfp.35.2019.02.07.05.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 05:57:41 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <32b0b694-f912-044e-1a50-55b9c355d0c3@gmail.com>
Date:   Thu, 7 Feb 2019 16:57:39 +0300
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
>  [V14] : Switched back to use dma_alloc_coherent as it guarentees contiguous device
> 	 dma address space.
> 	 Fixed FIFO Trigger level programming to construct value from scratch.
> 	 Previous versions does register read-modify-write without masking.
> 	 T20 has DVC offsets different to I2C. This version has fix to account DVC
> 	 offset during dma slave configuration.
>  [V13] : T20 has DVC used for some power controls. This version has fix for using
> 	 proper DVC register offsets for DMA programming incase when used in DMA
> 	 mode.
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
>  drivers/i2c/busses/i2c-tegra.c | 411 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 367 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 118b7023a0f4..fddfb46370e0 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -8,6 +8,8 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -44,6 +46,8 @@
>  #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
>  #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
>  #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2

I2C_FIFO_CONTROL_TX_TRIG_SHIFT and I2C_FIFO_CONTROL_RX_TRIG_SHIFT are not used anymore in the code, let's remove them.

> +#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
> +#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) << 2)
>  #define I2C_FIFO_STATUS				0x060
>  #define I2C_FIFO_STATUS_TX_MASK			0xF0
>  #define I2C_FIFO_STATUS_TX_SHIFT		4
> @@ -125,6 +129,16 @@
>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
>  
> +/* Packet header size in bytes */
> +#define I2C_PACKET_HEADER_SIZE			12
> +
> +/*
> + * Upto I2C_PIO_MODE_MAX_LEN bytes, controller will use PIO mode,
> + * above this, controller will use DMA to fill FIFO.
> + * MAX PIO len is 20 bytes excluding packet header.
> + */
> +#define I2C_PIO_MODE_MAX_LEN			32
> +
>  /*
>   * msg_end_type: The bus control which need to be send at end of transfer.
>   * @MSG_END_STOP: Send stop pulse at end of transfer.
> @@ -166,6 +180,7 @@ enum msg_end_type {
>   *		allowing 0 length transfers.
>   * @supports_bus_clear: Bus Clear support to recover from bus hang during
>   *		SDA stuck low from device for some unknown reasons.
> + * @has_apb_dma: Support of APBDMA on corresponding Tegra chip.
>   */
>  struct tegra_i2c_hw_feature {
>  	bool has_continue_xfer_support;
> @@ -180,6 +195,7 @@ struct tegra_i2c_hw_feature {
>  	bool has_mst_fifo;
>  	const struct i2c_adapter_quirks *quirks;
>  	bool supports_bus_clear;
> +	bool has_apb_dma;
>  };
>  
>  /**
> @@ -191,6 +207,7 @@ struct tegra_i2c_hw_feature {
>   * @fast_clk: clock reference for fast clock of I2C controller
>   * @rst: reset control for the I2C controller
>   * @base: ioremapped registers cookie
> + * @base_phys: Physical base address of the I2C controller
>   * @cont_id: I2C controller ID, used for packet header
>   * @irq: IRQ number of transfer complete interrupt
>   * @irq_disabled: used to track whether or not the interrupt is enabled
> @@ -204,6 +221,13 @@ struct tegra_i2c_hw_feature {
>   * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
>   * @is_multimaster_mode: track if I2C controller is in multi-master mode
>   * @xfer_lock: lock to serialize transfer submission and processing
> + * @tx_dma_chan: DMA transmit channel
> + * @rx_dma_chan: DMA receive channel
> + * @dma_phys: handle to DMA resources
> + * @dma_buf: pointer to allocated DMA buffer
> + * @dma_buf_size: DMA buffer size
> + * @is_curr_dma_xfer: indicates active DMA transfer
> + * @dma_complete: DMA completion notifier
>   */
>  struct tegra_i2c_dev {
>  	struct device *dev;
> @@ -213,6 +237,7 @@ struct tegra_i2c_dev {
>  	struct clk *fast_clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> +	phys_addr_t base_phys;
>  	int cont_id;
>  	int irq;
>  	bool irq_disabled;
> @@ -226,6 +251,13 @@ struct tegra_i2c_dev {
>  	u16 clk_divisor_non_hs_mode;
>  	bool is_multimaster_mode;
>  	spinlock_t xfer_lock;
> +	struct dma_chan *tx_dma_chan;
> +	struct dma_chan *rx_dma_chan;
> +	dma_addr_t dma_phys;
> +	u32 *dma_buf;
> +	unsigned int dma_buf_size;
> +	bool is_curr_dma_xfer;
> +	struct completion dma_complete;
>  };
>  
>  static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
> @@ -294,6 +326,109 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
>  	i2c_writel(i2c_dev, int_mask, I2C_INT_MASK);
>  }
>  
> +static void tegra_i2c_dma_complete(void *args)
> +{
> +	struct tegra_i2c_dev *i2c_dev = args;
> +
> +	complete(&i2c_dev->dma_complete);
> +}
> +
> +static int tegra_i2c_dma_submit(struct tegra_i2c_dev *i2c_dev, size_t len)
> +{
> +	struct dma_async_tx_descriptor *dma_desc;
> +	enum dma_transfer_direction dir;
> +	struct dma_chan *chan;
> +
> +	dev_dbg(i2c_dev->dev, "starting DMA for length: %zu\n", len);
> +	reinit_completion(&i2c_dev->dma_complete);
> +	dir = i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
> +	chan = i2c_dev->msg_read ? i2c_dev->rx_dma_chan : i2c_dev->tx_dma_chan;
> +	dma_desc = dmaengine_prep_slave_single(chan, i2c_dev->dma_phys,
> +					       len, dir, DMA_PREP_INTERRUPT |
> +					       DMA_CTRL_ACK);
> +	if (!dma_desc) {
> +		dev_err(i2c_dev->dev, "failed to get DMA descriptor\n");
> +		return -EINVAL;
> +	}
> +
> +	dma_desc->callback = tegra_i2c_dma_complete;
> +	dma_desc->callback_param = i2c_dev;
> +	dmaengine_submit(dma_desc);
> +	dma_async_issue_pending(chan);
> +	return 0;
> +}
> +
> +static void tegra_i2c_release_dma(struct tegra_i2c_dev *i2c_dev)
> +{
> +	if (i2c_dev->dma_buf) {
> +		dma_free_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
> +				  i2c_dev->dma_buf, i2c_dev->dma_phys);
> +		i2c_dev->dma_buf = NULL;
> +	}
> +
> +	if (i2c_dev->tx_dma_chan) {
> +		dma_release_channel(i2c_dev->tx_dma_chan);
> +		i2c_dev->tx_dma_chan = NULL;
> +	}
> +
> +	if (i2c_dev->rx_dma_chan) {
> +		dma_release_channel(i2c_dev->rx_dma_chan);
> +		i2c_dev->rx_dma_chan = NULL;
> +	}
> +}
> +
> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
> +{
> +	struct dma_chan *chan;
> +	u32 *dma_buf;
> +	dma_addr_t dma_phys;
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA) ||
> +	    !i2c_dev->hw->has_apb_dma) {
> +		err = -ENODEV;
> +		goto err_out;
> +	}
> +
> +	chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
> +	if (IS_ERR(chan)) {
> +		err = PTR_ERR(chan);
> +		goto err_out;
> +	}
> +
> +	i2c_dev->rx_dma_chan = chan;
> +
> +	chan = dma_request_slave_channel_reason(i2c_dev->dev, "tx");
> +	if (IS_ERR(chan)) {
> +		err = PTR_ERR(chan);
> +		goto err_out;
> +	}
> +
> +	i2c_dev->tx_dma_chan = chan;
> +
> +	dma_buf = dma_alloc_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
> +				     &dma_phys, GFP_KERNEL | __GFP_NOWARN);
> +	if (!dma_buf) {
> +		dev_err(i2c_dev->dev, "failed to allocate the DMA buffer\n");
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	i2c_dev->dma_buf = dma_buf;
> +	i2c_dev->dma_phys = dma_phys;
> +	return 0;
> +
> +err_out:
> +	tegra_i2c_release_dma(i2c_dev);
> +	if (err != -EPROBE_DEFER) {
> +		dev_err(i2c_dev->dev, "can't use DMA, err: %d, using PIO\n",
> +			err);
> +		return 0;
> +	}
> +
> +	return err;
> +}
> +
>  static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
>  {
>  	unsigned long timeout = jiffies + HZ;
> @@ -571,16 +706,6 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
>  		i2c_writel(i2c_dev, 0x00, I2C_SL_ADDR2);
>  	}
>  
> -	if (i2c_dev->hw->has_mst_fifo) {
> -		val = I2C_MST_FIFO_CONTROL_TX_TRIG(8) |
> -		      I2C_MST_FIFO_CONTROL_RX_TRIG(1);
> -		i2c_writel(i2c_dev, val, I2C_MST_FIFO_CONTROL);
> -	} else {
> -		val = 7 << I2C_FIFO_CONTROL_TX_TRIG_SHIFT |
> -			0 << I2C_FIFO_CONTROL_RX_TRIG_SHIFT;
> -		i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
> -	}
> -
>  	err = tegra_i2c_flush_fifos(i2c_dev);
>  	if (err)
>  		goto err;
> @@ -660,25 +785,37 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>  	if (i2c_dev->hw->supports_bus_clear && (status & I2C_INT_BUS_CLR_DONE))
>  		goto err;
>  
> -	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
> -		if (i2c_dev->msg_buf_remaining)
> -			tegra_i2c_empty_rx_fifo(i2c_dev);
> -		else
> -			BUG();
> -	}
> +	if (!i2c_dev->is_curr_dma_xfer) {
> +		if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
> +			if (i2c_dev->msg_buf_remaining)
> +				tegra_i2c_empty_rx_fifo(i2c_dev);
> +			else
> +				BUG();
> +		}
>  
> -	if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
> -		if (i2c_dev->msg_buf_remaining)
> -			tegra_i2c_fill_tx_fifo(i2c_dev);
> -		else
> -			tegra_i2c_mask_irq(i2c_dev, I2C_INT_TX_FIFO_DATA_REQ);
> +		if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
> +			if (i2c_dev->msg_buf_remaining)
> +				tegra_i2c_fill_tx_fifo(i2c_dev);
> +			else
> +				tegra_i2c_mask_irq(i2c_dev,
> +						   I2C_INT_TX_FIFO_DATA_REQ);
> +		}
>  	}
>  
>  	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
>  	if (i2c_dev->is_dvc)
>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
>  
> +	/*
> +	 * During message read XFER_COMPLETE interrupt is triggered prior to
> +	 * DMA completion and during message write XFER_COMPLETE interrupt is
> +	 * triggered after DMA completion.
> +	 * PACKETS_XFER_COMPLETE indicates completion of all bytes of transfer.
> +	 * so forcing msg_buf_remaining to 0 in DMA mode.
> +	 */
>  	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
> +		if (i2c_dev->is_curr_dma_xfer)
> +			i2c_dev->msg_buf_remaining = 0;
>  		BUG_ON(i2c_dev->msg_buf_remaining);
>  		complete(&i2c_dev->msg_complete);
>  	}
> @@ -694,12 +831,91 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>  	if (i2c_dev->is_dvc)
>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
>  
> +	if (i2c_dev->is_curr_dma_xfer) {
> +		if (i2c_dev->msg_read)
> +			dmaengine_terminate_async(i2c_dev->rx_dma_chan);
> +		else
> +			dmaengine_terminate_async(i2c_dev->tx_dma_chan);
> +
> +		complete(&i2c_dev->dma_complete);
> +	}
> +
>  	complete(&i2c_dev->msg_complete);
>  done:
>  	spin_unlock(&i2c_dev->xfer_lock);
>  	return IRQ_HANDLED;
>  }
>  
> +static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
> +				       size_t len)
> +{
> +	u32 val = 0, reg;
> +	u8 dma_burst = 0;
> +	struct dma_slave_config slv_config = {0};
> +	struct dma_chan *chan;
> +	int ret;
> +	unsigned long reg_offset;
> +
> +	if (i2c_dev->hw->has_mst_fifo)
> +		reg = I2C_MST_FIFO_CONTROL;
> +	else
> +		reg = I2C_FIFO_CONTROL;
> +
> +	if (i2c_dev->is_curr_dma_xfer) {
> +		if (len & 0xF)
> +			dma_burst = 1;
> +		else if (len & 0x10)
> +			dma_burst = 4;
> +		else
> +			dma_burst = 8;
> +
> +		if (i2c_dev->msg_read) {
> +			chan = i2c_dev->rx_dma_chan;
> +			reg_offset = tegra_i2c_reg_addr(i2c_dev, I2C_RX_FIFO);
> +			slv_config.src_addr = i2c_dev->base_phys + reg_offset;
> +			slv_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			slv_config.src_maxburst = dma_burst;
> +
> +			if (i2c_dev->hw->has_mst_fifo)
> +				val |= I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
> +			else
> +				val |= I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
> +		} else {
> +			chan = i2c_dev->tx_dma_chan;
> +			reg_offset = tegra_i2c_reg_addr(i2c_dev, I2C_TX_FIFO);
> +			slv_config.dst_addr = i2c_dev->base_phys + reg_offset;
> +			slv_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			slv_config.dst_maxburst = dma_burst;
> +
> +			if (i2c_dev->hw->has_mst_fifo)
> +				val |= I2C_MST_FIFO_CONTROL_TX_TRIG(dma_burst);
> +			else
> +				val |= I2C_FIFO_CONTROL_TX_TRIG(dma_burst);
> +		}
> +
> +		slv_config.device_fc = true;
> +		ret = dmaengine_slave_config(chan, &slv_config);
> +		if (ret < 0) {
> +			dev_err(i2c_dev->dev, "DMA slave config failed: %d\n",
> +				ret);
> +			dev_err(i2c_dev->dev, "fallbacking to PIO\n");
> +			tegra_i2c_release_dma(i2c_dev);
> +			i2c_dev->is_curr_dma_xfer = false;
> +		} else {
> +			goto out;
> +		}
> +	}
> +
> +	if (i2c_dev->hw->has_mst_fifo)
> +		val = I2C_MST_FIFO_CONTROL_TX_TRIG(8) |
> +		      I2C_MST_FIFO_CONTROL_RX_TRIG(1);
> +	else
> +		val = I2C_FIFO_CONTROL_TX_TRIG(8) |
> +		      I2C_FIFO_CONTROL_RX_TRIG(1);
> +out:
> +	i2c_writel(i2c_dev, val, reg);
> +}
> +
>  static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
>  {
>  	int err;
> @@ -744,6 +960,10 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	u32 int_mask;
>  	unsigned long time_left;
>  	unsigned long flags;
> +	size_t xfer_size;
> +	u32 *buffer = NULL;
> +	int err = 0;
> +	bool dma;
>  
>  	tegra_i2c_flush_fifos(i2c_dev);
>  
> @@ -753,19 +973,58 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	i2c_dev->msg_read = (msg->flags & I2C_M_RD);
>  	reinit_completion(&i2c_dev->msg_complete);
>  
> +	if (i2c_dev->msg_read)
> +		xfer_size = msg->len;
> +	else
> +		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
> +
> +	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> +	i2c_dev->is_curr_dma_xfer = (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
> +				    i2c_dev->dma_buf;
> +	tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
> +	dma = i2c_dev->is_curr_dma_xfer;
> +
>  	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
>  
>  	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
>  	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> +	if (dma) {
> +		if (i2c_dev->msg_read) {
> +			dma_sync_single_for_device(i2c_dev->dev,
> +						   i2c_dev->dma_phys,
> +						   xfer_size,
> +						   DMA_FROM_DEVICE);
> +			err = tegra_i2c_dma_submit(i2c_dev, xfer_size);
> +			if (err < 0) {
> +				dev_err(i2c_dev->dev,
> +					"starting RX DMA failed, err %d\n",
> +					err);
> +				goto unlock;
> +			}
> +
> +		} else {
> +			dma_sync_single_for_cpu(i2c_dev->dev,
> +						i2c_dev->dma_phys,
> +						xfer_size,
> +						DMA_TO_DEVICE);
> +			buffer = i2c_dev->dma_buf;
> +		}
> +	}
>  
>  	packet_header = (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
>  			PACKET_HEADER0_PROTOCOL_I2C |
>  			(i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
>  			(1 << PACKET_HEADER0_PACKET_ID_SHIFT);
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +	if (dma && !i2c_dev->msg_read)
> +		*buffer++ = packet_header;
> +	else
> +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
>  
>  	packet_header = msg->len - 1;
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +	if (dma && !i2c_dev->msg_read)
> +		*buffer++ = packet_header;
> +	else
> +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
>  
>  	packet_header = I2C_HEADER_IE_ENABLE;
>  	if (end_state == MSG_END_CONTINUE)
> @@ -782,23 +1041,81 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  		packet_header |= I2C_HEADER_CONT_ON_NAK;
>  	if (msg->flags & I2C_M_RD)
>  		packet_header |= I2C_HEADER_READ;
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> -
> -	if (!(msg->flags & I2C_M_RD))
> -		tegra_i2c_fill_tx_fifo(i2c_dev);
> +	if (dma && !i2c_dev->msg_read)
> +		*buffer++ = packet_header;
> +	else
> +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +
> +	if (!i2c_dev->msg_read) {
> +		if (dma) {
> +			memcpy(buffer, msg->buf, msg->len);

It became apparent to me that there is a problem here. The size of dma_buf is 4096 bytes and maximum message length is 4096 too, we have pushed 12 bytes packet_header to the buffer and now there are 4084 bytes left for the message in the buffer. Hence transfer of 4KB will cause buffer overflow and either crash kernel or corrupt memory. One solution is to just always push packet_header using PIO, other to reduce max_write_len or increase dma_buf size.

[snip]
