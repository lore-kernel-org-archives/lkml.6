Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3703C218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRZJHwQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfAaTDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:03:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34888 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfAaTDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:03:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so1904558plo.2;
        Thu, 31 Jan 2019 11:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FQujBP64ZW9d0QCQPr1XL1F/mjDPZ8Sv/5B5vPz0USc=;
        b=GRZJHwQbDkYlse38Km4mFosD3ptounH6r/JxUjUwf8PVeKomF7eT76fd5rGqHCL2AJ
         lx7lP6gBUlL9sBwM00h70riDH7W/0FuqMRs8DF432b/gusxc4nkJkCA+9OUAUnWP+lSC
         tj4aSCZVuW+1jSggKyoE1qa9H3XDJ1dCh16e5dREabgttfPES1NmXLs+fiIhviyYhhjS
         tKdRKn20b4FAMVQIFJVtdgS1cDEm0Coh7EeWInhjvh6MA8e2SbwK9+hYGiQIZPAFBmGv
         4h+VczhFnAjHovDlXGcVEDIrVC4BhjYkrKVfny88xzmnIMqp9VjN4kZYwZJm59zKPnnY
         x+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FQujBP64ZW9d0QCQPr1XL1F/mjDPZ8Sv/5B5vPz0USc=;
        b=Sre4d6HKq+BdFizoXfUIavY2zAY2BX1KqJN0Oi/jt+8IzB8y8kfEg+s12k20yh4G+3
         ao8oG/mAZs+M5J9IX+T0hPtFDcxxJNhP0i/nET0IlqFyaUwrV3WdKqdfVzTnlj5+2fnn
         Gk8KL7dVsKqRXxkfwIiFMPJTq0XeCZmQ7kphIT755rHDSKqiTpSRTR4196LJEAr/20dl
         2JoN4c3rJnmaICNGW7NeiZQsntBNM9u5/DyY0fwrPjkOBMxRvyE2icJDaiuIid1FMA7Z
         5eivKLUusYVJ1MU89IXBbNvLslkyHosgN4rfupp5tDJAZpHjiNFiBGj5Zc1J69MsLrSZ
         2fzw==
X-Gm-Message-State: AJcUuke01LBzbDvAft3RmZP/t3UBGvwF3le8R83KSjJDICd3uvIMH8yF
        E4365y9mT+P24O0g4+hgwouguB9i
X-Google-Smtp-Source: ALg8bN6uTyJa7S2Cd18ixfPRWXMdBMSu233rYT8WOvhvho1QwzFM+Pu76LdWnT3sMbDBy6S4EYC8QA==
X-Received: by 2002:a17:902:e002:: with SMTP id ca2mr36595126plb.103.1548961385731;
        Thu, 31 Jan 2019 11:03:05 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id 128sm9890286pfu.129.2019.01.31.11.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:03:04 -0800 (PST)
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
 <20190131160137.GA31126@ulmo>
 <4d08ac86-f278-515f-2c68-564362b7f083@gmail.com>
Message-ID: <365fe7b3-7206-cefa-f10a-06b5db42c761@gmail.com>
Date:   Thu, 31 Jan 2019 22:02:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4d08ac86-f278-515f-2c68-564362b7f083@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 19:27, Dmitry Osipenko пишет:
> 31.01.2019 19:01, Thierry Reding пишет:
>> On Thu, Jan 31, 2019 at 06:02:45PM +0300, Dmitry Osipenko wrote:
>>> 31.01.2019 17:43, Thierry Reding пишет:
>>>> On Thu, Jan 31, 2019 at 05:06:18PM +0300, Dmitry Osipenko wrote:
>>>>> 31.01.2019 15:06, Thierry Reding пишет:
>>>>>> On Thu, Jan 31, 2019 at 03:05:48AM +0300, Dmitry Osipenko wrote:
>>>>>>> 30.01.2019 19:01, Sowjanya Komatineni пишет:
>>>>>> [...]
>>>>>>>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
>>>>>> [...]
>>>>>>>> +		return -EIO;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	dma_desc->callback = tegra_i2c_dma_complete;
>>>>>>>> +	dma_desc->callback_param = i2c_dev;
>>>>>>>> +	dmaengine_submit(dma_desc);
>>>>>>>> +	dma_async_issue_pending(chan);
>>>>>>>> +	return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
>>>>>>>> +				    bool dma_to_memory)
>>>>>>>> +{
>>>>>>>> +	struct dma_chan *dma_chan;
>>>>>>>> +	u32 *dma_buf;
>>>>>>>> +	dma_addr_t dma_phys;
>>>>>>>> +	int ret;
>>>>>>>> +	const char *chan_name = dma_to_memory ? "rx" : "tx";
>>>>>>>
>>>>>>> What about to move out chan_name into the function arguments?
>>>>>>
>>>>>> That opens up the possibility of passing dma_to_memory = true and
>>>>>> chan_name as "tx" and create an inconsistency.
>>>>>>
>>>>>>>> @@ -884,6 +1187,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
>>>>>>>>  
>>>>>>>>  	i2c_dev->is_multimaster_mode = of_property_read_bool(np,
>>>>>>>>  			"multi-master");
>>>>>>>> +
>>>>>>>> +	i2c_dev->has_dma = of_property_read_bool(np, "dmas");
>>>>>>>
>>>>>>> Not only the existence of "dmas" property defines whether DMA is available. DMA subsystem could be disabled in the kernels configuration.
>>>>>>>
>>>>>>> Hence there is a need to check for DMA driver presence in the code:
>>>>>>>
>>>>>>> 	if (IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>>>>>>> 		i2c_dev->has_dma = of_property_read_bool(np, "dmas");
>>>>>>
>>>>>> Do we even need the ->has_dma at all? We can just go ahead and request
>>>>>> the channels at probe time and respond accordingly. If there's no dmas
>>>>>> property in DT, dma_request_slave_channel_reason() returns an error so
>>>>>> we can just deal with it at that time.
>>>>>>
>>>>>> So if we get -EPROBE_DEFER we can propagate that, for any other errors
>>>>>> we can simply fallback to PIO. Or perhaps we want to restrict fallback
>>>>>> to PIO for -ENODEV?
>>>>>>
>>>>>> I wouldn't want to add an IS_ENABLED(CONFIG_TEGRA20_APB_DMA) in here.
>>>>>> The purpose of these subsystems it to abstract all of that away.
>>>>>> Otherwise we could just as well use custom APIs, if we're tying together
>>>>>> drivers in this way anyway.
>>>>>
>>>>> DMA API doesn't fully abstract the dependencies between drivers, hence
>>>>> I disagree.
>>>>
>>>> Why not? The dependency we're talking about here is a runtime dependency
>>>> rather than a build time dependency. Kconfig is really all about build-
>>>> time dependencies.
>>>
>>> My understanding is that Kconfig is also about runtime dependencies,
>>> do you know if it's explicitly documented anywhere?
>>
>> I don't think it's explicitly documented, just a common practice that
>> I've seen applied multiple times over the years. A quick grep through
>> the drivers/ subdirectory confirms that it's not typical to have this
>> sort of dependency in the code.
>>
>> Similarly, Kconfig uses select primarily to pull in dependencies that
>> are in the form of helper libraries and such. Occasionally you'll have
>> some ARCH_* option select a couple of features, or even drivers, but
>> that is mostly a shortcut to explicitly having to list the essentials
>> in a defconfig.
>>
>> Another reason why it's not good to model these runtime dependencies in
>> Kconfig is because they unnecessarily restrict the driver. For example,
>> if you want to build a specialized Linux binary for Tegra186, you will
>> certainly want to include the i2c-tegra driver. At the same time you
>> won't want to include the APB DMA driver because it doesn't exist on
>> Tegra186. Instead you'd want the (non-existent) GPC DMA driver. select
>> on the APB DMA driver will unconditionally pull in the driver, depends
>> will only allow you to build i2c-tegra if the APB DMA driver is also
>> enabled and the conditional in the code may lead to not using DMA
>> because the APB DMA driver is not available. So you'd have to modify the
>> i2c-tegra driver to take into account the GPC DMA driver.
>>
>>>>>>> Also Tegra I2C driver should select DMA driver in Kconfig to make DMA
>>>>>>> driver built-in when I2C driver is built-in:
>>>>>>
>>>>>> I don't think there's a requirement for that. The only dependency we
>>>>>> really have here is the one on the DMA engine API. Since dmaengine.h
>>>>>> already provides dummy implementations, there's really no need for
>>>>>> us to have the dependency. If the DMA engine API is completely disabled,
>>>>>> a call to dma_request_slave_channel_reason() will return -ENODEV and we
>>>>>> should just deal with that the same way we would if there was no "dmas"
>>>>>> property present.
>>>>>
>>>>> In my opinion it is much better to avoid I2C driver probe failing with
>>>>> -EPROBE_DEFER if we could. It's just one line in code and one in
>>>>> Kconfig.. really. 
>>>>
>>>> The problem is that from a theoretical point of view we don't know that
>>>> APB DMA is the provider for the DMA channels. This provider could be a
>>>> completely different device on a different Tegra generation (in fact,
>>>> the DMA engine on Tegra186 is a different one, so we'd have to add that
>>>> to the list of checks to make sure we don't disable DMA there). And the
>>>> fact that we're tightly integrated is really only by accident. We could
>>>> have the same situation on a SoC that incorporates IP from multiple
>>>> different sources and multiple combinations thereof as well, so how
>>>> would you want to deal with those cases?
>>>>
>>>> Agreed, failing with -EPROBE_DEFER is suboptimal in that case, but that
>>>> is really more of an integration problem. Ideally of course there'd be
>>>> some way for the DMA engine subsystem to know that the provider for the
>>>> given device node will never show up and give us -ENODEV instead, but,
>>>> alas, I don't even think that would be possible. That's the price to pay
>>>> for abstraction.
>>>
>>> It's not a big problem to solve for this case, there is
>>> of_machine_is_compatible(). To me it's more a question about the will
>>> to invest some extra effort to support all of possible combinations.
>>> If there is no such will, then at least those unpopular combinations
>>> shouldn't hurt and thus it should make sense to add an explicit
>>> build-dependency on the DMA drivers.
>>
>> I think we're arguing about the same thing, only coming at it from
>> different angles. For me "all possible combinations" also includes the
>> case where you want to be able to run the driver with DMA if the APB DMA
>> is not enabled. And I similarly want to be able to run without DMA if
>> the APB DMA is enabled (by explicitly removing dmas from DT for
>> example). It just seems that we can't have it both ways.
>>
>> Also the i2c-tegra driver can perfectly well function without DMA
>> support (it's done so ever since it was first merged). Keeping existing
>> functionality shouldn't require the addition of another driver.
>>
>> Given the deadlock, I think I'd prefer the option of adding the
>> conditional in the code. I think that's the most accurate description of
>> the dependency, even though ideally it would be handled transparently by
>> the DMA engine API. Would that be an acceptable compromise?
> 
> Adding conditional to the code is not enough. Tegra I2C driver could be built-in, while APB DMA driver is a loadable module, hence Tegra I2C will fail to probe with -EPROBE_DEFER. Tegra I2C must select all of the relevant DMA drivers to avoid that situation. Later on it shouldn't be a problem to add .has_gpc_dma to the tegra_i2c_hw_feature and then check in the code whether corresponding DMA driver is enabled or not in the kernel's config.
> 
> Combining the code checking with the Kconfig selection that I'm suggesting covers all of possible combinations, otherwise please give me an explicit example when it could fail.
> 

Hm, oddly TEGRA20_APB_DMA driver can't be built as a module because it is a bool in Kconfig, but the code has the remove function. Maybe someday somebody will clean out all that mess :) Hence, Thierry, your point make sense. Still could be good to make DMA support explicitly optional for the I2C driver by adding Kconfig option for it, given that it adds some extra complexity and not well tested, up to you to decide.
