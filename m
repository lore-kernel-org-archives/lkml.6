Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N4McK2ixGlvOCQAAmS7hNA
	; Fri, 08 Jun 2018 16:40:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9F7A2607DC; Fri,  8 Jun 2018 16:40:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2B023602FC;
	Fri,  8 Jun 2018 16:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B023602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeFHQkG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:40:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35696 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeFHQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:40:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 107361435;
        Fri,  8 Jun 2018 09:40:04 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1D243F557;
        Fri,  8 Jun 2018 09:39:58 -0700 (PDT)
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
To: Quentin Perret <quentin.perret@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <52b9575b-4c2a-01df-fadd-10ccf3146112@arm.com>
 <20180608082511.GE3597@e108498-lin.cambridge.arm.com>
 <5a7b8177-7cbe-df90-7d00-8aad0a0f5f08@arm.com>
 <20180608131104.GA7838@e108498-lin.cambridge.arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a51f0aee-8d4b-1149-9cb5-ad1777a93f34@arm.com>
Date: Fri, 8 Jun 2018 18:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608131104.GA7838@e108498-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 03:11 PM, Quentin Perret wrote:
> On Friday 08 Jun 2018 at 14:39:33 (+0200), Dietmar Eggemann wrote:

[...]

>>>> Even though we would be forced to get cpufreq's related cpumask from
>>>> somewhere.
>>>
>>> That's the easy part. The difficult part is, where do you get power
>>> values from ? You have to let the lower layers register those values
>>> in a centralized location on a voluntary basis. And then it becomes easy
>>> for consumers to access that data, because they know where it is.
>>
>> The code in the arch could use the same struct em_data_callback em_cb = {
>> &dev_pm_opp_of_estimate_power } that the cpufreq driver is currently using?
> 
> How do you know from the arch code if you should get power from DT
> with dev_pm_opp_of_estimate_power or use another callback that reads
> power from firmware (SCMI) ?

Ah, ok, cpufreq dt, scpi and arm_big_little are dt, cpufreq scmi can be 
different ...

> 
> I don't think it is reasonable to assume a single source of information for
> an arch. It is is already an incorrect assumption even if just you look at
> the Arm world.

Ok, I see.

> 
>>> Again, I don't think that's possible. You have to let the lower layers
>>> tell you where the power values come from, at the very least. You could
>>> let the archs do that aggregation I suppose, but I don't really see the
>>> benefit over one centralized framework with a generic interface ...
>>> What's your opinion ?
>>
>> Don't understand the '... let the lower layers tell you where the power
>> values come from ...' part. Where is the difference whether the arch or the
>> cpufreq driver uses em_data_callback?
> 
> Because different CPUFreq drivers can be used for one arch. There are
> different CPUFreq drivers because there are different ways of getting
> information about the platform, even just for the Arm world (DT, SCPI,
> SCMI, ...). It's the same thing for power values, they don't necessarily
> come from DT.

scpi is dt ? At least scpi-cpufreq.c uses this 
dev_pm_opp_of_estimate_power too.

> The point of having a centralized EM framework with a standardized
> callback prototype is flexibility. You can implement a callback that
> estimates power from the DT. You can implement a callback that reads
> power from firmware. But you can also have a completely ad-hoc EM
> provider in a module if you like. All you have to do to provide data to
> the framework is respect the callback API.

IMHO, this idea is good, there should be also user of this outside 
arm/arm64 ...

[...]
