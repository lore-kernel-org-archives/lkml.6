Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeBHMKw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:10:52 -0500
Received: from foss.arm.com ([217.140.101.70]:34078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeBHMKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:10:51 -0500
Subject: Re: [PATCH v2 08/20] arm64: capabilities: Group handling of features
 and errata
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-9-suzuki.poulose@arm.com>
 <20180207103829.GY5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <86f23003-72bc-5bfc-af40-a92cc68def45@arm.com>
Date: Thu, 8 Feb 2018 12:10:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207103829.GY5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 10:38, Dave Martin wrote:
> On Wed, Jan 31, 2018 at 06:27:55PM +0000, Suzuki K Poulose wrote:
>> So far we have had separate routes for triggering errata and feature
>> capability detection. Also, we never allowed "features" based on local
>> CPU and "errata" based on System wide safe registers. This patch
>> groups the handling of errata and features and also allows them
>> to have all the possible scopes. So we now run through both
>> arm64_features and arm64_errata, in two phases for detection.
>>
>>   1) with SCOPE_LOCAL_CPU filter on each boot time enabled CPUs,
>>      via update_cpu_local_capabilities().
>>
>>   2) with SCOPE_SYSTEM filter only once after all boot time enabled
>>      CPUs are active, triggered from setup_cpu_features().
>>
>> A late CPU goes through both the tables for verification against
>> established capabilities, as before.
>>
>> We could ideally merge the two tables into one. But leave it as
>> it is for easy access to the list of particular type.
>>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> I don't know if there's a way of splitting or refactoring this patch to
> make it easier to understand the changes, but I think I get what's going
> on here now.
> 
> So,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 

Thanks,

> (But if you can see a good way to split it, I'll be happy to take
> another look.)

I did try this out, patches follows.
