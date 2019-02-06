Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9AEC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0303720B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcFpOi4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfBFNe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:34:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33499 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbfBFNe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:34:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so6082785ljd.0;
        Wed, 06 Feb 2019 05:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/TraXGrpDP3HhfJyy42ewoBODhy2MaW9/YMdeSly3V0=;
        b=FcFpOi4k0aoJ885OUpxt2BzrSHEvw8P9ptsVozFOWZLdEyN7LT2DGaBw5vhC4VEBWa
         NF98TPEuhb7SbaR/Ye+NnznrlW/dlqmKorhumcVmc0XWBFkixFodm8plSfQ34FIaKxmG
         jz4fTGN1FrD/cl0BsZ4BtOe1D8UZg1oGVw/gR4i7WtD1punzbutOJHde3YApRmzy1ewU
         FL5Wk3ofYr1paz4cHhcOwl+osXH5vs1oBVC5sKF4jZrmHWPpa0ZOZGr2YywT6Ac5+6kR
         qqpVx9G0pmG33mkjp44jkRjp66aMPG1RQq6MGi/RDRDdJwDdUcfC8ZqQKSlJz6hxdZ19
         8lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/TraXGrpDP3HhfJyy42ewoBODhy2MaW9/YMdeSly3V0=;
        b=dIOo/joiglan+K4haFU9To31Df1YWTyA6tjwsIdPsLeSJ897nvwztYihWqAJ5+7QP9
         xt002DcCEJLAedjObxEDlkaR9UVfbaU6B+tyhqD7x8lmN251K1p+1/SnVkL/fxmg5eq+
         Z4RSOTVqQi8nROJDSYA2NB7oE/7vEuPyWXYM/vR+nDdxFQ8jdW0wfz6T/7bOxbVrK0OV
         wtQ7vhpQxHVPI6d7H7255ON03dq0SO/SMM91Q4r3472Z4goNflJTEQzLsXZ5GFKKvtHB
         tLM+dItqz7mDFARO6Wliv7VRhjldRetKifri+GlnUHfRyiq7Gsg/IMXf7XJWLcZHN+dG
         lFaw==
X-Gm-Message-State: AHQUAuaaa8pCy067VQ6zP7E8f9DeUBEHOOM6rIwZzSz4OvVquFduKT9i
        hYCRx2dzbFmk5XPGWzAHNYl4nMhK
X-Google-Smtp-Source: AHgI3IaW8JM+TR0TOj4KCNswX36Xosy8uQTFuUrVMlmO1dlQrcWMkdUiKOVT4eXlqD4fDBEbJEkijg==
X-Received: by 2002:a2e:9556:: with SMTP id t22-v6mr6431212ljh.36.1549460093841;
        Wed, 06 Feb 2019 05:34:53 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm3803303ljf.28.2019.02.06.05.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 05:34:53 -0800 (PST)
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <c4f67e39-df72-cc56-216b-8e6014891b52@gmail.com>
 <BYAPR12MB3398E50ED1C6909D6BCB0DDFC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <304c1916-e836-fa95-5cec-887fef8f3eb2@gmail.com>
 <BYAPR12MB33986680570EB919369000F3C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <82f38909-94f1-7984-2b0f-df6231aee58f@gmail.com>
 <BYAPR12MB3398B4A862E4BFA5344AE461C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB3398501ACBC54906F677C661C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0cec3f47-6c47-b31d-74b5-696bd1f48596@gmail.com>
Date:   Wed, 6 Feb 2019 16:34:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398501ACBC54906F677C661C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 16:30, Sowjanya Komatineni пишет:
> 
> 
>>>
>>>>>> BTW, I'm seeing "atmel_mxt_ts 0-004c: Warning: Info CRC error - device=0xF436DC file=0x000000" whithout making any modifications to the original patch as well and it shall not happen, hence there is bug somewhere. Probably FIFO triggers are still not set up correctly... ?
>>>>>>
>>>>>>
>>>>> In snippet you sent, I see you are forcing dma_burst to 1 always which is what set for fifo trigger levels as well and also you are forcing dma all the time.
>>>>> So always it will be 1 word dma burst and 1 word trigger level and that should not be an issue.
>>>>>
>>>>
>>>> I reverted that snippet, this log is collected with the yours original patch.
>>>>
>>> From atmel driver, looks like this warning is from maxt_update_cfg 
>>> and due to CRC mismatch and above values shows read data CRC is 0Xf436dc which is compared against info_crc of all 0's Info_crc is based on raw config file and somehow its all 0's. this is not based on data read thru i2c.
>>> data->info_crc computed on data read is 0Xf436dc
>>>
>>> This warning is not related to I2C transfer
>>>
>>
>> It doesn't happen with the I2C PIO mode. Seems it means that the I2C reads out the 0xF436DC value instead of 0x000000.. if I'm not missing anything.
>>
> Log that you shared this warning, doesn’t show any i2c failures with atmel and CRC based on i2c read  data is 0Xf436dc.
> During this log, there are not DMA timeouts associated during this warning timeframe. So i2c read data is thru DMA which is non-zero.
> 
> Do you see DMA timeouts associated with this warning? I meant any DMA or I2C timeout during that time frame of warning?
> 

Actually you're right, my bad. That atmel error and atmel I2C timeout (due to I2C_ERR_NO_ACK) happens in the PIO mode too, hence that part is fine.

PIO log:

[    1.028889] atmel_mxt_ts 0-004c: Warning: Info CRC error - device=0xF436DC file=0x000000
[    1.078907] atmel_mxt_ts 0-004c: Resetting device
[    1.128646] usb 1-1: new full-speed USB device number 2 using tegra-ehci
[    1.198708] atmel_mxt_ts 0-004c: __mxt_read_reg: i2c transfer failed (-121)
[    1.198732] atmel_mxt_ts 0-004c: Failed to read 28 messages (-121)
