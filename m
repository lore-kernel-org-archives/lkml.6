Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970584AbeCSSy0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:54:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57022 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935682AbeCSSaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:30:20 -0400
Subject: Re: [PATCH v2] arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP
 hardening
From: Marc Zyngier <marc.zyngier@arm.com>
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Christoffer Dall <cdall@kernel.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Sean Campbell <scampbel@codeaurora.org>,
        Thomas Speier <tspeier@codeaurora.org>
References: <1520269603-2900-1-git-send-email-shankerd@codeaurora.org>
 <861sgx5wb6.wl-marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <fed53181-db58-9f48-0c5b-7eebe9eb9b10@arm.com>
Date: Mon, 19 Mar 2018 18:30:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <861sgx5wb6.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/18 10:32, Marc Zyngier wrote:
> On Mon, 05 Mar 2018 17:06:43 +0000,
> Shanker Donthineni wrote:
>>
>> The function SMCCC_ARCH_WORKAROUND_1 was introduced as part of SMC
>> V1.1 Calling Convention to mitigate CVE-2017-5715. This patch uses
>> the standard call SMCCC_ARCH_WORKAROUND_1 for Falkor chips instead
>> of Silicon provider service ID 0xC2001700.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>> Chnages since v1:
>>   - Trivial change in cpucaps.h (refresh after removing ARM64_HARDEN_BP_POST_GUEST_EXIT)
>>
>>  arch/arm64/include/asm/cpucaps.h |  5 ++--
>>  arch/arm64/include/asm/kvm_asm.h |  2 --
>>  arch/arm64/kernel/bpi.S          |  8 ------
>>  arch/arm64/kernel/cpu_errata.c   | 55 ++++++++++++++--------------------------
>>  arch/arm64/kvm/hyp/entry.S       | 12 ---------
>>  arch/arm64/kvm/hyp/switch.c      | 10 --------
>>  6 files changed, 21 insertions(+), 71 deletions(-)
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Will/Catalin, if you want to take it via the arm64 tree, that's fine
> by me.

Please allow me to change my mind. This is going to conflict horribly
with the VHE rework and the HYP randomization patches.

I'll take it via the KVM tree, which will make everyone's life a lot easier.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
