Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D76C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C654421908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBD9sojf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbeLUMgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:36:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35854 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731197AbeLUMgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:36:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so5561435wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 04:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TBeYpA+ZER3k/7FfAniVy3+DDhg63t94WdSvWr+H9BM=;
        b=VBD9sojfwuff9TQd3cCRJZqV+/JLU472daO5wi/nmLsk1/qtxnXGa8nL1C3xrgIvf4
         CokE6JYhoN1NMDqHXEx7CVSq3NztiYyoxzw+aWqpZqllRjqFVhTpMHUL6OSDBWzPfk1q
         7OREXHISVJkfJsapbuZWmv3G7kxXFqt2uNQpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TBeYpA+ZER3k/7FfAniVy3+DDhg63t94WdSvWr+H9BM=;
        b=IMfrh39ADAorfo4EtvehL3l+kzKcydhQLXhUn3mV5Uje1q9m4Hct3/sweih6aFrkri
         ci8FIVNJI3EBgoSa17ml3X3Jav4qMgGCE+Sv1i5WpALQXicYJGUu0IX6jyihSA+Bpia7
         Rm8EuhfStaW46mRqBMgQe7csx7ZfBL7E6juzi0QmqpkuV9vubv0s0FwFfleHNcOt1NJ2
         I2r/I2namfZo5LxMFB/KL4mydwEs/3qByNI19FPqzCNfAiqfdV8iw+d//qRO5s4KOVoR
         paxTMmRFBRXiCFjDVltn90neRu4unCnFkIO6Ixko9BModfabIarRswskn5wTY/a1up9Y
         kWnw==
X-Gm-Message-State: AA+aEWZq1YAZ9trxb8XJIp93+RXVCDKajvawyVUt+zVDsN4hZwTkX5Vz
        Mwj+f6q1qCRLZOXJwnu7Nwa2aA==
X-Google-Smtp-Source: AFSGD/UjQ3OTNyO6YJMQpLq3ZRqdIy0AMuUGPKYrYCFKqRJRBppcvQvKeFM0ZRsyQBfVEEM3tJzqVA==
X-Received: by 2002:a1c:d74a:: with SMTP id o71mr2708065wmg.73.1545395807382;
        Fri, 21 Dec 2018 04:36:47 -0800 (PST)
Received: from [192.168.1.2] (119.red-79-146-81.dynamicip.rima-tde.net. [79.146.81.119])
        by smtp.gmail.com with ESMTPSA id k135sm17256615wmd.42.2018.12.21.04.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 04:36:46 -0800 (PST)
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To:     Taniya Das <tdas@codeaurora.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
Date:   Fri, 21 Dec 2018 13:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 12:19, Taniya Das wrote:
>
>
> On 12/17/2018 3:16 PM, Jorge Ramirez-Ortiz wrote:
>> Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
>> specifications.
>>
>> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>   drivers/clk/qcom/gcc-qcs404.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-qcs404.c 
>> b/drivers/clk/qcom/gcc-qcs404.c
>> index 64da032..833436a 100644
>> --- a/drivers/clk/qcom/gcc-qcs404.c
>> +++ b/drivers/clk/qcom/gcc-qcs404.c
>> @@ -304,10 +304,16 @@ static struct clk_alpha_pll gpll0_out_main = {
>>       },
>>   };
>>   +static const struct pll_vco gpll0_ao_out_vco[] = {
>> +    { 800000000, 800000000, 0 },
>> +};
>> +
>>   static struct clk_alpha_pll gpll0_ao_out_main = {
>>       .offset = 0x21000,
>>       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>>       .flags = SUPPORTS_FSM_MODE,
>> +    .vco_table = gpll0_ao_out_vco,
>> +    .num_vco = ARRAY_SIZE(gpll0_ao_out_vco),
>
> Could you please help as to why this is required? This is a fixed PLL 
> and we do not require a VCO table for it.

Hi Taniya,

this patch - the additional information that it provides about the 
hardware - helps to select the right parent clock for a given frequency.

On the qcs404 this clock is one of the two parent clocks of the apcs 
clock controller (the other one being the high frequency pll)
When cpufreq sets a target frequency, there is an iteration through the 
list of parents to select the one that delivers the best match.

When attempting to set the clock for an alpha_pll, the operation does a 
sanity check to validate that the requested frequency is in fact 
reachable using the vco range: trying to set a value that is not in 
range will fail.

This patch makes sure that its range is explicitly defined.

It also helps making sure there are no rounding issues when setting its 
value: without it the clock was being read at 799MHz


>
>>       .clkr = {
>>           .enable_reg = 0x45000,
>>           .enable_mask = BIT(0),
>>
>

