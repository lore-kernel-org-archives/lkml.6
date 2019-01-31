Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37713C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C705D20823
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKAUPKD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfAaAF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:05:57 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46346 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfAaAF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:05:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id f5so917777lfc.13;
        Wed, 30 Jan 2019 16:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iFOM1nsEYWxxFVtiHnbI5k+yv+JyZrmzejIzdmoqAKQ=;
        b=oKAUPKD0YEiPUw9SsHEK9f8Rp/21ncS4w9EpRRVTaDB2q1w09/z/L6GZrRoy1Zcm1e
         4EsA3Ce+7rt5AJxPlLT04JHnLXfs3Ew0sjpervHQk708poKjwX31WmKxrskFQrIpMSLU
         NmhMuZba+ZyB6xXx9LxvJWmEHzJKd9oBT1vdd6Ko9WIEFiq/HzJd6mMeFDNkrqDLjF2Y
         ftuoaceHekCHJ3yFqhHjDEUfb04A1uyFwNu/eTAbIvv4rHwR0UKVk6uhW3VKq/AtpGSA
         g+0aBC5H9a3drSBoU/+31FllD/YI5ngJl3YbLMOWxcGlhwvGntDU2OOP3FBH8TBhqZTf
         YduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iFOM1nsEYWxxFVtiHnbI5k+yv+JyZrmzejIzdmoqAKQ=;
        b=lAeLz6DIUJn1c0edUFOVoblG005tC3cUldipv2HoncRr+dRlL0nL17QrDJd42zrx4V
         OT/r1Ba43r1xRITQhctbfNMwBA64xY1K30k9YdMnbFf1G8DDIUys1d83/AdzqnN0ln5U
         2PL7YxoIAogxhzJnszaDRaSJf5TsSIjdKAZ5LDuElaErybLT9l1LDDsYj/0mNf9BZlpK
         CF4quxN8FU6YJbzU5XjydIXJ7Doior6Kx+lZTXlqC+tUaUHryTmDHPx3L56+P0OiE8kh
         AOkR4RsiuEixVltIH6vhacFXCGwocAqv+qIoyshg6GLcBx4akcI0Is1eQjlkUCD4jWxF
         uDww==
X-Gm-Message-State: AJcUukcWptserSshccmAefEnrCjJ/n5PRGyvmhbcpGFF7QGaR/zP8ElB
        N8CJWQ8wSm8PoOQQE6jUFweJ8PLR
X-Google-Smtp-Source: ALg8bN6d3L2ScSV4c8PpjYagQXu2dqpjqSgc0HqV3eM9nlVhlJpdxJogIZOG8YhlK24GIgXaSLkoqw==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr26747328lfj.12.1548893151257;
        Wed, 30 Jan 2019 16:05:51 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id c133sm577014lfc.45.2019.01.30.16.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:05:50 -0800 (PST)
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
Date:   Thu, 31 Jan 2019 03:05:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2019 19:01, Sowjanya Komatineni пишет:
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
>  [V7] : Same as V6
>  [V6] : Updated for proper buffer allocation/freeing, channel release.
> 	Updated to use exact xfer size for syncing dma buffer.
>  [V5] : Same as V4
>  [V4] : Updated to allocate DMA buffer only when DMA mode.
> 	Updated to fall back to PIO mode when DMA channel request or
> 	buffer allocation fails.
>  [V3] : Updated without additional buffer allocation.
>  [V2] : Updated based on V1 review feedback along with code cleanup for
> 	proper implementation of DMA.
> 
>  drivers/i2c/busses/i2c-tegra.c | 370 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 345 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index c4892a47a483..b30b5da5ce6b 100644
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
> +#define DATA_DMA_DIR_TX				(1 << 0)
> +#define DATA_DMA_DIR_RX				(1 << 1)
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
> @@ -188,6 +206,7 @@ struct tegra_i2c_hw_feature {
>   * @fast_clk: clock reference for fast clock of I2C controller
>   * @rst: reset control for the I2C controller
>   * @base: ioremapped registers cookie
> + * @phys_addr: Physical address of I2C base address to use for DMA configuration
>   * @cont_id: I2C controller ID, used for packet header
>   * @irq: IRQ number of transfer complete interrupt
>   * @irq_disabled: used to track whether or not the interrupt is enabled
> @@ -201,6 +220,14 @@ struct tegra_i2c_hw_feature {
>   * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
>   * @is_multimaster_mode: track if I2C controller is in multi-master mode
>   * @xfer_lock: lock to serialize transfer submission and processing
> + * @has_dma: indicates if DMA can be utilized based on dma DT bindings
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
> @@ -210,6 +237,7 @@ struct tegra_i2c_dev {
>  	struct clk *fast_clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> +	phys_addr_t phys_addr;

What about to rename "phys_addr" to "base_phys"?

>  	int cont_id;
>  	int irq;
>  	bool irq_disabled;
> @@ -223,8 +251,18 @@ struct tegra_i2c_dev {
>  	u16 clk_divisor_non_hs_mode;
>  	bool is_multimaster_mode;
>  	spinlock_t xfer_lock;
> +	bool has_dma;
> +	struct dma_chan *tx_dma_chan;
> +	struct dma_chan *rx_dma_chan;
> +	dma_addr_t dma_phys;
> +	u32 *dma_buf;
> +	unsigned int dma_buf_size;
> +	bool is_curr_dma_xfer;
> +	struct completion dma_complete;
>  };
>  
> +static struct dma_chan *chan;

This driver is shared among multiple I2C device instances, hence they all share the global variable. Please don't do it, you may assume that global variables are prohibited for this driver. It should be fine to move out "*chan" into "struct tegra_i2c_dev".

> +
>  static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
>  		       unsigned long reg)
>  {
> @@ -291,6 +329,82 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
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
> +
> +	dev_dbg(i2c_dev->dev, "Starting DMA for length: %zu\n", len);
> +	reinit_completion(&i2c_dev->dma_complete);
> +	dir = i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
> +	dma_desc = dmaengine_prep_slave_single(chan, i2c_dev->dma_phys,
> +					       len, dir, DMA_PREP_INTERRUPT |
> +					       DMA_CTRL_ACK);
> +	if (!dma_desc) {
> +		dev_err(i2c_dev->dev, "Failed to get DMA descriptor\n");

Most of messages in the driver start with a lowercase letter, let's try to keep them more or less consistent.

> +		return -EIO;
> +	}
> +
> +	dma_desc->callback = tegra_i2c_dma_complete;
> +	dma_desc->callback_param = i2c_dev;
> +	dmaengine_submit(dma_desc);
> +	dma_async_issue_pending(chan);
> +	return 0;
> +}
> +
> +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
> +				    bool dma_to_memory)
> +{
> +	struct dma_chan *dma_chan;
> +	u32 *dma_buf;
> +	dma_addr_t dma_phys;
> +	int ret;
> +	const char *chan_name = dma_to_memory ? "rx" : "tx";

What about to move out chan_name into the function arguments?

> +
> +	if (!i2c_dev->has_dma)
> +		return -EINVAL;
> +
> +	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, chan_name);
> +	if (IS_ERR(dma_chan)) {
> +		dev_err(i2c_dev->dev, "DMA Channel not available\n");
> +		return PTR_ERR(dma_chan);
> +	}
> +
> +	if (!i2c_dev->dma_buf) {
> +		dma_buf = dma_alloc_coherent(i2c_dev->dev,
> +					     i2c_dev->dma_buf_size,
> +					     &dma_phys, GFP_KERNEL);
> +
> +		if (!dma_buf) {
> +			dev_err(i2c_dev->dev,
> +				"Failed to allocate the DMA buffer\n");
> +			ret = -ENOMEM;
> +			goto scrub;
> +		}
> +
> +		i2c_dev->dma_buf = dma_buf;
> +		i2c_dev->dma_phys = dma_phys;
> +	}
> +
> +	if (dma_to_memory)
> +		i2c_dev->rx_dma_chan = dma_chan;
> +	else
> +		i2c_dev->tx_dma_chan = dma_chan;
> +
> +	return 0;
> +
> +scrub:
> +	dma_release_channel(dma_chan);
> +	return ret;
> +}
> +
>  static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
>  {
>  	unsigned long timeout = jiffies + HZ;
> @@ -656,25 +770,45 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
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
> +		if (!i2c_dev->msg_read &&
> +		   (status & I2C_INT_TX_FIFO_DATA_REQ)) {
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
> -	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
> +	if (status & I2C_INT_ALL_PACKETS_XFER_COMPLETE) {

I2C_INT_ALL_PACKETS_XFER_COMPLETE shall be masked for the PIO mode.

> +	/*
> +	 * During message read XFER_COMPLETE interrupt is triggered prior to
> +	 * DMA complete notification and during message write XFER_COMPLETE
> +	 * interrupt is triggered after DMA complete notification.
> +	 * PACKETS_XFER_COMPLETE indicates completion of all bytes of transfer.
> +	 * so forcing msg_buf_remaining to 0.
> +	 */
> +		if (i2c_dev->is_curr_dma_xfer)
> +			i2c_dev->msg_buf_remaining = 0;
> +		status |= I2C_INT_PACKET_XFER_COMPLETE;
> +		i2c_writel(i2c_dev, status, I2C_INT_STATUS);
> +		if (!i2c_dev->msg_buf_remaining)
> +			complete(&i2c_dev->msg_complete);
> +	} else if (status & I2C_INT_PACKET_XFER_COMPLETE) {

I2C_INT_PACKET_XFER_COMPLETE shall be masked for the DMA mode, if I'm not missing something.

> +		if (i2c_dev->is_curr_dma_xfer)
> +			i2c_dev->msg_buf_remaining = 0;
>  		BUG_ON(i2c_dev->msg_buf_remaining);
>  		complete(&i2c_dev->msg_complete);
>  	}
> @@ -683,19 +817,70 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>  	/* An error occurred, mask all interrupts */
>  	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
>  		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
> -		I2C_INT_RX_FIFO_DATA_REQ);
> +		I2C_INT_RX_FIFO_DATA_REQ | I2C_INT_ALL_PACKETS_XFER_COMPLETE);
>  	if (i2c_dev->hw->supports_bus_clear)
>  		tegra_i2c_mask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
>  	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
>  	if (i2c_dev->is_dvc)
>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
>  
> +	if (i2c_dev->is_curr_dma_xfer) {
> +		dmaengine_terminate_all(chan);
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
> +				       size_t len, int direction)
> +{
> +	u32 val, reg;
> +	u8 dma_burst = 0;
> +	struct dma_slave_config dma_sconfig;
> +
> +	if (i2c_dev->hw->has_mst_fifo)
> +		reg = I2C_MST_FIFO_CONTROL;
> +	else
> +		reg = I2C_FIFO_CONTROL;
> +	val = i2c_readl(i2c_dev, reg);
> +
> +	if (len & 0xF)
> +		dma_burst = 1;
> +	else if (len & 0x10)
> +		dma_burst = 4;
> +	else
> +		dma_burst = 8;
> +
> +	if (direction == DATA_DMA_DIR_TX) {
> +		if (i2c_dev->hw->has_mst_fifo)
> +			val |= I2C_MST_FIFO_CONTROL_TX_TRIG(dma_burst);
> +		else
> +			val |= I2C_FIFO_CONTROL_TX_TRIG(dma_burst);
> +	} else {
> +		if (i2c_dev->hw->has_mst_fifo)
> +			val |= I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
> +		else
> +			val |= I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
> +	}
> +	i2c_writel(i2c_dev, val, reg);
> +
> +	if (direction == DATA_DMA_DIR_TX) {
> +		dma_sconfig.dst_addr = i2c_dev->phys_addr + I2C_TX_FIFO;
> +		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		dma_sconfig.dst_maxburst = dma_burst;
> +	} else {
> +		dma_sconfig.src_addr = i2c_dev->phys_addr + I2C_RX_FIFO;
> +		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		dma_sconfig.src_maxburst = dma_burst;
> +	}
> +
> +	dmaengine_slave_config(chan, &dma_sconfig);
> +}
> +
>  static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
>  {
>  	int err;
> @@ -740,6 +925,32 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	u32 int_mask;
>  	unsigned long time_left;
>  	unsigned long flags;
> +	size_t xfer_size;
> +	u32 *buffer = 0;
> +	int ret = 0;
> +	bool dma = false;
> +
> +	if (msg->flags & I2C_M_RD)
> +		xfer_size = msg->len;
> +	else
> +		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
> +
> +	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> +	dma = (xfer_size > I2C_PIO_MODE_MAX_LEN);
> +	if (dma) {
> +		if ((msg->flags & I2C_M_RD) && !i2c_dev->rx_dma_chan)
> +			ret = tegra_i2c_init_dma_param(i2c_dev, true);
> +		else if (!i2c_dev->tx_dma_chan)
> +			ret = tegra_i2c_init_dma_param(i2c_dev, false);

In the comment to V3 I mentioned that it's not a good idea to request channels dynamically because suspend-resume order is based on devices registration order, in this case APB DMA must be probed before I2C. Please move channels allocation into the probe.

This also raises the question about the need to register I2C driver from the subsys-init level because APB driver is getting registered from the module-init level and hence I2C probing will be deferred until APB DMA driver is registered. It looks to me that the subsys-init is a relict of the past and it should be fine to move I2C driver registration into the module-init level, of course it's not strictly necessary and could be done later on if desired.

> +		if (ret < 0) {
> +			dev_dbg(i2c_dev->dev, "Switching to PIO mode\n");
> +			dma = false;
> +			ret = 0;
> +		}
> +	}
> +
> +	i2c_dev->is_curr_dma_xfer = dma;
>  
>  	tegra_i2c_flush_fifos(i2c_dev);
>  
> @@ -754,14 +965,50 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
>  	tegra_i2c_unmask_irq(i2c_dev, int_mask);
>  
> +	if (dma) {
> +		if (i2c_dev->msg_read) {
> +			chan = i2c_dev->rx_dma_chan;
> +			tegra_i2c_config_fifo_trig(i2c_dev, xfer_size,
> +						   DATA_DMA_DIR_RX);
> +			/* make the dma buffer to read by dma */

I think it should be better and more correct to rephrase like this: "prepare dma buffer to be written by device".

I'd also recommend to just drop comments for dma_sync_single_*() because the function naming is quite self-explanatory.

> +			dma_sync_single_for_device(i2c_dev->dev,
> +						   i2c_dev->dma_phys,
> +						   xfer_size,
> +						   DMA_FROM_DEVICE);
> +			ret = tegra_i2c_dma_submit(i2c_dev, xfer_size);
> +			if (ret < 0) {
> +				dev_err(i2c_dev->dev,
> +					"Starting RX DMA failed, err %d\n",
> +					ret);
> +				goto exit;
> +			}
> +		} else {
> +			chan = i2c_dev->tx_dma_chan;
> +			tegra_i2c_config_fifo_trig(i2c_dev, xfer_size,
> +						   DATA_DMA_DIR_TX);
> +			/* Make the dma buffer to read by cpu */> +			dma_sync_single_for_cpu(i2c_dev->dev,
> +						i2c_dev->dma_phys,
> +						xfer_size,
> +						DMA_TO_DEVICE);

This is not correct, you need to call dma_sync_single_for_cpu() after completion of the transfer to give back dma buffer ownership to CPU, see below. This dma_sync_single_for_cpu() invocation should be removed.

> +			buffer = (u32 *)i2c_dev->dma_buf;

The type of i2c_dev->dma_buf is u32, there is no need to cast it.

> +		}
> +	}
> +
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
> @@ -778,29 +1025,85 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  		packet_header |= I2C_HEADER_CONT_ON_NAK;
>  	if (msg->flags & I2C_M_RD)
>  		packet_header |= I2C_HEADER_READ;
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> -
> -	if (!(msg->flags & I2C_M_RD))
> -		tegra_i2c_fill_tx_fifo(i2c_dev);
> -
> +	if (dma && !i2c_dev->msg_read)
> +		*buffer++ = packet_header;
> +	else
> +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +
> +	if (!i2c_dev->msg_read) {
> +		if (dma) {
> +			memcpy(buffer, msg->buf, msg->len);
> +			/* make the dma buffer to read by dma */
> +			dma_sync_single_for_device(i2c_dev->dev,
> +						   i2c_dev->dma_phys,
> +						   xfer_size,
> +						   DMA_TO_DEVICE);
> +			ret = tegra_i2c_dma_submit(i2c_dev, xfer_size);
> +			if (ret < 0) {
> +				dev_err(i2c_dev->dev,
> +					"Starting TX DMA failed, err %d\n",
> +					ret);
> +				goto exit;
> +			}
> +		} else {
> +			tegra_i2c_fill_tx_fifo(i2c_dev);
> +		}
> +	}
>  	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
>  		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
> -	if (msg->flags & I2C_M_RD)
> -		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
> -	else if (i2c_dev->msg_buf_remaining)
> -		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
> +	if (dma) {
> +		int_mask |= I2C_INT_ALL_PACKETS_XFER_COMPLETE;
> +	} else {
> +		if (msg->flags & I2C_M_RD)
> +			int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
> +		else if (i2c_dev->msg_buf_remaining)
> +			int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
> +	}
>  
>  	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> -	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
>  	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
>  		i2c_readl(i2c_dev, I2C_INT_MASK));
>  
> +exit:

Minor nit: usually such labels are named as "unlock:"

> +	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> +	if (ret)
> +		return ret;
> +
> +	if (dma) {
> +		time_left = wait_for_completion_timeout(
> +						&i2c_dev->dma_complete,
> +						TEGRA_I2C_TIMEOUT);
> +
> +		if (time_left == 0) {
> +			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
> +			dmaengine_terminate_all(chan);
> +			tegra_i2c_init(i2c_dev);
> +			return -ETIMEDOUT;
> +		}

Handle the error-case here:

	if (i2c_dev->msg_err != I2C_ERR_NONE) {
		dev_err(i2c_dev->dev, "i2c dma transfer failed\n");
		goto i2c_recover;
	}

...
	<--- end of tegra_i2c_xfer_msg() -->

	if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
		return 0;

i2c_recover:
	tegra_i2c_init(i2c_dev);
	/* start recovery upon arbitration loss in single master mode */
	if (i2c_dev->msg_err == I2C_ERR_ARBITRATION_LOST) {
		if (!i2c_dev->is_multimaster_mode)
			return tegra_i2c_issue_bus_clear(i2c_dev);
		return -EAGAIN;
	}
	if (i2c_dev->msg_err == I2C_ERR_NO_ACK) {
		if (msg->flags & I2C_M_IGNORE_NAK)
			return 0;
		return -EREMOTEIO;
	}

	return -EIO;
}


> +
> +		if (i2c_dev->msg_read) {
> +			if (likely(i2c_dev->msg_err == I2C_ERR_NONE)) {
> +				dma_sync_single_for_cpu(i2c_dev->dev,
> +							i2c_dev->dma_phys,
> +							xfer_size,
> +							DMA_FROM_DEVICE);
> +
> +				memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf,
> +					msg->len);
> +			}
> +		}

Here you should give back dma buffer ownership to CPU:

		else {
			dma_sync_single_for_cpu(i2c_dev->dev,
						i2c_dev->dma_phys,
						xfer_size,
						DMA_TO_DEVICE);
		}

> +	}
> +
>  	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
>  						TEGRA_I2C_TIMEOUT);
>  	tegra_i2c_mask_irq(i2c_dev, int_mask);
>  
>  	if (time_left == 0) {
>  		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
> +		if (dma) {
> +			dmaengine_terminate_all(chan);
> +			complete(&i2c_dev->dma_complete);
> +		}

DMA transfer has been completed at this point, hence this hunk isn't needed. Please remove it.

>  
>  		tegra_i2c_init(i2c_dev);
>  		return -ETIMEDOUT;
> @@ -884,6 +1187,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
>  
>  	i2c_dev->is_multimaster_mode = of_property_read_bool(np,
>  			"multi-master");
> +
> +	i2c_dev->has_dma = of_property_read_bool(np, "dmas");

Not only the existence of "dmas" property defines whether DMA is available. DMA subsystem could be disabled in the kernels configuration.

Hence there is a need to check for DMA driver presence in the code:

	if (IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
		i2c_dev->has_dma = of_property_read_bool(np, "dmas");

Also Tegra I2C driver should select DMA driver in Kconfig to make DMA driver built-in when I2C driver is built-in:

config I2C_TEGRA
	tristate "NVIDIA Tegra internal I2C controller"
	depends on ARCH_TEGRA
	select TEGRA20_APB_DMA
	help
	  If you say yes to this option, support will be included for the
	  I2C controller embedded in NVIDIA Tegra SOCs


And apparently there is no APB DMA driver for T210+ in upstream yet.

>  }
>  
>  static const struct i2c_algorithm tegra_i2c_algo = {
> @@ -1002,11 +1307,13 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  	struct clk *div_clk;
>  	struct clk *fast_clk;
>  	void __iomem *base;
> +	phys_addr_t phys_addr;
>  	int irq;
>  	int ret = 0;
>  	int clk_multiplier = I2C_CLK_MULTIPLIER_STD_FAST_MODE;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	phys_addr = res->start;
>  	base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> @@ -1029,6 +1336,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	i2c_dev->base = base;
> +	i2c_dev->phys_addr = phys_addr;
>  	i2c_dev->div_clk = div_clk;
>  	i2c_dev->adapter.algo = &tegra_i2c_algo;
>  	i2c_dev->adapter.quirks = &tegra_i2c_quirks;
> @@ -1036,6 +1344,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  	i2c_dev->irq = irq;
>  	i2c_dev->cont_id = pdev->id;
>  	i2c_dev->dev = &pdev->dev;
> +	i2c_dev->dma_buf_size = i2c_dev->adapter.quirks->max_write_len;
>  
>  	i2c_dev->rst = devm_reset_control_get_exclusive(&pdev->dev, "i2c");
>  	if (IS_ERR(i2c_dev->rst)) {
> @@ -1049,6 +1358,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  	i2c_dev->is_dvc = of_device_is_compatible(pdev->dev.of_node,
>  						  "nvidia,tegra20-i2c-dvc");
>  	init_completion(&i2c_dev->msg_complete);
> +	init_completion(&i2c_dev->dma_complete);
>  	spin_lock_init(&i2c_dev->xfer_lock);
>  
>  	if (!i2c_dev->hw->has_single_clk_source) {
> @@ -1173,6 +1483,16 @@ static int tegra_i2c_remove(struct platform_device *pdev)
>  	if (!i2c_dev->hw->has_single_clk_source)
>  		clk_unprepare(i2c_dev->fast_clk);
>  
> +	if (i2c_dev->dma_buf)
> +		dma_free_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
> +				  i2c_dev->dma_buf, i2c_dev->dma_phys);
> +
> +	if (i2c_dev->tx_dma_chan)
> +		dma_release_channel(i2c_dev->tx_dma_chan);
> +
> +	if (i2c_dev->rx_dma_chan)
> +		dma_release_channel(i2c_dev->tx_dma_chan);

	dma_release_channel(i2c_dev->rx_dma_chan);

> +
>  	return 0;
>  }
>  
> 

