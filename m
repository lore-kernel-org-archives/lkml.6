Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZruKqjBieSmKPH/IsIfQNGEybMQdbNqipbJuW9HMl+fMrPKBGoVHLmfGVoBysGd37N1dGj2
ARC-Seal: i=1; a=rsa-sha256; t=1524833402; cv=none;
        d=google.com; s=arc-20160816;
        b=uXgw4n/23orKNCctFiouxNiuUBHTTfBH52LIlpo0Wq0GzUrAI29FCjB4ZPeVmLdeEI
         5wnQ3SeCpaTZKtc/rC1e5mdZDolFwHhXv0yVVK8eq+JDxaGAsjX7cf9ab2mFNMmom/RE
         jQBY4bZ8en6DVdX+irVcJPC/Ulv+76X0sYMgnSdCvyszx6zLj/JhyBDCTymKOP3NzCyG
         OrElOROlzE+nGbTKIjsXZM8ByvtGI+M2QtloAm7A/XtshLD7t8JophWaBGQZHrtD1acl
         vZTaUBGY+rE2mCfZYI1SEH4esK6a9RCmknYD/KNafoxRvr16QklRxHs4CPPqt4dQpJMX
         HJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=RZMy8Vva5Z6l0IEYwvM4CexewWI6mTCnVdJmvMk7w/A=;
        b=OqEYN+GB5G2ldTsphL/BoEHstoH1JijV3YCmurmH0Atu1ZO+yphjg4X6RgNquVN0xM
         FPbvSGMwWvstW3WZtp/Kr5fndBOjhEMwH8oKojGdA0alv9H7iC17Ak7z1lXhnK2wa838
         dB47GHPQv3Jf9qJv7UUiktGoU48hTeMZP1vOd8Qj0K0nTy5uUAOHhf5XLYd8oexcKVun
         QY8mq+kVkEV66uPZmli8UzqcfoxR/jq/gMX23rMPmXLbxtWtGDWQ3UNtQ0t+YXL/G12x
         NTy82xafRyxSj6xWp5B0pvB9NeFV2iXz+j0ZlGO18xn/0aljPjnY/DdMQjijc5UZ1NOe
         TYNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 ard.biesheuvel@linaro.org
Subject: Re: [PATCH v8 07/13] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-8-jeremy.linton@arm.com>
 <c3306746-aacd-5ed8-95d6-a3186ec2089f@arm.com>
 <48bd3299-a95a-8aa6-524d-b3aa01dd9ef2@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <14062628-d6bb-2e46-fd7c-edce814b5d22@arm.com>
Date: Fri, 27 Apr 2018 13:49:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <48bd3299-a95a-8aa6-524d-b3aa01dd9ef2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766321415119595?=
X-GMAIL-MSGID: =?utf-8?q?1598903709734418404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/04/18 19:57, Jeremy Linton wrote:
> Hi,
> 
> On 04/26/2018 06:05 AM, Sudeep Holla wrote:
>>
>>
>> On 26/04/18 00:31, Jeremy Linton wrote:
>>> Call ACPI cache parsing routines from base cacheinfo code if ACPI
>>> is enable. Also stub out cache_setup_acpi() so that individual
>>> architectures can enable ACPI topology parsing.
>>>
>>
>> [...]
>>
>>> +#ifndef CONFIG_ACPI
>>> +static inline int acpi_find_last_cache_level(unsigned int cpu)
>>> +{
>>> +    /* ACPI kernels should be built with PPTT support */
>>
>> This sounds incorrect for x86. But I understand why you have it there.
>> Does it makes sense to change above to .. ?
>>
>> #if !defined(CONFIG_ACPI) || (defined(CONFIG_ACPI) &&
>> !(CONFIG_ACPI_PPTT))
>>
> I'm not sure what that buys us, if anything you want more non-users of
> the function to be falling through to the function prototype rather than
> the static inline. The only place any of this matters (as long as the
> compiler/linker is tossing the static inline) is arm64 because its the
> only arch making a call to acpi_find_last_cache_level(). ACPI_PPTT is
> also only visible on arm64 at the moment due to being wrapped in a if
> ARM64 in the Kconfig
> 

Fair enough.

> Put another way, I wouldn't expect an arch to have a 'user' visible
> option to enable/disable parsing the PPTT. If an arch can handle
> ACPI/PPTT topology then I would expect it to be fixed to the CONFIG_ACPI
> state. What happens when acpi_find_last_cache_level() is called should
> only be dependent on whether ACPI is enabled, the PPTT parser itself
> will handle the cases of a missing table.

Agreed. But technically that statement is still incorrect as x86 ACPI
build need not have PPTT enabled. IMO you can reword it, but I will
leave that to Rafael :)

Other than that, it looks good.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
