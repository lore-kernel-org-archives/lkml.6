Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76FE218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6tA7RR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfAYUkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:40:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36074 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYUkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:40:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so4672467pgm.3;
        Fri, 25 Jan 2019 12:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WZMUnIdM2wgUPHI/CCC2k5/Bf/kPJWYDXntSHmfQhd8=;
        b=B6tA7RR4cZW7xpPvVsr1F+SnXP4ycVtp26T2mVogeuiG9hPV6QC4N/nSCkJpqzc/2b
         6G/1o9AvGtlFctnOPSMSHexkAuxzWApgtheRF+4qOn0Gz6LJ6TREof76S5dHLYKGPkjI
         urBtujVdWhhjCAq5Dzm6/DWSIPRSOUND2IZOvta0bQLCF+T1A4i6YYQ2lx2BWd1sZ8Iq
         WUw/g3hocyXv59DRp8S7jfPvkqC5g4RMjwPpaQp4noY57fMkaDcvi4hjri7bSHpjYY6j
         lqP25adNEgh4VIrkqJ0bD5wERq8r0LGDSiLNoyzGf39w9/PZodHfk2S/ivaCGrMQThxA
         g/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZMUnIdM2wgUPHI/CCC2k5/Bf/kPJWYDXntSHmfQhd8=;
        b=mmiUqZ0tf8wRL1EWQwJkNN3L4bWDPoNPvgt+C+ENNtSqj4X6UIQxHFs6Fq+qCkWHOG
         p227RzPhhCRb1WK3y6CHitDTZkpuaoJxe4Y30G04vbXsxhWxOSIOomVRNYBrt3OQXoOs
         1y/1kLRc0BsvAIgIEGEwz8e5LG7OYXU7MWq4DmbKHwF743gJT+mr/ZG5mGDYLww5dSzg
         BOcZ5nV+xUK2F7LkXLGZ8FeHEMzL1edKhkeH6bqwli/ZvYdyvIquEoOFi4+ZuxltEa+7
         B0ZDiT2ZV06Y1CNvvS8dzIc0HrehYxGi9MKUqodFVS1ooPTjxcXpf2LaIONYKuFSvKPT
         nfpg==
X-Gm-Message-State: AJcUuke/WVmwDXQJrjhqC0BdupM8tam1Kuliq05AwN4V18U3iCdzZbn0
        S9beAwOPFnooYSUpOqEI73mYuC73
X-Google-Smtp-Source: ALg8bN4LOgsNVuavjylDX2BKAA9jt5Qnmlsq7faDQGEwDgitCWe0zowWNSsVZG2MSvGt8WEjtR/HjQ==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr12571093pfb.55.1548448811134;
        Fri, 25 Jan 2019 12:40:11 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id i4sm45993450pfj.82.2019.01.25.12.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 12:40:10 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ad177c2e-3801-ddad-b359-ac83530ee1d6@gmail.com>
Date:   Fri, 25 Jan 2019 23:40:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB339829FC6F2F95F833FE45A1C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.01.2019 23:31, Sowjanya Komatineni пишет:
> 
>>> +	if (i2c_dev->has_dma) {
>>> +		ret = tegra_i2c_init_dma_param(i2c_dev, true);
>>> +		if (ret == -EPROBE_DEFER)
>>> +			goto disable_div_clk;
>>> +		ret = tegra_i2c_init_dma_param(i2c_dev, false);
>>> +		if (ret == -EPROBE_DEFER)
>>> +			goto disable_div_clk;
>>
>> So tegra_i2c_init_dma_param() could fail, printing a error message, and probe will succeed? If allocation fails during the driver's probe, then just fail the probe. Please give the rationale.
> 
> If APB DMA probe doesn’t happen prior to tegra i2c, DMA is not available by the time tegra_init_dma_param tries to request slave channel and in those cases dma_request_slave_channel_reason will return EPROBE_DEFER for tegra I2C probe to retry
> 
> In case if DMA is available but DMA buffer allocation fails, then tegra_i2c_init_dma_param returns ENOMEM and probe also fails returning same ENOMEM

Is that what you're going to change in the next version? Your current variant of the code doesn't fail the probe on ENOMEM and there is duplicated attempt to invoke tegra_i2c_init_dma_param() during the transfer.
