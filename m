Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91270C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F9A21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnM0HfTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392008AbeLUVpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:45:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44057 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390834AbeLUVpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:45:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so6639726wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IPvxWyDGn40AW/ybwE+RF5uPIUCl8L1WOlqQ8THFUlQ=;
        b=MnM0HfTd74e7qQ66LwmA+S82wJWAJ4yv+6y73Wio2bLQ5CVdwGt32PgqJcjH+7S2XB
         Y3VFlfe4U74b8aqAlqiK1lKHniWk+xHHdrVjRTSC8D62h0yQTvGpA7a5QfRjeNaSW6ua
         nxhIJioRS/33gNC70NRq3mJvjghJTRUF4nFiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IPvxWyDGn40AW/ybwE+RF5uPIUCl8L1WOlqQ8THFUlQ=;
        b=GzSLuWHdy1UCB7365y2jEgNIe/suiAw+kG83leys+EamSkMTIp0UwPHsSHkdjVYSgy
         6KWVxR0i1RzZKjR5778sZTkTYJfMAXg7M6N1fSYD02/19Zs1NjQV3r5NTWJsb7zMl59Q
         pB+iAR+xahb/OHNNk81/LH4zx7dwEwslbEcoAbarl4rWTh4LA4z4o82iC1fEJngd1DJO
         Yki+k1OLYDlLwEBgibWmus1pESeBI1Lr0UWNEEl4Gv4uU94aVOYEpk1h0XvRRGa39xII
         NfwMWenMiuvuer6slSGcJIJfu4OxKy/bREkoc6RL1+9xqFmXeT8Wl7zB5ggFXJfe/MhK
         L3nw==
X-Gm-Message-State: AJcUukevEamFJ50QXPDYaPsx0yvfAnKyUviJ/lgFNMeLa7z8xy7ERSAb
        8Ju+/o0go0+ojO6I79yhW/u5vg==
X-Google-Smtp-Source: ALg8bN7d3xmC390m8qd9j4u6JLMgH+J+Oc8P81C/AeBE0yty8l06+1uwYNDNQmEWk6JFlkpLwkLtQg==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr4338977wra.81.1545428744225;
        Fri, 21 Dec 2018 13:45:44 -0800 (PST)
Received: from [192.168.1.2] (119.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.119])
        by smtp.gmail.com with ESMTPSA id o5sm20036921wmg.25.2018.12.21.13.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 13:45:43 -0800 (PST)
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
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
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
 <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
 <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
 <20181221192823.GA9704@minitux>
 <94b12f58-b586-6b4b-6c0c-b4adad80d7b0@linaro.org>
 <154542841268.13075.13095552962351570142@swboyd.mtv.corp.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <914bd56c-4470-4f78-75ac-f7bedd83d7c0@linaro.org>
Date:   Fri, 21 Dec 2018 22:45:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154542841268.13075.13095552962351570142@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 22:40, Stephen Boyd wrote:
> Quoting Jorge Ramirez (2018-12-21 11:45:28)
>> On 12/21/18 20:28, Bjorn Andersson wrote:
>>> Perhaps there's a better way to define that this particular clock
>>> hardware can change rate, but in this implementation it must not?
>> the initialization for this particular PLL on this particular platform
>> is wrong
>> as the interface does not apply to the platform needs even though it is an
>> alpha_pll
>>
>> if the VCO is not an option -even though it reflects the platform
>> constrains-
>> I would suggest nullifying the alpha_pll_ops that do not apply to this
>> platform:
>> ie: set_rate, round_rate set to null in the probe.
>>
>> allowing the interface calls (ops) to go through to later on make them fail
>> based on some setting would be fundamentally wrong IMO
>>
> We have clk_alpha_pll_postdiv_ro_ops so maybe just add another set of
> those for the alpha_pll itself?
>
>

something like  clk_alpha_pll_fixed_ops?
