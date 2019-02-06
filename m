Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B28C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038EC20818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyJ3U1hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfBFMlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:41:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33912 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBFMlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:41:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so3036683plz.1;
        Wed, 06 Feb 2019 04:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YYer4zpYbls2ex7LYr90RG8sinzJO8SlWBfYpFy1zBM=;
        b=iyJ3U1hdh0YlQhPK8Fz/T5cXYAJy45JTFYp5gshji4jFNdD7gkY8zY+nDKMxLpCZXC
         cpmPlI0JG0X5bAdA5OGhBnAgcmrZDmAesuBzbUemyNkK8cOiOikB+s+aiJlMr6vGzNDf
         Ug/7JFk5ph5tCTtRSiUrqW6o9mOXH6bCN2wR4zDWihQgeSLNsWmSZlFlmc49QhoYqaOC
         p/IOGdjjXmz2NA4MqE096n7P7cPwneg1391K3K73JA+xzlfXdrBeOfWQTK06d6f8HDJM
         JBnWrAeU8cKVUOotBSuZrUmWP3cU8rbTawclseAJ3An9SRgOELPXBBJI3twUm8GXaMcR
         UPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YYer4zpYbls2ex7LYr90RG8sinzJO8SlWBfYpFy1zBM=;
        b=YnsCmFrUuBEszTHSEHiRfsm0/+8MjuziEx1IgudfDGCjH/JDYXxIznp+KV60+3ZXDE
         dKaHN2zWkWpE9XwU2d01NGfqS6AD+YDjrQtivVX58uYDIJXcp+KEzWuKFY5IOVxYFkO+
         jH6SxrXh9PBeRpXhdSc5fKyut+kZbX5WDRssKj/D2Shh4Ca665hpbwrQkMAN4moFqPlO
         0PJRDY93Qt/DZKzToVJBSLgt5e9hx7FfUhMWjrp90ySxHrzqgVhHTB9hNYuwf09HHo4L
         7nGxSN7dBGdMA8bnvzM46hh8jMAkeT4mkJ7uSJyzdmNK0gOg8e/mrSHO5e871DgHv6iP
         WLKA==
X-Gm-Message-State: AHQUAuZWkm1+L26bE+8mFPNYf3SSa4a0qYS30aHowFU0vQsMjxZvI12p
        94PKp/b7JwWSzkLqLVjH3N50hA3L
X-Google-Smtp-Source: AHgI3IbMhDpn+XmXYiIiP5d1PWId1q8im/4T30GgNtec07ZAQEbwcpRRCdnqe7o9YQfx1DhEZRPYdw==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7mr10631532plk.282.1549456862408;
        Wed, 06 Feb 2019 04:41:02 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id 85sm10060528pfw.17.2019.02.06.04.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 04:41:01 -0800 (PST)
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <feb6bb13-644f-0ac8-6c82-3771b5dba584@gmail.com>
Date:   Wed, 6 Feb 2019 15:40:52 +0300
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
> @@ -166,6 +184,7 @@ enum msg_end_type {
>   *		allowing 0 length transfers.
>   * @supports_bus_clear: Bus Clear support to recover from bus hang during
>   *		SDA stuck low from device for some unknown reasons.
> + * @has_apb_dma: Support of APBDMA on corresponding Tegra chip.
>   */
>  struct tegra_i2c_hw_feature {
>  	bool has_continue_xfer_support;
> @@ -180,6 +199,7 @@ struct tegra_i2c_hw_feature {
>  	bool has_mst_fifo;
>  	const struct i2c_adapter_quirks *quirks;
>  	bool supports_bus_clear;
> +	bool has_apb_dma;
>  };
>  
>  /**
> @@ -191,6 +211,7 @@ struct tegra_i2c_hw_feature {
>   * @fast_clk: clock reference for fast clock of I2C controller
>   * @rst: reset control for the I2C controller
>   * @base: ioremapped registers cookie
> + * @base_phys: Physical base address of the I2C controller
>   * @cont_id: I2C controller ID, used for packet header
>   * @irq: IRQ number of transfer complete interrupt
>   * @irq_disabled: used to track whether or not the interrupt is enabled
> @@ -204,6 +225,13 @@ struct tegra_i2c_hw_feature {
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
> @@ -213,6 +241,7 @@ struct tegra_i2c_dev {
>  	struct clk *fast_clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> +	phys_addr_t base_phys;
>  	int cont_id;
>  	int irq;
>  	bool irq_disabled;
> @@ -226,6 +255,13 @@ struct tegra_i2c_dev {
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
> @@ -294,6 +330,111 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
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
> +		dma_free_attrs(i2c_dev->dev, i2c_dev->dma_buf_size,
> +			       i2c_dev->dma_buf, i2c_dev->dma_phys,
> +			       DMA_ATTR_FORCE_CONTIGUOUS);
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
> +	dma_buf = dma_alloc_attrs(i2c_dev->dev, i2c_dev->dma_buf_size,
> +				  &dma_phys, GFP_KERNEL | __GFP_NOWARN,
> +				  DMA_ATTR_FORCE_CONTIGUOUS);
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
> @@ -571,16 +712,6 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
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
> @@ -660,25 +791,37 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
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
> @@ -694,12 +837,89 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
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
> +	u32 val, reg;
> +	u8 dma_burst = 0;
> +	struct dma_slave_config slv_config = {0};
> +	struct dma_chan *chan;
> +	int ret;
> +
> +	if (i2c_dev->hw->has_mst_fifo)
> +		reg = I2C_MST_FIFO_CONTROL;
> +	else
> +		reg = I2C_FIFO_CONTROL;
> +	val = i2c_readl(i2c_dev, reg);
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
> +			slv_config.src_addr = i2c_dev->base_phys + I2C_RX_FIFO;
> +			slv_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			slv_config.src_maxburst = dma_burst;
> +
> +			if (i2c_dev->hw->has_mst_fifo)
> +				val |= I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
> +			else
> +				val |= I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
> +		} else {
> +			chan = i2c_dev->tx_dma_chan;
> +			slv_config.dst_addr = i2c_dev->base_phys + I2C_TX_FIFO;
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
> @@ -744,6 +964,10 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
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
> @@ -753,19 +977,57 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
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

I'm now also wondering whether that putting packet_header into the dma_buf is really needed at all.. Isn't possible to push packet_header using PIO regardless of whether the rest of the transfer will be in DMA or PIO modes?

Actually I tried to always push packet_header using PIO and apparently DMA works just fine with that:

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c538ed5f8e2c..a2c4338336d0 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1040,12 +1040,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
        i2c_dev->msg_read = (msg->flags & I2C_M_RD);
        reinit_completion(&i2c_dev->msg_complete);
 
-       if (i2c_dev->msg_read)
-               xfer_size = msg->len;
-       else
-               xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
-
-       xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
+       xfer_size = ALIGN(msg->len, BYTES_PER_FIFO_WORD);
        i2c_dev->is_curr_dma_xfer = (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
                                    i2c_dev->dma_buf;
        tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
@@ -1088,16 +1083,10 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
                        PACKET_HEADER0_PROTOCOL_I2C |
                        (i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
                        (1 << PACKET_HEADER0_PACKET_ID_SHIFT);
-       if (dma && !i2c_dev->msg_read)
-               *buffer++ = packet_header;
-       else
-               i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+       i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
 
        packet_header = msg->len - 1;
-       if (dma && !i2c_dev->msg_read)
-               *buffer++ = packet_header;
-       else
-               i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+       i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
 
        packet_header = I2C_HEADER_IE_ENABLE;
        if (end_state == MSG_END_CONTINUE)
@@ -1114,10 +1103,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
                packet_header |= I2C_HEADER_CONT_ON_NAK;
        if (msg->flags & I2C_M_RD)
                packet_header |= I2C_HEADER_READ;
-       if (dma && !i2c_dev->msg_read)
-               *buffer++ = packet_header;
-       else
-               i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+       i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
 
        if (!msg->flags & I2C_M_RD) {
                if (dma) {
