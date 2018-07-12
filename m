Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E37CC48A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557D92086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BH1ZRWn4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BH1ZRWn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557D92086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbeGLRcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:32:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeGLRcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:32:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8C04E6063F; Thu, 12 Jul 2018 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531416106;
        bh=SuF+3NZN9VhCerD0FARvXizhRudC49PJRmliDWG8lTg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BH1ZRWn4KdPLso+T3IAz/zSAeTKkbtcSfgwZmFn8MkznElvhY234boUKbFA+DamP/
         k06hhroXGebHEJJnSiOzFXF34SrUj9lO/HkQOdD+acbtggyoGALbtH6nKDUZnLo0hE
         /ll+Nh9lnz3Tsuc8TnTyIzle5ZuAzoL/1XXu4Ri4=
Received: from [10.79.173.52] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 200A460251;
        Thu, 12 Jul 2018 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531416106;
        bh=SuF+3NZN9VhCerD0FARvXizhRudC49PJRmliDWG8lTg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BH1ZRWn4KdPLso+T3IAz/zSAeTKkbtcSfgwZmFn8MkznElvhY234boUKbFA+DamP/
         k06hhroXGebHEJJnSiOzFXF34SrUj9lO/HkQOdD+acbtggyoGALbtH6nKDUZnLo0hE
         /ll+Nh9lnz3Tsuc8TnTyIzle5ZuAzoL/1XXu4Ri4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 200A460251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>, ryadav@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
 <153109408562.143105.15954380130353645468@swboyd.mtv.corp.google.com>
 <10f87216-caa2-d523-e134-6cf3acd268a7@codeaurora.org>
 <153111701079.143105.13387458941681113476@swboyd.mtv.corp.google.com>
 <436cc6a3-7406-c695-7879-3b9d042262cc@codeaurora.org>
 <153112184177.143105.15452587215679149679@swboyd.mtv.corp.google.com>
 <288770be-a763-b287-f62a-72ab7616efdb@codeaurora.org>
 <153114876561.143105.465317097490450694@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <e0203471-85ef-456a-d7f3-85c66a82b8c1@codeaurora.org>
Date:   Thu, 12 Jul 2018 22:51:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <153114876561.143105.465317097490450694@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++ Display driver team,

On 7/9/2018 8:36 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-07-09 02:34:07)
>>
>>
>> On 7/9/2018 1:07 PM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-07-09 00:07:21)
>>>>
>>>>
>>>> On 7/9/2018 11:46 AM, Stephen Boyd wrote:
>>>>>>
>>>>>>     > Why is the nocache flag needed? Applies to all clks in this file.
>>>>>>     >
>>>>>>
>>>>>> This flag is required for all RCGs whose PLLs are controlled outside the
>>>>>> clock controller. The display code would require the recalculated rate
>>>>>> always.
>>>>>
>>>>> Right. Why is the PLL controlled outside of the clock controller? The
>>>>> rate should propagate upward to the PLL from here, so who's going
>>>>> outside of that?
>>>>>
>>>> The DSI0/1 PLL are not part of the display clock controller, but in the
>>>> display subsystem which are managed by the DRM drivers. When DRM drivers
>>>> query for the rate clock driver should always return the non cached rates.
>>>
>>> Why? Is the DSI PLL changing rate all the time, randomly, without going
>>> through the clk APIs to do so?
>>>
>>
>> Hmm, I am afraid I do not have an answer for this, but this was the
>> requirement to always return the non cached rates from the clock driver.
>>
> 
> Ok. Who knows about this requirement? Can we add someone from the
> display driver to understand more?
> 
As per my discussions offline with the display teams,

There is a use-case where the clock framework is unaware of the PLL VCO 
frequency change and thus the drivers would query to get the actual HW 
frequency rather than the cached one.

Do you think keeping these flags would have any impact other than always 
getting the non-cached rates?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
