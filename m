Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079F9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE977208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE977208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936388AbeFORmy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:42:54 -0400
Received: from foss.arm.com ([217.140.101.70]:45384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932194AbeFORmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:42:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFE8B1529;
        Fri, 15 Jun 2018 10:42:51 -0700 (PDT)
Received: from [10.1.210.28] (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4593F25D;
        Fri, 15 Jun 2018 10:42:49 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To:     Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <a01f2528-f696-3819-73eb-e321d2256b85@arm.com>
 <c456625c-e61c-b07e-b355-478813d9a182@codeaurora.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <7f3ee013-bd12-7411-f90d-ed0fa1418ac3@arm.com>
Date:   Fri, 15 Jun 2018 18:42:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c456625c-e61c-b07e-b355-478813d9a182@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/18 18:31, Taniya Das wrote:
> 
> 
> On 6/15/2018 6:53 PM, Sudeep Holla wrote:
>>

[...]

>>>
>>>> It should be easily extensible is what I am
>>>> trying to say. You can add more info and alter the information in the
>>>> driver with compatibles if you keep the register info as minimum as
>>>> possible. For now, you have enable, set and lut registers. What if you
>>>> want to provide power numbers ?
>>>>
>>>
>>> Yes I do understand the intent of mapping the whole register space, but
>>> as per the HW specs these 3 registers would be the only ones required
>>> for now. I do not think this hardware engine has any information on the
>>> power numbers.
>>>
>>
>> That's fine. So on this platform DT, will you list only the registers
>> touched by the OS for all the IP ? I am sure that will not be the case.
>>
> 
> Yes, registers list those would be touched by OS only.
> 

You are still missing the point.
Look at other IP blocks like pinmux/gpio/...(choose your pick).

E.g. Lets say gpio controller driver touches only status set and get
registers in a port, will you list then individually in the DT for 'n'
ports on the platform ?

-- 
Regards,
Sudeep
