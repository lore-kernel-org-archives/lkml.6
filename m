Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA1AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB69E20869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coTzZoRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbfAaOG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:06:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39357 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfAaOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:06:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so1516377pfc.6;
        Thu, 31 Jan 2019 06:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PBGHXxo/4xPfjZbhM7pmhohV6uZrEQUB7ZW4IVLGDTc=;
        b=coTzZoRNkCRz/0RDKPLEWOG0A71WsZCLBU1RFm1ljIDyMVSpTEjChe94xH6Hnd2une
         t2G8l5jHslsLGNQn1umD+WMg9IZA2QkiLWmBLq66HGiJ2EKnorTjuLgfoUMFqRz1Ea0f
         +gc56lF2dQXou1fUvkmpXUE1l/sJBo2R93VLkbsBKvL/6tEtgtk+lwk0scenCQ8MgWHI
         ACXRGzSKnxxgKZ93ct/nu+Kx/lf+c8XTxyPbXi+TcP5brgzYWakzqVf61VOCdM1U27iC
         DvRAMwjs0OcWKe/lBESLufKnQqBgLQSr3OHu0boE+dwaK3bk4QmYZ4vwh3FOHBASKPkN
         ZtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PBGHXxo/4xPfjZbhM7pmhohV6uZrEQUB7ZW4IVLGDTc=;
        b=RGPFTu4u/eXSjaKvUNlTy/GHQjdJB8Unqtis5diYr1KfRUAO23U4yvaB9Du18CsK1+
         Utbnmkp4QZDB5Tsy9B0hl+FboZcbMHkvtWq3PLb6cJvG8m4Kb4noNGQjrKk1pBOyIHJx
         vwpHS+hDdXnEWbJWxJ5YTkjuzCsn4OE0G1eaGjlD2Uw138Vyeg8Xo1g5JfyC5l2sohct
         C9xvI4aEPm4biOAwQ1JkKMWs1UYib5Wd1dF6bP3+Fut2/RwY5NvVAiNT1gDhw4Bo0vFK
         hpCWr5egxWRtB+UusjNKmT4j81ZVBJsqXpsK2RcY1E1jI0JKo2+Up9uKLIj2mfsTE8cf
         KRdg==
X-Gm-Message-State: AJcUukdPcbYooEG00qSPw/EJ33WTrW9tpH8SMa4xCxnVivdTeAMMlXPR
        GTPITpxdpfCvMdmIGHRQsAFIxmof
X-Google-Smtp-Source: ALg8bN5LJ6rHaTMIQBvXKC3WRtYEEi2AHDaVVT/B72dOwB57plY2AibkSIl2DZ0EcGX8RRPmo0VAow==
X-Received: by 2002:a63:da45:: with SMTP id l5mr31904863pgj.111.1548943617197;
        Thu, 31 Jan 2019 06:06:57 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id r4sm21164983pgn.54.2019.01.31.06.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 06:06:55 -0800 (PST)
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
 <20190131120640.GF23438@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0e832fa6-f143-7b24-2685-b88a55e77e51@gmail.com>
Date:   Thu, 31 Jan 2019 17:06:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131120640.GF23438@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 15:06, Thierry Reding пишет:
> On Thu, Jan 31, 2019 at 03:05:48AM +0300, Dmitry Osipenko wrote:
>> 30.01.2019 19:01, Sowjanya Komatineni пишет:
> [...]
>>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> [...]
>>> +		return -EIO;
>>> +	}
>>> +
>>> +	dma_desc->callback = tegra_i2c_dma_complete;
>>> +	dma_desc->callback_param = i2c_dev;
>>> +	dmaengine_submit(dma_desc);
>>> +	dma_async_issue_pending(chan);
>>> +	return 0;
>>> +}
>>> +
>>> +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
>>> +				    bool dma_to_memory)
>>> +{
>>> +	struct dma_chan *dma_chan;
>>> +	u32 *dma_buf;
>>> +	dma_addr_t dma_phys;
>>> +	int ret;
>>> +	const char *chan_name = dma_to_memory ? "rx" : "tx";
>>
>> What about to move out chan_name into the function arguments?
> 
> That opens up the possibility of passing dma_to_memory = true and
> chan_name as "tx" and create an inconsistency.
> 
>>> @@ -884,6 +1187,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
>>>  
>>>  	i2c_dev->is_multimaster_mode = of_property_read_bool(np,
>>>  			"multi-master");
>>> +
>>> +	i2c_dev->has_dma = of_property_read_bool(np, "dmas");
>>
>> Not only the existence of "dmas" property defines whether DMA is available. DMA subsystem could be disabled in the kernels configuration.
>>
>> Hence there is a need to check for DMA driver presence in the code:
>>
>> 	if (IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>> 		i2c_dev->has_dma = of_property_read_bool(np, "dmas");
> 
> Do we even need the ->has_dma at all? We can just go ahead and request
> the channels at probe time and respond accordingly. If there's no dmas
> property in DT, dma_request_slave_channel_reason() returns an error so
> we can just deal with it at that time.
> 
> So if we get -EPROBE_DEFER we can propagate that, for any other errors
> we can simply fallback to PIO. Or perhaps we want to restrict fallback
> to PIO for -ENODEV?
> 
> I wouldn't want to add an IS_ENABLED(CONFIG_TEGRA20_APB_DMA) in here.
> The purpose of these subsystems it to abstract all of that away.
> Otherwise we could just as well use custom APIs, if we're tying together
> drivers in this way anyway.

DMA API doesn't fully abstract the dependencies between drivers, hence I disagree.

>> Also Tegra I2C driver should select DMA driver in Kconfig to make DMA
>> driver built-in when I2C driver is built-in:
> 
> I don't think there's a requirement for that. The only dependency we
> really have here is the one on the DMA engine API. Since dmaengine.h
> already provides dummy implementations, there's really no need for
> us to have the dependency. If the DMA engine API is completely disabled,
> a call to dma_request_slave_channel_reason() will return -ENODEV and we
> should just deal with that the same way we would if there was no "dmas"
> property present.

In my opinion it is much better to avoid I2C driver probe failing with -EPROBE_DEFER if we could. It's just one line in code and one in Kconfig.. really. 

Good point about handling -ENODEV of dma_request_slave_channel_reason(), +1 for it.
