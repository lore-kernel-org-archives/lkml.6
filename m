Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbeDRDYY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 23:24:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44619 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbeDRDYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 23:24:23 -0400
X-Google-Smtp-Source: AIpwx4+jCnrynvsV9/s/y9xhVARl5kRGgsMMgNn1C61Ew/HdjWTyv6a6NVLfZuODDHjZRRj71JfzsAddYDsiEXiWdBM=
MIME-Version: 1.0
In-Reply-To: <20180417202417.GA29865@localhost.localdomain>
References: <20180226113000.GC4377@pd.tnic> <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
 <20180226114409.GD4377@pd.tnic> <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic> <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com> <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com> <CANRm+CyyL2jjjn7nZtLJvP+t1pN9ndAGhijmbX4LJh15=O+dvQ@mail.gmail.com>
 <20180417202417.GA29865@localhost.localdomain>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 18 Apr 2018 11:24:22 +0800
Message-ID: <CANRm+CwA22VmpA5cfQg8mF_Xke_hXtP+_ui5xU+LV8v0JNj=3Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-18 4:24 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> On Tue, Apr 17, 2018 at 06:40:58PM +0800, Wanpeng Li wrote:
>> Cc Eduardo,
>> 2018-02-26 20:41 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>> > On 26/02/2018 13:22, Borislav Petkov wrote:
>> >> On Mon, Feb 26, 2018 at 01:18:07PM +0100, Paolo Bonzini wrote:
>> >>>> In this context, "host-initiated" write means written by KVM userspace
>> >>>> with ioctl(KVM_SET_MSR).  It generally happens only on VM startup, reset
>> >>>> or live migration.
>> >>>
>> >>> To be clear, the target of the write is still the vCPU's emulated MSR.
>> >>
>> >> So how am I to imagine this as a user:
>> >>
>> >> qemu-system-x86_64 --microcode-revision=0xdeadbeef...
>> >
>> > More like "-cpu foo,ucode_rev=0xdeadbeef".  But in practice what would
>> > happen is one of the following:
>> >
>> > 1) "-cpu host" sets ucode_rev to the same value of the host, everyone
>> > else leaves it to zero as is now.
>>
>> Hi Paolo,
>>
>> Do you mean the host admin to get the ucode_rev from the host and set
>> to -cpu host, ucode_rev=xxxxxx or qemu get the ucode_rev directly by
>> rdmsr?
>
> QEMU setting ucode_rev automatically using the host value when
> using "-cpu host" (with no need for explicit ucode_rev option)
> makes sense to me.

QEMU can't get the host value by rdmsr MSR_IA32_UCODE_REV directly
since rdmsr will #GP when ring !=0, any idea?

Regards,
Wanpeng Li
