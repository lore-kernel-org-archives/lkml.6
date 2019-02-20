Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4286C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847C821841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4YuMMGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfBTSFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:05:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38780 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTSFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:05:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id n15so18287198lfe.5;
        Wed, 20 Feb 2019 10:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+KGmtpbb8okmfk/nl/fCot1mya45UP+o0zKZ3jHJwl0=;
        b=g4YuMMGLpqUIxkcMtD/f4VRmaD7ASA7Mz8YWPcR40DkaH526y3EKYuiStdGHJTnKat
         astCvBJ27N6/BjiM+ZhPIiOhKML9W8TSjg0fJAQh8nvo9szQeuwxFuHe4wtTom67vWqb
         ivJsXXjI8jx1fW7xogpsGsipBy53c2b1IlUbafGd0JmVY8ja5+uxi7ZjeEhoBQq+knsl
         07Bh6OPevoct7IuNtV1PIfNWZAlsu57YqNliPTzNKAmY3NLnWf1VmBTLYXF6BmUwGEIo
         4k7xKz6Hn9DFwlPKbijtEZiZxIk8DPSyVYF2G8bAvMyFwS1Z6VDVCAt6dTEArQTpBpwN
         tOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+KGmtpbb8okmfk/nl/fCot1mya45UP+o0zKZ3jHJwl0=;
        b=Qf3ljUp8REo6JhetOL2PGv4LXDYm9o/e7BT6133NL5oDLhYWmX3eMn5tsd1Cjeg4j8
         g3lBqTckUkvYZiGHIpBp+Sg+vkT00hwY9TJYPgq7ZJUDDCPk+RUTL19pzcc8x1YP2K54
         d2R1Y+AbFuG8ZEYFcNraMx+enpF+E9Q9ebKM0phyOhMkUCK9Ch+//CyGSxnpiSw1FE6b
         8gVTk7iNzbQJoPd06bg8qpxVRjccOCZSuXl6VsOEST42gQ/VL/XRKMzhZgJoL3tX2dlt
         YIkCWoR+vfwqf+4Goyobaf8VqUZiwbjNEYh0Jr68JUp8ZM0ykdcrBLHJAOpdFvMCINbM
         8mzQ==
X-Gm-Message-State: AHQUAuZotTuaHwBMSXxjXlSCpeanQRKzUIslTHFWzYudQFBEl+jBvixd
        a1dNpukT/Ck6wbiQ2q6gdOsvdhCT
X-Google-Smtp-Source: AHgI3IYRQ3+1kJV+WykYwRwu9HRwzo1MRyrtU0El9hJGTOnQEZWCOtTGpkMFoAdK2D+ZZZpJR/xwow==
X-Received: by 2002:a19:4851:: with SMTP id v78mr20846507lfa.98.1550685920648;
        Wed, 20 Feb 2019 10:05:20 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id h5sm5406930lfm.29.2019.02.20.10.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 10:05:19 -0800 (PST)
Subject: Re: [PATCH V19 5/7] i2c: tegra: Add DMA support
To:     Jon Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, mkarthik@nvidia.com,
        smohammed@nvidia.com, talho@nvidia.com
Cc:     wsa@the-dreams.de, peda@axentia.se, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
 <1549998408-9137-5-git-send-email-skomatineni@nvidia.com>
 <a98faf49-98f5-7b85-8acd-0fd6a4c8b426@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c3a2c691-c020-5c44-1b89-3fb31724b65f@gmail.com>
Date:   Wed, 20 Feb 2019 21:05:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a98faf49-98f5-7b85-8acd-0fd6a4c8b426@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.02.2019 21:02, Jon Hunter пишет:
> 
> On 12/02/2019 19:06, Sowjanya Komatineni wrote:
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
>> Tegra210 and prior Tegra chips use APBDMA driver which is replaced
>> with GPCDMA on Tegra186 and Tegra194.
>> This patch uses has_apb_dma flag in hw_feature to differentiate
>> DMA driver change between Tegra chipset.
>>
>> APBDMA driver is registered from module-init level and this patch
>> also has a change to register I2C driver at module-init level
>> rather than subsys-init to avoid deferring I2C probe till APBDMA
>> driver is registered.
>>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> 
> ...
> 
>> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
>> +{
>> +	struct dma_chan *chan;
>> +	u32 *dma_buf;
>> +	dma_addr_t dma_phys;
>> +	int err;
>> +
>> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA) ||
>> +	    !i2c_dev->hw->has_apb_dma) {
>> +		err = -ENODEV;
>> +		goto err_out;
>> +	}
>> +
>> +	chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
>> +	if (IS_ERR(chan)) {
>> +		err = PTR_ERR(chan);
>> +		goto err_out;
>> +	}
>> +
>> +	i2c_dev->rx_dma_chan = chan;
>> +
>> +	chan = dma_request_slave_channel_reason(i2c_dev->dev, "tx");
>> +	if (IS_ERR(chan)) {
>> +		err = PTR_ERR(chan);
>> +		goto err_out;
>> +	}
>> +
>> +	i2c_dev->tx_dma_chan = chan;
>> +
>> +	dma_buf = dma_alloc_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
>> +				     &dma_phys, GFP_KERNEL | __GFP_NOWARN);
>> +	if (!dma_buf) {
>> +		dev_err(i2c_dev->dev, "failed to allocate the DMA buffer\n");
>> +		err = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +
>> +	i2c_dev->dma_buf = dma_buf;
>> +	i2c_dev->dma_phys = dma_phys;
>> +	return 0;
>> +
>> +err_out:
>> +	tegra_i2c_release_dma(i2c_dev);
>> +	if (err != -EPROBE_DEFER) {
>> +		dev_err(i2c_dev->dev, "cannot use DMA: %d\n", err);
>> +		dev_err(i2c_dev->dev, "fallbacking to PIO\n");
>> +		return 0;
>> +	}
> I think that the above should be a dev_dbg print or re-worked in someway
> because now for Tegra194 which does not have an APB DMA I see ...
> 
> [       6.093234] ERR KERN tegra-i2c 31c0000.i2c: cannot use DMA: -19
> [       6.096847] ERR KERN tegra-i2c 31c0000.i2c: falling back to PIO
> 
> Given that the APB DMA is not supported for Tegra186/Tegra194, there is
> no point in printing these error messages. Now it looks like something
> is wrong but really it is not :-(

Jon, patches are welcome ;)
