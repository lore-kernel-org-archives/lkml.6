Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964995AbeEYIla (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:41:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37422 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964791AbeEYIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:41:28 -0400
X-Google-Smtp-Source: ADUXVKLpLzXpBNdqMdnO8Z2v/yvPEHAgoqu+QcQ9166XOOmqwmtYrToJjHuId5yfpGkGelm2r8eKXg==
Subject: Re: [PATCH v1 2/2] cpufreq: tegra20: Use PLL_C as intermediate clock
 source
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180523160020.15291-1-digetx@gmail.com>
 <20180523160020.15291-2-digetx@gmail.com>
 <20180524043040.25pld3ezs4lpabro@vireshk-i7>
 <56552c53-8868-af50-232e-b12e3c247ecd@gmail.com>
 <CAJZ5v0iXibwwnAyjBXc+zO5YQ0=WwaoUqq1K3OWqojh8xX+Wjw@mail.gmail.com>
 <5f9364c0-4ef5-0883-583d-42da8f016a80@gmail.com>
 <CAJZ5v0j80jbqLKORZR87mftbKDbAophywnuDqTfNf-VSBYfyOQ@mail.gmail.com>
 <CAJZ5v0hcvSFfWVCgVU8ApvODhyZqXduaGoBmmh345aGe5MN59g@mail.gmail.com>
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
Message-ID: <1c901cf3-22c9-1784-9914-e460f1f9f22c@gmail.com>
Date: Fri, 25 May 2018 11:41:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hcvSFfWVCgVU8ApvODhyZqXduaGoBmmh345aGe5MN59g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.2018 11:36, Rafael J. Wysocki wrote:
> On Fri, May 25, 2018 at 10:14 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Thu, May 24, 2018 at 2:28 PM, Dmitry Osipenko <digetx@gmail.com> wrote:
>>> On 24.05.2018 11:01, Rafael J. Wysocki wrote:
>>>> On Thu, May 24, 2018 at 7:37 AM, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>> On 24.05.2018 07:30, Viresh Kumar wrote:
>>>>>> On 23-05-18, 19:00, Dmitry Osipenko wrote:
>>>>>>> PLL_C is running at 600MHz which is significantly higher than the 216MHz
>>>>>>> of the PLL_P and it is known that PLL_C is always-ON because AHB BUS is
>>>>>>> running on that PLL. Let's use PLL_C as intermediate clock source, making
>>>>>>> CPU snappier a tad during of the frequency transition.
>>>>>>>
>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/cpufreq/tegra20-cpufreq.c | 25 +++++++++++++++++++++----
>>>>>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
>>>>>>> index 3ad6bded6efc..4bf5ba7da40b 100644
>>>>>>> --- a/drivers/cpufreq/tegra20-cpufreq.c
>>>>>>> +++ b/drivers/cpufreq/tegra20-cpufreq.c
>>>>>>> @@ -25,12 +25,13 @@
>>>>>>>  #include <linux/types.h>
>>>>>>>
>>>>>>>  #define PLL_P_FREQ  216000
>>>>>>> +#define PLL_C_FREQ  600000
>>>>>>>
>>>>>>>  static struct cpufreq_frequency_table freq_table[] = {
>>>>>>>      { .frequency = 216000 },
>>>>>>>      { .frequency = 312000 },
>>>>>>>      { .frequency = 456000 },
>>>>>>> -    { .frequency = 608000 },
>>>>>>> +    { .frequency = 600000 },
>>>>>>>      { .frequency = 760000 },
>>>>>>>      { .frequency = 816000 },
>>>>>>>      { .frequency = 912000 },
>>>>>>> @@ -44,6 +45,7 @@ struct tegra20_cpufreq {
>>>>>>>      struct clk *cpu_clk;
>>>>>>>      struct clk *pll_x_clk;
>>>>>>>      struct clk *pll_p_clk;
>>>>>>> +    struct clk *pll_c_clk;
>>>>>>>      bool pll_x_prepared;
>>>>>>>  };
>>>>>>>
>>>>>>> @@ -58,7 +60,10 @@ static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
>>>>>>>      if (index == 0 || policy->cur == PLL_P_FREQ)
>>>>>>>              return 0;
>>>>>>>
>>>>>>> -    return PLL_P_FREQ;
>>>>>>> +    if (index == 3 || policy->cur == PLL_C_FREQ)
>>>>>>> +            return 0;
>>>>>>
>>>>>> So we can choose between two different intermediate frequencies ? And
>>>>>> I didn't like the way magic number 3 is used here. Its prone to errors
>>>>>> and we better use a macro or something else here.
>>>>>>
>>>>>> Like instead of doing index == 3, what about freq_table[index].freq ==
>>>>>> PLL_C_FREQ ? Same for the previous patch as well.
>>>>>
>>>>> The frequency is determined by the parent clock of CCLK (CPU clock), we can
>>>>> choose between different parents for the CCLK. PLL_C as PLL_P and PLL_X are
>>>>> among the available parents for the CCLK to choose from and there some others.
>>>>>
>>>>> I don't mind to use freq_table[index].freq, though I'd like to keep compiled
>>>>> assembly minimal where possible. Hence the freq_table should be made constant to
>>>>> tell compiler that it doesn't need to emit data fetches for the table values and
>>>>> could embed the constants into the code where appropriate.
>>>>>
>>>>> Could we constify the "struct cpufreq_frequency_table" within the cpufreq core?
>>>>> Seems nothing prevents this (I already tried to constify - there are no
>>>>> obstacles), unless some cpufreq driver would try to modify
>>>>> policy->freq_table->... within the cpufreq callback implementation.
>>>>
>>>> Some drivers generate frequency tables out of external data
>>>> unavailable at compile time, like ACPI tables.
>>>
>>> Instead of making the table constant itself (with its values), seems we can just
>>> make the policy->freq_table pointer constant. I'll try to make a patch for that,
>>> adjusting the pointers in cpufreq core and the drivers. This works for the
>>> acpi-cpufreq at least.
>>
>> Honestly, messing up with the whole subsystem in order to avoid an
>> explicit pointer case doesn't sound right to me.
> 
> Actually, on a second thought I agree that it is better to do it as
> you suggested: make the policy->freq_table pointer constant
> everywhere.
> 
> Sorry for the noise.

No worries.

As I wrote in the reply to the other patch, the Tegra30 support is now on the
way. These changes will collide a tad with the support integration, so I'll
return to re-considering the changes made in this patchset after Tegra30 support
will land. Thank you very much for your reviews and suggestions, I'll take them
into account in the next iteration.
