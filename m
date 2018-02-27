Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeB0Igx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 03:36:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752023AbeB0Igw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 03:36:52 -0500
Subject: Re: [PATCH v3] KVM: X86: Allow userspace to define the microcode
 version
To: Wanpeng Li <kernellwp@gmail.com>, Nadav Amit <nadav.amit@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
References: <1519694331-16368-1-git-send-email-wanpengli@tencent.com>
 <F68C9207-03D2-437F-981D-63FE9D5AA61A@gmail.com>
 <CANRm+CwC-Zk4Uq7pYjD9vBW_J9EL0hntFCMtd5sUuYn=ztMRXg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2592816c-80d1-9172-47b4-78613215dc26@redhat.com>
Date: Tue, 27 Feb 2018 09:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CwC-Zk4Uq7pYjD9vBW_J9EL0hntFCMtd5sUuYn=ztMRXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2018 03:22, Wanpeng Li wrote:
>>> @@ -2551,7 +2561,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>               msr_info->data = 0;
>>>               break;
>>>       case MSR_IA32_UCODE_REV:
>>> -             msr_info->data = 0x100000000ULL;
>>> +             msr_info->data = (u64)vcpu->arch.microcode_version;
>> I think that the shifts are missing here (the version should be on the high
>> bits according to intel_get_microcode_revision() ).
> You are right, it seems that we all miss it before.

It's not that the shift are missing.  It's that microcode_version should
be u64 and initialized to 0x100000000ULL.  Sorry I was too concise in my
review of v2, and made that implicit.

(Boris noticed offlist that AMD places the revision is in bit 0-31).

Thanks,

Paolo
