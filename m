Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62821C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B20521934
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJ/qut51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbeLUTpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:45:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39023 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbeLUTpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:45:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so6771053wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bPsdJXvaDKjMpm+MxiZxTRI2Embzlx3Zwq30nS6yXJw=;
        b=hJ/qut51LkniPzqQhs719iid4FVamcxiB6jBKTvZhuttF1u/LA5u0gTA26uzDzrbuN
         cbveu4ZquLtyTUEouTScXsYnK2Go6nXnTUU3QFxcTY+3ZJlrO8euUbkUbqQNvhIb3msi
         VAQ9+WRQajoTmMHaw/rYBMNhPFfsMiUe6CrKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bPsdJXvaDKjMpm+MxiZxTRI2Embzlx3Zwq30nS6yXJw=;
        b=P1+BMe/4kbYpG4fC8IjD3RJcVz4OR3aM+3/fMbqPqsk6e8TEJraScufAF+WwdJyAEc
         Ss3tcb/dO8PciLLNb+QaFKIHPQYPuq+iDE/xTKtS1pceDGI8uXbbZjfX457INeoa05C3
         GjJ/UEyQkjOu1pL5YjK3cS5ef2fmkjSfp/kY5+huTa5/T6RbYFqUiJjwYo+TtD8pdGRe
         X3Bi0EQWyySTOVP2n+hvlzF50PRJMXzKOJtrzA115My+VUPodlL1y8oyAxnumGcAjfLC
         EhS37rofm0aG0bN22WIhUAEj4MNRCP4db5qn/v1XJ5I3Ufs/rrTCl0dtsBDC/cbik52D
         FDZg==
X-Gm-Message-State: AA+aEWZJ7rrfo5JUmslLYUC7MP5nQ2lSba4PtL/nOVHEFQovfcJnCOcl
        7tVvKSiLNqOSTL/tglD/yGTUyA==
X-Google-Smtp-Source: AFSGD/VmeVwISoEhsSm7H7yJYXVWxXpelLTbavp1NLiLUl4fsBfj4XRsTgkYRgSrLUoqTZOn8JA8iQ==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr4244346wms.70.1545421531174;
        Fri, 21 Dec 2018 11:45:31 -0800 (PST)
Received: from [192.168.1.2] (119.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.119])
        by smtp.gmail.com with ESMTPSA id j129sm9760935wmb.39.2018.12.21.11.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:45:30 -0800 (PST)
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
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
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <94b12f58-b586-6b4b-6c0c-b4adad80d7b0@linaro.org>
Date:   Fri, 21 Dec 2018 20:45:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221192823.GA9704@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 20:28, Bjorn Andersson wrote:
> On Fri 21 Dec 09:58 PST 2018, Taniya Das wrote:
>
>> Hello,
>>
>> On 12/21/2018 6:06 PM, Jorge Ramirez wrote:
>>> On 12/21/18 12:19, Taniya Das wrote:
>>>>
>>>> On 12/17/2018 3:16 PM, Jorge Ramirez-Ortiz wrote:
>>>>> Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
>>>>> specifications.
>>>>>
>>>>> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
>>>>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>>>> ---
>>>>>    drivers/clk/qcom/gcc-qcs404.c | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/clk/qcom/gcc-qcs404.c
>>>>> b/drivers/clk/qcom/gcc-qcs404.c
>>>>> index 64da032..833436a 100644
>>>>> --- a/drivers/clk/qcom/gcc-qcs404.c
>>>>> +++ b/drivers/clk/qcom/gcc-qcs404.c
>>>>> @@ -304,10 +304,16 @@ static struct clk_alpha_pll gpll0_out_main = {
>>>>>        },
>>>>>    };
>>>>>    +static const struct pll_vco gpll0_ao_out_vco[] = {
>>>>> +    { 800000000, 800000000, 0 },
>>>>> +};
>>>>> +
>>>>>    static struct clk_alpha_pll gpll0_ao_out_main = {
>>>>>        .offset = 0x21000,
>>>>>        .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>>>>>        .flags = SUPPORTS_FSM_MODE,
>>>>> +    .vco_table = gpll0_ao_out_vco,
>>>>> +    .num_vco = ARRAY_SIZE(gpll0_ao_out_vco),
>>>> Could you please help as to why this is required? This is a fixed
>>>> PLL and we do not require a VCO table for it.
>>> Hi Taniya,
>>>
>>> this patch - the additional information that it provides about the
>>> hardware - helps to select the right parent clock for a given frequency.
>>>
>>> On the qcs404 this clock is one of the two parent clocks of the apcs
>>> clock controller (the other one being the high frequency pll)
>>> When cpufreq sets a target frequency, there is an iteration through the
>>> list of parents to select the one that delivers the best match.
>>>
>>> When attempting to set the clock for an alpha_pll, the operation does a
>>> sanity check to validate that the requested frequency is in fact
>>> reachable using the vco range: trying to set a value that is not in
>>> range will fail.
>>>
>>> This patch makes sure that its range is explicitly defined.
>>>
>>> It also helps making sure there are no rounding issues when setting its
>>> value: without it the clock was being read at 799MHz
>>>
>>>
>> If the PLL is being read as 799MHz it would because not all the 40 bits of
>> the ALPHA_VAL being programmed by the bootloaders(which are the original
>> owners of this PLL). So we should go with the way they are being set by
>> bootloaders and read by HLOS driver.
>>
>> And a VCO range you have considered is wrong from a PLL perspective. As
>> these are fixed PLLs and VCO range really does not matter here, so please
>> drop this change.
>>
> The problem here is that the PLL should be fixed at 800MHz, but the
> alpha PLL is defined such that it can change. So when the mux-div is
> looking for a suitable parent and divider for our CPU clock it concludes
> that the best way to reach certain frequencies is to change the rate of
> GPLL0.
>
> Adding the vco_table limits the available frequencies for GPLL0 in
> QCS404, without modifying the implementation of the alpha PLL.
>
> Perhaps there's a better way to define that this particular clock
> hardware can change rate, but in this implementation it must not?

the initialization for this particular PLL on this particular platform 
is wrong
as the interface does not apply to the platform needs even though it is an
alpha_pll

if the VCO is not an option -even though it reflects the platform 
constrains-
I would suggest nullifying the alpha_pll_ops that do not apply to this 
platform:
ie: set_rate, round_rate set to null in the probe.

allowing the interface calls (ops) to go through to later on make them fail
based on some setting would be fundamentally wrong IMO












>
> Regards,
> Bjorn
>

