Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4779FC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3134214DC
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bwEm0PMa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TElOT9+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3134214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeIWPcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 11:32:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35602 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeIWPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 11:32:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 892EE60C85; Sun, 23 Sep 2018 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537695316;
        bh=JRt6QTdPzV+hiEmLqvodyH9j77nJh8dRpyJ164eCFjk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bwEm0PMaBiKANlMR0T5/MSjNp0wCP/xQ5b/xLzkS5xUqs9rG602zZQehZCfvgM8xj
         d+xa9pZ6UzXq7YDWB95LULUH07T+SAdi1UY8YprxFJZ+1WRoy9ov9kPL1JlZxm2Qg5
         4D31pFMiG/jWhPBGG3iDwk3yDf7qTjwgSGQK/IkM=
Received: from [10.79.169.181] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE52960C81;
        Sun, 23 Sep 2018 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537695315;
        bh=JRt6QTdPzV+hiEmLqvodyH9j77nJh8dRpyJ164eCFjk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TElOT9+IUdqQFKL+MOG00iF94qhkPDJN7dGbs840v2W4aIWlEfEte2ybiFGIwxHPj
         KCxNHAQxt/Ya404SZGrefh3qV/JAvEOIXMDKLx88L7QNshymqI1NRhQeMIM1eZNdGr
         rsUyqH74G8Mb43EJ/sFaz38QU6iu23D1iJcddbCQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE52960C81
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
 <c83e4248-aef2-bb40-8d8e-47d9b2918cc7@codeaurora.org>
 <153504951102.28926.11593809590549791317@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <3e6b6874-3560-0ea0-6861-9f47f308e089@codeaurora.org>
Date:   Sun, 23 Sep 2018 15:05:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153504951102.28926.11593809590549791317@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,


On 8/24/2018 12:08 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-08-08 03:15:26)
>>
>>
>> On 8/8/2018 11:52 AM, Stephen Boyd wrote:
>>>>
>>>> Binding describes hardware controllable by the OS. That's the reality.
>>>> Let's not add mandatory clock bindings for clocks that the OS can't do
>>>> anything about.
>>>>
>>>
>>> It seems that you believe clks should only be used to turn on/off and
>>> control rates. That is not the whole truth. Sometimes clks are there
>>> just to express the clk frequencies that are present in the design so
>>> that drivers can figure out what to do.
>>>
>>
>> Stephen,
>>
>> As this clock is not configurable by linux clock drivers and we really
>> do not care the parent src(as mentioned by Saravana) to generate the
>> 300MHz, would it be good to define a fixed rate clock so as to express
>> the HW connectivity & frequency?
>>
> 
> As a hack that works great, but why do we need to workaround problems by
> adding a fixed rate clk to DT for this PLL? The PLL is provided by GCC
> node so it should be connected to the GCC node.
> 

Please help with review the next patch series which would take the PLL 
phandle from DT.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
