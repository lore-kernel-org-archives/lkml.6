Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463C4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD5D21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOvYMlwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfBGP4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:56:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39401 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGP4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:56:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id m11so248402lfc.6;
        Thu, 07 Feb 2019 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S4C7LWb6f7wTS8q9teu6x/KIrykYAciGtbxaT+D9h4U=;
        b=TOvYMlwYMLC4BVmW7/pSw+1fwZp0ApAZoM3UTKQBz/kWlkhcgfqXre2tO5Zc7+hLAg
         CwKIjIF4kbwhoMdJz7rD/46cvoQVGUQb7hAEgLe2Pu9mj9xf3Ekrfit5Py/+MJWHHYTg
         wFoR/aPFO0LsGr/AcLor+oaBBVlRQVA8U5oO4/nvXdjl9qz2uoiycMY1ja24vanakjvg
         x7jJiEAu+LsVqUPyugX5XRsCuLP7Xj6fa+S0Cv2yKDKqGAA0uDEJOw9UDWemmbk095yr
         fcQMUydNufQLRXn5Q2rSZhGFi068Cwt4ovFyMNuna/zZ42TZkroZ2ZMJ2Dqk/kOAVCBX
         bXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S4C7LWb6f7wTS8q9teu6x/KIrykYAciGtbxaT+D9h4U=;
        b=ovmZy4EPio5P83WeDIyr6AX0QCNpusog5qY2a9zKoDfYR9Ld5JALc4AhWlIzRPnoxf
         ZTgPcWyVYxXAzb9TRrRfxZr7KGX+lEKIIhCUgAmh6bLRuPekTz7FSDrDNWKjR6zJQDv3
         hc+EI2KteuggMX8hcLvfDassgW/9BdlVUWvO4z/1vCDL2IoGQbkIoQzdBHHzAfslpCJ5
         wEqX3D61iNl1K0sdtVXH5uYYjJh/Ga0NdcGkO2RgL3vQVmeMG6d1D7FPzd0fEU6Ie09d
         NjaAqVXAPh5HRu2MF8NsUB4JTGZMjOAM/dlDTqn8H4qxY/Pfd1YtL8AStbEi2/cRXpGT
         hWvg==
X-Gm-Message-State: AHQUAuY0diL4JcJuF+x3BlvYUrI7a/fLtNoGxCvn4bCBF+pUqTsps/qt
        5X2Pcrzsc4W3N05rqiCJdrdfPxbw
X-Google-Smtp-Source: AHgI3Ib2kpj0le2/USziAY4f4xJOCTONeSZ0DrpD6dHH/jwuZXS3DXty9Tottem0yJeG3iFbYiu0fA==
X-Received: by 2002:a19:c48e:: with SMTP id u136mr4492085lff.167.1549554975309;
        Thu, 07 Feb 2019 07:56:15 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id j25-v6sm4289832lji.77.2019.02.07.07.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 07:56:14 -0800 (PST)
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
 <BYAPR12MB3398D7C0AF550D12F3D133C9C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67f10b9a-9dbc-aa01-e83e-e5de440f23c6@gmail.com>
Date:   Thu, 7 Feb 2019 18:56:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398D7C0AF550D12F3D133C9C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2019 18:17, Sowjanya Komatineni пишет:
>>>
>>>> @@ -1124,6 +1453,10 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>>>>  		}
>>>>  	}
>>>>  
>>>> +	ret = tegra_i2c_init_dma(i2c_dev);
>>>> +	if (ret < 0)
>>>> +		goto disable_div_clk;
>>>> +
>>>>  	ret = tegra_i2c_init(i2c_dev);
>>>>  	if (ret) {
>>>>  		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
>>>
>>>
>>> Missing DMA resourcing release on probe failure.
>>
> If probe fails due to other reasons, then I2C interface will not be available and boot will not even happen.
> Do we need DMA resourcing release?
> Probe can fail due to timeout or from pm_runtime.. and if i2c fails lots of things don’t happen properly and doesn’t boot.
> 
> Will add but want to check..
> 

1) There is no guarantee that other error cases won't return -EPROBE_DEFER.

2) I2C driver could be compiled as a module.

3) It is simply a bad programming practice to leak resources.
