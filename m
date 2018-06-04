Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeFDJxv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:53:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58055 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751930AbeFDJxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:53:49 -0400
Subject: Re: [PATCH v1 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To: Eric Northup <digitaleric@google.com>
CC: <rkrcmar@redhat.com>, <corbet@lwn.net>, <christoffer.dall@arm.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>, <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        KVM <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
References: <1527772139-19665-1-git-send-email-gengdongjiu@huawei.com>
 <1527772139-19665-3-git-send-email-gengdongjiu@huawei.com>
 <CAG7+5M08R5MDHbR-oYK+un1jgGta2UfuaLaVG5Hf9qT7usHKfg@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <2d6fda7c-653a-4a36-62fb-4e0fc25767b3@huawei.com>
Date: Mon, 4 Jun 2018 17:53:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAG7+5M08R5MDHbR-oYK+un1jgGta2UfuaLaVG5Hf9qT7usHKfg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/6/2 5:22, Eric Northup wrote:
> On Wed, May 30, 2018 at 10:04 PM Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>
>> For the migrating VMs, user space may need to know the exception

[...]

>> +               __u8 pad[6];
>> +               __u64 serror_esr;
>> +       } exception;
>> +       __u32 reserved[12];
> 
> It will be easier to re-purpose this in the future if the field is
> reserved and is checked that it must be zero.  SET_VCPU_EVENTS would
> return EINVAL if reserved fields get used until a later meaning is
> defined for them.
Ok, thanks. I will check the reserved fields when calling SET_VCPU_EVENTS.

> 
>> +};
>> +
>>  /* If you need to interpret the index values, here is the key: */
>>  #define KVM_REG_ARM_COPROC_MASK                0x000000000FFF0000
>>  #define KVM_REG_ARM_COPROC_SHIFT       16
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 56a0260..71d3841 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -289,6 +289,42 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>>         return -EINVAL;
>>  }
>>
[...]
>> --
>> 2.7.4
>>
> 
> .
> 
