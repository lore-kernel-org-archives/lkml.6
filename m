Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933207AbeEHQ57 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:57:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbeEHQ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:57:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B085D6019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [v8] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1525428158-29147-1-git-send-email-tdas@codeaurora.org>
 <1525428158-29147-2-git-send-email-tdas@codeaurora.org>
 <152545267793.138124.15345698220033125655@swboyd.mtv.corp.google.com>
 <a926924f-2033-acd6-67cb-210a5e487ebb@codeaurora.org>
 <152573930157.138124.12994299541712205183@swboyd.mtv.corp.google.com>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <ebdc6b56-f6d6-7e63-ebc2-6d60f5d1b690@codeaurora.org>
Date: Tue, 8 May 2018 22:27:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152573930157.138124.12994299541712205183@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for your review comments, please check my comments below,  so 
that I could submit the next patch series.

On 5/8/2018 5:58 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-05-07 03:48:06)
>> Hello Stephen,
>>
>> Could you please let me know your comments on the below.
>>
>> On 5/4/2018 10:21 PM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-05-04 03:02:38)
>>>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>>>> new file mode 100644
>>>> index 0000000..944fe04
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/clk-rpmh.c
>>>> @@ -0,0 +1,334 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>>>> + */
>>>> +
>>>> +};
>>>> +
>>>> +struct clk_rpmh_desc {
>>>> +       struct clk_hw **clks;
>>>> +       size_t num_clks;
>>>> +};
>>>
>>> This could be replaced with the clk_hw_onecell_data struct and then the
>>> only problem becomes the const part which seems pretty impossible to fix
>>> at this point. One "workaround" is to memdup the structure. Ugh.
>>>
>>
>> Will be okay, if I can the following?
>>
>> _probe...
>> {
>>          struct clk_rpmh_desc *hw_desc_data;
>>          ....
>>
>>          hw_desc_data = kmemdup(desc, sizeof(*desc), GFP_KERNEL);
>>
>>          ...
>>          ret = devm_of_clk_add_hw_provider(&pdev->dev,     of_clk_rpmh_hw_get,
>> hw_desc_data);
>>           ....
>>
>> }
>>
>> And also I fix the "getter" function.
> 
> I'd rather see the check for out of bounds number just go away, unless
> that's helping something. The kmemdup() doesn't look good.
> 

I think it is better to copy the desc data to "clk_hw_onecell_data", as 
I would also have to fix the "getter" function to check for out of bound 
numbers (idx >= num_clks).

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
