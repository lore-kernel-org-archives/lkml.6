Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeBZMlp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:41:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752698AbeBZMll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:41:41 -0500
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Borislav Petkov <bp@alien8.de>
Cc: Wanpeng Li <kernellwp@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
 <20180226111630.GB4377@pd.tnic>
 <CANRm+Cxw2-8Cf+6cg_yZC+SD66uNA5RO+ZaoHHmkpHLzjCih=A@mail.gmail.com>
 <20180226113000.GC4377@pd.tnic>
 <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
 <20180226114409.GD4377@pd.tnic>
 <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic>
 <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com>
 <20180226122205.GG4377@pd.tnic>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
Date: Mon, 26 Feb 2018 13:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226122205.GG4377@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 13:22, Borislav Petkov wrote:
> On Mon, Feb 26, 2018 at 01:18:07PM +0100, Paolo Bonzini wrote:
>>> In this context, "host-initiated" write means written by KVM userspace
>>> with ioctl(KVM_SET_MSR).  It generally happens only on VM startup, reset
>>> or live migration.
>>
>> To be clear, the target of the write is still the vCPU's emulated MSR.
> 
> So how am I to imagine this as a user:
> 
> qemu-system-x86_64 --microcode-revision=0xdeadbeef...

More like "-cpu foo,ucode_rev=0xdeadbeef".  But in practice what would
happen is one of the following:

1) "-cpu host" sets ucode_rev to the same value of the host, everyone
else leaves it to zero as is now.

2) Only Amazon uses this feature and we ignore it. :)

Paolo
