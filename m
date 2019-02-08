Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF38C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F026D20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfR8zk4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfBHOcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:32:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45799 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBHOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:32:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so2651250lfa.12;
        Fri, 08 Feb 2019 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mvIc4dhIg9Wnqxnnl4loTbrWqnDq8Qs0p5CMfXRijSs=;
        b=VfR8zk4aAgXVKavUkBU/71ML2bPpDAE7R7WNy94/f9oz6WPmqjouStTWP44OZqNrj5
         7vmMl2JzBQvNOAyR/0kP2RrbezD4GgB/lHQKJZrismba06TUsotZJCo7eZ93BTga81u7
         9y+nT3TwkRSMuzmINn3VV3IwbCDtJ0LpnPjgQ+AKO7jkw4u+ZnH2LIFEcu8xwyAaXLdd
         ecr42s6Rq1cYsXj16uVZPyZBTEDCc8zr7lJTCUkDfpmgGVJ7p3wFoVE7yRNvIXBCQGQo
         1StV/E736n1KNAsv3RKWuo9euYENL9YAEmMF85euss/zJ67gORSwlqak37jpB9x9gF1P
         wMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mvIc4dhIg9Wnqxnnl4loTbrWqnDq8Qs0p5CMfXRijSs=;
        b=aLP/pTLIiJWNZsg3DNJ1XzvnFXRVt3Kg8hMBoDssu/Hnqx+ZV75tNES927LnjAv/UY
         6EuV5xFcEXMWG0PqUK2wljzB/qstbJ/8RHGOx5Rii1BrKIf4I9t3lQGdWE5XVWRUcTIO
         X2jhjWDjCKO8Opn2nE2GsGZThg28gYmPF3ADr0nWPZJKxv6mFUQIRyWnvH6VX0v+GxGg
         uXH61FJxxXOYWhUFKR2b8iKaY7lRJShJI5LHL3PcL1cbK9efbUrMWApGL4bCmnriv964
         YoNy577VEaTVXeVkGRg3hQhyhP5WXR5iD2PLX23LfaRiY+IDX2t8vgcHEYkqJxFgfkiS
         o+vw==
X-Gm-Message-State: AHQUAua4jfNnw77ddCcn4mprv5cqL0wRRRpasoisclUPDCpVbEa7V1Mk
        b0x+xvycOfTQHz+PruGJZF3FXYRU
X-Google-Smtp-Source: AHgI3IbLIdOSQJw7r4XnPKLgNIu/FsfTljvuTexGwTnGhBqdbqQdASapRbU8tQzJ03IFoq64qipw/A==
X-Received: by 2002:a19:750a:: with SMTP id y10mr95772lfe.157.1549636323060;
        Fri, 08 Feb 2019 06:32:03 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id u22sm392856lfu.78.2019.02.08.06.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:32:02 -0800 (PST)
Subject: Re: [PATCH V15 3/6] i2c: tegra: fix maximum transfer size
To:     Peter Rosin <peda@axentia.se>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mkarthik@nvidia.com" <mkarthik@nvidia.com>,
        "smohammed@nvidia.com" <smohammed@nvidia.com>,
        "talho@nvidia.com" <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-3-git-send-email-skomatineni@nvidia.com>
 <1202cc91-cacf-673e-c32b-b4d1c78b71f2@gmail.com>
 <515cb722-c345-8dd6-dbe5-557dec0d1384@gmail.com>
 <a57f0374-8468-f24a-1743-b446b8260a46@gmail.com>
 <9e8f26bb-2159-6ca4-783e-91a73dac0823@axentia.se>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <96a3955f-ef4f-e4df-4907-6ec760fad3fe@gmail.com>
Date:   Fri, 8 Feb 2019 17:32:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <9e8f26bb-2159-6ca4-783e-91a73dac0823@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 17:12, Peter Rosin пишет:
> On 2019-02-08 13:46, Dmitry Osipenko wrote:
>> 08.02.2019 1:25, Dmitry Osipenko пишет:
>>>> 08.02.2019 1:16, Sowjanya Komatineni пишет:> 
>>>>>> This is wrong, 65535 = 64 * 1024 - 1.
>>>>>>
>>>>>> Let's just use size-constants provided by kernel:
>>>>>>
>>>>>> static const struct i2c_adapter_quirks tegra_i2c_quirks = {
>>>>>> 	.flags = I2C_AQ_NO_ZERO_LEN,
>>>>>> 	.max_read_len = SZ_4K,
>>>>>> 	.max_write_len = SZ_4K - I2C_PACKET_HEADER_SIZE, };
>>>>>>
>>>>>> static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
>>>>>> 	.flags = I2C_AQ_NO_ZERO_LEN,
>>>>>> 	.max_read_len = SZ_64K,
>>>>>> 	.max_write_len = SZ_64K - I2C_PACKET_HEADER_SIZE, };
>>>>>>
>>>>>>
>>>>>> I'll take a look at other patches later today, no need to send out new version right now.
>>>>>>
>>>>>>
>>>>>
>>>>> SIZE_64K is 0x00010000 (65536)
>>>>>
>>>>> msg len is u16 and max that can be set to msg.len is 65535
>>>
>>> Ah, okay. Then it looks about right, maybe it's time to change u16 to u32 in the I2C core.
>>>
>>
>> Here is my suggestion:
>>
>> 1) Use SZ_4K / SZ_64K that I suggested above.
>>
>> 2) Squash this patch into the DMA-patch.
>>
>> 3) Add another patch (before the DMA-patch) that changes max_read_len/max_write_len types to u32 in the include/linux/i2c.h
> 
> That is a bit naive and will not fly since the I2C core has a max message
> size of 65535. Which is exposed to user space...
> 
> Given the above, saying .max_read_len = 65535 a NOP (and is in fact omitted
> in places where it would be needed if the type is changed). I suggest that
> it is omitted here as well. But SZ_64K - I2C_PACKET_HEADER_SIZE is still
> needed of course. At least if I2C_PACKET_HEADER_SIZE is guaranteed to be
> non-zero?

Ah, I missed that message len is also u16 and then we indeed could just drop the "max_read_len" for T194. Thank you Peter.

Sowjanya, given the above, it probably better to define dma_buf max-size in the tegra_i2c_hw_feature.
