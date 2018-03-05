Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932731AbeCEWKI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:10:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbeCEWKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:10:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59C0D6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A9DC03B.8020201@codeaurora.org>
Date: Mon, 05 Mar 2018 14:10:03 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: robh@kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>, peterz@infradead.org,
        sudeep.holla@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        jonathan.cameron@huawei.com, frowand.list@gmail.com,
        leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
References: <20180102112533.13640-1-suzuki.poulose@arm.com> <20180102112533.13640-9-suzuki.poulose@arm.com> <5A90B77E.8040105@codeaurora.org> <20180225143653.peb4quk3ha5h3t5x@salmiak> <5A972A7D.9020301@codeaurora.org> <20180301114911.fundyuqxtj5klk4e@lakrids.cambridge.arm.com> <5A986425.9080007@codeaurora.org> <20180302104223.7tpsyhsum7nej237@lakrids.cambridge.arm.com> <5A99A3DC.9020400@codeaurora.org> <20180305105925.4cjiqejfid7rswe6@lakrids.cambridge.arm.com>
In-Reply-To: <20180305105925.4cjiqejfid7rswe6@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 02:59 AM, Mark Rutland wrote:
> On Fri, Mar 02, 2018 at 11:19:56AM -0800, Saravana Kannan wrote:
>> On 03/02/2018 02:42 AM, Mark Rutland wrote:
>>> It's important to note that the DSU PMU's event_init() ensures events
>>> are affine to a single CPU, and the perf core code serializes operations
>>> on those events via the context lock.
>>
>> Ah, I see that now. Thanks!
>>
>>> Therefore, two CPUs *won't* try to access the registers simultaneously.
>>
>> Right, and this driver seems to be going through a lot of work to make sure
>> all events are read in one CPU.
>>
>> Do you even have an upstream target where there are multiple DSU's in a
>> system?
>
> I have no idea, though I do beleive that it's possible for a system to
> have multiple DSUs.
>
>> If not, we can simplify a ton of this code (no hotplug notifiers, no
>> migrating PMUs, no SMP calls, etc) by just adding a spinlock and letting any
>> CPU read these DSU counters.
>
> Regardless of whether we allow arbitrary CPUs to read the counters,
> other logic still needs to be CPU affine, and we'll still need hotplug
> notifiers and event migration.

If you have to support multiple DSUs in a system, then the need is 
obvious. But if you don't have to support multiple DSU, it's not obvious 
to me on why you still need CPU affining or hotplug notifiers. Could you 
please provide me pointers for general understanding?


> I am not necessarily opposed to allowing read() calls from associated
> CPUs, but as before, I'll leave that to Suzuki.

Can you make sure this thread is on Suzuki's radar?

Suzuki,

Could please respond? IPI for DSUs are definitely a pain for us.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
