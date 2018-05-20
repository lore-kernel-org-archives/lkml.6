Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeETOxR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 10:53:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55936 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeETOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 10:53:15 -0400
X-Google-Smtp-Source: AB8JxZoWs+Cqpvx2CEcBp+7L+x5yB9PBBNhvVA5iWNwIzNBOrtpMoucGH+6pKEQetE4pLGB6k46/ag==
Subject: Re: [PATCH v1 1/5] ARM: trusted_foundations: Implement L2 cache
 initialization callback
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20180520101542.12206-1-digetx@gmail.com>
 <20180520101542.12206-2-digetx@gmail.com>
 <20180520140805.GL17671@n2100.armlinux.org.uk>
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
Message-ID: <a5b6a37c-68e7-eb8b-fb78-2942fe501f28@gmail.com>
Date: Sun, 20 May 2018 17:53:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180520140805.GL17671@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.2018 17:08, Russell King - ARM Linux wrote:
> On Sun, May 20, 2018 at 01:15:38PM +0300, Dmitry Osipenko wrote:
>> Implement L2 cache initialization firmware callback that should be invoked
>> early in boot to enable cache HW.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/firmware/trusted_foundations.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
>> index 3fb1b5a1dce9..198ce5c75ca0 100644
>> --- a/arch/arm/firmware/trusted_foundations.c
>> +++ b/arch/arm/firmware/trusted_foundations.c
>> @@ -18,8 +18,13 @@
>>  #include <linux/init.h>
>>  #include <linux/of.h>
>>  #include <asm/firmware.h>
>> +#include <asm/outercache.h>
>>  #include <asm/trusted_foundations.h>
>>  
>> +#define TF_CACHE_MAINT		0xfffff100
>> +
>> +#define TF_CACHE_INIT		1
>> +
>>  #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
>>  
>>  #define TF_CPU_PM		0xfffffffc
>> @@ -63,9 +68,27 @@ static int tf_prepare_idle(void)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_CACHE_L2X0
>> +static void tf_cache_write_sec(unsigned long val, unsigned int reg)
>> +{
>> +	pr_warn("%s: Ignoring write [0x%x]: 0x%08lx\n", __func__, reg, val);
> 
> Why at warning level?  Is this some issue that the user needs to be
> warned about?
> 

If cache-l2x0 code will be changed in the future in a way that it will try to do
something using the secure-registers, then user should be informed about that
incident as we are ignoring the accesses to secure-registers and this may lead
to an undesired consequences. If a such change in cache-l2x0 will happen, then
we will have to take some action by either fixing the invalid accesses or
silencing the warning message if will be appropriate. For now I'd prefer to have
verbosity in the KMSG to masking the potential problems.
