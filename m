Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED967C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92522085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYdOGeSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfAVTfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:35:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40951 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVTfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:35:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so28765002wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tRJsa09xm5VgkkRKpiXzMXtNZ4IuWnoYtrD79ZJjKyM=;
        b=aYdOGeSxYb6EgYiJjYM3xMjjqx383yaSYPXElTvOyHBuB5oRkLCx1JsrfAA9OdboOn
         OMtZr7PejcJ1g1ZQZSY3aolib8OGpd6rMt21yH4TSuhk4wHjS81nZG9sv8eorsD29mdC
         4W5Z3im7ubSScOn1ZN82aUh4RAMk5kOtkN7tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRJsa09xm5VgkkRKpiXzMXtNZ4IuWnoYtrD79ZJjKyM=;
        b=YmwhObPXBTvypUcFZ09BLGBQk9u/J10EvXDZDyo5nQlQbCXVfI8Eux7hmmqLhdybtG
         P3diaAEmilf/HodFNDfkmvVfQvn3L3kkKmI+mEsTOxIC2AYdBA9z081TrHnm5O4vWleW
         Hy7Jw166q9KdujVSIyEwVqm20n831Xj5ixBv8LT8WD5TEugHZmXO/2bUpaISuM1C21Jj
         zbY/7EsZWfuTdR05Q6Bkz7TUPd3GxB2YvFMgMzoNC26pOwhxvIV6MBInMFgrpUwtZIG9
         3CNSwqR+P5TEHfoVpbQJrAfAv9d7S7FsHRIZrYtfIHaItllH79dO81HAwFdsFO/B2OD9
         ABwQ==
X-Gm-Message-State: AJcUukfOWr8ZDvvM7RGBey9podVLTRF5C6LL4duSF6zOatc5L6OV11gV
        OdPYdbH5urZqMKCxM2p9yT0LPA==
X-Google-Smtp-Source: ALg8bN6jMUXSPhssGVxvXuXyM3eh9MIbLvsAUqJhuxMyFGI3KZkY+gsWJBz0thl0QEU68N2zVVoLaA==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr34485511wrx.85.1548185752852;
        Tue, 22 Jan 2019 11:35:52 -0800 (PST)
Received: from [192.168.1.2] (92.red-83-34-185.dynamicip.rima-tde.net. [83.34.185.92])
        by smtp.gmail.com with ESMTPSA id e16sm168281100wrn.72.2019.01.22.11.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 11:35:52 -0800 (PST)
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
To:     Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190117063312.GE25498@builder>
 <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
 <20190117100807.pmew5iqisdcc63eq@vireshk-i7>
 <e55df608-7058-63b9-b449-982d32e08759@linaro.org>
 <154818283956.20280.2895221927807522124@swboyd.mtv.corp.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <3ffe45a8-401d-37f6-4368-f14e2f2e5392@linaro.org>
Date:   Tue, 22 Jan 2019 20:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154818283956.20280.2895221927807522124@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 19:47, Stephen Boyd wrote:
> Quoting Jorge Ramirez (2019-01-17 02:46:21)
>> On 1/17/19 11:08, Viresh Kumar wrote:
>>> On 17-01-19, 09:38, Jorge Ramirez wrote:
>>>> COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
>>>> to disable the clocks that were enabled by the firwmare and not by the
>>>> drivers.
>>>>
>>>> the cpufreq driver does not enable the cpu clock.
>>>>
>>>> so when clk_change_rate is called, the enable_count counter is not
>>>> incremented and therefore it just remains null since this was enabled by
>>>> the firmware.
>>>>
>>>> I tried doing:
>>>>
>>>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>>>> index e58bfcb..5a9f83e 100644
>>>> --- a/drivers/cpufreq/cpufreq-dt.c
>>>> +++ b/drivers/cpufreq/cpufreq-dt.c
>>>> @@ -124,6 +124,10 @@ static int resources_available(void)
>>>>                 return ret;
>>>>         }
>>>>
>>>> + ret = clk_prepare_enable(cpu_clk);
>>>> + if (ret)
>>>> +         return ret;
>>>> +
>>>>         clk_put(cpu_clk);
>>>>
>>>>         name = find_supply_name(cpu_dev);
>>>>
>>>>
>>>> and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
>>>> the system wide consequences of that change to cpufreq.
>>>
>>> If the cpufreq driver enables it then it should disable it on exit as
>>> well, right ? And in that case if you unload your driver's module, you
>>> will hang the system as the clock will get disabled :)
>>
>> ah, of course, sorry was over-thinking this thing :)
>>
>>>
>>> Every other platform must either be marking it with CLK_IGNORE_UNUSED
>>> or they must be doing clk_enable from somewhere, maybe the CPU online
>>> path, not sure though.
>>>
>>
>> since this clock is enabled by the firmware, it seems to me that using
>> CLK_IGNORE_UNUSED remains the best option.
>>
> 
> What do you do about CPUs being offlined? Presumably when the CPU is
> gone the system doesn't need to keep the clk enabled anymore.
> 
> 

the kernel does not take any action - it is under firmware control; and
since the clock is shared between all cores I there will have to be some
involvement not only at TF-A/firmware level but also at the TrustedOS
level for when the last core is offlined.

I dont have visibility on either of those projects though.
