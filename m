Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0624C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E21A20844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3HYYELD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfAYXWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:22:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40247 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYXWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:22:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so9726479lji.7;
        Fri, 25 Jan 2019 15:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0AC2GWMTB5KQjHvZ4IGIkxKjDqAbIJBEHv1HA2f6mAQ=;
        b=X3HYYELD5oE2fgCchB5vtJVJfibELkf4Zd4cSVvMBURuucHWRLZavWc85iJpyy3Zie
         laezbtWmKC4WIF6x2tf+D5CykWtL6GRNscfGFEhqq+hA1Aa0m8bDabI6KgGo28XXxWZZ
         hpUcws3pUvQNOrF9F1XhGe0UvPRzBfEMCP8T5D2wExNU8Gtx4+IYE8MQofcRY8RizfRB
         r2M+A4aIpZKvdEQxjBq7nxlAZnccxQvU1G3SaOHxMTdj6ehdrQdxgO08XEukH1UgORLu
         SwTJMGSErxfuus9n4u3CMXYrhC7YCa3CUxCad7prgVW7YMzUW7nuibzWizPUAKozqVgx
         paVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0AC2GWMTB5KQjHvZ4IGIkxKjDqAbIJBEHv1HA2f6mAQ=;
        b=JIX4ivAUSxFKJAg543s6pdkGm7rAPym5QeBiR7PIeG5UYKyqVTPZGPscalK/f4NBIo
         3WYrvLxq740UJSq+D51x+X6Emua8V7g4KA1TnXgDrpZ9Z4MkKzKUil189QBUWdrIrZjv
         Ymfs9r8G8K6GPEILianfvOe7VN8Lz6KooG045Am91ee7iUClIrmc13GqKkKGylceK6hQ
         5B7QERJOQLH7sZmMP6T6KmUUHhG7cPK6Hj4W28xyrvu/LL/PAppHQPncdpibyYV6y9E4
         /Mlc/phlvKTTiv8RJmWfI2x7VJ1N3CxdZHdclh8AhKfqKlk0dnu0KwJFqlpXdUJOpuvf
         EXEA==
X-Gm-Message-State: AJcUukcbDKwvrs+hPVRASqnYe/p8daKGGeXEldBug29aMgvhX2yeRscz
        xwtkoFp6K6MxYc1QY3NG/u7gsFFQ
X-Google-Smtp-Source: ALg8bN6SOWOPgVSaQaY9E2EV1toXvHCqlu1b/P3K6QAGfdHv4Npa4NEClHfj7Y6d4dXIroVEBSkz6Q==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr10778807lje.110.1548458561137;
        Fri, 25 Jan 2019 15:22:41 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id f8sm1932709lfe.72.2019.01.25.15.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:22:40 -0800 (PST)
Subject: Re: [PATCH V2 2/4] i2c: tegra: Update I2C transfer using buffer
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-2-git-send-email-skomatineni@nvidia.com>
 <185da588-1080-1589-46b6-5b63dff681eb@gmail.com>
 <BYAPR12MB33982FC612F99AC5CAE29EDBC29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <9b80cfc0-6cb4-a08e-ad78-2ce9bbea7036@gmail.com>
Message-ID: <2a9c9637-c8af-f3ff-ff40-fc2a4b810846@gmail.com>
Date:   Sat, 26 Jan 2019 02:22:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9b80cfc0-6cb4-a08e-ad78-2ce9bbea7036@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.01.2019 0:25, Dmitry Osipenko пишет:
> 25.01.2019 23:20, Sowjanya Komatineni пишет:
>>
>>
>>>> This patch prepares the buffer with the message bytes to be 
>>>> transmitted along with the packet header information and then performs 
>>>> i2c transfer in PIO mode.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>>  [V2] : DMA support changes include preparing buffer with message bytes and
>>>> 	and header before sending them through DMA. So splitted the whole
>>>> 	change into 2 seperate patches in this series.
>>>>
>>>>  drivers/i2c/busses/i2c-tegra.c | 97 
>>>> +++++++++++++++++++++++++++++-------------
>>>>  1 file changed, 68 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-tegra.c 
>>>> b/drivers/i2c/busses/i2c-tegra.c index ef854be4c837..13bce1411ddc 
>>>> 100644
>>>> --- a/drivers/i2c/busses/i2c-tegra.c
>>>> +++ b/drivers/i2c/busses/i2c-tegra.c
>>>> @@ -117,6 +117,9 @@
>>>>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>>>>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
>>>>  
>>>> +/* Packet header size in bytes */
>>>> +#define I2C_PACKET_HEADER_SIZE			12
>>>> +
>>>>  /*
>>>>   * msg_end_type: The bus control which need to be send at end of transfer.
>>>>   * @MSG_END_STOP: Send stop pulse at end of transfer.
>>>> @@ -677,35 +680,69 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>>>>  	return IRQ_HANDLED;
>>>>  }
>>>>  
>>>> +static int tegra_i2c_start_pio_xfer(struct tegra_i2c_dev *i2c_dev) {
>>>> +	u32 *buffer = (u32 *)i2c_dev->msg_buf;
>>>> +	unsigned long flags;
>>>> +	u32 int_mask;
>>>> +
>>>> +	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
>>>> +
>>>> +	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
>>>> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
>>>> +
>>>> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
>>>> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
>>>> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
>>>> +
>>>> +	i2c_dev->msg_buf = (u8 *) buffer;
>>>> +
>>>> +	if (!i2c_dev->msg_read)
>>>> +		tegra_i2c_fill_tx_fifo(i2c_dev);
>>>> +
>>>> +	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
>>>> +		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
>>>> +	if (i2c_dev->msg_read)
>>>> +		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
>>>> +	else if (i2c_dev->msg_buf_remaining)
>>>> +		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
>>>> +
>>>> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
>>>> +	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
>>>> +	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
>>>> +		i2c_readl(i2c_dev, I2C_INT_MASK));
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>>>>  	struct i2c_msg *msg, enum msg_end_type end_state)  {
>>>>  	u32 packet_header;
>>>>  	u32 int_mask;
>>>>  	unsigned long time_left;
>>>> -	unsigned long flags;
>>>> +	u32 *buffer;
>>>> +	int ret = 0;
>>>> +
>>>> +	buffer = kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
>>>> +					I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
>>>> +	if (!buffer)
>>>> +		return -ENOMEM;
>>>
>>> Isn't it possible to avoid "buffer" allocation / copying overhead and keep code as-is for the PIO mode?
>>>
>>
>> Keeping PIO mode code as is and adding DMA mode will have redundant code for header generation and msg complete timeout sections.
>> Also in existing PIO mode implementation, TX FIFO is filled as soon as the word is ready but for DMA mode need to put all msg bytes along with header together to send thru DMA.
>> So created common buffer to perform PIO/DMA to reduce redundancy.
>>
> 
> Okay, what about something like in this sketch:
> 
> ...
> 	if (msg->flags & I2C_M_RD)
> 		xfer_size = msg->len;
> 	else
> 		xfer_size = ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
> 			    I2C_PACKET_HEADER_SIZE;
> 
> 	dma = ((xfer_size > I2C_PIO_MODE_MAX_LEN) &&
> 		i2c_dev->tx_dma_chan && i2c_dev->rx_dma_chan);
> 
> 	if (dma) {
> 		buffer = kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
> 				I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
> 		i2c_dev->msg_buf = (u8 *)buffer;
> 	}
> 
> 	packet_header = (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
> 				PACKET_HEADER0_PROTOCOL_I2C |
> 				(i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
> 				(1 << PACKET_HEADER0_PACKET_ID_SHIFT);
> 		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> 
> 	if (dma)
> 		(*buffer++) = packet_header;
> 	else
> 		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> 
> ... and so on.
> 
> Likely that kmalloc overhead will be bigger than the above variant. Please consider to avoid kmalloc and copying for the PIO case in the next version.
> 

Also, is the intermediate kmalloc "buffer" really needed at all? Why just not to write directly into the DMA buffer?
