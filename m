Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeDXC4w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:56:52 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37549 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932722AbeDXC4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:56:46 -0400
X-Google-Smtp-Source: AIpwx48JqAYYZ1kuuU2ZowZnFE3kPyjsVeyi3KPZAvaPcFccFeGoX+ZmMqI1MfCef2P6TmYyV01qmWneFBEQEQHWLq8=
MIME-Version: 1.0
In-Reply-To: <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
References: <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
 <20180226111630.GB4377@pd.tnic> <CANRm+Cxw2-8Cf+6cg_yZC+SD66uNA5RO+ZaoHHmkpHLzjCih=A@mail.gmail.com>
 <20180226113000.GC4377@pd.tnic> <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
 <20180226114409.GD4377@pd.tnic> <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic> <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com> <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 24 Apr 2018 10:56:46 +0800
Message-ID: <CANRm+CwF+=MZK7a+emRbQuA4OueM3pf3ouo2hch9gnRwBLduUA@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 20:41 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 26/02/2018 13:22, Borislav Petkov wrote:
>> On Mon, Feb 26, 2018 at 01:18:07PM +0100, Paolo Bonzini wrote:
>>>> In this context, "host-initiated" write means written by KVM userspace
>>>> with ioctl(KVM_SET_MSR).  It generally happens only on VM startup, reset
>>>> or live migration.
>>>
>>> To be clear, the target of the write is still the vCPU's emulated MSR.
>>
>> So how am I to imagine this as a user:
>>
>> qemu-system-x86_64 --microcode-revision=0xdeadbeef...
>
> More like "-cpu foo,ucode_rev=0xdeadbeef".  But in practice what would
> happen is one of the following:
>
> 1) "-cpu host" sets ucode_rev to the same value of the host, everyone

I found vmware on my macbook will also do this. :)

Regards,
Wanpeng Li
