Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeBWVqy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:46:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52740 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBWVqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:46:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91A2A6030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A908BCA.3080403@codeaurora.org>
Date: Fri, 23 Feb 2018 13:46:50 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>, will.deacon@arm.com,
        robh@kernel.org, sudeep.holla@arm.com, mathieu.poirier@linaro.org,
        peterz@infradead.org, jonathan.cameron@huawei.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com, leo.yan@linaro.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        avilaj@codeaurora.org
Subject: Re: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
References: <20180102112533.13640-1-suzuki.poulose@arm.com> <20180102112533.13640-9-suzuki.poulose@arm.com> <5A8E2BCE.3050509@codeaurora.org> <20180222113352.oeedj7upx3zxvdcc@lakrids.cambridge.arm.com> <5A8F2A4F.5020105@codeaurora.org> <20180223113552.2gn27h4uxbpo5zoq@lakrids.cambridge.arm.com>
In-Reply-To: <20180223113552.2gn27h4uxbpo5zoq@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 03:35 AM, Mark Rutland wrote:
> On Thu, Feb 22, 2018 at 12:38:39PM -0800, Saravana Kannan wrote:
>> On 02/22/2018 03:33 AM, Mark Rutland wrote:
>>> On Wed, Feb 21, 2018 at 06:32:46PM -0800, Saravana Kannan wrote:
>>>> I'm not exactly sure if we can add entries to perf_type_id. If that's
>>>> allowed maybe we need to add something line PERF_TYPE_DSU and use that?
>>>>
>>>> Or if that's not allowed then would it be better to offset the DSU PMU
>>>> events by some number (say 0x1000) and then delete the event type check or
>>>> pass PERF_TYPE_RAW to perf_pmu_register()?
>>>
>>> As above, neither of these should be necessary.
>>
>> For the userspace interface. How about the kernel interface though?
>> perf_event_create_kernel_counter() takes attr.type as an input. But there's
>> no way to look up the DSU PMU's "type".
>
> There is no lookup mechanism currently.
>
> I take it you want to use DSU events from a kernel module?

Yes

>
> It would be possible to have a simlar name -> type lookup mechanism
> kernel-side, if necessary.

Yeah, this is what I was thinking once you explained how user space 
handles this. Just wanted to hear it from this thread. I can submit a patch.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
