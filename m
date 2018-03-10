Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeCJSkw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:40:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35844 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeCJSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:40:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFABE601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
Reply-To: shankerd@codeaurora.org
Subject: Re: [PATCH v2] arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP
 hardening
To: Will Deacon <will.deacon@arm.com>
Cc: Thomas Speier <tspeier@codeaurora.org>,
        Christoffer Dall <cdall@kernel.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Sean Campbell <scampbel@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1520269603-2900-1-git-send-email-shankerd@codeaurora.org>
 <20180309134809.GC15537@arm.com>
From: Shanker Donthineni <shankerd@codeaurora.org>
Message-ID: <92763e2b-ffba-8247-c403-bcd1d331a872@codeaurora.org>
Date: Sat, 10 Mar 2018 12:40:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180309134809.GC15537@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 03/09/2018 07:48 AM, Will Deacon wrote:
> Hi SHanker,
> 
> On Mon, Mar 05, 2018 at 11:06:43AM -0600, Shanker Donthineni wrote:
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
> Could you reply to my outstanding question on the last version of this patch
> please?
> 

I replied to your comments. This patch contents have been discussed with QCOM CPU
architecture and design team. Their recommendation was to keep two variants of
variant2 mitigation in order to take advantage of Falkor hardware and avoid the
unnecessary overhead by calling SMMCC always.


> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/564194.html
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
