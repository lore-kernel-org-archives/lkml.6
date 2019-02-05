Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150B6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA40B2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb7W/oh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBEGCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:02:40 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37104 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbfBEGCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:02:39 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so5589592iti.2;
        Mon, 04 Feb 2019 22:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n9kOzT9WMeX686La3jKzb9pb2RG9HuRLsp3vA1TXq8Q=;
        b=fb7W/oh/kMnmYbqgOhq05aYaJdQOon/IOqA0OwsbOzsdNgxz1iiNNM79D+q5ULG+Cw
         I2HRlefjtEL+EMZsQvyIbmgXvHJ7k3+8SrUafQDOBRumPb+Bq5d0rQZJK4ezGlOXoXle
         LNpG7QCAP2LtwIWyMtZ0gCyVXy+70uD18v22M97KaUfSIXWGx7+GtzAt9wsJieT8w2Mj
         B/H4KvKwSXJRDfQcDZKM3SwdzNQxtCPC0zTbjXqtd3V9T0VpSrUlGmY2vnmYRlmBu77A
         EIQx/9k2+HsXEXrdcbALs5N4xoXjwdmnatiWEkuDxqf3xOiYvGUCfZDLPrmZG5uHErDW
         U3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9kOzT9WMeX686La3jKzb9pb2RG9HuRLsp3vA1TXq8Q=;
        b=dvL7d9mGM8OSs33AvJXN400DKZfyFBsHQuA5x/7KCgRmNRIe4hZOgyTqschgfBvOB8
         MMU2/PtWCsvY4H5qsfbx5GPPGm8dBN18rjWpTICQROB2ulykMlnKox9FiFjt9djf27GQ
         FDi9Nptt7eBc9y7j88talF7oqtTK0JT0r9VzBsqvezOZ81O1fidVFqYr96OL+ii2bcbM
         Nmhx2z3WjGmedaw+RBxz5iC7PDfp8ENzmqpKieWSfvl5nmUczwevyDYzXnjfwz2QVWFF
         6TeNVv4Go75kgilGodPaeTyVGh2pHHYn5v5uJo4tnCSqiKkyP2OVjCv14MG3ydnp7YNx
         UiGQ==
X-Gm-Message-State: AHQUAua5rETjAMp08g7CPnjPNCGS8J6TgUov626CcdQuqupsudy3CVBr
        Og+rlVnzk/dr3UMT/ExD/pkiK7Is
X-Google-Smtp-Source: AHgI3IYaUFQLRDA0z8SQivgLGMo8HY3eLTaWzlWMHJ+5EzIhYK4NT/+ZrYkxG/XpqmVAhXz97UDDPQ==
X-Received: by 2002:a02:13c6:: with SMTP id 189mr1740265jaz.117.1549346557464;
        Mon, 04 Feb 2019 22:02:37 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id q14sm1063152itb.36.2019.02.04.22.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:02:36 -0800 (PST)
Subject: Re: [PATCH V10 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549330167-8690-1-git-send-email-skomatineni@nvidia.com>
 <1549330167-8690-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fdc076fb-ee99-31a0-93d0-331478421b47@gmail.com>
Date:   Tue, 5 Feb 2019 09:01:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549330167-8690-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.02.2019 4:29, Sowjanya Komatineni пишет:
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
>  [V10] : APBDMA is replaced with GPCDMA on Tegra186 and Tegra194 designs.
> 	Added apbdma hw support flag to now allow Tegra186 and later use
> 	APBDMA driver.
> 	Added explicit flow control enable for DMA slave config and error handling.
> 	Moved releasing DMA resources to seperate function to reuse in
> 	multiple places.
> 	Updated to register tegra_i2c_driver from module level rather than subsys
> 	level.
> 	Other minor feedback
>  [V9] : Rebased to 5.0-rc4
> 	Removed dependency of APB DMA in Kconfig and added conditional check
> 	in I2C driver to decide on using DMA mode.
> 	Changed back the allocation of dma buffer during i2c probe.
> 	Fixed FIFO triggers depending on DMA Vs PIO.
>  [V8] : Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLETE
> 	interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
> 	other fixes
> 	Updated Kconfig for APB_DMA dependency
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
>  drivers/i2c/busses/i2c-tegra.c | 404 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 360 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 118b7023a0f4..658cf01e3f59 100644
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
> @@ -294,6 +330,109 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
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
> +		return -EIO;

		return -EINVAL;

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
> +	int err = 0;
> +
> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA) ||
> +	   (!i2c_dev->hw->has_apb_dma)) {

Parens around !i2c_dev->hw->has_apb_dma are not needed.

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
> @@ -571,16 +710,6 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
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
> @@ -660,25 +789,37 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
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
> @@ -694,12 +835,87 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>  	if (i2c_dev->is_dvc)
>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
>  
> +	if (i2c_dev->is_curr_dma_xfer) {
> +		if (i2c_dev->msg_read)
> +			dmaengine_terminate_all(i2c_dev->rx_dma_chan);
> +		else
> +			dmaengine_terminate_all(i2c_dev->tx_dma_chan);

dmaengine_terminate_all() is deprecated, see include/linux/dmaengine.h

Please replace it with dmaengine_terminate_async().

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
> +static int tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
> +				      size_t len)
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
> +			dev_err(i2c_dev->dev,
> +				"DMA slave config failed, err: %d\n", ret);
> +			tegra_i2c_release_dma(i2c_dev);

So you're releasing DMA and then want to continue with PIO? In this case FIFO control will be left unconfigured

> +			return ret;
> +		}
> +	} else {

because the configuration happens here.

> +		if (i2c_dev->hw->has_mst_fifo)
> +			val = I2C_MST_FIFO_CONTROL_TX_TRIG(8) |
> +			      I2C_MST_FIFO_CONTROL_RX_TRIG(1);
> +		else
> +			val = I2C_FIFO_CONTROL_TX_TRIG(8) |
> +			      I2C_FIFO_CONTROL_RX_TRIG(1);
> +	}
> +
> +	i2c_writel(i2c_dev, val, reg);
> +	return 0;
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
> +	bool dma = false;
>  
>  	tegra_i2c_flush_fifos(i2c_dev);
>  
> @@ -753,19 +973,59 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	i2c_dev->msg_read = (msg->flags & I2C_M_RD);
>  	reinit_completion(&i2c_dev->msg_complete);
>  
> +	if (i2c_dev->msg_read)
> +		xfer_size = msg->len;
> +	else
> +		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
> +
> +	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> +	dma = (xfer_size > I2C_PIO_MODE_MAX_LEN) && i2c_dev->dma_buf;
> +	i2c_dev->is_curr_dma_xfer = dma;
> +
>  	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
>  
>  	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
>  	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> +	err = tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
> +	if (err < 0)
> +		i2c_dev->is_curr_dma_xfer = dma = false;
> +
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
>  
>  	packet_header = I2C_HEADER_IE_ENABLE;
>  	if (end_state == MSG_END_CONTINUE)
> @@ -782,23 +1042,74 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
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
> +	if (!msg->flags & I2C_M_RD) {
> +		if (dma) {
> +			memcpy(buffer, msg->buf, msg->len);
> +			dma_sync_single_for_device(i2c_dev->dev,
> +						   i2c_dev->dma_phys,
> +						   xfer_size,
> +						   DMA_TO_DEVICE);
> +			err = tegra_i2c_dma_submit(i2c_dev, xfer_size);
> +			if (err < 0) {
> +				dev_err(i2c_dev->dev,
> +					"starting TX DMA failed, err %d\n",
> +					err);
> +				goto unlock;
> +			}
> +		} else {
> +			tegra_i2c_fill_tx_fifo(i2c_dev);
> +		}
> +	}
>  
>  	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
>  		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
> -	if (msg->flags & I2C_M_RD)
> -		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
> -	else if (i2c_dev->msg_buf_remaining)
> -		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
> +
> +	if (!dma) {
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
> +unlock:
> +	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> +
> +	if (dma) {
> +		if (err)
> +			return err;
> +
> +		time_left = wait_for_completion_timeout(
> +						&i2c_dev->dma_complete,
> +						TEGRA_I2C_TIMEOUT);
> +
> +		if (time_left == 0) {
> +			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
> +			dmaengine_terminate_all(i2c_dev->msg_read ?
> +						i2c_dev->rx_dma_chan :
> +						i2c_dev->tx_dma_chan);

It's not an atomic context here, hence use the synchronous termination:

			dmaengine_terminate_sync(i2c_dev->msg_read ?
						 i2c_dev->rx_dma_chan :
						 i2c_dev->tx_dma_chan);

> +			tegra_i2c_init(i2c_dev);
> +			return -ETIMEDOUT;
> +		}
> +
> +		if (i2c_dev->msg_read && (i2c_dev->msg_err == I2C_ERR_NONE)) {

Parens around i2c_dev->msg_err == I2C_ERR_NONE are not needed.

> +			dma_sync_single_for_cpu(i2c_dev->dev,
> +						i2c_dev->dma_phys,
> +						xfer_size,
> +						DMA_FROM_DEVICE);
> +			memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf,
> +				msg->len);
> +		}

DMA terminates asynchronously in a case of error, hence need to synchronize it here.

		if (i2c_dev->msg_err != I2C_ERR_NONE)) {
			dmaengine_synchronize(i2c_dev->msg_read ?
					      i2c_dev->rx_dma_chan :
					      i2c_dev->tx_dma_chan);

> +	}
> +
>  	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
>  						TEGRA_I2C_TIMEOUT);
>  	tegra_i2c_mask_irq(i2c_dev, int_mask);
> @@ -920,6 +1231,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = false,
> +	.has_apb_dma = true,
>  };
>  
>  static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
> @@ -935,6 +1247,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = false,
> +	.has_apb_dma = true,
>  };
>  
>  static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
> @@ -950,6 +1263,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = true,
> +	.has_apb_dma = true,
>  };
>  
>  static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
> @@ -965,6 +1279,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = true,
> +	.has_apb_dma = true,
>  };
>  
>  static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
> @@ -980,6 +1295,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = true,
> +	.has_apb_dma = true,
>  };
>  
>  static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
> @@ -995,6 +1311,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
>  	.has_mst_fifo = true,
>  	.quirks = &tegra194_i2c_quirks,
>  	.supports_bus_clear = true,
> +	.has_apb_dma = false,
>  };
>  
>  /* Match table for of_platform binding */
> @@ -1017,11 +1334,13 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  	struct clk *div_clk;
>  	struct clk *fast_clk;
>  	void __iomem *base;
> +	phys_addr_t base_phys;
>  	int irq;
>  	int ret = 0;
>  	int clk_multiplier = I2C_CLK_MULTIPLIER_STD_FAST_MODE;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base_phys = res->start;
>  	base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> @@ -1044,6 +1363,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	i2c_dev->base = base;
> +	i2c_dev->base_phys = base_phys;
>  	i2c_dev->div_clk = div_clk;
>  	i2c_dev->adapter.algo = &tegra_i2c_algo;
>  	i2c_dev->adapter.retries = 1;
> @@ -1063,7 +1383,9 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  	i2c_dev->is_dvc = of_device_is_compatible(pdev->dev.of_node,
>  						  "nvidia,tegra20-i2c-dvc");
>  	i2c_dev->adapter.quirks = i2c_dev->hw->quirks;
> +	i2c_dev->dma_buf_size = i2c_dev->adapter.quirks->max_write_len;
>  	init_completion(&i2c_dev->msg_complete);
> +	init_completion(&i2c_dev->dma_complete);
>  	spin_lock_init(&i2c_dev->xfer_lock);
>  
>  	if (!i2c_dev->hw->has_single_clk_source) {
> @@ -1124,6 +1446,10 @@ static int tegra_i2c_probe(struct platform_device *pdev)
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
> @@ -1188,6 +1514,7 @@ static int tegra_i2c_remove(struct platform_device *pdev)
>  	if (!i2c_dev->hw->has_single_clk_source)
>  		clk_unprepare(i2c_dev->fast_clk);
>  
> +	tegra_i2c_release_dma(i2c_dev);
>  	return 0;
>  }
>  
> @@ -1211,18 +1538,7 @@ static struct platform_driver tegra_i2c_driver = {
>  	},
>  };
>  
> -static int __init tegra_i2c_init_driver(void)
> -{
> -	return platform_driver_register(&tegra_i2c_driver);
> -}
> -
> -static void __exit tegra_i2c_exit_driver(void)
> -{
> -	platform_driver_unregister(&tegra_i2c_driver);
> -}
> -
> -subsys_initcall(tegra_i2c_init_driver);
> -module_exit(tegra_i2c_exit_driver);
> +module_platform_driver(tegra_i2c_driver);
>  
>  MODULE_DESCRIPTION("nVidia Tegra2 I2C Bus Controller driver");
>  MODULE_AUTHOR("Colin Cross");
> 

