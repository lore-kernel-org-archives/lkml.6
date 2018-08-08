Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AFAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B76721730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jk4Flibl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aTsxIEUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B76721730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeHHMeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:34:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53122 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeHHMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:34:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EF3A60AD9; Wed,  8 Aug 2018 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533723334;
        bh=6I1EO0ib4V9wMyDkp8pUnStRFhnqTcJod7D01rpa8X8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jk4FliblKDZHlnxHVB+LHzbhMne1W796XW5Z9jYzhsrQPDE7EV5oKnErDaoEAXvao
         SvUNOLN50u79PJAGIUDGEyJm6JBcJUpG17FlxJ3gB0zvIUFZz+rVzllVF4JJu32ikd
         sxWpSpHyUMueiXSFdFKYezsKSK3A2mSn9IURsMYs=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AAB9860115;
        Wed,  8 Aug 2018 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533723333;
        bh=6I1EO0ib4V9wMyDkp8pUnStRFhnqTcJod7D01rpa8X8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aTsxIEUULsCisTNZnV8PvnvL9HUA4Nhdia5q3koZll79WhPkpmTjH3CrezBX3L15g
         WOAHRrIdjtQn01Y3pi80AJW/bPtRIrnLKV8Y6V1edU8xYq7HakUs02kj0hpcuje1Ld
         5EqPqytV26tVhRhlQgeP624tdjlwdoSljF9rBQN8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AAB9860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Stephen Boyd <sboyd@kernel.org>, skannan@codeaurora.org
Cc:     Evan Green <evgreen@google.com>, rjw@rjwysocki.net,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        anischal@codeaurora.org, devicetree@vger.kernel.org,
        robh@kernel.org, amit.kucheria@linaro.org
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
 <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
 <153333504360.10763.8964005567051510823@swboyd.mtv.corp.google.com>
 <4d37a1ee4f2d5b30da3f62cbfca756a8@codeaurora.org>
 <153370933225.220756.12056174025047430491@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <c83e4248-aef2-bb40-8d8e-47d9b2918cc7@codeaurora.org>
Date:   Wed, 8 Aug 2018 15:45:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153370933225.220756.12056174025047430491@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2018 11:52 AM, Stephen Boyd wrote:
> Quoting skannan@codeaurora.org (2018-08-06 13:46:05)
>> On 2018-08-03 15:24, Stephen Boyd wrote:
>>> Quoting skannan@codeaurora.org (2018-08-03 12:52:48)
>>>> On 2018-08-03 12:40, Evan Green wrote:
>>>>> Hi Taniya,
>>>>>
>>>>> On Tue, Jul 24, 2018 at 3:44 AM Taniya Das <tdas@codeaurora.org> wrote:
>>>>>>
>>>>>> +               if (src)
>>>>>> +                       c->table[i].frequency = c->xo_rate * lval /
>>>>>> 1000;
>>>>>> +               else
>>>>>> +                       c->table[i].frequency = INIT_RATE / 1000;
>>>>>
>>>>> I don't know much about how this hardware works, but based on the
>>>>> mask, src has 4 possible values. So does 0 mean INIT_RATE, and 1, 2,
>>>>> and 3 all mean xo_rate?
>>>>>
>>>>> Also, is INIT_RATE really constant? It sounds like gpll0 (or
>>>>> gpll0_out_even?). You're already getting the xo clock, why not get
>>>>> gpll0's real rate as well?
>>>>
>>>> Actually I was about to comment and say NOT to get clocks just to get
>>>> their rate. The XO_RATE is just a multiplication factor. This HW/FW
>>>> can
>>>> change in the future and make the multiplication factor to 1KHz.
>>>
>>> So future changes to this hardware are going to make this register
>>> return the final frequency that we should use? Sounds great! But that
>>> isn't how it's working right now. We need to have XO in the binding
>>> here
>>> so the driver can work with different XO frequencies in case that ever
>>> happens. Same story for GPLL0. Hardcoding this stuff in the driver just
>>> means we'll have to swizzle things in the driver when it changes.
>>
>> XO being a different frequency in a Qualcomm chip is way way less likely
>> than anything else we are discussing here. In the 10+years I've been
>> there this has never changed.
>>
>> So, how about making this binding optional? If it's not present we can
>> make assumptions for XO rate and init rate. That'll handle your
>> hypothetical use case while also being optimized.
> 
> Optional properties are almost never correct for clks. Either the clk
> goes there or it doesn't go there. The only time it's optional is if the
> HW has the choice of generating the clk itself internally or to use an
> external clk as input.
> 
> In this case, it's not optional, it's actually used so marking it
> optional is highly confusing.
> 
>>
>>>> We also
>>>> can't really control any of the clocks going to this block from Linux
>>>> (it's all locked down).
>>>
>>> This shouldn't matter. The clocks going to this hardware block are
>>> described by the firmware to the OS by means of the DT node. If the
>>> firmware or the hardware decides to change the input clks then the
>>> binding can have different clk nodes used.
>>
>> There are tons of clocks that are input to blocks in an SoC that are
>> never controlled by Linux. Or are expose in DT because they are set up
>> ahead of time and can't change. So, why make an exception here?
> 
> Because the driver doesn't have to hard-code some frequency that can
> easily come from the DT, making it more flexible for frequency plan
> changes. It doesn't matter about control of clks at all here, so this
> comparison is just plain wrong.
> 
>>
>>>> The INIT_RATE will
>>>> always be 300 MHz independent of what source it's coming from (as in,
>>>> if
>>>> GPLL0 can't give 300, the HW design will be so that we'll find a
>>>> different source).
>>>>
>>>> So, I'd like to remove any clock bindings for this driver.
>>>
>>> No. Bindings describe how the hardware is connected. Please don't
>>> remove
>>> clocks from the binding just because probe defer is a concern.
>>
>> Binding describes hardware controllable by the OS. That's the reality.
>> Let's not add mandatory clock bindings for clocks that the OS can't do
>> anything about.
>>
> 
> It seems that you believe clks should only be used to turn on/off and
> control rates. That is not the whole truth. Sometimes clks are there
> just to express the clk frequencies that are present in the design so
> that drivers can figure out what to do.
> 

Stephen,

As this clock is not configurable by linux clock drivers and we really 
do not care the parent src(as mentioned by Saravana) to generate the 
300MHz, would it be good to define a fixed rate clock so as to express 
the HW connectivity & frequency?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
