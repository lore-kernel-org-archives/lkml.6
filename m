Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED18EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C412086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ov27V6jV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBGTDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:03:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34828 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfBGTDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:03:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id l142so736446lfe.2;
        Thu, 07 Feb 2019 11:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ryiNJjwSO+H9H1HR+xSj0CsnyzI3s6e5cROjPOlTmcc=;
        b=ov27V6jVE8bIzl9a26cMODnrYjtAwcQEDGUjao5mgma3uB/AYOakanmL2A/4/9wMLf
         yVfMPo7taQfw1Ws9ffk4ywIZHfLOrmbskrKmGmeFoAodZXZzUXkQTvp/8+dtH0FJyZnd
         8I+ey/YfmENs+z5IqcHRuGuUXT7zDOzKkNL/HP1kTjMpeUjZQlTjowPIEK1LMRSA7WUM
         MGp203DRvWmNP51xU/ZqwySAsif98uvLL6jt5Fv8Z1ClHC5BdjcBgMe5PtmN5qkQK6SW
         FlSBICfjZYNL+ZdK6SlFriPh6u8DByc1heidg0EYPvJ92YfyUhGZiDOkdJghzfB5ReDC
         OzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ryiNJjwSO+H9H1HR+xSj0CsnyzI3s6e5cROjPOlTmcc=;
        b=m/EMxcqdTzps76p9OXf4SBpYIArgZ0e0d0Jy0DEIfpHrMQjpcwDFN5QxktQQohP9Bf
         QHAnnzqokTpUZOiepAmTppJBNLSUyZk52Uxk6GVQLrYXPJay2sNQqXPYAkDZbWUEU92I
         VAWl2coKkaqh/XTSF2ioaOtzVvgO5uWbdFSLq/ZQLHSpe05zUAoSjqdvByA2NVN487sp
         q/peJ7AHyccxVubQYPVH25rjXwGSBRk8UYJDpvAOQsQklqykl5QJ+XeP+tJp9R2sOSzc
         Q4RHcxhOnvfjYYxgXm/C7c4SFZhn0WPV6CM7i2zFxCaTySBEwRhgyY4R17TGYlm9fLdd
         R/zQ==
X-Gm-Message-State: AHQUAubF0KSsi7SDZCviwpwTrEfi/oHuSI+BzTOjI2UEDNmU6cgv0oRr
        7EhUyvBdpt/JXEhCUAT4p2Wr4l6V
X-Google-Smtp-Source: AHgI3IY0Cp2KyubecGHY+o0uZD9iF4nODjt53+AdopN01Eihtzwo68DANzTy+QiJpqi1QFpHQLuZ4Q==
X-Received: by 2002:ac2:42d2:: with SMTP id n18mr10695079lfl.37.1549566187165;
        Thu, 07 Feb 2019 11:03:07 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id g70-v6sm4468092ljg.92.2019.02.07.11.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:03:06 -0800 (PST)
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
 <e09062b7-9c74-6aee-477a-72fb72bbd5d3@gmail.com>
 <BYAPR12MB33980D6751904EBEFC38BBAAC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <da8138fe-ea4b-42be-1065-c7098ac59691@gmail.com>
Date:   Thu, 7 Feb 2019 22:03:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33980D6751904EBEFC38BBAAC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2019 21:56, Sowjanya Komatineni пишет:
>  
>>>  static const struct tegra_i2c_hw_feature tegra210_i2c_hw = { @@ 
>>> -980,6 +1302,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
>>>  	.has_mst_fifo = false,
>>>  	.quirks = &tegra_i2c_quirks,
>>>  	.supports_bus_clear = true,
>>> +	.has_apb_dma = true,
>>>  };
>>
>> T186 is missed here.
> 
> Currently t186 hw feature is not present in existing linux next and device trees use both t186 and t114 compatibles, so t114 is being applies.
> But dmas are not used for t186 yet.
> 
> T186 hw feature is added for first time as part of interface timing and its in patch next to this patch in same series.
> This is the same from beginning of all these series.
> 
>>
>>>  
>>>  static const struct tegra_i2c_hw_feature tegra194_i2c_hw = { @@ 
>>> -995,6 +1318,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
>>>  	.has_mst_fifo = true,
>>>  	.quirks = &tegra194_i2c_quirks,
>>>  	.supports_bus_clear = true,
>>> +	.has_apb_dma = false,
>>>  };
> 

You added "has_apb_dma" for T194 and not T186 in this patch, I happened to notice it only right now. Please, let's be consistent and set the new field for all of the platforms in this patch.
