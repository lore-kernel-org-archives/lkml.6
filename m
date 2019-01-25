Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE9AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1A2218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPOu5D40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfAYV0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:26:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35922 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYV0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:26:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so5315650pfc.3;
        Fri, 25 Jan 2019 13:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IrWB1Ti275ClfkgObR9EXLN41d1idd7jpxV49MPVMfU=;
        b=ZPOu5D40lUiN8SwyFRyA7p8N4E3dGPqLSNNDRJBJTMtQltuWg7sSMtejtej68iY9rz
         XdWlsKJucBDb+DslZxPzKJTn/woC9Qv98Xyy3gzG74JU40nzIQbfSXfp+sZUVhrANZYi
         rl62d4aslcBkHrboMa92hGh+BXA+70KFb4z33eQmMQ2b27cYdYch0Axed3Rk2idkMqar
         b75YJT1m+b/gQOuDXp9fcV+MIw/LoPLKo+Aa0HZFf3ZoPoToIocpdFSeW7Dmr+jhozeK
         95mLGOsABXrsoDPbSogg3J2TWVKeNggz7UpW9gZMTbyr3nw95WcqbgoeSQ41rKF4ywVN
         rT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IrWB1Ti275ClfkgObR9EXLN41d1idd7jpxV49MPVMfU=;
        b=Il1qW77u3GO6Pbt4m7JOzooD/OHrM0mclFxzM2SisT46KOZGIX6OCpayZxyz+uBch1
         73b3Br6cirfOCE2MRA3cEYRnKGewFeQI9ZIQ4RNttrdZ6NIYrMuSM5YkzdChKR7UUEbE
         JVc2Wb6D4sLNBUnvH1rxHQ7QPZG5lWXZWbaXA+nhKiwJQLhn3vu2X3mS7Dlt6N/LqNC9
         p6eOHoGZ9MQUwi9bHhYMrfCW9arhmQDxQ8FI6kFB2u0yRczrLcBwM0x1fTc1kQ8zXgqc
         +T+RM8eGt1cvjVWrPBwROljqPIGMl0gVEyYWCwEDbfGkoVKeqOfWcdUI6mT5eSXw8TT3
         ggqA==
X-Gm-Message-State: AJcUukfXBwGRvq2ejnsoDrBSYl/D06Ao7iRAEqU1XY3FpQTdo9ky35v9
        7RTttYOc2QQlkGLiQVm87E0Llrwm
X-Google-Smtp-Source: ALg8bN4ovsVEKUTllkH2iPd9yA1mA3fqE+0rEG4P1HPTLjsch4MBQeA8E3egAjDz/bfza7HBUbTnbw==
X-Received: by 2002:a63:1444:: with SMTP id 4mr11554704pgu.430.1548451568148;
        Fri, 25 Jan 2019 13:26:08 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id z62sm37812647pfi.4.2019.01.25.13.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 13:26:07 -0800 (PST)
Subject: Re: [PATCH V2 2/4] i2c: tegra: Update I2C transfer using buffer
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9b80cfc0-6cb4-a08e-ad78-2ce9bbea7036@gmail.com>
Date:   Sat, 26 Jan 2019 00:25:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33982FC612F99AC5CAE29EDBC29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.01.2019 23:20, Sowjanya Komatineni пишет:
> 
> 
>>> This patch prepares the buffer with the message bytes to be 
>>> transmitted along with the packet header information and then performs 
>>> i2c transfer in PIO mode.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>  [V2] : DMA support changes include preparing buffer with message bytes and
>>> 	and header before sending them through DMA. So splitted the whole
>>> 	change into 2 seperate patches in this series.
>>>
>>>  drivers/i2c/busses/i2c-tegra.c | 97 
>>> +++++++++++++++++++++++++++++-------------
>>>  1 file changed, 68 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-tegra.c 
>>> b/drivers/i2c/busses/i2c-tegra.c index ef854be4c837..13bce1411ddc 
>>> 100644
>>> --- a/drivers/i2c/busses/i2c-tegra.c
>>> +++ b/drivers/i2c/busses/i2c-tegra.c
>>> @@ -117,6 +117,9 @@
>>>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>>>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
>>>  
>>> +/* Packet header size in bytes */
>>> +#define I2C_PACKET_HEADER_SIZE			12
>>> +
>>>  /*
>>>   * msg_end_type: The bus control which need to be send at end of transfer.
>>>   * @MSG_END_STOP: Send stop pulse at end of transfer.
>>> @@ -677,35 +680,69 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
>>>  	return IRQ_HANDLED;
>>>  }
>>>  
>>> +static int tegra_i2c_start_pio_xfer(struct tegra_i2c_dev *i2c_dev) {
>>> +	u32 *buffer = (u32 *)i2c_dev->msg_buf;
>>> +	unsigned long flags;
>>> +	u32 int_mask;
>>> +
>>> +	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
>>> +
>>> +	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
>>> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
>>> +
>>> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
>>> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
>>> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
>>> +
>>> +	i2c_dev->msg_buf = (u8 *) buffer;
>>> +
>>> +	if (!i2c_dev->msg_read)
>>> +		tegra_i2c_fill_tx_fifo(i2c_dev);
>>> +
>>> +	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
>>> +		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
>>> +	if (i2c_dev->msg_read)
>>> +		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
>>> +	else if (i2c_dev->msg_buf_remaining)
>>> +		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
>>> +
>>> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
>>> +	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
>>> +	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
>>> +		i2c_readl(i2c_dev, I2C_INT_MASK));
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>>>  	struct i2c_msg *msg, enum msg_end_type end_state)  {
>>>  	u32 packet_header;
>>>  	u32 int_mask;
>>>  	unsigned long time_left;
>>> -	unsigned long flags;
>>> +	u32 *buffer;
>>> +	int ret = 0;
>>> +
>>> +	buffer = kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
>>> +					I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
>>> +	if (!buffer)
>>> +		return -ENOMEM;
>>
>> Isn't it possible to avoid "buffer" allocation / copying overhead and keep code as-is for the PIO mode?
>>
> 
> Keeping PIO mode code as is and adding DMA mode will have redundant code for header generation and msg complete timeout sections.
> Also in existing PIO mode implementation, TX FIFO is filled as soon as the word is ready but for DMA mode need to put all msg bytes along with header together to send thru DMA.
> So created common buffer to perform PIO/DMA to reduce redundancy.
> 

Okay, what about something like in this sketch:

...
	if (msg->flags & I2C_M_RD)
		xfer_size = msg->len;
	else
		xfer_size = ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
			    I2C_PACKET_HEADER_SIZE;

	dma = ((xfer_size > I2C_PIO_MODE_MAX_LEN) &&
		i2c_dev->tx_dma_chan && i2c_dev->rx_dma_chan);

	if (dma) {
		buffer = kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
				I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
		i2c_dev->msg_buf = (u8 *)buffer;
	}

	packet_header = (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
				PACKET_HEADER0_PROTOCOL_I2C |
				(i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
				(1 << PACKET_HEADER0_PACKET_ID_SHIFT);
		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);

	if (dma)
		(*buffer++) = packet_header;
	else
		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);

... and so on.

Likely that kmalloc overhead will be bigger than the above variant. Please consider to avoid kmalloc and copying for the PIO case in the next version.
