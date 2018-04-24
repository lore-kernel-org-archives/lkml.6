Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932868AbeDXC7J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:59:09 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:42885 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932787AbeDXC7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:59:05 -0400
X-Google-Smtp-Source: AIpwx4/RX/+ZFW9dTDnIPKk4XtoEHEgd5g6XMW254dAIvMHqjjbwjgROYBcBZU8Tjh8Ai0ikeuFWK0ghiHIEfT+TuEg=
MIME-Version: 1.0
In-Reply-To: <de059c45-d706-ff70-9063-92ac0a807e26@redhat.com>
References: <20180226114409.GD4377@pd.tnic> <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic> <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com> <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com> <CANRm+CyyL2jjjn7nZtLJvP+t1pN9ndAGhijmbX4LJh15=O+dvQ@mail.gmail.com>
 <20180417202417.GA29865@localhost.localdomain> <CANRm+CwA22VmpA5cfQg8mF_Xke_hXtP+_ui5xU+LV8v0JNj=3Q@mail.gmail.com>
 <20180418090329.GJ29865@localhost.localdomain> <de059c45-d706-ff70-9063-92ac0a807e26@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 24 Apr 2018 10:59:04 +0800
Message-ID: <CANRm+CzxG5cm8ECopzGYpF3E3RTjvFGD3_7o8S=tffFxnvYoiA@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-18 18:36 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 18/04/2018 11:03, Eduardo Habkost wrote:
>>>> QEMU setting ucode_rev automatically using the host value when
>>>> using "-cpu host" (with no need for explicit ucode_rev option)
>>>> makes sense to me.
>>> QEMU can't get the host value by rdmsr MSR_IA32_UCODE_REV directly
>>> since rdmsr will #GP when ring !=0, any idea?
>> By looking at kvm_get_msr_feature(), it looks like
>> ioctl(system_fd, KVM_GET_MSRS) would return the host MSR value
>> for us.
>
> Yes, that's exactly what it was introduced for (together with other MSRs
> including VMX capabilities).

How about the live migration? What will happen if the source and
destination machines have different microcode version?

Regards,
Wanpeng Li
