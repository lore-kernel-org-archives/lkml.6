Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeESWCy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:02:54 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39500 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeESWCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:02:51 -0400
X-Google-Smtp-Source: AB8JxZq+H2rrw9ji0RiTVianlyoN5t5ZE9tQAsmoL5oQMLQY96LgGNyUb5NwWPJ9PQAKFWGbw7D/og==
Subject: Re: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked
 function
To: Stefan Agner <stefan@agner.ch>, Thierry Reding <treding@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>, linux@armlinux.org.uk
Cc: Stephen Warren <swarren@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>, ard.biesheuvel@linaro.org,
        arnd@arndb.de, nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-4-stefan@agner.ch>
 <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com>
 <263337af-7541-be9e-3db6-6cb987fd08fb@arm.com>
 <f627177c-f813-9e10-ade5-c7654375639b@gmail.com>
 <cf9b916103c0dba1e67682efc69f5bae@agner.ch>
 <498de826-6e6c-63d8-00d6-f394b2725a34@wwwdotorg.org>
 <507a66ab9ab530a6d71db7a74f11ddfb@agner.ch>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <3bc2c0c2-1b8b-5296-4d33-ee8c97c54430@gmail.com>
Date: Sun, 20 May 2018 01:02:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <507a66ab9ab530a6d71db7a74f11ddfb@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.2018 21:21, Stefan Agner wrote:
> On 16.04.2018 18:08, Stephen Warren wrote:
>> On 04/16/2018 09:56 AM, Stefan Agner wrote:
>>> On 27.03.2018 14:16, Dmitry Osipenko wrote:
>>>> On 27.03.2018 14:54, Robin Murphy wrote:
>>>>> On 26/03/18 22:20, Dmitry Osipenko wrote:
>>>>>> On 25.03.2018 21:09, Stefan Agner wrote:
>>>>>>> As documented in GCC naked functions should only use Basic asm
>>>>>>> syntax. The Extended asm or mixture of Basic asm and "C" code is
>>>>>>> not guaranteed. Currently this works because it was hard coded
>>>>>>> to follow and check GCC behavior for arguments and register
>>>>>>> placement.
>>>>>>>
>>>>>>> Furthermore with clang using parameters in Extended asm in a
>>>>>>> naked function is not supported:
>>>>>>>     arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>>>>>>>             references not allowed in naked functions
>>>>>>>                   : "r" (type), "r" (arg1), "r" (arg2)
>>>>>>>                          ^
>>>>>>>
>>>>>>> Use a regular function to be more portable. This aligns also with
>>>>>>> the other smc call implementations e.g. in qcom_scm-32.c and
>>>>>>> bcm_kona_smc.c.
>>>>>>>
>>>>>>> Cc: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> Cc: Stephen Warren <swarren@nvidia.com>
>>>>>>> Cc: Thierry Reding <treding@nvidia.com>
>>>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>> - Keep stmfd/ldmfd to avoid potential ABI issues
>>>>>>>
>>>>>>>    arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>>>>>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/firmware/trusted_foundations.c
>>>>>>> b/arch/arm/firmware/trusted_foundations.c
>>>>>>> index 3fb1b5a1dce9..689e6565abfc 100644
>>>>>>> --- a/arch/arm/firmware/trusted_foundations.c
>>>>>>> +++ b/arch/arm/firmware/trusted_foundations.c
>>>>>>> @@ -31,21 +31,25 @@
>>>>>>>      static unsigned long cpu_boot_addr;
>>>>>>>    -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>>>>>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>>>>>>>    {
>>>>>>> +    register u32 r0 asm("r0") = type;
>>>>>>> +    register u32 r1 asm("r1") = arg1;
>>>>>>> +    register u32 r2 asm("r2") = arg2;
>>>>>>> +
>>>>>>>        asm volatile(
>>>>>>>            ".arch_extension    sec\n\t"
>>>>>>> -        "stmfd    sp!, {r4 - r11, lr}\n\t"
>>>>>>> +        "stmfd    sp!, {r4 - r11}\n\t"
>>>>>>>            __asmeq("%0", "r0")
>>>>>>>            __asmeq("%1", "r1")
>>>>>>>            __asmeq("%2", "r2")
>>>>>>>            "mov    r3, #0\n\t"
>>>>>>>            "mov    r4, #0\n\t"
>>>>>>>            "smc    #0\n\t"
>>>>>>> -        "ldmfd    sp!, {r4 - r11, pc}"
>>>>>>> +        "ldmfd    sp!, {r4 - r11}\n\t"
>>>>>>>            :
>>>>>>> -        : "r" (type), "r" (arg1), "r" (arg2)
>>>>>>> -        : "memory");
>>>>>>> +        : "r" (r0), "r" (r1), "r" (r2)
>>>>>>> +        : "memory", "r3", "r12", "lr");
>>>>>>
>>>>>> Although seems "lr" won't be affected by SMC invocation because it should be
>>>>>> banked and hence could be omitted entirely from the code. Maybe somebody could
>>>>>> confirm this.
>>>>> Strictly per the letter of the architecture, the SMC could be trapped to Hyp
>>>>> mode, and a hypervisor might clobber LR_usr in the process of forwarding the
>>>>> call to the firmware secure monitor (since Hyp doesn't have a banked LR of its
>>>>> own). Admittedly there are probably no real systems with the appropriate
>>>>> hardware/software combination to hit that, but on the other hand if this gets
>>>>> inlined where the compiler has already created a stack frame then an LR clobber
>>>>> is essentially free, so I reckon we're better off keeping it for reassurance.
>>>>> This isn't exactly a critical fast path anyway.
>>>>
>>>> Okay, thank you for the clarification.
>>>
>>> So it seems this change is fine?
>>>
>>> Stephen, you picked up changes for this driver before, is this patch
>>> going through your tree?
>>
>> You had best ask Thierry; he's taken over Tegra maintenance upstream.
>> But that said, don't files in arch/arm go through Russell?
> 
> I think the last patches applied to that file went through your tree.
> 
> Thierry, Russel, any preferences?

I've been preparing patches for upstream to add initial support of L2 cache
maintance to TF / Tegra30 and noticed that without this patch I'm getting a hang
early in boot. That is because before this patch registers store / restore was
incorrect, probably the premature return (lr -> pc) causes stack corruption. Not
sure whether it's worth to backport this patch, but I want to see it at least in
-next.

Thierry, please take care of this patch. Thanks.
