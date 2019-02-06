Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB80C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081A820B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXd+udS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfBFON1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:13:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43090 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfBFON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:13:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so6133203lji.10;
        Wed, 06 Feb 2019 06:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aUHG7d3xHYvEgH+3O/qLLA3Mvo4iLlj8+8TJPghjq5s=;
        b=SXd+udS5WMKgExfKjMJreegtsJhRh9SMDl5y2aaJBKc9VMLnVTb9BW7pbhSBlSizBP
         iWRbLQhX/9Yb37ZXCtqdQnbWmNww37DbUrXGcdmll6Nr4LiK5vCgklq0eVzxLQTn74IC
         Ogf9+XQSSo9xm3FGgaLXukhHr5xYtkLQQjzKoOIDb5Pym7OFeSWW5D8AsiWu/37Ka1jj
         2qjHBZjFFhYPyHsrSlreZNovPEdOKEYuKI8lpO2T9hnQ5wisLxPD2/ofY4cKluEvxU2G
         K5I2uhO/84hKbt87UVxOD80EWWNkHCaljFzqDu926Lv3/k52qUxQcn0yUF7swzc8R6T2
         7yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aUHG7d3xHYvEgH+3O/qLLA3Mvo4iLlj8+8TJPghjq5s=;
        b=B7+B3gGcs9z/XEJQgIZUsBG4V1VHsA8/gprKED/Voq5CCp9cb6vWK2qG/ov8SNPd7i
         n+OVjeRgOIn/gIKNwUkR02gqiUaqOyEPD5n0YiK073Ge7v+oM/Z8Aq0uVzvcQbtaXo+5
         jBbetGAg3DyEvanqeQe1jfX1uaURnsJGZYj6xAM+RiJ/w5Ppz6ZDm7o6Nw1P67DdtVeQ
         z/53UNItdTZwggMvqJ/8d5yw3xKNhxttml2vJQEWMx3A44pLwJcOec/inR+TRTR0tLh2
         nob9aVT7aspXdbq4rR10q40sdXMPQkHmZX9AYjZdLE6KopI5wJhvGEALcVZjNpU65XLH
         Q67w==
X-Gm-Message-State: AHQUAuZRfgt/Ahc12CMIcPx7XC7y+GTWPSE7NfzPYrBs3DmBsutD1mD/
        zBzh8ta9C9CCpDMRuiN91X537QWS
X-Google-Smtp-Source: AHgI3IbPQk/ntKnCWfZQqkBaDa3ziuL7RQzMMbQDH4aTn1EAbp5O6PjHyi6fIp+sQ2aYja6BIN6l+w==
X-Received: by 2002:a2e:4819:: with SMTP id v25-v6mr6607100lja.2.1549462403554;
        Wed, 06 Feb 2019 06:13:23 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id w16-v6sm3870730ljw.11.2019.02.06.06.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 06:13:22 -0800 (PST)
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9b4bfee0-f3f2-bae7-5010-97a86bb5e03f@gmail.com>
Date:   Wed, 6 Feb 2019 17:13:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206140141.GO21676@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 17:01, Thierry Reding пишет:
> On Wed, Feb 06, 2019 at 01:51:12PM +0000, Sowjanya Komatineni wrote:
>>
>>>>>>> That's odd because it suggests that DMA actually completed, but 
>>>>>>> the message didn't.
>>>>>>>
>>>>>>> I'm not sure I understand how that could happen.
>>>>>>>
>>>>>>> What's also weird above is that there doesn't seem to be a DMA 
>>>>>>> that is started for that particular message. Or is the timeout 
>>>>>>> message a response to the prior transfer (length 10)? Seems like 
>>>>>>> that should not be possible because we get the "transfer complete" message.
>>>>>>
>>>>>> Wait, those are actually different instances of the I2C 
>>>>>> controller, so the relevant log entries are these:
>>>>>>
>>>>>> 	[    0.945445] tegra-i2c 7000d000.i2c: starting DMA for length: 16
>>>>>> 	[    0.945456] tegra-i2c 7000d000.i2c: unmasked irq: 0c
>>>>>> 	...
>>>>>> 	[    1.049224] tegra-i2c 7000d000.i2c: i2c transfer timed out
>>>>>>
>>>>>> And these don't happen if you use higher burst sizes or before the 
>>>>>> DMA series?
>>>>>
>>>>> I tried to enforce DMA without changing bursts:
>>>>>
>>>>> ----------
>>>>> diff --git a/drivers/i2c/busses/i2c-tegra.c 
>>>>> b/drivers/i2c/busses/i2c-tegra.c index c538ed5f8e2c..5d1c54ce7800
>>>>> 100644
>>>>> --- a/drivers/i2c/busses/i2c-tegra.c
>>>>> +++ b/drivers/i2c/busses/i2c-tegra.c
>>>>> @@ -6,6 +6,8 @@
>>>>>   * Author: Colin Cross <ccross@android.com>
>>>>>   */
>>>>>  
>>>>> +#define DEBUG
>>>>> +
>>>>>  #include <linux/clk.h>
>>>>>  #include <linux/delay.h>
>>>>>  #include <linux/dmaengine.h>
>>>>> @@ -1046,8 +1048,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>>>>>                 xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
>>>>>  
>>>>>         xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
>>>>> -       i2c_dev->is_curr_dma_xfer = (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
>>>>> -                                   i2c_dev->dma_buf;
>>>>> +       i2c_dev->is_curr_dma_xfer = !!i2c_dev->dma_buf;
>>>>>         tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
>>>>>         dma = i2c_dev->is_curr_dma_xfer;
>>>>> ----------
>>>>>
>>>>> Here is the log with this change:
>>>>>
>>>>> [    0.760796] tegra_rtc 7000e000.rtc: registered as rtc1
>>>>> [    0.760850] tegra_rtc 7000e000.rtc: Tegra internal Real Time Clock
>>>>> [    0.761050] i2c /dev entries driver
>>>>> [    0.918928] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>>>>> [    0.918940] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    0.919040] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    0.919050] tegra-i2c 7000c000.i2c: starting DMA for length: 8
>>>>> [    0.919059] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    0.919322] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    0.919335] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>>>>> [    0.919343] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    0.919440] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    0.919448] tegra-i2c 7000c000.i2c: starting DMA for length: 112
>>>>> [    0.919456] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    0.922818] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
>>>>> [    0.922829] atmel_mxt_ts 0-004c: Family: 160 Variant: 0 Firmware V1.0.AA Objects: 18
>>>>> [    0.922886] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>>>>> [    0.922895] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    0.922993] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    0.923002] tegra-i2c 7000c000.i2c: starting DMA for length: 224
>>>>> [    0.923011] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    0.933253] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
>>>>> [    0.933287] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>>>>> [    0.933297] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    0.933478] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    0.933487] tegra-i2c 7000c000.i2c: starting DMA for length: 12
>>>>> [    0.933496] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    0.945120] tegra-i2c 7000d000.i2c: starting DMA for length: 16
>>>>> [    0.945130] tegra-i2c 7000d000.i2c: unmasked irq: 0c
>>>>> [    1.038917] tegra-i2c 7000c000.i2c: DMA transfer timeout
>>>>> [    1.038982] atmel_mxt_ts 0-004c: __mxt_read_reg: i2c transfer failed (-110)
>>>>> [    1.039000] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>>>>> [    1.039006] atmel_mxt_ts 0-004c: Failed to read T44 and T5 (-110)
>>
>>
>>
>>>>> [    1.039009] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    1.039148] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    1.039157] tegra-i2c 7000c000.i2c: starting DMA for length: 4
>>>>> [    1.039166] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    1.039304] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    1.039340] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>>>>> [    1.039349] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    1.039535] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    1.039544] tegra-i2c 7000c000.i2c: starting DMA for length: 12
>>>>> [    1.039552] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    1.040055] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    1.040083] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>>>>> [    1.040092] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>>>>> [    1.040301] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>>>>> [    1.048934] tegra-i2c 7000d000.i2c: i2c transfer timed out
>>>>
>>>> This log shows DMA transfer timeout for atmel read.
>>>> Do you see issue if you don’t enforce dma all time and let it choose PIO Vs DMA?
>>>>
>>>
>>> No, there are no timeout errors in PIO mode. I could post full log with the PIO-only mode if you want.
>>>
>> Yes please post full log of PIO only and DMA only
>> Also, in above log, lots of DMA transfer went thru fine except this
>> one transfer where DMA timed out.
>> DMA completion doesnt happen on DMA submit during this particular
>> transaction timeframe for some reason.
> 
> Dmitry, can you provide some background information on the setup that
> you're using? I vaguely remember something about i2c@7000d000 being
> special on older Tegra devices. Perhaps there's something additional
> that we need to take into account?
> 
> Aha! Look at tegra_i2c_reg_addr() which special-cases I2C_TX_FIFO on
> the DVC variant of the controller, which is exactly the one that you
> are seeing the timeouts on and it's exactly the register that we use
> as destination for the DMA transfer.
> 
> I think we need to do something like this:
> 
> 	slv_config.dst_addr = i2c_dev->base_phys + tegra_i2c_reg_addr(i2c_dev, I2C_TX_FIFO);
> 
> to make sure we pass the right FIFO register address to DMA.

I'm running it on T20 at the moment. I don't know about the DVC quirks, but sounds plausible. Please let me know if you need any other info.

Here the full logs:

PIO-only: http://dpaste.com/2MX3EAN.txt
DMA-only: http://dpaste.com/3VXZSSM.txt

Note the "Failed to read T44 and T5 (-110)" error that happens in DMA-only. And it happens on i2c@7000c000, DVC is i2c@7000d000.
