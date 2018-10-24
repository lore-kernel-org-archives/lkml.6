Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A78C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C3D20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRxAyMbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C3D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJXTSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:18:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53718 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXTSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:18:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id f8-v6so2485047wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kZyhbqSxZNbeQN2mnEkquQCKqrEqclmCDrXW/BZSNT8=;
        b=TRxAyMbb6EoFk4jD0b3bgXWSP3kDrj3NCzFiOZsg+Mi4L90c6w7MW0PXiIPEkwkej/
         FulQWHnryu1+Yhmiyy3Qfe9x72I100Y8bjlVqTR5Fpzkgyn0wfRr+Gz3KWEValueZdzP
         8vTAUjwUW6h5Y8k4OgQzBik3ZKzWX4VsSKk9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kZyhbqSxZNbeQN2mnEkquQCKqrEqclmCDrXW/BZSNT8=;
        b=AOU0Z9ywr1tq3PmTiWM/PM8pd8G5OfKHarDmW6vIfiOHYoK8gwMi4+gQt7J8OEVyNZ
         Om9ceTkia2d62akMu4Hjp3tsaon5IFWdH/LouilreTjoY8qZ9Pf1FQHHQ2AMLjK/3Z8K
         8PPzjWu9bZGQnnbgAIY2+feY+uu3JS4m8a2cgWNDuuJNh2m/pzE64Vpydaq3C+ycF/Px
         hPLwx97n/1XU9XUBk2Y64pqS7MQp614OSt/pRbbNxq9q1UAdxs9SWH7X5UlhrUxE+eCJ
         SgJQcW1inPSJj/Gt9fotOzgPodbwCmNVcByYBcJlNvpomE1VpWWslCpM6Br4zqZSR271
         H7XA==
X-Gm-Message-State: AGRZ1gLPBZOi7Xzw9iA62WWLmZ4GxVgH2u3cO9zF/0NWvvF9kEL6uZmu
        FaZuHWjAVi0BONCwdQ9Ip1t+hw==
X-Google-Smtp-Source: AJdET5dG9TvfsHu4VaHv1VpNYiva7czBOK3PjkDffuURcbk3GfI6WO1/UEOsdv5Gi7xtjYqtIP0W2A==
X-Received: by 2002:a1c:248b:: with SMTP id k133-v6mr1766223wmk.148.1540378246578;
        Wed, 24 Oct 2018 03:50:46 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id f7-v6sm2666677wrr.68.2018.10.24.03.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:50:45 -0700 (PDT)
Subject: Re: [PATCH v4 02/14] mfd: wcd9335: add support to wcd9335 core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
 <20180917005727.32728-3-srinivas.kandagatla@linaro.org>
 <20181024070746.GZ4939@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8ec691a9-d91c-752b-de21-a82a7e78ee05@linaro.org>
Date:   Wed, 24 Oct 2018 11:50:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181024070746.GZ4939@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/18 08:07, Lee Jones wrote:
>> +#define WCD9335_SLIM_INTERFACE_DEVICE_INDEX	0
>> +
>> +static const struct mfd_cell wcd9335_devices[] = {
>> +	{ .name = "wcd9335-codec", },
>> +};
> Any news on other devices?
> 
We are totally limited with hardware to test other devices on this 
codec. Given the fact that no one is actively working on adding support 
to other devices ATM.
Also IRC discussions with you suggested that I should move this driver 
to codecs for now and when a new device support comes up we can move it 
back to mfd.

Regarding other comments, I will make sure that address them if the code 
is still there after moving to codecs.

thanks,
srini

>> +static const struct regmap_range_cfg wcd9335_ranges[] = {
>> +	{
>> +		.name = "WCD9335",
>> +		.range_min =  0x0,
>> +		.range_max =  WCD9335_MAX_REGISTER,
>> +		.selector_reg = WCD9335_REG(0x0, 0),
>> +		.selector_mask = 0xff,
>> +		.selector_shift = 0,
>> +		.window_start = 0x0,
>> +		.window_len = 0x1000,
>> +	},
>> +};
