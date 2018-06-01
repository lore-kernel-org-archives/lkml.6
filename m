Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeFANUv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:20:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeFANUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:20:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8213A605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v9 01/15] ARM: Add Krait L2 register accessor functions
To: Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
 <1520347148-27852-2-git-send-email-sricharan@codeaurora.org>
 <20180524173926.GC14924@minitux>
 <664089d4-b30d-99bb-2021-12128b2895ba@codeaurora.org>
 <152769571081.144038.4314499217001219157@swboyd.mtv.corp.google.com>
 <9f2e1aa8-21c1-10b0-6193-e6bc16993a0d@codeaurora.org>
 <152775249799.144038.9269415086304305030@swboyd.mtv.corp.google.com>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <9ca51832-6095-c8a5-1347-f57abf99e8f9@codeaurora.org>
Date: Fri, 1 Jun 2018 18:50:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152775249799.144038.9269415086304305030@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 5/31/2018 1:11 PM, Stephen Boyd wrote:
> Quoting Sricharan R (2018-05-30 21:57:20)
>> Hi Stephen,
>>
>> On 5/30/2018 9:25 PM, Stephen Boyd wrote:
>>> Quoting Sricharan R (2018-05-24 22:40:11)
>>>> Hi Bjorn,
>>>>
>>>> On 5/24/2018 11:09 PM, Bjorn Andersson wrote:
>>>>> On Tue 06 Mar 06:38 PST 2018, Sricharan R wrote:
>>>>>
>>>>>> From: Stephen Boyd <sboyd@codeaurora.org>
>>>>>>
>>>>>> Krait CPUs have a handful of L2 cache controller registers that
>>>>>> live behind a cp15 based indirection register. First you program
>>>>>> the indirection register (l2cpselr) to point the L2 'window'
>>>>>> register (l2cpdr) at what you want to read/write.  Then you
>>>>>> read/write the 'window' register to do what you want. The
>>>>>> l2cpselr register is not banked per-cpu so we must lock around
>>>>>> accesses to it to prevent other CPUs from re-pointing l2cpdr
>>>>>> underneath us.
>>>>>>
>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>>>>
>>>>> This should have your signed-off-by here as well.
>>>>>
>>>>
>>>>  ok.
>>>>
>>>>> Apart from that:
>>>>>
>>>>> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>
>>>>
>>>
>>> Will these patches come around again? I'll do a quick sweep on them
>>> today but I expect them to be resent.
>>
>> Sure, i will have to resend them again, fixing couple of Bjorn's
>> minor comments. Will address your comments that you would give
>> as well along with that.
>>
> 
> Ok. One general comment is that it would be nice if the bindings for all
> the nodes that are introduced included 'clocks' properties and also
> maybe 'clock-names' properties for the clocks that are consumed by each
> node. Right now, we hide those details from DT and rely on the string
> names to hook the clk tree up for us. That sort of prevents us from
> moving away from string easily, so I would just throw the clocks into
> the binding right now and always have them there just in case we want to
> use the binding to figure out the hierarchy in the future.
> 

 ok, understand that mostly. So will try to revamp those patches with
 the 'clocks' property in the binding added, reading them in the driver
 from DT.

> I've been thinking we need to do something similar for the gcc and other
> nodes for any clks they use, but I haven't gotten around to it.
> 
> Otherwise the patches look mostly ok to me. Not sure I'll have any other
> comments.
> 

 Thanks, will respin.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
