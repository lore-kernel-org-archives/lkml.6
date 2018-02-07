Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeBGPKv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:10:51 -0500
Received: from foss.arm.com ([217.140.101.70]:52038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754417AbeBGPKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:10:50 -0500
Subject: Re: [PATCH v2 1/2] arm64: Relax constraints on ID feature bits
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, james.morse@arm.com
References: <20180207142106.10716-1-suzuki.poulose@arm.com>
 <20180207150906.GQ5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <1b48ec33-db45-d6b2-b519-b5652196cb45@arm.com>
Date: Wed, 7 Feb 2018 15:10:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207150906.GQ5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 15:09, Dave Martin wrote:
> On Wed, Feb 07, 2018 at 02:21:05PM +0000, Suzuki K Poulose wrote:

...

> [...]
> 
>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ASID_SHIFT, 4, 0),
>> +	/*
>> +	 * We handle differing ASID widths by explicit checks to make sure the system is
>> +	 * safe via verify_cpu_asid_bits()
> 
> I guess that's sufficient.
> 
> Although I had suggested adding a comment to verify_cpu_asid_bits()
> cross-referencing back to here, it now seems superfluous.  It's fairly
> obvious what that function is supported to do.
> 
> 
> [...]
> 
>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
> 
> [...]
> 
>> +	/*
>> +	 * When CONFIG_ARM64_VHE is enabled, we ensure that there is no conflict in run
>> +	 * levels via verify_cpu_run_el()
>> +	 */
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
> 
> Similarly ack.
> 
> 
> [...]
> 
>> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
> 
> [...]
> 
>> +	/*
>> +	 * Lacking implicit ESB on exception boundaries on a subset of CPUs is no worse than
>> +	 * lacking it on all of them.
>> +	 */
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
> 
> And again.  Thanks.
> 
> [...]
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 


Thanks Dave !
