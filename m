Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24261C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16682175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG3xUS5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfBFNGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:06:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44706 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfBFNGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:06:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so5242114lfe.11;
        Wed, 06 Feb 2019 05:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QsRDa3ARBgIjfOnDoJ2f9NcB3vbF15mzRS/pT7O0YI8=;
        b=fG3xUS5gVZUhpg3tBumrBsuQNptoEJ7gEeEEp8zyUKfTrfXNGHruJdus8pQ/Rgav1G
         D2heOMsaa18n+uvcLBIPjt9PUyKRTTQQP7HiZt7MFTj4QYAs3IzEuzNwrvCDZUEbMyEQ
         ehW9zEwltRBVy6FEbVbqrQakx/i/61rE9REhJVH+wqeViFFnpPgxC8qIHp/2Fh8HtzMa
         2H+yULmyA5PtjnU1BlIkgGgNCJTDtEPWbXU9du4w+IWxbt27wbltJSX30Y2oU3hZvqOY
         CrgU/M8cYzKTd8Xbbhnv4AAM25D6lCzapNIqbTVxb8QrE/N++S6i0GFrqdEmsnISA5aU
         DnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QsRDa3ARBgIjfOnDoJ2f9NcB3vbF15mzRS/pT7O0YI8=;
        b=QFniCZPrfbYNNMeeL66/KL+p0XjdrsWaXC6MQ0A6/IejVFaWsbOTqBTf0M3ZbJNmIL
         sSkcT23pGiD6rhX/InQI2oflemK+/JTGLfHNYmY/bN1erz9jXe6UZ/eGS2EZWOfsDq/U
         IXh8aigLau8U25MQow6x52ToJsWKGMvw+aLFqhw+C0uIpLyXj4tPMkmw0aFG8kCKxiAO
         1NmQzaIKh+++znA7tHLCkt8Fmt+03hkBIFGhiiYsslcDHsvxHJ4os9mqQ0oIbDHm2Ulw
         VJSLjW7dFZUIpG9OvMb2S739Fcg6/3Mo5wEWWlCHl0gcTPMV+yT88S2mUFxcGQUpiH2I
         9Upw==
X-Gm-Message-State: AHQUAubgEOJlh9iUILZYLJ/h6Kl0Rk6Hcq1tUd2TuRfEMHF4tvjHr1Yg
        eDhQlCsbUtCVLUsoJcMn1q2Ty5x0
X-Google-Smtp-Source: AHgI3Iba0rvaj69ghXcenhnLKlhw1eiNIGK6snwhe99ATA0TZj5PEJRzucFKNG6fmKdgoAcrLABmkA==
X-Received: by 2002:a19:2906:: with SMTP id p6mr6406229lfp.17.1549458406609;
        Wed, 06 Feb 2019 05:06:46 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id b16sm659150lff.33.2019.02.06.05.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 05:06:45 -0800 (PST)
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
 <BYAPR12MB33983AF91EA28744B7614971C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d3414641-5f5f-18b8-196f-50b3b9f26c58@gmail.com>
Date:   Wed, 6 Feb 2019 16:06:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33983AF91EA28744B7614971C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 15:49, Sowjanya Komatineni пишет:
> 
>> 		TEGRA_I2C_TIMEOUT);
>>>  	tegra_i2c_mask_irq(i2c_dev, int_mask); @@ -814,6 +1133,7 @@ static 
>>> int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>>>  		time_left, completion_done(&i2c_dev->msg_complete),
>>>  		i2c_dev->msg_err);
>>>  
>>> +	i2c_dev->is_curr_dma_xfer = false;
>>
>> This line could be removed because there is no need to clear "is_curr_dma_xfer" at this point.
>>
> 
> It is needed because in case of ARB_LOST, we terminate dmaengine and then we perform bus clear operation. 
> On bus clear done interrupt, it again goes thru I2C error section to mask all interrupts and when curr_dma_xfer is true it does dmaengine terminate again so setting curr_dma_xfer as false when transfer in dma mode is done.

Ah, okay. Thank you for the clarification.

>>
>>
>> Sowjanya, I tried to enforce DMA transferring + setting DMA burst to a one word and this combination doesn't work well while it should, if I'm not missing something. Could >you please take a look at the problem or explain why that happens?
>>
>>
>> [    1.017496] tegra-i2c 7000c000.i2c: starting DMA for length: 120
>> [    1.017504] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    1.020896] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
>> [    1.020909] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    1.020918] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    1.021055] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    1.032230] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    1.032239] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    1.032359] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    1.032368] tegra-i2c 7000c000.i2c: starting DMA for length: 12
>> [    1.032376] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    1.032704] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    1.049224] tegra-i2c 7000d000.i2c: i2c transfer timed out
>>
>>
> I don’t see any issue with dma burst of 1 word irrespective of transfers in always dma mode.
> One strange thing is in your above log, for last transaction after transfer complete, there is i2c transfer timed which doesn’t make sense.
> If transfer timeout happens, it returns from i2c transfer but shouldn’t go thru transfer complete

For now I don't have any good ideas about what is wrong, will take a closer look.

>> I'm now also wondering whether that putting packet_header into the dma_buf is really needed at all.. Isn't possible to push packet_header using PIO regardless of whether > the rest of the transfer will be in DMA or PIO modes?
>>
>> Actually I tried to always push packet_header using PIO and apparently DMA works just fine with that:
>>
> Ofcourse it will work using PIO for packet header and dma only for data bytes. But packet header is just 12 bytes so why not we transfer it along with data together thru dma.
> 

Okay!
