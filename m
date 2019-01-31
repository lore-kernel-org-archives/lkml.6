Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE2FC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00E720881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdb2lEfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfAaCNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:13:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38428 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaCNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:13:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so1125002lfk.5;
        Wed, 30 Jan 2019 18:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xuNsfW1hGW0JrfhCUXOX6eVGxtbE/SqTq//mAzTTJ6s=;
        b=Jdb2lEfGy6C4Y4CfumSh+vfsD1w4Hzbmz2yKtx96OAhwYfWeqx5O7ZfTb1DEYQwiQy
         Y0I+iJW8RJLTvgFE5DrIQJ1SqKObHeM7DpNYc6Y+O3xOHpBf6wEcCP4uzEIvrETdYbxv
         fyYcj9aLqIhC1+jwVQj2NnOmzDrai2t7OSQhI/j6YFex84BqagNTdQWzW+lUrKsxu3yt
         rWft7YcZKA8SlI4ypUhMQFxIL8qDfW+lfaI/Yeq/jiCoYgNytFYbprHKeEnvLIjBl8Dw
         OkscVcAjY6QoUPOZiHxNmrbF2BA1X+DFVolh2FbLVJ1/uZYyNVLM1FsRGT5Y5fktAXpr
         dUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xuNsfW1hGW0JrfhCUXOX6eVGxtbE/SqTq//mAzTTJ6s=;
        b=RKkjG+tZ++8EnYYfnPQ+LRxNRq/reeww/YqcAnxGnh4PU8W89c62SOMTtzxh9VIpO5
         VoH5WgRV3QfJ+fCW9UTtY13R5zN5LLRW89rDAwaQU6sGIA8sRgMllj5kuofGHR9EU8Iw
         dtdVUR05wRB9fo5r07JojFmuTopy5TSvhOak2r4X965wg8bRxZE28M5W647wMUYRKevk
         HuUJ0/bkenLdDXAzyUvZ39w/8MRIGAxyrNvvCM+RCFOAtJrktAIH5Z5YliY1OoRhBZgk
         umicikNWSGRjwZ4kA52fQFZfvudvHixso+n8WYDt3sOfIwnGkxsgTqJc3ky/CDefTpHz
         rpMA==
X-Gm-Message-State: AJcUukc5kUPZ9/fg6LmPzPjfPfdWCWgdq78GFIhzbiKS1KnLguge8T5k
        7xREf0tPKofFutkXy3DdPMz8dZNd
X-Google-Smtp-Source: ALg8bN7w6Z3J3Fb519gtXshyNkkpTQHHkBUitSEveRJdXNOk7pYnXTivuv3vZKawMo2JFKACvuX9og==
X-Received: by 2002:ac2:51a2:: with SMTP id f2mr24719564lfk.161.1548900785415;
        Wed, 30 Jan 2019 18:13:05 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id h3sm570671lfj.25.2019.01.30.18.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 18:13:04 -0800 (PST)
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
 <BYAPR12MB3398B845E97674BE93CCD7D9C2910@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f3282ada-56a8-b5c7-c400-38483eab2d06@gmail.com>
Date:   Thu, 31 Jan 2019 05:13:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398B845E97674BE93CCD7D9C2910@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 4:19, Sowjanya Komatineni пишет:
>>> +			dma_sync_single_for_device(i2c_dev->dev,
>>> +						   i2c_dev->dma_phys,
>>> +						   xfer_size,
>>> +						   DMA_FROM_DEVICE);
>>> +			ret = tegra_i2c_dma_submit(i2c_dev, xfer_size);
>>> +			if (ret < 0) {
>>> +				dev_err(i2c_dev->dev,
>>> +					"Starting RX DMA failed, err %d\n",
>>> +					ret);
>>> +				goto exit;
>>> +			}
>>> +		} else {
>>> +			chan = i2c_dev->tx_dma_chan;
>>> +			tegra_i2c_config_fifo_trig(i2c_dev, xfer_size,
>>> +						   DATA_DMA_DIR_TX);
>>> +			/* Make the dma buffer to read by cpu */> +			dma_sync_single_for_cpu(i2c_dev->dev,
>>> +						i2c_dev->dma_phys,
>>> +						xfer_size,
>>> +						DMA_TO_DEVICE);
>>
>> This is not correct, you need to call dma_sync_single_for_cpu() after completion of the transfer to give back dma buffer ownership to CPU, see below. This dma_sync_single_for_cpu() invocation should be removed.
> 
> Transfer is not done yet. Dma buffer ownership is given to CPU here before copying header bytes and msg bytes into dma buffer before actually transmitting
> 

In fact dma_sync_single_for_cpu(DMA_TO_DEVICE) is not needed at all because it is a NO-OP on ARM, but technically it is needed to conform to DMA API. I think it is more logical that device owns dma buffer only during of the actual DMA transfer, the rest of the time CPU should be owner of the buffer.

>>> +
>>> +		if (i2c_dev->msg_read) {
>>> +			if (likely(i2c_dev->msg_err == I2C_ERR_NONE)) {
>>> +				dma_sync_single_for_cpu(i2c_dev->dev,
>>> +							i2c_dev->dma_phys,
>>> +							xfer_size,
>>> +							DMA_FROM_DEVICE);
>>> +
>>> +				memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf,
>>> +					msg->len);
>>> +			}
>>> +		}
>>
>> Here you should give back dma buffer ownership to CPU:
> 
> After transfer is done, for msg reads, dma buffer ownership is given to CPU and read data from dma buffer is copied to msg buffer
> For msg writes, no need of ownership to CPU.
>>>
>>> 		else {
>>> 			dma_sync_single_for_cpu(i2c_dev->dev,
>>> 						i2c_dev->dma_phys,
>>> 						xfer_size,
>>> 						DMA_TO_DEVICE);
>>> 		}
>>
>>>  	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
>>>  						TEGRA_I2C_TIMEOUT);
>>>  	tegra_i2c_mask_irq(i2c_dev, int_mask);
>>>  
>>>  	if (time_left == 0) {
>>>  		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
>>> +		if (dma) {
>>> +			dmaengine_terminate_all(chan);
>>> +			complete(&i2c_dev->dma_complete);
>>> +		}
>>
>> DMA transfer has been completed at this point, hence this hunk isn't needed. Please remove it.
> 
> DMA complete alone doesn’t guarantee the transfer. Packets/All packets xfer interrupt from I2C confirms complete transaction along with dma complete check.
> So still need to check for msg_complete timeout. 

You're waiting for DMA completion and then for the I2C message completion.

Hence your code is structured like this:

1. Issue DMA transfer
2. Wait for DMA completion
3. Wait for message completion

Why do you need to abort DMA in 3 if it was already completed in 2?

>>> @@ -740,6 +925,32 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>>>  	u32 int_mask;
>>>  	unsigned long time_left;
>>>  	unsigned long flags;
>>> +	size_t xfer_size;
>>> +	u32 *buffer = 0;
>>> +	int ret = 0;
>>> +	bool dma = false;
>>> +
>>> +	if (msg->flags & I2C_M_RD)
>>> +		xfer_size = msg->len;
>>> +	else
>>> +		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
>>> +
>>> +	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
>>> +	dma = (xfer_size > I2C_PIO_MODE_MAX_LEN);
>>> +	if (dma) {
>>> +		if ((msg->flags & I2C_M_RD) && !i2c_dev->rx_dma_chan)
>>> +			ret = tegra_i2c_init_dma_param(i2c_dev, true);
>>> +		else if (!i2c_dev->tx_dma_chan)
>>> +			ret = tegra_i2c_init_dma_param(i2c_dev, false);
>>
>> In the comment to V3 I mentioned that it's not a good idea to request channels dynamically because suspend-resume order is based on devices registration order, in this case APB DMA must be probed before I2C. Please move channels allocation into the probe.
>>
>> This also raises the question about the need to register I2C driver from the subsys-init level because APB driver is getting registered from the module-init level and hence I2C probing will be deferred until APB DMA driver is registered. It looks to me that the subsys-init is a relict of the past and it should be fine to move I2C driver registration into the module-init level, of course it's not strictly necessary and could be done later on if desired.
>>
>>> +		if (ret < 0) {
>>> +			dev_dbg(i2c_dev->dev, "Switching to PIO mode\n");
>>> +			dma = false;
>>> +			ret = 0;
>>> +		}
>>> +	}
>>> +
>>> +	i2c_dev->is_curr_dma_xfer = dma;
>>
>>
> Since your previous feedback suggest "let's postpone channels requesting and dma_buf allocation until they are really needed", I thought it make sense to not request channels and allocate till DMA is needed.
> So moved from probe to xfer_msg function. By the time it gets to xfer msg function, devices registration should be done already along with apb dma probe.
> 
> 

Yes, I made that comment, but then corrected myself. Seems you missed the correction: https://lkml.org/lkml/2019/1/26/217

If you're having troubles with the corporate email, maybe you could try to switch to something else like gmail.

I've tried to apply this series locally, but again it fails to apply. What's the kernel base you're using? You should make your patches on top linux-next (preferably) or mainline.
