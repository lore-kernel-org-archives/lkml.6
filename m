Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CCC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3419621738
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJTADGxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfA2DMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:12:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46479 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfA2DMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:12:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so8964062pfe.13;
        Mon, 28 Jan 2019 19:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pzbzUxuc5l78aFWZpDvT2UuYMY7xsK52+UZ108r6hto=;
        b=aJTADGxTW+DFfnXqEpwuoMD6s4JFSqs1xN4ifIw4Ho31yo1MQjUy2JDj42vr6PzTv8
         gzf3+5x+pBhA4EXxQdn+zQxu2wU6+Z7ObJzeDo3JGVjXaRzApOMMsVPai1ZHbhTf7byd
         sYFsyBCl5hFDFzbaemPB8lVG7xzyhNEbjsQLBpEjcxXf7ErW6Jt9RIHxKD5camhVmgkq
         pUoBhgyB25cVJxK/XCOhMpd+7qebV1wCpT2ztx+Is0f2mFFA2ENFL2vdKOlavcmhLsTR
         JpB6/fEM4pj4xF6OBr/dKPi5ppMMqq3diFxoj63I/cb/n+Hb2r8UfDzZQeDAaGV2ZAi9
         8xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pzbzUxuc5l78aFWZpDvT2UuYMY7xsK52+UZ108r6hto=;
        b=I4erPeueTKk3x/7flTsJ5h+SA83h8QzfHT4iBXiAZIFTrWXxB0qSrOIf1+1jzMBhuT
         Y3Dey4YXiiMpYr7rw+BAGsn0qUcVkiYHJLF5xU+EuvdKaSGe7pgbmhI389RHvE71BOb5
         pX9MoqGZFgMnH7vhbRXG0aETnn5lKV2LWWrTNk1rOMdvY+AM551qywf6iH7FLgnoub9F
         GCnIq0LHIv3ArmZCjOJMdQYOFdDaF7iWb/ML40qyVnVNLODgkq0tTRDcUIgitdmg2eXY
         edUzeTgV40DJTjZE0VzsxAPzTZ07S6NwLxUXED89VX7+/n8D51a8GpNxl4OLj2jSLzsV
         6KUQ==
X-Gm-Message-State: AJcUukc7xuKTfqzMdsqG/tAzU+M65Uzumk/6YGrWgx67Et/7xQdW6kN/
        ysT5V2+tbrfYPoYFthq2Ze30/iDG
X-Google-Smtp-Source: ALg8bN62zPIPjOXU4J69Vick9dowc8LgrHfS67Ujz12vN9/o0kvAtGDXCZW30DMVHu5tgBS3rDy9EQ==
X-Received: by 2002:aa7:8045:: with SMTP id y5mr24209182pfm.62.1548731524828;
        Mon, 28 Jan 2019 19:12:04 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id y89sm53696488pfa.136.2019.01.28.19.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 19:12:04 -0800 (PST)
Subject: Re: [PATCH V3 3/3] i2c: tegra: Add DMA Support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-3-git-send-email-skomatineni@nvidia.com>
 <5973707c-555f-a27c-2ff3-e867d4b2cde7@gmail.com>
 <BYAPR12MB339874021C106E447529E887C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB339837F4E341F7911F1E1E67C2970@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <778d578f-6bee-1acb-0562-6657ab4edb43@gmail.com>
Date:   Tue, 29 Jan 2019 06:11:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339837F4E341F7911F1E1E67C2970@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.01.2019 5:02, Sowjanya Komatineni пишет:
> 
> 
>>>> This patch adds DMA support for Tegra I2C.
>>>>
>>>> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for 
>>>> transfer size of the max FIFO depth and DMA mode is used for 
>>>> transfer size higher than max FIFO depth to save CPU overhead.
>>>>
>>>> PIO mode needs full intervention of CPU to fill or empty FIFO's and 
>>>> also need to service multiple data requests interrupt for the same 
>>>> transaction adding overhead on CPU for large transfers.
>>>>
>>>> DMA mode is helpful for Large transfers during downloading or 
>>>> uploading FW over I2C to some external devices.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>
>>>> ---
>>>
>>> Seems there are good news, APB DMA could access IRAM. Quote from TRM: "The source may be DRAM or IRAM, and the destination location could be devices placed on > APB Bus; or vice versa". Hence it shall be much more efficient to use IRAM for the DMA buffer, please consider that variant.
>>>
>>
>> Regarding your request for Write Combined memory, it doesn’t guarantee the order.

The memory-access order doesn't matter at all in your case, all you need to care about is that actual data is read from dma-buffer and that caches are flushed after writing is done.

>> Main reason for adding DMA mode support to Tegra I2C driver is not for actual transfer performance but for not having delayed I2C transfer mainly in case of CPU fully loaded and I2C transfer during that time (FW upload/download, Sensor programming..) using PIO > mode introduces delay b/w bytes of transfer as it depends on CPU scheduling and interrupt priority which impacts on serving interrupts and filling FIFO for transfer to happen.
>>
>> Below are the cases where we see the need for DMA mode for I2C transfers (mainly during the use cases where CPU is fully loaded)
>> - Some devices need FW update over I2C and DMA mode helps in such large transfers on I2C reducing CPU intervention mainly when CPU is fully loaded.
>> - Some devices have internal timeout for no data activity on I2C bus after the start command (time restriction b/w data to data within single transaction) to avoid bus hang and they force to stop when timeout happens. with PIO mode in those cases, depending on CPU load, there could be more delay in serving interrupt for data requests and sending the data causing the device to trigger its timeout and transaction stops.
>> - Helps for reading data from I2C sensors with better BW.

Okay, since the efficiency between transfers is not the concern in your case, it doesn't really matter much where dma-buffer is located.

> Found from documentation default attribute is DMA_ATTR_WRITE_BARRIER which forces all pending writes to complete preventing race b/w completion notification and data DMA.
> Will use write-combined memory allocation for DMA buffer in revised patch..

Actually mapping is write-combined on ARM for the coherent DMA allocation with CONFIG_ARM_DMA_MEM_BUFFERABLE=y (enabled by default). I just falsely assumed that it could be writeback. Hence please keep the coherent allocation as-is. And you don't need to care about DMA_ATTR_WRITE_BARRIER, apparently it is only relevant for PCI on IA64.
