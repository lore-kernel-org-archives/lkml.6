Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16673C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C150820823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZufgfBVB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fAAQ0JsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C150820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeKSVp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:45:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeKSVp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:45:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F5CA60B26; Mon, 19 Nov 2018 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542626527;
        bh=/aG8FfUVsrWgRePao2YL9igaOZZUd9d7fc1B+qdSZ2k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZufgfBVBYaBqWK8pVkBzDnXFefKIqj/xNsf4tJf685DR1LmQ4P9V0LTaBkHWvMpof
         2S4OaSoR2qIGCu4tYrvFnfSoJRs6sBN1CdczT/zNIfyBvrFTCdEqGC5uzVvOoSk0Zk
         cSlg+UgGCrFAjoeSdZ23R5CEn02ek9rTDrzz6CqI=
Received: from [10.79.168.24] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5836E6022B;
        Mon, 19 Nov 2018 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542626526;
        bh=/aG8FfUVsrWgRePao2YL9igaOZZUd9d7fc1B+qdSZ2k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fAAQ0JsOry9SWcfViMYG5o0X/qRm7kWB3yp9uYRF+BA58bXUzd/Os3Dn56VKNJm0w
         PIgtQD8cZ9UOTIQqrgnXL4Acaki7tQqpDkYaMDEBZJnOOQTqBchrYi51XB3mgM71ss
         56XDjrfYKsEPAN6JF+rkD7HWQBdlv2qWiTRNtNGI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5836E6022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 1/4] clk: qcom: gdsc: Add support to enable/disable the
 clocks with GDSC
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
 <1534141987-29601-2-git-send-email-anischal@codeaurora.org>
 <154139967580.88331.12189885863422622526@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <0595a52b-f5f4-5b70-ac39-296c9547c55d@codeaurora.org>
Date:   Mon, 19 Nov 2018 16:51:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154139967580.88331.12189885863422622526@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 11/5/2018 12:04 PM, Stephen Boyd wrote:
> Quoting Amit Nischal (2018-08-12 23:33:04)
>> For some of the GDSCs, there is a requirement to enable/disable the
>> few clocks before turning on/off the gdsc power domain. Add support
>> for the same by specifying a list of clk_hw pointers per gdsc and
>> enable/disable them along with power domain on/off callbacks.
>>
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> 
> In v1 of this patch series I asked for much more information in this
> commit text. Please add it here. I won't apply this patch until the
> justification is put into this commit text.
> 

Would surely add more details.

>> ---
>>   drivers/clk/qcom/gdsc.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/gdsc.h |  5 +++++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index a077133..b6adca1 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -12,6 +12,8 @@
>>    */
>>   
>>   #include <linux/bitops.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
> 
> This makes me unhappy. It's almost always a problem when we see clk.h
> and clk-provider.h included in the same file, so if gdsc has to call clk
> APIs to operate correctly, then we should do that by having the gdsc
> code get clks properly instead of directly reaching into the clk_hw
> structure to get a clk pointer. This means we should have the gdsc code
> ask the clk framework to convert a clk_hw pointer into a clk pointer
> because of how so intimately connected the gdsc is to clks on this SoC.
> But given all that, I'm still trying to understand why we need to do
> this within the gdsc code.
> 
> Adding these clk calls to the gdsc seems like we're attaching at the
> wrong abstraction level. Especially if the reason we do it is to make it
> easier for the GPU driver to handle dependencies. I hope that's not the
> case. Either way, it would make more sense to me if we made genpds for
> the clks and genpds for the gdscs and then associated the clk genpds
> with the gdsc genpds so that when a gdsc is enabled the clk domain that
> it depends on is enabled first. Then we have a generic solution for
> connecting clks to gdscs that doesn't require us to add more logic to
> the gdsc driver and avoids having clk providers do clk consumer things.
> Instead, it's all handled outside of this driver by specifying a domain
> dependency. It may turn out that such a solution would still need a way
> to make clk domains in the clk driver, and it will probably need to do
> that by converting clk_hw structures into clk pointers, but it would be
> good to do that anyway.
> 
> So in summary, I believe we should end up at a point where we have clk
> domains and power domains (gdscs) all supported with genpds, and then we
> can connect them together however they're connected by linking the
> genpds to each other. Device drivers wouldn't really need to care how
> they're connected, as long as those genpds are attached to their device
> then the driver would be able to enable/disable them through runtime PM.
> But I can see how this may be hard to do for this patch series, so in
> the spirit of progress and getting things done, it would be OK with me
> if the gdsc code called some new clk API to convert a clk_hw pointer
> into a clk pointer and then did the same enable/disable things it's
> doing in this patch. This whole patch would need to be completely
> untangled and ripped out later when we have clk domains but at least we
> could get something working now while we work on making clk domains and
> plumbing them into genpds and runtime PM.
> 

Yes, I agree with your points above, but as genpds currently cannot have 
a way to take in clock handles, this was the way we chose.

I would add a new clock API as suggested and submit the next series.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
