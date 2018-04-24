Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeDXUfE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:35:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751295AbeDXUfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:35:01 -0400
Subject: Re: [PATCH v3 02/12] KVM: arm/arm64: Document
 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
To: Peter Maydell <peter.maydell@linaro.org>,
        Christoffer Dall <christoffer.dall@arm.com>
References: <1523607658-9166-1-git-send-email-eric.auger@redhat.com>
 <1523607658-9166-3-git-send-email-eric.auger@redhat.com>
 <20180424164649.GA4533@C02W217FHV2R.local>
 <CAFEAcA_EKuW6DWaHCvAftbL6QUSo6WY0cQmHrZhhbP5HoN_NqQ@mail.gmail.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm-devel <kvm@vger.kernel.org>, kvmarm@lists.cs.columbia.edu,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f4179521-225f-82d3-50b6-af775b375453@redhat.com>
Date: Tue, 24 Apr 2018 22:34:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_EKuW6DWaHCvAftbL6QUSo6WY0cQmHrZhhbP5HoN_NqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoffer, Peter,

On 04/24/2018 06:50 PM, Peter Maydell wrote:
> On 24 April 2018 at 17:46, Christoffer Dall <christoffer.dall@arm.com> wrote:
>> On Fri, Apr 13, 2018 at 10:20:48AM +0200, Eric Auger wrote:
>>> --- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>>> +++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>>> @@ -27,9 +27,32 @@ Groups:
>>>        VCPU and all of the redistributor pages are contiguous.
>>>        Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
>>>        This address needs to be 64K aligned.
>>> +
>>> +    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION (rw, 64-bit)
>>> +      The attr field of kvm_device_attr encodes 3 values:
>>> +      bits:     | 63   ....  52  |  51   ....   16 | 15 - 12  |11 - 0
>>> +      values:   |     count      |       base      |  flags   | index
>>> +      - index encodes the unique redistributor region index
>>
>> I'm not entirely sure I understand the purpose of the index field.
>> Isn't a redistributor region identified uniquely by its base address?
> 
> You need a way to tell the difference beween:
>  (1) redistributors for CPUs 0..63 at 0x40000000, redistributors
>      for 64..127 at 0x80000000
>  (2) redistributors for CPUs 0..63 at 0x80000000, redistributors
>      for 64..127 at 0x40000000
> 
> The index field tells you which order the redistributor
> regions go in.

Yes redistributors are filled in the index order. This matches DT
description
(Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt):

<0x0 0x2d000000 0 0x800000>,      // GICR 1: CPUs 0-31
<0x0 0x2e000000 0 0x800000>;      // GICR 2: CPUs 32-63

Thanks

Eric


> 
> thanks
> -- PMM
> 
