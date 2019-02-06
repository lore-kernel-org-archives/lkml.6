Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A509DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7348B218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtXBr/P1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfBFQcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:32:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43003 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfBFQcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:32:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so5801267lfh.9;
        Wed, 06 Feb 2019 08:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/4f6ADmWDY5LQdqstMPnNOOqvGQ3bBKjOJk4kNdS4T4=;
        b=WtXBr/P1AeL/QYwRf9RP78Svrr6yO584eFMhAQYzY1jrWk2IGUGm1O1eJIHmgvaGLa
         lUbRaalyMvdJMfKvqkrjonIidNGWMNOlUo+sJbBvtEgrORmt5QrGDyK23vj1HKni3h+a
         TxbNRAIJpDx6vhQ9J+Lji6cVu9cJE4Iug7qRD7cmd3lQxkebDOS4uM32qtX4XbrRpm8B
         7y8U44ZAjPjTx94BR+lUwuyZw8cOJ8XTVobv7PGzzE3wlEnRE4+FIFYNaFoj8H4GCuzt
         7kwi0kRcz9usqB4v6l8Gt1NUNK54umMyvcrBr69opMDM6stwjpSMDLZrENs4g1TgQnWb
         NmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4f6ADmWDY5LQdqstMPnNOOqvGQ3bBKjOJk4kNdS4T4=;
        b=ZLuD1qSHrzQZkxOHA1NT94Zp5CmVhVVN8ERlJw4M+K0bWefLOJTEvScUvi6l9AnH8L
         oWIHTIzIZyBj3GTTFpuUnKir2+mxOAof9RhaZYUo+bNBbmk4U4pSHFEALIaQrsKq48BD
         mlFQJzOlYu0V+kla7J7RovN7DwW0OH8TW41toZYEI024iwdKTxTHy+cZn5dpXLoAnUif
         aGAaDNbqnk1MxpWFfsWbjx5Pb0+2PbHgUrfWhSLTKNkzwxR1PUL9SDdpbC1fUOz7wX9l
         ZinRI0tTfCOsSB11c//39WgIk/AaKb45Fr0HuoIlhnzL7w1Flx2avCo3yoRZWuC9AmWC
         6v/Q==
X-Gm-Message-State: AHQUAubzNdIE4Me8Huu+muuvtrbR357be/iO2mPQj7OWipekb4CX3MXk
        cDu+hktBbYk2+fuk61aNYosZCzZH
X-Google-Smtp-Source: AHgI3Ibh2p7JrsK/ogRonCaTsqcFkK8J27cy1IDxB+WogPyNRymUkMn0XNwDLl3Estls7QNpo/u2Aw==
X-Received: by 2002:a19:280f:: with SMTP id o15mr7586054lfo.0.1549470739135;
        Wed, 06 Feb 2019 08:32:19 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id x18-v6sm4286641lji.27.2019.02.06.08.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 08:32:18 -0800 (PST)
Subject: Re: [PATCH V13 3/5] i2c: tegra: Add DMA support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
 <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
 <4ecd3894-a1cb-20dd-8675-26e6e84254e7@gmail.com>
 <BYAPR12MB3398A6C76EC731D259FC3EA4C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33988DCC1F4997AAF2112447C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <9c6524ec-b40b-5b0f-eb70-f9ce2c426fd9@gmail.com>
Message-ID: <8eccb125-b771-fe10-492f-41dcda00c3b0@gmail.com>
Date:   Wed, 6 Feb 2019 19:32:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9c6524ec-b40b-5b0f-eb70-f9ce2c426fd9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 19:07, Dmitry Osipenko пишет:
> 06.02.2019 18:55, Sowjanya Komatineni пишет:
>>
>>
>>>> Two ";;" at the end.
>>>>
>>>>
>>>>
>>>> Good news: DVC I2C works now and tps6586x probes fine! :) Bad news: 
>>>> atmel-touch still has same problems as in V12 :(
>>>>
>>>> DMA-only V13: http://dpaste.com/0XJ1Z8G.txt
>>>
>>> Strangely, there are many transactions to touch and all of them are good except DMA timeout only when reading T44 and T5 atmel_mxt_ts 0-004c: Failed to read T44 and T5 (-110)
>>
>> [    0.923138] tegra-i2c 7000c000.i2c: starting DMA for length: 16
>> [    0.923148] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.923337] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
>> [    0.923347] tegra-i2c 7000c000.i2c: starting DMA for length: 12
>> [    0.923355] tegra-i2c 7000c000.i2c: unmasked irq: 0c
>> [    0.935048] tegra-i2c 7000d000.i2c: starting DMA for length: 16
>> [    0.935058] tegra-i2c 7000d000.i2c: unmasked irq: 0c
>> [    1.028750] tegra-i2c 7000c000.i2c: DMA transfer timeout
>> [    1.028816] atmel_mxt_ts 0-004c: __mxt_read_reg: i2c transfer failed (-110)
>>
>> Looking into timestamps and transactions, DMA timeouts after start of DMA for I2C1 to touch during this transaction.
>> While it is waiting for I2C1 DMA transfer, lots of DVC transactions happened thru DMA which are successful
>>
>> What is the I2C1 speed?
> 
> 400KHz
> 
>> Also incase if device is running slow for some reason, probably timeout was not enough as this patch series changes timeout with base 100mS + msg transfer time based on transfer size.
>> Can you give quick try with increased timeout incase if device is running slow?
>>
> 
> Tried to increase the timeout to 1 second, doesn't help.
> 
> What helped again is the I2C HW resetting after each transfer. Likely that means that HW isn't programmed correctly, please carefully check every bit.
> 
> DMA-only + I2C HW reset: http://dpaste.com/26AQXFM.txt

Seems I found what's the problem. Here is the fix, please include it to v14 if it is correct.

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index a9391c3646b6..5ad54da70304 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -912,7 +912,7 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
                                       size_t len)
 {
-       u32 val, reg;
+       u32 val = 0, reg;
        u8 dma_burst = 0;
        struct dma_slave_config slv_config = {0};
        struct dma_chan *chan;
@@ -922,7 +922,6 @@ static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
                reg = I2C_MST_FIFO_CONTROL;
        else
                reg = I2C_FIFO_CONTROL;
-       val = i2c_readl(i2c_dev, reg);
 
        if (i2c_dev->is_curr_dma_xfer) {
                if (len & 0xF)
