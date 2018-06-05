Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeFEQSv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:18:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbeFEQSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:18:50 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] ACPI / PPTT: fix build when CONFIG_ACPI_PPTT is
 not enabled
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
 <1528209304-3280-2-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0gqQNHCuaeduQ8oQtGNUQcZxK171nDfyMNi1VVfnVsMqQ@mail.gmail.com>
 <83b1b038-c4c1-0199-2cb0-fb5343f0e3f5@arm.com>
 <CAJZ5v0hrJs1Oo-uA560qisZ4no4mbgbH+2fza+5B0ErGGYPTHw@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <ec94a230-2798-8001-d3c5-902ea6f1855b@arm.com>
Date: Tue, 5 Jun 2018 17:18:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hrJs1Oo-uA560qisZ4no4mbgbH+2fza+5B0ErGGYPTHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/18 17:12, Rafael J. Wysocki wrote:
> On Tue, Jun 5, 2018 at 5:33 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 05/06/18 16:00, Rafael J. Wysocki wrote:
>>> On Tue, Jun 5, 2018 at 4:35 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>> Though CONFIG_ACPI_PPTT is selected by platforms and nor user visible,
>>>> it may be useful to support the build with CONFIG_ACPI_PPTT disabled.
>>>>
>>>> This patch adds the missing dummy/boiler plate implementation to fix
>>>> the build.
>>>>
>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>  include/linux/acpi.h      | 15 +++++++++++++++
>>>>  include/linux/cacheinfo.h |  2 +-
>>>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> Hi Rafael,
>>>>
>>>> If you are fine with this, can you provide Ack, so that we route this
>>>> through ARM64 tree where most of the ACPI PPTT support is present.
>>>>
>>>> Regards,
>>>> Sudeep
>>>>
>>>> v1->v2:
>>>>         - removed duplicate definition for acpi_find_last_cache_level
>>>>
>>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>>> index 8f2cdb0eca71..4b35a66383f9 100644
>>>> --- a/include/linux/acpi.h
>>>> +++ b/include/linux/acpi.h
>>>> @@ -1299,8 +1299,23 @@ static inline int lpit_read_residency_count_address(u64 *address)
>>>>  }
>>>>  #endif
>>>>
>>>> +#ifdef CONFIG_ACPI_PPTT
>>>>  int find_acpi_cpu_topology(unsigned int cpu, int level);
>>>>  int find_acpi_cpu_topology_package(unsigned int cpu);
>>>>  int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
>>>> +#else
>>>> +static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
>>>> +{
>>>> +       return -EINVAL;
>>>
>>> Why -EINVAL?
>>>
>>
>> I am not sure either. I used to return -ENOTSUPP, but IIRC someone
>> suggested to use it only for syscalls. Also I just based it on other
>> existing functions in acpi.h
>>
>> I am open for any alternatives if you think that is better here.
> 
> It would be good to make it consistent with the error codes returned
> by the functions when they are present.
> 
> Anyway, it's fine by me if that's consistent with the other acpi.h stubs.
> 

Thanks, indeed I copied it from existing stubs.

Can I take this as official Ack ?

-- 
Regards,
Sudeep
