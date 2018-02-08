Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBHSBZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:01:25 -0500
Received: from foss.arm.com ([217.140.101.70]:38498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHSBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:01:23 -0500
Subject: Re: [PATCH] coresight replicator: set default y after Kconfig rename
To: Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
 <CANLsYkwMUG9pwcMH9UdLWVqS9pzJCOFJa5Y0Y1NX0SqznUdx+w@mail.gmail.com>
 <20180208112213.2f466a1c09f942e8e158a168@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <0457dce1-4cbf-1e29-1f8f-6a38b8d3d713@arm.com>
Date: Thu, 8 Feb 2018 18:01:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180208112213.2f466a1c09f942e8e158a168@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/18 17:22, Kim Phillips wrote:
> On Thu, 8 Feb 2018 08:59:30 -0700
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> 
>> On 7 February 2018 at 14:03, Kim Phillips <kim.phillips@arm.com> wrote:
>>> Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
>>> replicator naming") changed the Kconfig symbol name from
>>> QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
>>> was being set in my juno build script, which left the new symbol unset,
>>> causing the following unexpected grief:
>>>
>>>   # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
>>>   ..<snip>..
>>>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>>   mmap size 528384B
>>>   AUX area mmap length 4194304
>>>   perf event ring buffer mmapped per cpu
>>>   failed to mmap AUX area
>>>   failed to mmap with 12 (Cannot allocate memory)
>>>
>>> Make it default y to help not surprise unsuspecting users.
>>>
>>> Fixes: 1c8859848dbb ("coresight replicator: Cleanup programmable replicator naming")
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/Kconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>>> index ef9cb3c164e1..b94bbd95efa6 100644
>>> --- a/drivers/hwtracing/coresight/Kconfig
>>> +++ b/drivers/hwtracing/coresight/Kconfig
>>> @@ -73,6 +73,7 @@ config CORESIGHT_SOURCE_ETM4X
>>>   config CORESIGHT_DYNAMIC_REPLICATOR
>>>          bool "CoreSight Programmable Replicator driver"
>>>          depends on CORESIGHT_LINKS_AND_SINKS
>>> +       default y
>>>          help
>>>            This enables support for dynamic CoreSight replicator link driver.
>>>            The programmable ATB replicator allows independent filtering of the
>>
>> As I said before don't see why it needs to be treated differently than other CS
>> blocks
> 
> I don't think it does either, but this one is special since it recently
> underwent a rename, which breaks its users that were setting the old
> name in their config builds.  The default y keeps it set in those
> cases, thereby discontinuing any such regression.

I don't think the kernel CONFIG symbols are part of the kernel ABI. So,
unfortunately the users have to take care of making sure they select what
they need.

Suzuki
