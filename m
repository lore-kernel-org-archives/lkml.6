Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87724C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49369218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC0nOo00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfAYVuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:50:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38728 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:50:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so5332042pfi.5;
        Fri, 25 Jan 2019 13:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yTEavDtA3yJcKVDEdgLLqL+IspX2mD2fA6pVfc2AQfo=;
        b=FC0nOo00vnFj0mpgw9Y4S9N131OFT20VFPY6gY6JgRLqCkkjDFTGJyNdpef4w60ueb
         vh7HoKxqRYoZ2+Bmoz6MMG1Uh8QIWnclAVC6JkJl31kvtGB6u+pFwDKxyQTqpGm9FkBd
         2C7MUBUDHZTQrqSVZP9LDcTbWEhY2AsecNRr9BcZaawiN1IctGdbia7OYu+tud8cHGCa
         oSu0IryeGa2UJlEbv58K/oYmkGPusek/G5B/5N/aztfZcrYqVuI2q03feKFf9q5RjCmJ
         UEpgfaWBG3XSciiJRVVbndS7mYAehdIB7PcA7ayxwrKMKP3yOwtff9V4dWrByw482MPJ
         DLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yTEavDtA3yJcKVDEdgLLqL+IspX2mD2fA6pVfc2AQfo=;
        b=BorA29tIwqlUsja+J7uEAooga17vGMBdOYVQwoH9r5uGiDtati4Pcl3kTnAOsxhHNl
         DYQNg2dQU/0DFJ2JvmOe3Wn0Tok1TegeuBsMXnmigom9VHR4vMOXnJB4nuSlWs3WwUQn
         QOyTBLdDrlki3JGd0MPtMaoWIwqPQVB618RzK8U+JD9alT//e06ZnFAh3ukhyouESiyw
         GbpL5sMISOh9Os6w3+X9dRJPbj8KICRjQfBWQnulc5oah6r3dksv4EEC3XSBgA/UOTqt
         nW7MiGH5MUMreIp4JBycc0jw32lQxGN9cLqapwaoyPGhAmDq7kOFpjNasMThwU5RmBOy
         pzuw==
X-Gm-Message-State: AJcUukeTN7Hh9cK8+rT8eOOlwmM27ikXuPm1v32bkE722bstNwAcYkqK
        emkSJ1vvwO0rapzHKwp8cn4jaO1o
X-Google-Smtp-Source: ALg8bN6Ay2vMEdFrEoOIhsXHNE/ZBbbhFAc1CygrBvVn8zv3LhP0/yILVGubw6Gxa9R9YnwCMwMSnA==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr12635181pfl.106.1548453001963;
        Fri, 25 Jan 2019 13:50:01 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id m11sm38472944pgh.51.2019.01.25.13.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 13:50:01 -0800 (PST)
Subject: Re: [PATCH V2 3/4] i2c: tegra: Add DMA Support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
 <dcc1e094-638e-5b04-7a61-bdbc24ee068f@gmail.com>
 <BYAPR12MB339829FC6F2F95F833FE45A1C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <ad177c2e-3801-ddad-b359-ac83530ee1d6@gmail.com>
 <BYAPR12MB33982ED3A9EC34819D2490F8C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <782dcecf-2991-e886-af18-d355a3ea8325@gmail.com>
Date:   Sat, 26 Jan 2019 00:49:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33982ED3A9EC34819D2490F8C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.01.2019 0:11, Sowjanya Komatineni пишет:
> 
> 
>>>>> +	if (i2c_dev->has_dma) {
>>>>> +		ret = tegra_i2c_init_dma_param(i2c_dev, true);
>>>>> +		if (ret == -EPROBE_DEFER)
>>>>> +			goto disable_div_clk;
>>>>> +		ret = tegra_i2c_init_dma_param(i2c_dev, false);
>>>>> +		if (ret == -EPROBE_DEFER)
>>>>> +			goto disable_div_clk;
>>>>
>>>> So tegra_i2c_init_dma_param() could fail, printing a error message, and probe will succeed? If allocation fails during the driver's probe, then just fail the probe. Please give the rationale.
>>>
>>> If APB DMA probe doesn’t happen prior to tegra i2c, DMA is not available by the time tegra_init_dma_param tries to request slave channel and in those cases dma_request_slave_channel_reason will return EPROBE_DEFER for tegra I2C probe to retry
>>>
>>> In case if DMA is available but DMA buffer allocation fails, then tegra_i2c_init_dma_param returns ENOMEM and probe also fails returning same ENOMEM
>>
>> Is that what you're going to change in the next version? Your current variant of the code doesn't fail the probe on ENOMEM and there is duplicated attempt to invoke tegra_i2c_init_dma_param() during the transfer.
> 
> Sorry correction to my previous reply.  If DMA buffer allocation fails, tegra_i2c_init_dma_param returns ENOMEM but probe will succeed as i2c transaction need to happen during  boot for some platform device programming for successful boot and they use PIO mode as xfer bytes is less and deferring i2c probe for ENOMEM causes boot to fail so during probe EPROBE_DEFER is only taken care.
> 
> Re-attempt of tegra_i2c_init_dma_param in xfer happens only if no successful DMA channel allocation happens prior to that ( during probe in case of ENOMEM).
> DMA mode is mainly for large transfer, and i2c xfer returning failure due to failing DMA buffer allocation causes boot to hang as platform device programming need to happen which doesn’t need to use DMA.
> Will fix this and will send updated patch to reattempt DMA request and buffer allocation during DMA mode transfer and will return fail for DMA mode I2C transfer...

1) The chance to get ENOMEM during is miserable and likely that there are much bigger problems in this case. Hence just fail the probe if tegra_i2c_init_dma_param() fails with any error.

2) What is that super-critical platform device? It is possible to compile tegra-i2c as a kernel module and seems nothing enforces CONFIG_I2C_TEGRA=y.

3) After applying these patches I2C transfers are failing on Tegra20 with "tegra-i2c 7000c400.i2c: Failed to allocate the DMA buffer". 
