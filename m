Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B400C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1672186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhKim9lS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfBFOfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:35:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40321 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:35:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so6234687lji.7;
        Wed, 06 Feb 2019 06:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=25Mdd5zqTPgmCOWRFk/cvCLecFWgX/QQ4KBH0CxM2Zk=;
        b=HhKim9lSLsYBtk/7WtPCmm7NnI0b0KFv27Uj3dDLJHUO2+zrg8fFR3LeUwl/oKOhnB
         5Rg3/a5mQi3LdPOtLnmK0eHeucvQnaPV+km1+KKcof/Dx1GKwWNvgGGwBNZfMYrWBIF5
         yQctRoKUkHSuRd5049jI4UfcqQ4vGJqI2DC0lwP1H/sOj76hVqPe8iXdJNm6PU62P3cj
         5oyR2C7lZ44vNRtEiodb7GsGjwLbxIsJl7d9ToIVWKlz6bRcRAB8/sDONY6rRwMD/jd4
         VAOF52aTIs9cV2vvwUMWrN8GMOOjBsFP5ZpL8wO0i/3Lg0gg0xSvEu4yfVJz17SgW6B/
         +oVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=25Mdd5zqTPgmCOWRFk/cvCLecFWgX/QQ4KBH0CxM2Zk=;
        b=WlCpNLvC6RQT+9dZfF9x37ISlrZIealHTIyOr6X+yLpPh0IxqhwXP6OtwhQGvahuhk
         Kbls3+Ml2pzqvLiUiSF7kAmzkwjGOzQQuaxDepgeZ2aRC0EPLT4MwOEMk0EzXxsgPzb0
         7Scd3tkqMDT5bn7/h16PY5s6W6hEmOArHVQZWmowrw3ENf+ebmi03ilHaHHgXYfUyWbu
         QfVDzr9ghr7uumL7Wpj34fhAut9xkzSTbly84PI72vW71MmCJJhuCjIgEkAh/FPmvSi0
         oBJVuuXH5krh+UOPr/9Lik8uCGcZEasjwezqnH/SyLSEHrdfzDB/aV0Ij6JjJGnfkola
         bzlA==
X-Gm-Message-State: AHQUAuaiyu2la3EoCMqLWeTbvpTt4o1B8tmfEemqAufIp0OZp/Sdpxte
        UjGccmclFUVhlFKRs4SC2qRkXHdC
X-Google-Smtp-Source: AHgI3IYIr5OlE6jw4Fplvhdz4QEseTrng75RLY1FbelCYoEcC2rPL02HGINEZdhERBveVV6JqqL/ZA==
X-Received: by 2002:a2e:81a:: with SMTP id 26-v6mr6698149lji.14.1549463717457;
        Wed, 06 Feb 2019 06:35:17 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id r1-v6sm3873899ljb.64.2019.02.06.06.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 06:35:16 -0800 (PST)
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <20190206130909.GJ21676@ulmo> <20190206131310.GK21676@ulmo>
 <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
 <BYAPR12MB33983A0E93B17808DECFD0F2C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6edef92d-66a7-0f70-e59e-7381b82516eb@gmail.com>
 <BYAPR12MB339826EB972C5DB7957E8A82C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33989329D0E0C0049F1DEA6EC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190206140141.GO21676@ulmo>
 <9b4bfee0-f3f2-bae7-5010-97a86bb5e03f@gmail.com>
 <BYAPR12MB3398D7685B5A7462161F9578C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <649cdfb4-214e-bf01-348d-f950628ecf9b@gmail.com>
 <BYAPR12MB33988A49F8831BD8CAB575E5C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2f6ac9c6-bdc8-2a48-8f95-d761d5d56d8d@gmail.com>
Date:   Wed, 6 Feb 2019 17:35:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33988A49F8831BD8CAB575E5C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 17:29, Sowjanya Komatineni пишет:
> 
>>>>>> Yes please post full log of PIO only and DMA only Also, in above 
>>>>>> log, lots of DMA transfer went thru fine except this one transfer 
>>>>>> where DMA timed out.
>>>>>> DMA completion doesnt happen on DMA submit during this particular 
>>>>>> transaction timeframe for some reason.
>>>>>
>>>>> Dmitry, can you provide some background information on the setup 
>>>>> that you're using? I vaguely remember something about i2c@7000d000 
>>>>> being special on older Tegra devices. Perhaps there's something 
>>>>> additional that we need to take into account?
>>>>>
>>>>> Aha! Look at tegra_i2c_reg_addr() which special-cases I2C_TX_FIFO on 
>>>>> the DVC variant of the controller, which is exactly the one that you 
>>>>> are seeing the timeouts on and it's exactly the register that we use 
>>>>> as destination for the DMA transfer.
>>>>>
>>>>> I think we need to do something like this:
>>>>>
>>>>> 	slv_config.dst_addr = i2c_dev->base_phys + 
>>>>> tegra_i2c_reg_addr(i2c_dev, I2C_TX_FIFO);
>>>>>
>>>>> to make sure we pass the right FIFO register address to DMA.
>>>>
>>>> I'm running it on T20 at the moment. I don't know about the DVC quirks, but sounds plausible. Please let me know if you need any other info.
>>>>
>>>> Here the full logs:
>>>>
>>>> PIO-only: http://dpaste.com/2MX3EAN.txt
>>>> DMA-only: http://dpaste.com/3VXZSSM.txt
>>>>
>>>> Note the "Failed to read T44 and T5 (-110)" error that happens in DMA-only. And it happens on i2c@7000c000, DVC is i2c@7000d000.
>>>
>>> Yes this is due to same issue theirry mentioned.
>>> Prior to transfer timeout for touch, tps6586x regulator probe failed due to i2c timeout which uses DVC (7000D000) and since DMA mode is enforced all DVC/PWR I2C transactions also go thru DMA and FIFO register for DVC offset is not accounted when configure to dma slave.
>>> Will fix and send so you can see for repro with updated patch..
>>>
>>>
>>> [    0.925155] tegra-i2c 7000d000.i2c: starting DMA for length: 16
>>> [    0.925165] tegra-i2c 7000d000.i2c: unmasked irq: 0c
>>> [    1.028961] tegra-i2c 7000d000.i2c: i2c transfer timed out
>>> [    1.028968] tegra-i2c 7000c000.i2c: DMA transfer timeout
>>> [    1.028995] tps6586x 3-0034: Chip ID read failed: -110
>>> [    1.029029] tps6586x: probe of 3-0034 failed with error -5
>>> [    1.029045] atmel_mxt_ts 0-004c: __mxt_read_reg: i2c transfer failed (-110)
>>> [    1.029051] atmel_mxt_ts 0-004c: Failed to read T44 and T5 (-110)
>>>
>>
>> I think tps6586x and atmel-touch should be independent issues, but will see. Thanks!
> Whats your platform setup? Is atmel touch power ON default or its programmed during boot by SW whcih need to use DVC?
> 

It's "power ON default". I tried to boot in PIO-only mode with tps6586x disabled and there is no "Failed to read T44 and T5" error, atmel probed successfully.
