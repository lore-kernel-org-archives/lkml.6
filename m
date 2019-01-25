Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937F7C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBCB218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUVCtXgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAYTzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:55:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46917 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYTzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:55:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so4603611pgp.13;
        Fri, 25 Jan 2019 11:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FsslcgbhoOpznTJ7q1iEsH7skIJufDE6HzIThGChvTs=;
        b=sUVCtXgmF8eSjrtvXNRixomKCPoymcR/BhCUF9FqEHyu4LN+ax0LlqFiTxcaMvjqD7
         /yEN9nlovRzesomNo7XczZPXOIPGmAhPoaldC5Ii7Y5YLUb2TKd2A+5Kl0X1GFkuSKBC
         btY13mRer+SKo40jyf84YsFEnO1cYLxqLtkM9VFC8qJhb7TSN3l5GBu0d+OTSrHEL+30
         LVsqJIBt+3hRi12o7r6Zwvj3O+UHayDgrbIzcygK8KvHJogMHkJOycgj5OQJLHZB6+7z
         J0q+KlbHsQRAgNez7qDHMW23itiFGHkW6omHkXLegQ1b9JR+hS6KfHvHs2WE9liPciUt
         YNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FsslcgbhoOpznTJ7q1iEsH7skIJufDE6HzIThGChvTs=;
        b=Xp2f4cnFLCyu3ETPQYth0eCrXc6dNQK09KveCRRaI5F0u5kP1NafRzXUhIyZQHt2t/
         kZo7+drOWdVJX0jCnmy4cplnsl5DggCzsBSVT8LaMKgrNNY4TTCVicTpezbTllyd7rJy
         06om0NLu1ivlCYSTFBfd/qglSbqJFS/6DyTDIPZejox9QysiwTIJl/QVeflkAkwtyqAf
         DKMLubLCOUYp1BrHLoCELVBndrWpMrrh1Bsj78bAibU9YkU3rIGXSAn5Po7UDMblFhWS
         wwGlawZ+cXh3mo7sySRiWzC871GUZu3T46gNkSKdmzCsri9RVmDagv9pJ0ZBp4MVyhT8
         1O4g==
X-Gm-Message-State: AJcUukf3UaLiBLzvh/FDzE/DI3Qkv9T6OepD7Fj9DaxjS6r08cyeA5tW
        fqZ6t3ePIRLaFBoZSeWDmOr6JCbQ
X-Google-Smtp-Source: ALg8bN4L6bYghyPFO7vacNUgYttQTlCBQbzYdLSgEpQodCJWfsTY+lGsraUXTktWUeCWbrQUwsz8yA==
X-Received: by 2002:a63:fc49:: with SMTP id r9mr10923997pgk.209.1548446117503;
        Fri, 25 Jan 2019 11:55:17 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id j73sm35580115pge.13.2019.01.25.11.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 11:55:16 -0800 (PST)
Subject: Re: [PATCH V2 2/4] i2c: tegra: Update I2C transfer using buffer
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <185da588-1080-1589-46b6-5b63dff681eb@gmail.com>
Date:   Fri, 25 Jan 2019 22:55:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548363113-25969-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.01.2019 23:51, Sowjanya Komatineni пишет:
> This patch prepares the buffer with the message bytes to be
> transmitted along with the packet header information and then
> performs i2c transfer in PIO mode.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V2] : DMA support changes include preparing buffer with message bytes and
> 	and header before sending them through DMA. So splitted the whole
> 	change into 2 seperate patches in this series.
> 
>  drivers/i2c/busses/i2c-tegra.c | 97 +++++++++++++++++++++++++++++-------------
>  1 file changed, 68 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index ef854be4c837..13bce1411ddc 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -117,6 +117,9 @@
>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
>  
> +/* Packet header size in bytes */
> +#define I2C_PACKET_HEADER_SIZE			12
> +
>  /*
>   * msg_end_type: The bus control which need to be send at end of transfer.
>   * @MSG_END_STOP: Send stop pulse at end of transfer.
> @@ -677,35 +680,69 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static int tegra_i2c_start_pio_xfer(struct tegra_i2c_dev *i2c_dev)
> +{
> +	u32 *buffer = (u32 *)i2c_dev->msg_buf;
> +	unsigned long flags;
> +	u32 int_mask;
> +
> +	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
> +
> +	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> +
> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
> +
> +	i2c_dev->msg_buf = (u8 *) buffer;
> +
> +	if (!i2c_dev->msg_read)
> +		tegra_i2c_fill_tx_fifo(i2c_dev);
> +
> +	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
> +		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
> +	if (i2c_dev->msg_read)
> +		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
> +	else if (i2c_dev->msg_buf_remaining)
> +		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
> +
> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> +	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> +	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
> +		i2c_readl(i2c_dev, I2C_INT_MASK));
> +
> +	return 0;
> +}
> +
>  static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	struct i2c_msg *msg, enum msg_end_type end_state)
>  {
>  	u32 packet_header;
>  	u32 int_mask;
>  	unsigned long time_left;
> -	unsigned long flags;
> +	u32 *buffer;
> +	int ret = 0;
> +
> +	buffer = kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
> +					I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;

Isn't it possible to avoid "buffer" allocation / copying overhead and keep code as-is for the PIO mode?

[snip]
