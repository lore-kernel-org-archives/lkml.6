Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D852C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC43220834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MyuoMBiP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L0ge9JtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC43220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeLACtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:49:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44874 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeLACtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:49:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E9BA613C2; Fri, 30 Nov 2018 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543592371;
        bh=B6ePkGvCq4o7KNWp1ARfZRvwuJPMrrlqx2Dv9p3Qtt8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MyuoMBiPbdV2voRwpcDg1Jjacq8Vxnqi7CsgJSxJSDuIzFiU7QOignZTphO/VmjFW
         Oy6O3X4fsqB+SBBwXiIvqEiJFL3CHl1L5svtqbDBQZUm5el4Ps3G4nKBuH4jOXM9Hl
         I5AsO2qoxN7pRQj1g/B312Rxg0rTwAWwpB6YkTbQ=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B14FE613C2;
        Fri, 30 Nov 2018 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543592369;
        bh=B6ePkGvCq4o7KNWp1ARfZRvwuJPMrrlqx2Dv9p3Qtt8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L0ge9JtM569syhkmcgJJuhwL1XEd3IsVVe8WtaPjoiI6tmeDTSWjyUghwKOtYxnJG
         Geod7KkxWh7HiTH1mhtt7ur5p7a7V3FdkasMzlZj7+iY/5UAQ8/sqrm+lW0H9gG9Mi
         3hgc/e6OgtDFKvXoAR/iIdZnw5UoV1Zwo9U7mDNc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B14FE613C2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 1/3] clk: qcom: gcc-msm8998: Mark hmss_dvm and lpass_at
 critical
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
 <20181130065259.26497-2-bjorn.andersson@linaro.org>
 <154356151361.88331.1298482384404357982@swboyd.mtv.corp.google.com>
 <20181130072420.GG5278@tuxbook-pro>
 <154356557630.88331.15462727905875864666@swboyd.mtv.corp.google.com>
 <ea03cff9-517f-f7ec-bc51-966393388c9f@free.fr>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <ed74aad3-26d3-0871-6586-bdd19c5d0253@codeaurora.org>
Date:   Fri, 30 Nov 2018 08:39:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <ea03cff9-517f-f7ec-bc51-966393388c9f@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/2018 2:23 AM, Marc Gonzalez wrote:
> On 30/11/2018 09:12, Stephen Boyd wrote:
> 
>> Quoting Bjorn Andersson (2018-11-29 23:24:20)
>>
>>> On Thu 29 Nov 23:05 PST 2018, Stephen Boyd wrote:
>>>
>>>> Quoting Bjorn Andersson (2018-11-29 22:52:57)
>>>>
>>>>> Keep the two clocks enabled, so that the platform passes
>>>>> clk_disable_unused().
>>>>>
>>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>> ---
>>>>>   drivers/clk/qcom/gcc-msm8998.c | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
>>>>> index 9f0ae403d5f5..d89f8e7c2a59 100644
>>>>> --- a/drivers/clk/qcom/gcc-msm8998.c
>>>>> +++ b/drivers/clk/qcom/gcc-msm8998.c
>>>>> @@ -1972,6 +1972,7 @@ static struct clk_branch gcc_hmss_dvm_bus_clk = {
>>>>>                  .enable_mask = BIT(0),
>>>>>                  .hw.init = &(struct clk_init_data){
>>>>>                          .name = "gcc_hmss_dvm_bus_clk",
>>>>> +                       .flags = CLK_IS_CRITICAL,
>>>>
>>>> Please add a comment about why they're critical. This is a temporary
>>>> solution?
>>>
>>> Disabling them in clk_disable_unused() are bad, mkay...
>>
>> Ugh sad.
>>
>>> SDM845 marks the equivalent clocks as critical with a comment that they
>>> must be on for system operation... I'm uncertain what the exact purpose
>>> of these two clocks are, so I don't have a better explanation right now.
>>
>> Ok. But does any driver ever want to use it? It may make more sense to
>> just remove it entirely and not touch it.
> 
> FWIW, gcc_hmss_dvm_bus_clk is flagged "always on" downstream:
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/clk/msm/clock-gcc-8998.c?h=LE.UM.1.3.r3.25#n1715
> 
> 
> config REGULATOR_CPR3_HMSS
>          bool "CPR3 regulator for HMSS"
>          depends on OF
>          select REGULATOR_CPR3
>          help
>            This driver supports Qualcomm Technologies, Inc. HMSS application
>            processor specific features including memory array power mux (APM)
>            switching, two CPR3 threads which monitor the two HMSS clusters that
>            are both powered by a shared supply, and hardware closed-loop auto
>            voltage stepping.  This driver reads both initial voltage and CPR
>            target quotient values out of hardware fuses.
> 
> I wasn't able to find the meaning of the HMSS acronym via git grep, pdfgrep,
> or a web search. It should be forbidden to use an undefined acronyms in
> bindings documentation, IMHO.

HMSS = Hydra Monaco SubSystem

> 
> 
> I couldn't find gcc_lpass_at_clk in the downstream 4.4 kernel...
> LPASS = Low Power Audio Subsystem
> 
> Regards.
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
