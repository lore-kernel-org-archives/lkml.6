Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34642C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B1721019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0mgJ4q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeLaImi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:42:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34636 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeLaImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:42:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so29629242wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 00:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=El90UuvXSTwvHkTCycgQ+Zo1FPArY4bUiDSukrnlXpo=;
        b=B0mgJ4q8VvsUUC6I+FZaFu3eQ6CD5FFUjZpzdzCpOem5TjESV0+8tPdYbh849/DRkt
         X4sZo9vftrf83GdHq8pEGjl9JH8SU8JWhofQQtS2LGx97/7fG1VnAsttLZnHV7F87UpA
         d/lC4UMEBTm38vD8QyWYTYVmcEKRVFtUheNf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=El90UuvXSTwvHkTCycgQ+Zo1FPArY4bUiDSukrnlXpo=;
        b=NvCT6zghFhNc6Ke3BetnX4JCFdMGZOCrLN4+wUDArucSvtPORlE7+k6dnyeetq1llU
         FkKBYOQ98xLey6tZkDw5XP9T85Clcaxs1CebyRIFAUkfSt3y6vGJ6Re6paK8HoNGUrAZ
         D1fmOPnNPQ/v1IWTyL6nkBYsmS9nzdI5jyrS3iN86BmXQn5VP+muek6etW9SEXJEEmsm
         Kf8wTMMJhYuBZQIWKzvCUlw/ET84CRktxzCOzxPA3b26qJGhtYH/W4oGjr/PZ0uSc2k6
         pZ8zpXFhFkac2nFmqgrr5tZB61O/tCB1IkIJVeQtSppbCe8Cu5tGeg1hSjWsb+GEjSqd
         X+8g==
X-Gm-Message-State: AA+aEWZotckA6i5ufNa+8ad9N+kIdf1ySZn7lctRAbg7NVk7gJNnpy4H
        HI5quGsHP5pKmPWbz7l+L7mCzg==
X-Google-Smtp-Source: AFSGD/WEKyUwv2tuz8D2f7vDYkbd3Buv/bJHy53tqnckCpIFz1B/AtUQ3hNtKf1utkb9M7je68532g==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr29394245wmc.129.1546245755633;
        Mon, 31 Dec 2018 00:42:35 -0800 (PST)
Received: from [192.168.1.2] (92.red-83-34-185.dynamicip.rima-tde.net. [83.34.185.92])
        by smtp.gmail.com with ESMTPSA id g198sm53816074wmd.23.2018.12.31.00.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 00:42:34 -0800 (PST)
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
To:     Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        bjorn.andersson@linaro.org, vkoul@kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
 <20181218143503.GA32562@centauri.ideon.se>
 <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
 <154603613437.179992.1170701312259011363@swboyd.mtv.corp.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <45a9e033-16e8-e0f9-36cf-3b892af1bd8f@linaro.org>
Date:   Mon, 31 Dec 2018 09:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154603613437.179992.1170701312259011363@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/18 23:28, Stephen Boyd wrote:
> Quoting Jorge Ramirez (2018-12-26 01:20:07)
>> On 12/18/18 15:35, Niklas Cassel wrote:
>>> On Mon, Dec 17, 2018 at 03:37:43PM -0800, Stephen Boyd wrote:
>>>> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
>>>>> Allow accessing the parent clock names required for the driver
>>>>> operation by using the device tree node.
>>>>>
>>>>> This permits extending the driver to other platforms without having to
>>>>> modify its source code.
>>>>>
>>>>> For backwards compatibility leave previous values as default.
>>>>
>>>> Why do we need to maintain backwards compatibility? Isn't is required
>>>> that the nodes have clocks properties?
>>>>
>>>
>>> Hello Stephen,
>>>
>>>
>>> This is the existing DT nodes for msm8916:
>>>
>>>                  a53pll: clock@b016000 {
>>>                           compatible = "qcom,msm8916-a53pll";
>>>                           reg = <0xb016000 0x40>;
>>>                           #clock-cells = <0>;
>>>                   };
>>>
>>>                   apcs: mailbox@b011000 {
>>>                           compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>>>                           reg = <0xb011000 0x1000>;
>>>                           #mbox-cells = <1>;
>>>                           clocks = <&a53pll>;
>>>                           #clock-cells = <0>;
>>>                   };
>>>
>>>
>>> This is the (suggested) DT nodes for qcs404:
>>>
>>>                   apcs_hfpll: clock-controller@0b016000 {
>>>                           compatible = "qcom,hfpll";
>>>                           reg = <0x0b016000 0x30>;
>>>                           #clock-cells = <0>;
>>>                           clock-output-names = "apcs_hfpll";
>>>                           clocks = <&xo_board>;
>>>                           clock-names = "xo";
>>>                   };
>>>
>>>                   apcs_glb: mailbox@b011000 {
>>>                           compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>>>                           reg = <0x0b011000 0x1000>;
>>>                           #mbox-cells = <1>;
>>>                           clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
>>>                           clock-names = "aux", "pll";
>>>                           #clock-cells = <0>;
>>>                   };
>>>
>>> qcs404 specifies two clocks, with an accompanied clock-name for each clock.
>>>
>>> msm8916 specifies a single clock, without an accompanied clock-name.
>>>
>>> It is possible to append clock-names = "pll" for the existing clock,
>>> as well as to define the aux clock in the apcs node in the msm8916 DT:
>>> clocks = <&gcc GPLL0_VOTE>;
>>> clock-names = "aux";
>>>
>>> However, since the DT is treated as an ABI, the existing DT for msm8916 must
>>> still work, so I don't think that it is possible to ignore having backwards
>>> compability in the apcs clock driver.
>>
>>
>> so where are we with this?
>>
>> do we remove backwards compatibility (see below] for v2 or is the DT
>> really an ABI and therefore the patch under review is good as is?
>>
> 
> Breaking compatibility is up to the platform maintainers. If anything, I
> would make the DTS and driver changes in parallel and then remove the
> driver's backwards compatibility logic later on.
> 
> 

I am not completely sure of what you mean. are you saying that the 
original patch is good and we should just provide another patch (not 
part of the current patch series) to remove the compatibility?

TIA

