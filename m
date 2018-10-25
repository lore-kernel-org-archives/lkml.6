Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2A9ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA62F2082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZdVYQMti";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xnxzs4aD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA62F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeJYTXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:23:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44176 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeJYTXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:23:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FA4860C5F; Thu, 25 Oct 2018 10:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540464662;
        bh=+539guyBfZaQ4LpDvxZY7Ql5hW2MUnEqFJTP2ysr8Ls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZdVYQMtisPDp3C2amJPWVfjwa/7aTosaGRHxGgWs+0TcFiImBKaxqOpx67ICD8X9I
         0cFU/6SRh5l2isvzDCW4s4tu00PcW/KOC+cvOTNSbu8g3mgIEKK1LioWskxJLHtFnG
         60IOKwlm/P8YAUcg5Aea+XjGQvX2yUgVYp41Sh0A=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 945D060792;
        Thu, 25 Oct 2018 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540464661;
        bh=+539guyBfZaQ4LpDvxZY7Ql5hW2MUnEqFJTP2ysr8Ls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xnxzs4aDg5CtIXPx3iZ0Zt9TTB/mAxF0lOmVcVmHA/y2Bs8xJ7t0EBGoZMKMBMqyF
         LqErEdKS2yS3N53b61SLImu81w3zkDwm+L+K/0mrhJiq49LTizKkAL9U8qwnzb6fGP
         LckWGNXmElhrsoj0DVWqw0kGAcAvXB9T7BV7Af+A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 16:21:01 +0530
From:   tdas@codeaurora.org
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
Subject: Re: [PATCH v6] clk: qcom: Add lpass clock controller driver for
 SDM845
In-Reply-To: <5f1b1ab5-e2eb-05ff-7b6d-8557f6dd2ad9@codeaurora.org>
References: <1538654546-31204-1-git-send-email-tdas@codeaurora.org>
 <1538654546-31204-2-git-send-email-tdas@codeaurora.org>
 <153896666821.119890.13143150697797456341@swboyd.mtv.corp.google.com>
 <ba0d7d92-5ad9-2dcf-c5a5-21332df193f0@codeaurora.org>
 <153911832719.119890.11984877060665330428@swboyd.mtv.corp.google.com>
 <7d4012b9-e71d-f114-b228-7198f07ea767@codeaurora.org>
 <153936574404.5275.10513827793530511886@swboyd.mtv.corp.google.com>
 <7ad2344b-2307-3fb3-c34e-7443fb3a1ec8@codeaurora.org>
 <42e20a5e-beb4-fdc1-cf4a-f6329b09a476@codeaurora.org>
 <153978601529.5275.17218656685998024623@swboyd.mtv.corp.google.com>
 <5f1b1ab5-e2eb-05ff-7b6d-8557f6dd2ad9@codeaurora.org>
Message-ID: <360c18d625d6e4792e9ba830c6d0b6ea@codeaurora.org>
X-Sender: tdas@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-19 16:09, Taniya Das wrote:
> On 10/17/2018 7:50 PM, Stephen Boyd wrote:
>> Quoting Taniya Das (2018-10-17 05:04:10)
>>> 
>>> 
>>> On 10/17/2018 5:07 PM, Taniya Das wrote:
>>>> Hello Stephen,
>>>> 
>>>> On 10/12/2018 11:05 PM, Stephen Boyd wrote:
>>>>> Quoting Taniya Das (2018-10-09 23:12:27)
>>>>>> 
>>>>>> 
>>>>>> On 10/10/2018 2:22 AM, Stephen Boyd wrote:
>>>>>>> Quoting Taniya Das (2018-10-09 10:26:38)
>>>>>>>> Hello Stephen,
>>>>>>>> 
>>>>>>>> On 10/8/2018 8:14 AM, Stephen Boyd wrote:
>>>>>>>>> Quoting Taniya Das (2018-10-04 05:02:26)
>>>>>>>>>> Add support for the lpass clock controller found on SDM845 
>>>>>>>>>> based
>>>>>>>>>> devices.
>>>>>>>>>> This would allow lpass peripheral loader drivers to control 
>>>>>>>>>> the
>>>>>>>>>> clocks to
>>>>>>>>>> bring the subsystem out of reset.
>>>>>>>>>> LPASS clocks present on the global clock controller would be
>>>>>>>>>> registered
>>>>>>>>>> with the clock framework based on the device tree flag. Also 
>>>>>>>>>> do
>>>>>>>>>> not gate
>>>>>>>>>> these clocks if they are left unused.
>>>>>>>>> 
>>>>>>>>> Why not gate them? This statement states what the code is 
>>>>>>>>> doing,
>>>>>>>>> not why
>>>>>>>>> it's doing it which is the more crucial information that should 
>>>>>>>>> be
>>>>>>>>> described in the commit text. Also, please add a comment about 
>>>>>>>>> it
>>>>>>>>> to the
>>>>>>>>> code next to the flag.
>>>>>>>>> 
>>>>>>>>> I am concerned that it doesn't make any sense though, so 
>>>>>>>>> probably it
>>>>>>>>> shouldn't be marked as CLK_IGNORE_UNUSED and it's papering over 
>>>>>>>>> some
>>>>>>>>> other larger bug that needs to be fixed.
>>>>>>>>> 
>>>>>>>> 
>>>>>>>> It does not have any bug, it is just that to access these lpass
>>>>>>>> registers we would need the GCC lpass registers to be enabled. I 
>>>>>>>> would
>>>>>>>> update the same in the commit text.
>>>>>>>> 
>>>>>>>> During clock late_init these clocks should not be accessed to 
>>>>>>>> check
>>>>>>>> the
>>>>>>>> clock status as they would result in unclocked access. The 
>>>>>>>> client
>>>>>>>> would
>>>>>>>> request these clocks in the correct order and it would not have 
>>>>>>>> any
>>>>>>>> issue.
>>>>>>>> 
>>>>>>> 
>>>>>>> That seems like the bug right there. If the LPASS registers can't 
>>>>>>> be
>>>>>>> accessed unless the clks in GCC are enabled then this driver 
>>>>>>> needs to
>>>>>>> turn the clks on before reading/writing registers. Marking the 
>>>>>>> clks as
>>>>>>> ignore unused is skipping around the real problem.
>>>>>>> 
>>>>>> 
>>>>>> If the driver requests for the clocks they would maintain the 
>>>>>> order. But
>>>>>> if the clock late init call is invoked before the driver requests, 
>>>>>> there
>>>>>> is no way I could manage this dependency, that is the only reason 
>>>>>> to
>>>>>> mark them unused.
>>>>>> 
>>>>> 
>>>>> Which driver are we talking about here? The lpass clk driver? 
>>>>> Presumably
>>>>> the lpass clk driver would request the GCC clks and turn them on in
>>>>> probe and then register any lpass clks. If the lpass clk driver 
>>>>> probes
>>>>> bfeore late init, then the gcc clks will be enabled and everything
>>>>> works, and if the lpass clk driver probes after late init then the 
>>>>> clks
>>>>> that can't be touched without gcc clks enabled won't be registered, 
>>>>> and
>>>>> then they won't be touched. What goes wrong?
>>>>> 
>>>>> 
>>>> 
>>>> Okay, sure, I will take the GCC clock handles and then 
>>>> enable/disable
>>>> them accordingly.
>>>> 
>>>> I missed earlier, so here is what you suggest
>>> 
>>> gcc_probe --> GCC LPASS clocks registered.
>>> lpass_probe --> clk_get on gcc_lpass_clocks/ clk_prepare_enable -->
>>> register the lpass clocks --> clk_disable_unprepare gcc_lpass_clocks.
>> 
>> Why did the gcc_lpass_clocks get turned off? Shouldn't they just stay
>> enabled all the time?
>> 
> 
> I don't think they are kept enabled all the time.
> 
>>> 
>>> But the problem is not during the above. It is the below
>>> static void clk_disable_unused_subtree(struct clk_core *core)
>>> {
>>> ....
>>> 
>>>           if (clk_core_is_enabled(core)) {  --> This access fails.
>>> ....
>>> 
>>> }
>>> 
>> 
>> You may need to add some prepare_ops to turn on clks needed to
>> read/write lpass registers. Or you can look into using some sort of
>> genpd to enable required clks when these clks are enabled or disabled.
>> But I suspect it would be easier to just leave the clks in GCC for 
>> lpass
>> always enabled and not worry about the complicated genpd things.
>> 
> 
> I need to check if keeping them enabled/marking them CRITICAL could
> have an impact on the reset of the subsystem.

I have checked internally with the teams and the GCC LPASS clocks could 
be left enabled.
Would submit a patch keeping them CRITICAL.
