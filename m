Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeBELJC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:09:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751705AbeBELIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:08:54 -0500
Subject: Re: [PATCH v3 08/18] arm/arm64: KVM: Add PSCI version selection API
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jon Masters <jcm@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20180201114657.7323-1-marc.zyngier@arm.com>
 <20180201114657.7323-9-marc.zyngier@arm.com>
 <20180202201706.dj6jmff7lh7bleze@kamzik.brq.redhat.com>
 <20180203115932.24c4bcfb@why.wild-wind.fr.eu.org>
 <20180204123701.GK21802@cbox> <6b0d5f23-950c-b2a6-3cc8-63c3145893b4@arm.com>
 <20180205095823.r5vlfkovrgksykxh@hawk.localdomain>
 <7eb71dd4-c06b-9680-0280-03569925283b@arm.com> <20180205105031.GV21802@cbox>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <3089d003-5904-94a2-c62a-e2c0f512e803@arm.com>
Date: Mon, 5 Feb 2018 11:08:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205105031.GV21802@cbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/18 10:50, Christoffer Dall wrote:
> On Mon, Feb 05, 2018 at 10:42:44AM +0000, Marc Zyngier wrote:
>> On 05/02/18 09:58, Andrew Jones wrote:
>>> On Mon, Feb 05, 2018 at 09:24:33AM +0000, Marc Zyngier wrote:
>>>> On 04/02/18 12:37, Christoffer Dall wrote:
>>
>> [...]
>>
>>>>> Given the urgency of adding mitigation towards variant 2 which is the
>>>>> driver for this work, I think we should drop the compat functionality in
>>>>> this series and work this out later on if needed.  I think we can just
>>>>> tweak the previous patch to enable PSCI 1.0 by default and drop this
>>>>> patch for the current merge window.
>>>>
>>>> I'd be fine with that, as long as we have a clear agreement on the
>>>> impact of such a move.
>>>
>>> Yeah, that's what I was trying to figure out with my fancy tables. I might
>>> be coming around more to your approach now, though. Ensuring the new->old
>>> migration fails is a nice feature of this series. It would be good if
>>> we could preserve that behavior without committing to a new userspace
>>> interface, but I'm not sure how. Maybe I should just apologize for the
>>> noise, and this patch be left as is...
>>
>> How about we don't decide now?
>>
>> I can remove this patch from the series so that the core stuff can make
>> it into the arm64 tree ASAP (I think Catalin wants to queue something
>> early this week so that it can hit Linus' tree before the end of the
>> merge window), and then repost this single patch on its own (with fixes
>> for the things that Christoffer found in his review) after -rc1.
>>
>> It leaves us time to haggle over the userspace ABI (which is
>> realistically not going to affect anyone), and we get the core stuff in
>> place for SoC vendors to start updating their firmware.
>>
> I agree, that's what I tried to suggest in my e-mail as well.  Just
> remember to tweak the previous patch to actually enable PSCI 1.0 by
> default.

Yup. I'll move the KVM_ARM_PSCI_LATEST hunk to that patch, and return it
unconditionally from kvm_psci_version.

	M.
-- 
Jazz is not dead. It just smells funny...
