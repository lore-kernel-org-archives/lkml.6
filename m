Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BF7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25D6218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0PkRzVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbfAaQ4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:56:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34345 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfAaQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:56:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so1609545pga.1;
        Thu, 31 Jan 2019 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QwSjmDw/87/CwpQPLpCabXrqoXEUc4O5k5+WgbRqRvc=;
        b=l0PkRzVM1jSZqc2HERufrdkbOpzCL9TseUta+o4rUsUZn8YRxNByRzbWvQWc80SJat
         17i0r5SGx+cG8JvrfYk78ItU/6w8SktCwuqhmOuu8jfeO00N2GGFcCwtE29CAYUmHbBM
         3mLGZpJGBxEajQ5NryCUXE+ntSNTxHitYunq6XD5EWcBgVs82x29qH8/IyzFgz2v0Jjj
         HovVrsY2ME8ZypwRJH55vaqU3//EoKZwTVOUmAjUdrrPATY6LcgHJ/NEzanoJctCMC8B
         iCYiKRCNQPcojjUFRlcW7pFToC+NuerYPtLSdmpeR+5FcdEc0iqLJcASYMjniZFTGA7m
         QSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QwSjmDw/87/CwpQPLpCabXrqoXEUc4O5k5+WgbRqRvc=;
        b=bSOwhdPqa4Z8ikNoGKU0HHrh/+PVhSiLcbXld7lIwxTpl9fjAV4QRlsPamRvDGNlmJ
         j+DUMRgiRDUQ0UwuH26M33wKVL6+wiRBnw08AsmJlcRkU6DXKVsj66bSC5jOTuCgd8Oi
         OPS+YJWIwzjTDW9JaQgK6VENKeCw7aYBBPYADePehCo4rwjA7ITZJ+OwCi7s8fELjsPO
         2k7ojC4Q8D2mamxzSTUnpJtY85q34v+C065Jjig2SO+dUx7MOiYcrYioLKerpO4BfLHu
         WRq/0DIu2LykRkhjvU4k/V3mm6eMymWdOKOxtij9ltHfFek569eiooWvyUuAUDtc8BDR
         Iw1Q==
X-Gm-Message-State: AJcUukekGJ3K1+FN6vCsCegXv9nf0QaIAKOvQ6X+LQj63FTIiOMCkhh0
        Ilt/OuIq469oAy7lVftHiy6XjYa9
X-Google-Smtp-Source: ALg8bN7V6n2V8Sf3sWuWYFibfg9R+4ozCZMSBUZfsgGPg1cWjxIKjOE/gO4Y+oZtJM+9q9PdaYB2Zw==
X-Received: by 2002:a62:60c5:: with SMTP id u188mr35688853pfb.4.1548953766464;
        Thu, 31 Jan 2019 08:56:06 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id v89sm7631453pfk.12.2019.01.31.08.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 08:56:05 -0800 (PST)
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
 <20190131120640.GF23438@ulmo>
 <0e832fa6-f143-7b24-2685-b88a55e77e51@gmail.com>
 <20190131144344.GP23438@ulmo>
 <bdb5ab9f-b047-6b9e-696a-8d6ef4065c77@gmail.com>
Message-ID: <6c2909cb-f31c-921d-8449-79ec77c02d9b@gmail.com>
Date:   Thu, 31 Jan 2019 19:55:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bdb5ab9f-b047-6b9e-696a-8d6ef4065c77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 18:02, Dmitry Osipenko пишет:
> 31.01.2019 17:43, Thierry Reding пишет:
>> On Thu, Jan 31, 2019 at 05:06:18PM +0300, Dmitry Osipenko wrote:
>>> 31.01.2019 15:06, Thierry Reding пишет:
>>>> On Thu, Jan 31, 2019 at 03:05:48AM +0300, Dmitry Osipenko wrote:
>>>>> 30.01.2019 19:01, Sowjanya Komatineni пишет:
>>>> [...]
>>>>>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
>>>> [...]
>>>>>> +		return -EIO;
>>>>>> +	}
>>>>>> +
>>>>>> +	dma_desc->callback = tegra_i2c_dma_complete;
>>>>>> +	dma_desc->callback_param = i2c_dev;
>>>>>> +	dmaengine_submit(dma_desc);
>>>>>> +	dma_async_issue_pending(chan);
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
>>>>>> +				    bool dma_to_memory)
>>>>>> +{
>>>>>> +	struct dma_chan *dma_chan;
>>>>>> +	u32 *dma_buf;
>>>>>> +	dma_addr_t dma_phys;
>>>>>> +	int ret;
>>>>>> +	const char *chan_name = dma_to_memory ? "rx" : "tx";
>>>>>
>>>>> What about to move out chan_name into the function arguments?
>>>>
>>>> That opens up the possibility of passing dma_to_memory = true and
>>>> chan_name as "tx" and create an inconsistency.
>>>>
>>>>>> @@ -884,6 +1187,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
>>>>>>  
>>>>>>  	i2c_dev->is_multimaster_mode = of_property_read_bool(np,
>>>>>>  			"multi-master");
>>>>>> +
>>>>>> +	i2c_dev->has_dma = of_property_read_bool(np, "dmas");
>>>>>
>>>>> Not only the existence of "dmas" property defines whether DMA is available. DMA subsystem could be disabled in the kernels configuration.
>>>>>
>>>>> Hence there is a need to check for DMA driver presence in the code:
>>>>>
>>>>> 	if (IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>>>>> 		i2c_dev->has_dma = of_property_read_bool(np, "dmas");
>>>>
>>>> Do we even need the ->has_dma at all? We can just go ahead and request
>>>> the channels at probe time and respond accordingly. If there's no dmas
>>>> property in DT, dma_request_slave_channel_reason() returns an error so
>>>> we can just deal with it at that time.
>>>>
>>>> So if we get -EPROBE_DEFER we can propagate that, for any other errors
>>>> we can simply fallback to PIO. Or perhaps we want to restrict fallback
>>>> to PIO for -ENODEV?
>>>>
>>>> I wouldn't want to add an IS_ENABLED(CONFIG_TEGRA20_APB_DMA) in here.
>>>> The purpose of these subsystems it to abstract all of that away.
>>>> Otherwise we could just as well use custom APIs, if we're tying together
>>>> drivers in this way anyway.
>>>
>>> DMA API doesn't fully abstract the dependencies between drivers, hence
>>> I disagree.
>>
>> Why not? The dependency we're talking about here is a runtime dependency
>> rather than a build time dependency. Kconfig is really all about build-
>> time dependencies.
> 
> My understanding is that Kconfig is also about runtime dependencies, do you know if it's explicitly documented anywhere?
> 
>>>>> Also Tegra I2C driver should select DMA driver in Kconfig to make DMA
>>>>> driver built-in when I2C driver is built-in:
>>>>
>>>> I don't think there's a requirement for that. The only dependency we
>>>> really have here is the one on the DMA engine API. Since dmaengine.h
>>>> already provides dummy implementations, there's really no need for
>>>> us to have the dependency. If the DMA engine API is completely disabled,
>>>> a call to dma_request_slave_channel_reason() will return -ENODEV and we
>>>> should just deal with that the same way we would if there was no "dmas"
>>>> property present.
>>>
>>> In my opinion it is much better to avoid I2C driver probe failing with
>>> -EPROBE_DEFER if we could. It's just one line in code and one in
>>> Kconfig.. really. 
>>
>> The problem is that from a theoretical point of view we don't know that
>> APB DMA is the provider for the DMA channels. This provider could be a
>> completely different device on a different Tegra generation (in fact,
>> the DMA engine on Tegra186 is a different one, so we'd have to add that
>> to the list of checks to make sure we don't disable DMA there). And the
>> fact that we're tightly integrated is really only by accident. We could
>> have the same situation on a SoC that incorporates IP from multiple
>> different sources and multiple combinations thereof as well, so how
>> would you want to deal with those cases?
>>
>> Agreed, failing with -EPROBE_DEFER is suboptimal in that case, but that
>> is really more of an integration problem. Ideally of course there'd be
>> some way for the DMA engine subsystem to know that the provider for the
>> given device node will never show up and give us -ENODEV instead, but,
>> alas, I don't even think that would be possible. That's the price to pay
>> for abstraction.
> 
> It's not a big problem to solve for this case, there is of_machine_is_compatible(). To me it's more a question about the will to invest some extra effort to support all of possible combinations. If there is no such will, then at least those unpopular combinations shouldn't hurt and thus it should make sense to add an explicit build-dependency on the DMA drivers.
> 

Ah, my bad. I assumed that selecting TEGRA20_APB_DMA won't enable DMA_ENGINE.

Then what about something like this?

config I2C_TEGRA
	tristate "NVIDIA Tegra internal I2C controller"
	depends on ARCH_TEGRA
	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_2x_SOC)
	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_3x_SOC)
	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_114_SOC)
	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_124_SOC)
	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_210_SOC)
	help
	  If you say yes to this option, support will be included for the
	  I2C controller embedded in NVIDIA Tegra SOCs

config I2C_TEGRA_DMA_SUPPORT
	bool "NVIDIA Tegra internal I2C controller DMA support"
	depends on I2C_TEGRA
	help
	  If you say yes to this option, DMA engine integration support will
	  be included for the I2C controller embedded in NVIDIA Tegra SOCs


Well, since my assumption was incorrect, maybe indeed not worth to care about all cases. I'm in doubt now.
