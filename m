Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECABC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F1F20823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbR6sq9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfBCP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:27:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44265 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfBCP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:27:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so1350432pgk.11;
        Sun, 03 Feb 2019 07:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nmwf7aYSRgCDy54Jkz6FLEN4aLHpnfQ2PvYMA0ZcYvA=;
        b=qbR6sq9v6JJDogzCt7uRLLDd/pOa5nslgFnJcwhqNKICOoHbHmdFKyX5n2MZ0kdOJR
         rrIS1L/UJG+YzRt5QjnwsOQvvhTzTJt2omyOCqHoFJZhPmKfB5pD1y47s4Gy9NQ5Ovra
         qxGGNSjqJqvfCbggPMh+hwyv2FLrYQqnw2G0YP/gd1F6qnCEuuHFU35N8Oy1ThH0hMHV
         S6gzTT+eSSk7t3gt1soOL3mfJ7HNze/V7HV6SzYHneAC6OtEozjhrivr8IkUfMv/WkjB
         blkwMC9D5YdYAThaQgw31ZPTZEuEh2/0bqV94qb8SJ6XS5EGMNPsANkFNjWYw1oiN3OH
         wehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nmwf7aYSRgCDy54Jkz6FLEN4aLHpnfQ2PvYMA0ZcYvA=;
        b=GDnzRVVqZ3Kv/zzQA2mH31fwruzLW2zqsUokTr/cVjdF6snB9hF7DNVA3yMKjQ69gG
         +2JlQqb999wY5vAtx8KMqIA5CCfl/MpPEquutDoHaaHImpFp/Mi/mUhHTCiX7TGXIx84
         9qoPOy/MTJm0Twe0uAUDgu/NgY2e4QqdDJutarhAysu9uAWsOThDGFLcrh23IGMwhXWm
         OzgwoS6pCRDfOgiwkmPbGiy/wcjZajMXDgLbgt/PEH6kr2HpeafBQ+VzOxB4y7n2/Cyt
         vL+zq0ZlvPM1XWvVoODsEXgMQVZbA1UAe+mdzmsgk1rwTkHCNgRyJhYBXs3ymfQaIrM1
         BJrA==
X-Gm-Message-State: AHQUAuavS8SGbeOIuIkN05RFOrER5/BBFTMc3KLLQE+cwM2m97z7GujX
        FJfaVzyzkkC/yOKEheIsJ4wTh8g3
X-Google-Smtp-Source: AHgI3IbN27vW2ym8mA/gSpNoGI5s2c0KNT4CQ7PFCJu2UOSKAqjQiynWZivK6rm+HRuRI5WNHWhOJg==
X-Received: by 2002:a63:c0f:: with SMTP id b15mr9860805pgl.314.1549207665099;
        Sun, 03 Feb 2019 07:27:45 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id w10sm20114228pgi.81.2019.02.03.07.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 07:27:44 -0800 (PST)
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <467a3ac8-5667-66bf-50eb-7d21a103d901@gmail.com>
Message-ID: <3243523d-07e0-9942-3e9b-6bae2131c3a1@gmail.com>
Date:   Sun, 3 Feb 2019 18:27:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <467a3ac8-5667-66bf-50eb-7d21a103d901@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.02.2019 17:47, Dmitry Osipenko пишет:
> 01.02.2019 20:07, Sowjanya Komatineni пишет:
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
>>  [V9] : Rebased to 5.0-rc4
>> 	Removed dependency of APB DMA in Kconfig and added conditional check
>> 	in I2C driver to decide on using DMA mode.
>> 	Changed back the allocation of dma buffer during i2c probe.
>> 	Fixed FIFO triggers depending on DMA Vs PIO.
>>  [V8] : Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLETE
>> 	interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
>> 	other fixes
>> 	Updated Kconfig for APB_DMA dependency
>>  [V7] : Same as V6
>>  [V6] : Updated for proper buffer allocation/freeing, channel release.
>> 	Updated to use exact xfer size for syncing dma buffer.
>>  [V5] : Same as V4
>>  [V4] : Updated to allocate DMA buffer only when DMA mode.
>> 	Updated to fall back to PIO mode when DMA channel request or
>> 	buffer allocation fails.
>>  [V3] : Updated without additional buffer allocation.
>>  [V2] : Updated based on V1 review feedback along with code cleanup for
>> 	proper implementation of DMA.
>>
>>  drivers/i2c/busses/i2c-tegra.c | 368 +++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 335 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
>> index 118b7023a0f4..ac8009c35863 100644
>> --- a/drivers/i2c/busses/i2c-tegra.c
>> +++ b/drivers/i2c/busses/i2c-tegra.c
>> @@ -8,6 +8,9 @@
>>  
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dmapool.h>
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
>> +#define DATA_DMA_DIR_TX				(1 << 0)
>> +#define DATA_DMA_DIR_RX				(1 << 1)
>> +
>> +/*
>> + * Upto I2C_PIO_MODE_MAX_LEN bytes, controller will use PIO mode,
>> + * above this, controller will use DMA to fill FIFO.
>> + * MAX PIO len is 20 bytes excluding packet header.
>> + */
>> +#define I2C_PIO_MODE_MAX_LEN			32
>> +
>>  /*
>>   * msg_end_type: The bus control which need to be send at end of transfer.
>>   * @MSG_END_STOP: Send stop pulse at end of transfer.
>> @@ -191,6 +209,7 @@ struct tegra_i2c_hw_feature {
>>   * @fast_clk: clock reference for fast clock of I2C controller
>>   * @rst: reset control for the I2C controller
>>   * @base: ioremapped registers cookie
>> + * @base_phys: Physical base address of the I2C controller
>>   * @cont_id: I2C controller ID, used for packet header
>>   * @irq: IRQ number of transfer complete interrupt
>>   * @irq_disabled: used to track whether or not the interrupt is enabled
>> @@ -204,6 +223,13 @@ struct tegra_i2c_hw_feature {
>>   * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
>>   * @is_multimaster_mode: track if I2C controller is in multi-master mode
>>   * @xfer_lock: lock to serialize transfer submission and processing
>> + * @tx_dma_chan: DMA transmit channel
>> + * @rx_dma_chan: DMA receive channel
>> + * @dma_phys: handle to DMA resources
>> + * @dma_buf: pointer to allocated DMA buffer
>> + * @dma_buf_size: DMA buffer size
>> + * @is_curr_dma_xfer: indicates active DMA transfer
>> + * @dma_complete: DMA completion notifier
>>   */
>>  struct tegra_i2c_dev {
>>  	struct device *dev;
>> @@ -213,6 +239,7 @@ struct tegra_i2c_dev {
>>  	struct clk *fast_clk;
>>  	struct reset_control *rst;
>>  	void __iomem *base;
>> +	phys_addr_t base_phys;
>>  	int cont_id;
>>  	int irq;
>>  	bool irq_disabled;
>> @@ -226,6 +253,13 @@ struct tegra_i2c_dev {
>>  	u16 clk_divisor_non_hs_mode;
>>  	bool is_multimaster_mode;
>>  	spinlock_t xfer_lock;
>> +	struct dma_chan *tx_dma_chan;
>> +	struct dma_chan *rx_dma_chan;
>> +	dma_addr_t dma_phys;
>> +	u32 *dma_buf;
>> +	unsigned int dma_buf_size;
>> +	bool is_curr_dma_xfer;
>> +	struct completion dma_complete;
>>  };
>>  
>>  static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
>> @@ -294,6 +328,86 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
>>  	i2c_writel(i2c_dev, int_mask, I2C_INT_MASK);
>>  }
>>  
>> +static void tegra_i2c_dma_complete(void *args)
>> +{
>> +	struct tegra_i2c_dev *i2c_dev = args;
>> +
>> +	complete(&i2c_dev->dma_complete);
>> +}
>> +
>> +static int tegra_i2c_dma_submit(struct tegra_i2c_dev *i2c_dev, size_t len)
>> +{
>> +	struct dma_async_tx_descriptor *dma_desc;
>> +	enum dma_transfer_direction dir;
>> +	struct dma_chan *chan;
>> +
>> +	dev_dbg(i2c_dev->dev, "starting DMA for length: %zu\n", len);
>> +	reinit_completion(&i2c_dev->dma_complete);
>> +	dir = i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
>> +	chan = i2c_dev->msg_read ? i2c_dev->rx_dma_chan : i2c_dev->tx_dma_chan;
>> +	dma_desc = dmaengine_prep_slave_single(chan, i2c_dev->dma_phys,
>> +					       len, dir, DMA_PREP_INTERRUPT |
>> +					       DMA_CTRL_ACK);
>> +	if (!dma_desc) {
>> +		dev_err(i2c_dev->dev, "failed to get DMA descriptor\n");
>> +		return -EIO;
>> +	}
>> +
>> +	dma_desc->callback = tegra_i2c_dma_complete;
>> +	dma_desc->callback_param = i2c_dev;
>> +	dmaengine_submit(dma_desc);
>> +	dma_async_issue_pending(chan);
>> +	return 0;
>> +}
>> +
>> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
>> +{
>> +	struct dma_chan *dma_chan;
>> +	u32 *dma_buf;
>> +	dma_addr_t dma_phys;
>> +	int err = 0;
>> +
>> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>> +		return -ENODEV;
>> +
>> +	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
>> +	if (IS_ERR(dma_chan))
>> +		return PTR_ERR(dma_chan);
>> +
>> +	i2c_dev->rx_dma_chan = dma_chan;
>> +
>> +	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, "tx");
>> +	if (IS_ERR(dma_chan)) {
>> +		err = PTR_ERR(dma_chan);
>> +		goto error;
>> +	}
>> +
>> +	i2c_dev->tx_dma_chan = dma_chan;
>> +
>> +	dma_buf = dma_alloc_coherent(i2c_dev->dev,
>> +				     i2c_dev->dma_buf_size, &dma_phys,
>> +				     GFP_KERNEL | __GFP_NOWARN);
>> +
>> +	if (!dma_buf) {
>> +		dev_err(i2c_dev->dev, "failed to allocate the DMA buffer\n");
>> +		err = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	i2c_dev->dma_buf = dma_buf;
>> +	i2c_dev->dma_phys = dma_phys;
>> +	return 0;
>> +
>> +error:
>> +	if (i2c_dev->tx_dma_chan)
>> +		dma_release_channel(i2c_dev->tx_dma_chan);
>> +
>> +	if (i2c_dev->rx_dma_chan)
>> +		dma_release_channel(i2c_dev->rx_dma_chan);
>> +
>> +	return err;
>> +}
>> +
>>  static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
>>  {
>>  	unsigned long timeout = jiffies + HZ;
>> @@ -571,16 +685,6 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
>>  		i2c_writel(i2c_dev, 0x00, I2C_SL_ADDR2);
>>  	}
>>  
>> -	if (i2c_dev->hw->has_mst_fifo) {
>> -		val = I2C_MST_FIFO_CONTROL_TX_TRIG(8) |
>> -		      I2C_MST_FIFO_CONTROL_RX_TRIG(1);
>> -		i2c_writel(i2c_dev, val, I2C_MST_FIFO_CONTROL);
>> -	} else {
>> -		val = 7 << I2C_FIFO_CONTROL_TX_TRIG_SHIFT |
>> -			0 << I2C_FIFO_CONTROL_RX_TRIG_SHIFT;
>> -		i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
>> -	}
>> -
>>  	err = tegra_i2c_flush_fifos(i2c_dev);
>>  	if (err)
>>  		goto err;
>> @@ -660,25 +764,37 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>>  	if (i2c_dev->hw->supports_bus_clear && (status & I2C_INT_BUS_CLR_DONE))
>>  		goto err;
>>  
>> -	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
>> -		if (i2c_dev->msg_buf_remaining)
>> -			tegra_i2c_empty_rx_fifo(i2c_dev);
>> -		else
>> -			BUG();
>> -	}
>> +	if (!i2c_dev->is_curr_dma_xfer) {
>> +		if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
>> +			if (i2c_dev->msg_buf_remaining)
>> +				tegra_i2c_empty_rx_fifo(i2c_dev);
>> +			else
>> +				BUG();
>> +		}
>>  
>> -	if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
>> -		if (i2c_dev->msg_buf_remaining)
>> -			tegra_i2c_fill_tx_fifo(i2c_dev);
>> -		else
>> -			tegra_i2c_mask_irq(i2c_dev, I2C_INT_TX_FIFO_DATA_REQ);
>> +		if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
>> +			if (i2c_dev->msg_buf_remaining)
>> +				tegra_i2c_fill_tx_fifo(i2c_dev);
>> +			else
>> +				tegra_i2c_mask_irq(i2c_dev,
>> +						   I2C_INT_TX_FIFO_DATA_REQ);
>> +		}
>>  	}
>>  
>>  	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
>>  	if (i2c_dev->is_dvc)
>>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
>>  
>> +	/*
>> +	 * During message read XFER_COMPLETE interrupt is triggered prior to
>> +	 * DMA completion and during message write XFER_COMPLETE interrupt is
>> +	 * triggered after DMA completion.
>> +	 * PACKETS_XFER_COMPLETE indicates completion of all bytes of transfer.
>> +	 * so forcing msg_buf_remaining to 0 in DMA mode.
>> +	 */
>>  	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
>> +		if (i2c_dev->is_curr_dma_xfer)
>> +			i2c_dev->msg_buf_remaining = 0;
>>  		BUG_ON(i2c_dev->msg_buf_remaining);
>>  		complete(&i2c_dev->msg_complete);
>>  	}
>> @@ -694,12 +810,69 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>>  	if (i2c_dev->is_dvc)
>>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
>>  
>> +	if (i2c_dev->is_curr_dma_xfer) {
>> +		if (i2c_dev->msg_read)
>> +			dmaengine_terminate_all(i2c_dev->rx_dma_chan);
>> +		else
>> +			dmaengine_terminate_all(i2c_dev->tx_dma_chan);
>> +
>> +		complete(&i2c_dev->dma_complete);
>> +	}
>> +
>>  	complete(&i2c_dev->msg_complete);
>>  done:
>>  	spin_unlock(&i2c_dev->xfer_lock);
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
>> +				       size_t len, int direction)
>> +{
>> +	u32 val, reg;
>> +	u8 dma_burst = 0;
>> +	struct dma_slave_config dma_sconfig;
> 
> This structure is allocated on stack, please initialize it to 0:
> 
> 	struct dma_slave_config dma_sconfig = { 0 };
> 
>> +	struct dma_chan *chan;
>> +
>> +	if (i2c_dev->hw->has_mst_fifo)
>> +		reg = I2C_MST_FIFO_CONTROL;
>> +	else
>> +		reg = I2C_FIFO_CONTROL;
>> +	val = i2c_readl(i2c_dev, reg);
>> +
>> +	if (len & 0xF)
>> +		dma_burst = 1;
>> +	else if (len & 0x10)
>> +		dma_burst = 4;
>> +	else
>> +		dma_burst = 8;
>> +
>> +	if (direction == DATA_DMA_DIR_TX) {
>> +		if (i2c_dev->hw->has_mst_fifo)
>> +			val |= I2C_MST_FIFO_CONTROL_TX_TRIG(dma_burst);
>> +		else
>> +			val |= I2C_FIFO_CONTROL_TX_TRIG(dma_burst);
>> +	} else {
>> +		if (i2c_dev->hw->has_mst_fifo)
>> +			val |= I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
>> +		else
>> +			val |= I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
>> +	}
>> +	i2c_writel(i2c_dev, val, reg);
>> +
>> +	if (direction == DATA_DMA_DIR_TX) {
>> +		dma_sconfig.dst_addr = i2c_dev->base_phys + I2C_TX_FIFO;
>> +		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +		dma_sconfig.dst_maxburst = dma_burst;
>> +	} else {
>> +		dma_sconfig.src_addr = i2c_dev->base_phys + I2C_RX_FIFO;
>> +		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +		dma_sconfig.src_maxburst = dma_burst;
>> +	}
>> +
>> +	chan = i2c_dev->msg_read ? i2c_dev->rx_dma_chan : i2c_dev->tx_dma_chan;

BTW, you could write this as:

	if (direction == DATA_DMA_DIR_TX)
		chan = i2c_dev->tx_dma_chan;
	else
		chan = i2c_dev->rx_dma_chan;

for consistency

>> +	dmaengine_slave_config(chan, &dma_sconfig);
>> +}


