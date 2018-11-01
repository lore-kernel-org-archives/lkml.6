Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD31C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF1620830
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cZ/u97vG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nFcQ3sPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF1620830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeKAODz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:03:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42526 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeKAODy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 10:03:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01EA560795; Thu,  1 Nov 2018 05:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541048552;
        bh=Do00PobtbZla7MZ3DLlGPN3rzOic9p3z4301VRbKRgc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cZ/u97vGfB34SuQ7Wh1uCu/KmuZDtYpeX8wd1RUosjCA2bjMlYiUdx4IfPWRlASFs
         ewTw3oaBrgpSzjcc5bQDyVVQmZorS5msUokjivoSEz5FXfIL8MUnrTatgfCt7IFBvW
         TuiDT1zE18OYv24+y+jqIWUC3fKfSB+pXOyGbAS8=
Received: from [10.79.162.146] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A85C6014B;
        Thu,  1 Nov 2018 05:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541048551;
        bh=Do00PobtbZla7MZ3DLlGPN3rzOic9p3z4301VRbKRgc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nFcQ3sPDQ1VUa3P1Yk7org8SxXJX8JivSiBQQssOHLMq+zN5A2v22oKvSn7yoz12S
         vlv97JGwreH3QLPLDmPvY+dI4az7e8b0o4lWXRL75h0uYVqmILNyubVsScAMILdvDX
         sdrhFgp+V9LfDak4m7yEY6QXJIFctq2v2SbHkQcM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A85C6014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 2/2] clk: qcom : dispcc: Add support for display port
 clocks
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        chandanu@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org, linux-arm-msm-owner@vger.kernel.org
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
 <153911726378.119890.5522594539667887860@swboyd.mtv.corp.google.com>
 <3c4cccca-2c5c-927f-f471-2bbbd71b4155@codeaurora.org>
 <9c359e26-3708-14b6-f22a-fb529446d325@codeaurora.org>
 <154083859263.98144.15690571729193618604@swboyd.mtv.corp.google.com>
 <f3e40308-d2dd-cce9-4b19-3af419841bc1@codeaurora.org>
 <154091723693.98144.6979314028521443413@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <9c82010f-f3fd-2867-352e-3584ab4ba8f0@codeaurora.org>
Date:   Thu, 1 Nov 2018 10:32:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154091723693.98144.6979314028521443413@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Chandan from Display Port team,

On 10/30/2018 10:03 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-29 23:01:44)
>> On 10/30/2018 12:13 AM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-10-28 03:34:55)
>>>> On 2018-10-19 16:04, Taniya Das wrote:
>>>>> On 10/10/2018 2:04 AM, Stephen Boyd wrote:
>>>>>> Quoting Taniya Das (2018-10-09 06:57:47)
>>>>>>> diff --git a/drivers/clk/qcom/dispcc-sdm845.c
>>>>>>> b/drivers/clk/qcom/dispcc-sdm845.c
>>>>>>> index 0cc4909..6d3136a 100644
>>>>>>> --- a/drivers/clk/qcom/dispcc-sdm845.c
>>>>>>> +++ b/drivers/clk/qcom/dispcc-sdm845.c
>>>>>>> +       },
>>>>>>> +};
>>>>>>> +
>>>>>>> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_link_clk_src[] = {
>>>>>>> +       F(162000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>>>>>>> +       F(270000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>>>>>>> +       F(540000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>>>>>>> +       F(810000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>>>>>>
>>>>>> Are these in kHz? They really look like it and that's bad. Why do we
>>>>>> need them at all? Just to make sure the display driver picks these
>>>>>> exact
>>>>>> frequencies? It seems like we could just pass whatever number comes in
>>>>>> up to the parent and see what it can do.
>>>>>>
>>>>>
>>>>> Let me check back the reason we had to make this change.
>>>>
>>>> We will need this flag since we reset/power-down the PLL every time we
>>>> disconnect/connect the DP cable or during suspend/resume. Only with this
>>>> flag, the calls to the PLL driver are properly called.
>>>
>>> What does this mean? I wanted to know about the weird frequencies listed
>>> above, and why it can't be done without a frequency table and direct
>>> rates passed up to the parent.
>>>
>>
>> OOps, my bad :(.
>>
>> We added these changes to handle higher clock rates. These rates when
>> greater than 4.3Ghz cannot be represented in 32bit variables. For DP, we
>> already have 5.4G and 8.1GHz freq for VCO clock. We will need these Khz
>> freq list in clock driver.
>>    Let me check if they can do something like the byte/pixel clocks of
>> display.
> 
> Well then we really should just throw away the freq table here and have
> rcg ops that pass the frequency up to the display PLL. Also, those
> numbers look like gigabits per second (Gbit/s) for the DP spec which
> isn't exactly the same as a clk frequency. What frequency does the PLL
> run at for these various DP link speeds?
> 
Could you please help with the above query from Stephen?
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
