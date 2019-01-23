Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F67C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2F921848
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7td8MU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAWNRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:17:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45538 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAWNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:17:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so1528426lfa.12;
        Wed, 23 Jan 2019 05:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9U5mJ3JQQ6l5G8m6vheeQNGDuwznsVNravUDQYCdGho=;
        b=F7td8MU+50uf7vbGClsS7aj+IZ1NbsXy34UgFAquTtBc3SOspYB+5twrndDCz4UpC/
         tLc2pbbb8EuXFTT9usXbJcnCsTw58kCYrQMH5LzrjbVLmCgQkp0Lu86X3bAkNbcQseYx
         ondyJIu6UwmKe1ITMxCd42T17uJUxWr9IdfqSbqULHlJ2K5yruh5ad44qrjVigz2OgWJ
         Iq8Nj6F+9d+sOFlgwzzjND8T7fhyIGUxuoLdxJZfbxVWsfTmqJHsdXEOtZursMehZmgy
         uRfH75b3zHQ9aYEIaitRXPd0rudjRPXsYVC2efR3Ll/0QnuwsaQcwEw1pmOz4WKwAH8+
         fE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9U5mJ3JQQ6l5G8m6vheeQNGDuwznsVNravUDQYCdGho=;
        b=KKRsqAoGAvB7ZrCYElZEmZv3OmlU+LDx3jdRw0+oOGGwFZEwqEuMojulb87j8EWIzb
         aNR5boyVMW+Vljm+R08eExRUSlVurR4oJIPN0q4ijvNogkjS+pXTXxLCEV2HV0zhPfZj
         1dJY5mVTZMSbXbS9PE/WdU2IwOaUnRJ3VbWR1+42YsQqIJl1jA525aNJIc0+alSNizzJ
         GjUzKe3Fq43nPxVDAUKCfoNIAQ9I9iHP6Nj4Pt62uZXTTnKY1DKUeX7zp+FJBPlh88xz
         HXE6xU2OO22etngh35ShkliXdiNFDGWS+4sQ2gjrBumek92k0gud3nQtwRUXajUq1Ayo
         M2zw==
X-Gm-Message-State: AJcUukcgx4j1qdFMAJ449uf2tKcd/laCBzdcsjqfFoqYeppl68Xm3ou4
        VkhD05TcgePweUK0PpvW1GpZ2qa8
X-Google-Smtp-Source: ALg8bN6yb2uanylGeRhmwV1SOCONdPC1emSpI//vf2nL+y2AUpjZirDaPd/6TH2tTvzTV9QOGs6qFA==
X-Received: by 2002:a19:f204:: with SMTP id q4mr1915483lfh.133.1548249441609;
        Wed, 23 Jan 2019 05:17:21 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id k68-v6sm507709ljb.35.2019.01.23.05.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 05:17:20 -0800 (PST)
Subject: Re: [PATCH V3] i2c: tegra: Add Bus Clear Master Support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1548187338-6807-1-git-send-email-skomatineni@nvidia.com>
 <5405e9aa-d974-ca9d-dec1-32f8631a045d@gmail.com>
 <BYAPR12MB33984356AE1E279C7E0E880CC2980@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190123014042.6d64ee29@dimatab>
 <BYAPR12MB33986390C45475180381713FC2980@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <783993ec-6d88-9a84-b1bd-cd44d45e2584@gmail.com>
Date:   Wed, 23 Jan 2019 16:17:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33986390C45475180381713FC2980@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.01.2019 2:26, Sowjanya Komatineni пишет:
> 
> 
>>>>> +	if (i2c_dev->msg_err == I2C_ERR_ARBITRATION_LOST) {
>>>>> +		if (!i2c_dev->is_multimaster_mode)
>>>>> +			return tegra_i2c_issue_bus_clear(i2c_dev);
>>>>> +		return -EAGAIN;
>>>>
>>>> This changes the returned errno from -EIO to -EAGAIN for the 
>>>> supports_bus_clear=false case, is it okay and intentional?
>>>>  
>>>
>>> Yes EAGAIN is intentional to allow for transfer retry.
>>> During single master mode, ARBITRATION LOST notification happens when 
>>> 1. I2C Master sees the bus is occupied by some other device when a 
>>> transfer is initiated 2. I2C Master lost the bus during arbitration 
>>> incase if slave device pulls SDA line low continuously for some 
>>> unknown reason If arbitration lost is due to cause 1, retry helps to 
>>> continue with transfer once bus is released by the slave and it just 
>>> added delay in communication due to bus release delay by slave. In 
>>> case of 2nd cause, retry never succeeds in cases where bus clear is 
>>> not supported.
>>
>> It's unclear whether the "never succeeds retry" may fail with the EAGAIN, causing an endless retry-loop. Could you please clarify this moment?
> 
> during master transmit mode, on arbitration lost and if master doesn’t support bus clear to recover then transfer will return EAGAIN.
> I2c core base driver performs retries if return code from i2c_transfer is EAGAIN up to specified retries in i2c adapter and returns the ret code from the last retry.
> Retry is not endless as i2c core base performs retry only up to specified adapter retries.
> Following return code from documentation
> https://www.kernel.org/doc/Documentation/i2c/fault-codes
> 
> 

Could you please point at the code that sets the number of retries for the Tegra's I2C? Looks it is always 0 and hence EAGAIN won't do anything useful.
