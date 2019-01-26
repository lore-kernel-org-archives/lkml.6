Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0493C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2B0218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyKbiyvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfAZAtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 19:49:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44750 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZAtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 19:49:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so9816444lji.11;
        Fri, 25 Jan 2019 16:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iGCRi/hU3ZzY5IaZLnPxIsHPf97Jyu0CsdYSUty2Yt0=;
        b=JyKbiyvbwLedKda0EXPkYFSOjzex115SbcoRjMScpPg0EbdOpsUdsm27YOvgEmQsje
         5v+0DY3NIHb8Sn07Q7leYcTcLP4SsthAXWMB3+0EOJ2/1fwGpY3koLSdme39kbyO+Xa3
         i7EpVIz4uiqtzdAltpbjw9AT1qPaJwIK3PJBPSGzhSVNZgtmvEhkt1G8Dx8M2o/eTNZg
         az6Mrsti/8dDYpZ4r7AoIVmqEF8mOh/NPKGIIgan+6+UHPkmhKa60I4VXQGs55b3yZ3c
         JnMbrARRc2EjyyktwXBYlfyskS8ZYzCmVAOLpVbEbv6SD1a96eY9ZqCvjBeRET22WFwm
         hZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGCRi/hU3ZzY5IaZLnPxIsHPf97Jyu0CsdYSUty2Yt0=;
        b=i/13Inh6sPP/ySLh+ZmT5rrPQXrv+9SfGibx1vCEv4Uzo47KvF+Do7QMmXbXEDYvP4
         aUYLz4OLhwEYGspN1/CybDbfgkNJaFBk4ay+ICkpaTskF2tC7pMPlqpKzIalrkwjVtBc
         fI8+G4RlD8nH+hrWAx8x8VcotWIO8/jE2JK9Xe/IIdyHwcPMkXzVL4L7FjneP8o6jncw
         57iioZUghxRdNH1evt4TJaHzjbtIPSKQ2VmPvQMAY7ETyHz0Kr1XPBWZUd98t9Q9/3T1
         IfQRLceGnpm8byIoxLkxS3ADQ3nm1UWlvtxBYTyX+ExMMWfzne05AckdjWK3o+fVVU+3
         Ctgw==
X-Gm-Message-State: AHQUAuY6/OpzqhgoomYfdR+MASWmBNYDsGnQAtLXdjdmbbLPpW0dt/Dr
        c1qIoReefX/o9N9vxis05+SyTrcb
X-Google-Smtp-Source: AHgI3IZCRKq2LvlTSnIzxepyfsvBjT3gC9HoYa8qCW6uniX3WrshgbuN286Nlh/bgqo7peyky3BRLQ==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr2082590ljj.18.1548463755811;
        Fri, 25 Jan 2019 16:49:15 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id k3-v6sm1790230lja.8.2019.01.25.16.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 16:49:14 -0800 (PST)
Subject: Re: [PATCH V2 3/4] i2c: tegra: Add DMA Support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
 <e782dfd3-4dc4-4f69-e360-f38e4705fdb4@gmail.com>
Message-ID: <ce028eb1-d236-06c7-35fc-978fdef62c6b@gmail.com>
Date:   Sat, 26 Jan 2019 03:49:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e782dfd3-4dc4-4f69-e360-f38e4705fdb4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.01.2019 3:28, Dmitry Osipenko пишет:
> 24.01.2019 23:51, Sowjanya Komatineni пишет:
>> This patch adds DMA support for Tegra I2C.
>>
>> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
>> transfer size of the max FIFO depth and DMA mode is used for
>> transfer size higher than max FIFO depth to save CPU overhead.
>>
>> PIO mode needs full intervention of CPU to fill or empty FIFO's
>> and also need to service multiple data requests interrupt for the
>> same transaction adding overhead on CPU for large transfers.
>>
>> DMA mode is helpful for Large transfers during downloading or
>> uploading FW over I2C to some external devices.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  [V2] : Updated based on V1 review feedback along with code cleanup for
>> 	proper implementation of DMA.
>>
>>  drivers/i2c/busses/i2c-tegra.c | 366 +++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 349 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
>> index 13bce1411ddc..769700d5a7f3 100644
>> --- a/drivers/i2c/busses/i2c-tegra.c
>> +++ b/drivers/i2c/busses/i2c-tegra.c
>> @@ -9,6 +9,9 @@
>>  #include <asm/unaligned.h>
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dmapool.h>
>> +#include <linux/dma-mapping.h>
>>  #include <linux/err.h>
>>  #include <linux/i2c.h>
>>  #include <linux/init.h>
>> @@ -46,6 +49,8 @@
>>  #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
>>  #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
>>  #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
>> +#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
>> +#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) << 2)
>>  #define I2C_FIFO_STATUS				0x060
>>  #define I2C_FIFO_STATUS_TX_MASK			0xF0
>>  #define I2C_FIFO_STATUS_TX_SHIFT		4
>> @@ -120,6 +125,16 @@
>>  /* Packet header size in bytes */
>>  #define I2C_PACKET_HEADER_SIZE			12
>>  
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
>> @@ -180,6 +195,7 @@ struct tegra_i2c_hw_feature {
>>   * @fast_clk: clock reference for fast clock of I2C controller
>>   * @rst: reset control for the I2C controller
>>   * @base: ioremapped registers cookie
>> + * @phys_addr: Physical address of I2C base address to use for DMA configuration
>>   * @cont_id: I2C controller ID, used for packet header
>>   * @irq: IRQ number of transfer complete interrupt
>>   * @irq_disabled: used to track whether or not the interrupt is enabled
>> @@ -193,6 +209,14 @@ struct tegra_i2c_hw_feature {
>>   * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
>>   * @is_multimaster_mode: track if I2C controller is in multi-master mode
>>   * @xfer_lock: lock to serialize transfer submission and processing
>> + * @has_dma: indicated if controller supports DMA
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
>> @@ -202,6 +226,7 @@ struct tegra_i2c_dev {
>>  	struct clk *fast_clk;
>>  	struct reset_control *rst;
>>  	void __iomem *base;
>> +	phys_addr_t phys_addr;
>>  	int cont_id;
>>  	int irq;
>>  	bool irq_disabled;
>> @@ -215,8 +240,18 @@ struct tegra_i2c_dev {
>>  	u16 clk_divisor_non_hs_mode;
>>  	bool is_multimaster_mode;
>>  	spinlock_t xfer_lock;
>> +	bool has_dma;
>> +	struct dma_chan *tx_dma_chan;
>> +	struct dma_chan *rx_dma_chan;
>> +	dma_addr_t dma_phys;
>> +	u32 *dma_buf;
>> +	unsigned int dma_buf_size;
>> +	bool is_curr_dma_xfer;
>> +	struct completion dma_complete;
>>  };
>>  
>> +static struct dma_chan *chan;
>> +
>>  static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
>>  		       unsigned long reg)
>>  {
>> @@ -283,6 +318,75 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
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
>> +
>> +	dev_dbg(i2c_dev->dev, "Starting DMA for length: %zu\n", len);
>> +	reinit_completion(&i2c_dev->dma_complete);
>> +	dir = i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
>> +	dma_desc = dmaengine_prep_slave_single(chan, i2c_dev->dma_phys,
>> +					       len, dir, DMA_PREP_INTERRUPT |
>> +					       DMA_CTRL_ACK);
>> +	if (!dma_desc) {
>> +		dev_err(i2c_dev->dev, "Failed to get DMA descriptor\n");
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
>> +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
>> +				    bool dma_to_memory)
>> +{
>> +	struct dma_chan *dma_chan;
>> +	u32 *dma_buf;
>> +	dma_addr_t dma_phys;
>> +	int ret;
>> +	const char *chan_name = dma_to_memory ? "rx" : "tx";
>> +
>> +	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, chan_name);
>> +	if (IS_ERR(dma_chan))
>> +		return PTR_ERR(dma_chan);
> 
> Here shall be a check of whether dma_buf is already allocated, otherwise it will be allocated twice and the first allocation turned into memleak:
> 
> 	if (i2c_dev->dma_buf)
> 		return 0;
> 
>> +
>> +	dma_buf = dma_alloc_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
>> +				     &dma_phys, GFP_KERNEL);
>> +
> 
> I'm wondering whether a write-combined DMA mapping will be more optimal than having L2 flushes / invalidation for the "coherent" allocations. 
> 
> And I'm now questioning whether there is any real benefit from the DMA transferring at all, given the DMA bounce-buffer CPU read/write overhead. It looks to me that the whole purpose of the I2C DMA transferring is to move data from (to) some I2C device to a some device on the APB bus, bypassing the CPU. If that's is the case, then this patch may not really worth the effort and instead could only hurt the transferring performance. Please provide some performance results or correct me if I'm wrong.

And probably the last thought for today.. Could APB DMA access IRAM? If yes, then it becomes more interesting.
