Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDEEC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E758C2183F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpnKZ7Vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfBCQmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:42:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36555 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfBCQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:42:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so8579686lfg.3;
        Sun, 03 Feb 2019 08:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tF+GA1Yi07fx97nqrNK0wVhnQ2WjFuOoG3w312DD64c=;
        b=LpnKZ7VdnWtAQDPKfV9IbPISoa/CvuKhuF1uCs5456aB4I/eeEzYB6pa5w+KuyzhuD
         +IznyqCY2d4PzRu9D37StzzAyMi+5PZ2aPbhrDSW3bMBEHoagdTzqeLtq8t3UPnc3ths
         8iXjI7qOqs5imzAQr+oupkZNKGGcvetbk2Qr1WVkvYqVH680LjF4NpMAXTQHjp6TW/Zr
         os5YB5YlFouo3PFTYPMga+ej2MCw5KTCHm7mJ6L8Hc3Fx4w6PIXD1sO0gBwnj8aqTajR
         mh0AdiDG6pUbRzV/qSUCnmOUKfwCfMP5ap7G63OCjpsU4m+cKxL49bchV1ZiKw7A5Ivp
         b/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tF+GA1Yi07fx97nqrNK0wVhnQ2WjFuOoG3w312DD64c=;
        b=dfOEyUhMWHpWFiA+lOUHgo4VchkjO5gZ9IMEk1cftQg3Wzy4gLIGsp9ZIyFlWrau5P
         HujJsIQLW3AXK9FCrPPJO+UKK2atoH4HHNaJjg/DFPxz8iR7R9FT6pYuDnipvMhBzLiz
         EITPbE2gRM7NzGkPNVMe8H29unEVmIjXAbuD26stREdibg7gKE+Rnon2dVW+mq6LB0dC
         OYiHL3BLCvqsngwzn7WJbt0VNWgoKRI9YGOjdhnKowecu70EDiojqqUIr82e5dOyLehy
         tDhQ8zUAfMbAK6DXSrgJ99JsKpkKZ9SEjBdds9LY6LHNvvqIZ5cKMiX0+13DV6TytQVa
         SmPQ==
X-Gm-Message-State: AHQUAuaNgUwt06XvlHja6Cn0pCc2pADv4i1sJRjldRGtqA6uBRACSQoH
        eEf5ABVzvNII2Dw3CeN620b5Y1GU
X-Google-Smtp-Source: AHgI3IYx+XmNekl4MOW69yo4GlUCCQAT/x1Erj9/4BP1FVzHNXk075FzMibV1OE/IE2JhD7nYiq/Tg==
X-Received: by 2002:a19:f804:: with SMTP id a4mr4515388lff.9.1549212138587;
        Sun, 03 Feb 2019 08:42:18 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm2360064ljg.21.2019.02.03.08.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 08:42:17 -0800 (PST)
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <951cf1f5-ba3a-94ef-0399-2259effebc99@gmail.com>
 <BYAPR12MB33984FB81B8BB1EC8C0C4908C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6150de70-6ca8-944a-780a-4574ff2b21c7@gmail.com>
 <f667ab55-c7c7-4ac1-100a-7f7ade87708d@gmail.com>
 <BYAPR12MB339885398C3B0218D452B6CAC2930@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d16a6de3-9ae6-5fd7-4df9-43cd96007153@gmail.com>
Date:   Sun, 3 Feb 2019 19:42:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339885398C3B0218D452B6CAC2930@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.02.2019 21:43, Sowjanya Komatineni пишет:
> 
>>>>>> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev) {
>>>>>> +	struct dma_chan *dma_chan;
>>>>>> +	u32 *dma_buf;
>>>>>> +	dma_addr_t dma_phys;
>>>>>> +	int err = 0;
>>>>>> +
>>>>>> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>>>>>> +		return -ENODEV;
>>>>>
>>>>> Driver shall not fail to probe if DMA driver is disabled, but to continue with the PIO-only mode available.
>>>>>
>>>>> Should be:
>>>>>
>>>>> 	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
>>>>> 		return 0;
>>>>>
>>>> Except EPROBE_DEFER, anything else returned from tegra_i2c_init_dma 
>>>> (ENODEV/ENOMEM) is ignored in i2c_probe DMA mode decision is based on xfer size and availability of dma channel or can be changed based on valid dma buf to shorten the line.
>>>>
>>>
>>> Ah, sorry. I missed that, seems good then.
>>>
>>
>> BTW, it may be worthwhile to move out the error code handling into tegra_i2c_init_dma() for clarity. It also won't hurt to not ignore errors other than -ENODEV.
> 
> Either ways are same. To be more readable/clear on error types for diff cases and errors that we are ignoring, I am explicitly keeping error codecs (EPROBE_DEFER/ENODEV/ENOMEM) same way.
> Also in probe for readability checking with EPROBE_DEFER which explicitly indicating we keep deferring i2c probe rather than simple return.
> 

Okay, then please add a error message for the dma_chan request-failure, printing a message that tells error code for the case (or even regardless) of errno != -ENODEV.
