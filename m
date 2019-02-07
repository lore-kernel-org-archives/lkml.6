Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFC3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4C820821
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYnIeiKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBGPRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:17:46 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:45902 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGPRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:17:45 -0500
Received: by mail-lj1-f179.google.com with SMTP id s5-v6so129526ljd.12;
        Thu, 07 Feb 2019 07:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+00+RoTCU0unIjYGZk/5iaOU3uDgw/f67GH2ODDZV3U=;
        b=PYnIeiKhZMP7V2nWc7K6yO499Ac0lyc9Gvx9SHdVT4SvUPJkk7Rt3AXlvvcNeBRk7e
         FwsaBCSTmhKSYCsQjU4Co0+RIk4woFmlo5oj11Oy0ofEWXPtWu93WQ5+FFaJynweVYW1
         8wgG4V1wBJkLk05mdMxhrZj5/RlcUFKrZeg8jTmVIRiIHqx1JMviPb8viLQ0zPVwBZGO
         uXHvssLNxxOsoBc52y71HUvM6hZZQRyEb022328OveDLCsmjBow9WKVNmdFmG4o0sTFl
         72Owt6R4idKxLpz7azEGeS/96qg3oUbVd1g8WW9ofdQPqqjEGniJfQrXE6aBpifWOEHt
         uhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+00+RoTCU0unIjYGZk/5iaOU3uDgw/f67GH2ODDZV3U=;
        b=OPSp9mbpJLxc9E1LfoAq4SucHjehgLgytu1IUq+vgBnI8K26cNuPPCGZY/z3a6p3J4
         PvyiA0kf+7JeHKRvNv59KiYCSowGGhER0LthYo4vyfS1qRbT1u4Gcx7Bxrlk2r+IiFF0
         1zKDElCBQCAVC/sf4MXo4axNzJyQ9mxZPAPxaocaPS7msI+6G/H+9qZGrn1EJAQxJFOg
         KnGKoaMS7qxNQTAoUY3sbWS6iMJVypm1XP68JjrQiqOCYm/WidozKVUn7wxyNVdA9+e7
         Oskhfe2zzth5ebHMuqvclWPL+f6+iNL6HF2GYeQK60EVp4kFaOrO2xeDQSGtkE7Y3igc
         ivZg==
X-Gm-Message-State: AHQUAuZbOa7MxEgc6xi3WrO6jgI+zPwndl4ff7+5RvgbOX0ZcsmovsXP
        o2jvLU8kbVsr2eWxUCqnxTW+3Cfe
X-Google-Smtp-Source: AHgI3Ia66QDT86/gSy7/uULCS4CHjaHeHpACdQsb3MV39NdKHEAFGGFAgGpmN3EyigB/ykks+7+ziw==
X-Received: by 2002:a2e:9e93:: with SMTP id f19-v6mr3042471ljk.122.1549552662871;
        Thu, 07 Feb 2019 07:17:42 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id z2-v6sm4389386ljk.50.2019.02.07.07.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 07:17:42 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <a6b1acbd-9be0-62b7-29bb-081d93ee92fb@gmail.com>
 <BYAPR12MB3398712D185CCCB345EB2B5BC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ec44c61b-6186-83da-6224-ff8db91a293c@gmail.com>
Date:   Thu, 7 Feb 2019 18:17:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398712D185CCCB345EB2B5BC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2019 18:11, Sowjanya Komatineni пишет:
>>
>>
>>> @@ -1124,6 +1453,10 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>>>  		}
>>>  	}
>>>  
>>> +	ret = tegra_i2c_init_dma(i2c_dev);
>>> +	if (ret < 0)
>>> +		goto disable_div_clk;
>>> +
>>>  	ret = tegra_i2c_init(i2c_dev);
>>>  	if (ret) {
>>>  		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
>>
>>
>> Missing DMA resourcing release on probe failure.
> 
> If probe fails due to other reasons, then I2C interface will not be available and boot will not even happen.
> Do we need DMA resourcing release?
> 

Absolutely! Every allocated resource must be released.
