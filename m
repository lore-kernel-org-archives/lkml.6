Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D9EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B98F214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gn6udRjh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kr4UAioK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B98F214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJQTc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:32:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJQTc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:32:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6647860B1E; Wed, 17 Oct 2018 11:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539776257;
        bh=BmpRy23IUR2+vjVJ4S6FjNtO1J0fGZf2IKh9Vu6z4aI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gn6udRjhsDLQcd5U1f+c0VNyx/M1USDQqfvSLpTErmQuUgdzCSlvAXi00h0ZBM5mS
         bO8n7mHSrw7B5gQA1PBwOpN0UT5olYMjaDi2CzYQAMdCCm+RkTf0qzBIbG1P95+ZLe
         GQ0mjXd5dKm3yDc/8lcF1LfotoRhTx34MlYzAnzA=
Received: from [192.168.225.247] (unknown [49.33.192.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F85D60285;
        Wed, 17 Oct 2018 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539776256;
        bh=BmpRy23IUR2+vjVJ4S6FjNtO1J0fGZf2IKh9Vu6z4aI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kr4UAioKkT0pRH1Gz5v3rzkkC4VIDwZob3FzOdItSzjkJ5EvDKRVDuANbWU2vkLhQ
         uMdfkDLqLKG8TXndCLBxCpaDDLTtTn+bEuBb+DerEzSMb4675YM8dvMM0voKbgqtM+
         tG2IMYV420//nWJ+pyrKh7mgZ7pMsL0PNiO0LKWQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F85D60285
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v6] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538654546-31204-1-git-send-email-tdas@codeaurora.org>
 <1538654546-31204-2-git-send-email-tdas@codeaurora.org>
 <153896666821.119890.13143150697797456341@swboyd.mtv.corp.google.com>
 <ba0d7d92-5ad9-2dcf-c5a5-21332df193f0@codeaurora.org>
 <153911832719.119890.11984877060665330428@swboyd.mtv.corp.google.com>
 <7d4012b9-e71d-f114-b228-7198f07ea767@codeaurora.org>
 <153936574404.5275.10513827793530511886@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <7ad2344b-2307-3fb3-c34e-7443fb3a1ec8@codeaurora.org>
Date:   Wed, 17 Oct 2018 17:07:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153936574404.5275.10513827793530511886@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 10/12/2018 11:05 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-09 23:12:27)
>>
>>
>> On 10/10/2018 2:22 AM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-10-09 10:26:38)
>>>> Hello Stephen,
>>>>
>>>> On 10/8/2018 8:14 AM, Stephen Boyd wrote:
>>>>> Quoting Taniya Das (2018-10-04 05:02:26)
>>>>>> Add support for the lpass clock controller found on SDM845 based devices.
>>>>>> This would allow lpass peripheral loader drivers to control the clocks to
>>>>>> bring the subsystem out of reset.
>>>>>> LPASS clocks present on the global clock controller would be registered
>>>>>> with the clock framework based on the device tree flag. Also do not gate
>>>>>> these clocks if they are left unused.
>>>>>
>>>>> Why not gate them? This statement states what the code is doing, not why
>>>>> it's doing it which is the more crucial information that should be
>>>>> described in the commit text. Also, please add a comment about it to the
>>>>> code next to the flag.
>>>>>
>>>>> I am concerned that it doesn't make any sense though, so probably it
>>>>> shouldn't be marked as CLK_IGNORE_UNUSED and it's papering over some
>>>>> other larger bug that needs to be fixed.
>>>>>
>>>>
>>>> It does not have any bug, it is just that to access these lpass
>>>> registers we would need the GCC lpass registers to be enabled. I would
>>>> update the same in the commit text.
>>>>
>>>> During clock late_init these clocks should not be accessed to check the
>>>> clock status as they would result in unclocked access. The client would
>>>> request these clocks in the correct order and it would not have any issue.
>>>>
>>>
>>> That seems like the bug right there. If the LPASS registers can't be
>>> accessed unless the clks in GCC are enabled then this driver needs to
>>> turn the clks on before reading/writing registers. Marking the clks as
>>> ignore unused is skipping around the real problem.
>>>
>>
>> If the driver requests for the clocks they would maintain the order. But
>> if the clock late init call is invoked before the driver requests, there
>> is no way I could manage this dependency, that is the only reason to
>> mark them unused.
>>
> 
> Which driver are we talking about here? The lpass clk driver? Presumably
> the lpass clk driver would request the GCC clks and turn them on in
> probe and then register any lpass clks. If the lpass clk driver probes
> bfeore late init, then the gcc clks will be enabled and everything
> works, and if the lpass clk driver probes after late init then the clks
> that can't be touched without gcc clks enabled won't be registered, and
> then they won't be touched. What goes wrong?
> 
> 

Okay, sure, I will take the GCC clock handles and then enable/disable 
them accordingly.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
