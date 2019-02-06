Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E2DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CB92175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo3BotPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfBFNmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:42:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41557 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfBFNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:42:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id j1-v6so2135345lja.8;
        Wed, 06 Feb 2019 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5iuzvviaUc9UAagsY+qfjYLk+jF988/exC9/tFrvaLs=;
        b=Jo3BotPlSHo6njhs+E8fTSjve/86eyKG9oyjQYkWAmuuhRPtH3J55aUFatj8/H+ilF
         lXuVS+lbX07135lJ1d3/wv+4QX/mNBAk2YCmPaYWv8QlesIeCL0j9gLIHN/YnxmiA5Va
         iKditLQC64lHwhtVlNkPrXxEmqaljpFCowCeK6m5yh0qKk7UbqMAhT9WDaESTP8mjliV
         TyTVWRt4kBOGlJg0Pf9cgitKqGkWsUxBcR9jtiv1a1ZgT0jh/aVqapiMDJClQihxU6uq
         LXaDXMlcly3e5cQhud9l+yjLORTaCIUbOXdrPn5G3wAteYzOXnninnBv0TfrS4pUGa+6
         IWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5iuzvviaUc9UAagsY+qfjYLk+jF988/exC9/tFrvaLs=;
        b=WllQ9k0Y9NkedVSWOYTPIHOUgN/YHv+BbTqukOj53a2jfcvmjoYUoNkJgtrh7KNoPq
         PbcUsirFJ00X6WGn3iDCKGvLTVJUX/y8/wxWMe9OxRDD1ZCeCRi/LaiutXhxHJVjPnyp
         XRRurxQlzrL+009vZGh2dfdDYgVzFPKMUe4AI/l+lvo03ZI5w2IWvnkT+muycUih2bf8
         9HdpJ3xkjBaoaVxEJvbnMoUDE853ZZo48D3Ey92T+zIcSBu/5D9hvuVS0jYF34FJah6E
         gr0my4g90kYu7LVmwbM/LMl3m9piKePydx5ml0eStQq8c6IMh+zeLtUhPzw+1uKTzSI9
         LT8Q==
X-Gm-Message-State: AHQUAuajavFRsq+EiNM9R+HUFq2Ppf5Ulz0i5j3EkBNDKzE1zfcCeKkC
        8tg1KFdq1VLxmGvarQM63OEFp/Ke
X-Google-Smtp-Source: AHgI3IbKuebd990Zj7vEyaFGqOLrXaZSIR4RNXKtk/f99nEt7WhuCnzzEbVG7+qVCC7C5/sm9jEUrw==
X-Received: by 2002:a2e:6f11:: with SMTP id k17-v6mr6438564ljc.94.1549460539247;
        Wed, 06 Feb 2019 05:42:19 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id y10-v6sm3721709ljy.65.2019.02.06.05.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 05:42:18 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6edef92d-66a7-0f70-e59e-7381b82516eb@gmail.com>
Date:   Wed, 6 Feb 2019 16:42:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33983A0E93B17808DECFD0F2C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 16:25, Sowjanya Komatineni пишет:
> 
> 
>>>> That's odd because it suggests that DMA actually completed, but the 
>>>> message didn't.
>>>>
>>>> I'm not sure I understand how that could happen.
>>>>
>>>> What's also weird above is that there doesn't seem to be a DMA that 
>>>> is started for that particular message. Or is the timeout message a 
>>>> response to the prior transfer (length 10)? Seems like that should 
>>>> not be possible because we get the "transfer complete" message.
>>>
>>> Wait, those are actually different instances of the I2C controller, so 
>>> the relevant log entries are these:
>>>
>>> 	[    0.945445] tegra-i2c 7000d000.i2c: starting DMA for length: 16
>>> 	[    0.945456] tegra-i2c 7000d000.i2c: unmasked irq: 0c
>>> 	...
>>> 	[    1.049224] tegra-i2c 7000d000.i2c: i2c transfer timed out
>>>
>>> And these don't happen if you use higher burst sizes or before the DMA 
>>> series?
>>
>> I tried to enforce DMA without changing bursts:
>>
>> ----------
>> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c index c538ed5f8e2c..5d1c54ce7800 100644
>> --- a/drivers/i2c/busses/i2c-tegra.c
>> +++ b/drivers/i2c/busses/i2c-tegra.c
>> @@ -6,6 +6,8 @@
>>   * Author: Colin Cross <ccross@android.com>
>>   */
>>  
>> +#define DEBUG
>> +
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>>  #include <linux/dmaengine.h>
>> @@ -1046,8 +1048,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>>                 xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
>>  
>>         xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
>> -       i2c_dev->is_curr_dma_xfer = (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
>> -                                   i2c_dev->dma_buf;
>> +       i2c_dev->is_curr_dma_xfer = !!i2c_dev->dma_buf;
>>         tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
>>         dma = i2c_dev->is_curr_dma_xfer;
>> ----------
>>
>> Here is the log with this change:
>>
>> [    0.760796] tegra_rtc 7000e000.rtc: registered as rtc1
>> [    0.760850] tegra_rtc 7000e000.rtc: Tegra internal Real Time Clock
>> [    0.761050] i2c /dev entries driver
>> [    0.918928] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    0.918940] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.919040] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    0.919050] tegra-i2c 7000c000.i2c: starting DMA for length: 8
>> [    0.919059] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.919322] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    0.919335] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    0.919343] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.919440] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    0.919448] tegra-i2c 7000c000.i2c: starting DMA for length: 112
>> [    0.919456] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.922818] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
>> [    0.922829] atmel_mxt_ts 0-004c: Family: 160 Variant: 0 Firmware V1.0.AA Objects: 18
>> [    0.922886] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    0.922895] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.922993] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    0.923002] tegra-i2c 7000c000.i2c: starting DMA for length: 224
>> [    0.923011] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.933253] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
>> [    0.933287] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    0.933297] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.933478] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    0.933487] tegra-i2c 7000c000.i2c: starting DMA for length: 12
>> [    0.933496] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.945120] tegra-i2c 7000d000.i2c: starting DMA for length: 16
>> [    0.945130] tegra-i2c 7000d000.i2c: unmasked irq: 0c
>> [    1.038917] tegra-i2c 7000c000.i2c: DMA transfer timeout
>> [    1.038982] atmel_mxt_ts 0-004c: __mxt_read_reg: i2c transfer failed (-110)
>> [    1.039000] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    1.039006] atmel_mxt_ts 0-004c: Failed to read T44 and T5 (-110)



>> [    1.039009] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    1.039148] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    1.039157] tegra-i2c 7000c000.i2c: starting DMA for length: 4
>> [    1.039166] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    1.039304] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    1.039340] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    1.039349] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    1.039535] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    1.039544] tegra-i2c 7000c000.i2c: starting DMA for length: 12
>> [    1.039552] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    1.040055] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    1.040083] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    1.040092] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    1.040301] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    1.048934] tegra-i2c 7000d000.i2c: i2c transfer timed out
> 
> This log shows DMA transfer timeout for atmel read.
> Do you see issue if you don’t enforce dma all time and let it choose PIO Vs DMA?
> 

No, there are no timeout errors in PIO mode. I could post full log with the PIO-only mode if you want.
