Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeDXQvE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:51:04 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:36834 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeDXQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:50:58 -0400
X-Google-Smtp-Source: AB8JxZoytZeb7w3rHwwu8bE306YAt84dKb5bqySSlI2THmVpc4jDzS5UU9CXse9obf21ZGYdTmewIQzevwFbpVmg8pQ=
MIME-Version: 1.0
In-Reply-To: <20180424164649.GA4533@C02W217FHV2R.local>
References: <1523607658-9166-1-git-send-email-eric.auger@redhat.com>
 <1523607658-9166-3-git-send-email-eric.auger@redhat.com> <20180424164649.GA4533@C02W217FHV2R.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Apr 2018 17:50:37 +0100
Message-ID: <CAFEAcA_EKuW6DWaHCvAftbL6QUSo6WY0cQmHrZhhbP5HoN_NqQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] KVM: arm/arm64: Document KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
To: Christoffer Dall <christoffer.dall@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>,
        Eric Auger <eric.auger.pro@gmail.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm-devel <kvm@vger.kernel.org>, kvmarm@lists.cs.columbia.edu,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 April 2018 at 17:46, Christoffer Dall <christoffer.dall@arm.com> wrote:
> On Fri, Apr 13, 2018 at 10:20:48AM +0200, Eric Auger wrote:
>> --- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>> +++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>> @@ -27,9 +27,32 @@ Groups:
>>        VCPU and all of the redistributor pages are contiguous.
>>        Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
>>        This address needs to be 64K aligned.
>> +
>> +    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION (rw, 64-bit)
>> +      The attr field of kvm_device_attr encodes 3 values:
>> +      bits:     | 63   ....  52  |  51   ....   16 | 15 - 12  |11 - 0
>> +      values:   |     count      |       base      |  flags   | index
>> +      - index encodes the unique redistributor region index
>
> I'm not entirely sure I understand the purpose of the index field.
> Isn't a redistributor region identified uniquely by its base address?

You need a way to tell the difference beween:
 (1) redistributors for CPUs 0..63 at 0x40000000, redistributors
     for 64..127 at 0x80000000
 (2) redistributors for CPUs 0..63 at 0x80000000, redistributors
     for 64..127 at 0x40000000

The index field tells you which order the redistributor
regions go in.

thanks
-- PMM
