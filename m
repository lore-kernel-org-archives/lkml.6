Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbeBGENH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:13:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeBGENF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:13:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FD26601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
To: Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org>
 <CAD=FV=WcCnQJc25=sKWtOi=ZWi=ium6DVsexuQnsLDL=aJE6-Q@mail.gmail.com>
 <20180206190614.GL9465@builder>
 <CAD=FV=Whxf1VRJ6qx9mioEEkTeS+uJfJKPbOMcGy-Wigh_NORw@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <ade06d48-2003-026a-2e99-06ff0223efb9@codeaurora.org>
Date: Wed, 7 Feb 2018 09:42:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Whxf1VRJ6qx9mioEEkTeS+uJfJKPbOMcGy-Wigh_NORw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 01:19 AM, Doug Anderson wrote:
> Hi,
> 
> On Tue, Feb 6, 2018 at 11:06 AM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
>> On Tue 06 Feb 10:37 PST 2018, Doug Anderson wrote:
>>
>>> Hi,
>>>
>>> On Fri, Jan 26, 2018 at 2:18 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>>> On 01/25, Rajendra Nayak wrote:
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..b97f99e6f4b4
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
>>>>> @@ -0,0 +1,32 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>>>>> + */
>>>>> +
>>>>> +&tlmm {
>>>>
>>>> I'm not the maintainer, but I find this approach to the pins
>>>> really annoying. I have to flip to another file to figure out how
>>>> a board has configured the pins. And we may bring in a bunch of
>>>> settings that we don't ever use on some board too. Why can't we
>>>> put the settings in the board file directly?
>>>
>>> I'm not so familiar with how things work with Qualcomm, but in general
>>> I think putting this in the "board" file is a bad idea.  I'd be OK
>>> with putting this directly in the SoC file (though it might get
>>> unwieldy?), but not moving things to the board file as was done with
>>> v2 of this patch.
>>>
>>> Said another way: nearly board that uses SDM845 that uses UART2 will
>>> have the same definitions for these pins so we shouldn't be
>>> duplicating it across every board, right?
>>>
>>
>> We've run into several cases where different boards uses the same
>> function but requires board specific electrical configuration.
>>
>> So what we decided was to keep the pinmux in the soc-file (where e.g.
>> the uart definition is) and then extend it with the board specific
>> electrical properties (the pinconf), in the board files.
>>
>> This does come with the complexity of having the pinctrl nodes split in
>> two places, but the responsibilities of the two parts is clear and we
>> remove the need for all board files to ensure the appropriate pinmux is
>> in place.
>>
>>
>> NB. We did discuss adding "sane defaults" for the pinconf in the soc
>> dtsi, but we end up spending considerable time debugging issues stemming
>> from not having the right pinconf; so better make this explicit and say
>> that the board has to specify it's config.
> 
> Whoops, saw your responses _after_ I sent my response to v2.  In any
> case this makes sense to me then!  On Rockchip boards I've been
> involved in we often added "sane defaults", but I can see how that
> could be confusing in different ways.  I'm happy with your choice and
> it seems like a happy medium.  The sdm845.dtsi file can have the main
> definition of the nodes and can thus refer to the nodes.  Then you
> just add the extra bit in the board file.
> 
> What you propose is not what happened in v2 of the series
> <https://patchwork.kernel.org/patch/10194201/> though.  In v2 _both_
> the pinconf and the pinmux moved to the board file.  That's wrong.

got it. I'll fix this up in my v3. Thanks for the review.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
