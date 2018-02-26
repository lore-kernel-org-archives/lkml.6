Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeBZMSN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:18:13 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51143 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbeBZMSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:18:11 -0500
X-Google-Smtp-Source: AH8x226Van2S+Cz3FXoNCGdtk+/d8mdWTUZIpOXXDuwXMvB3RLwjJmpBPjKUEK8BgY+1lPapRZOiyA==
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
From: Paolo Bonzini <pbonzini@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Wanpeng Li <kernellwp@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180226094148.GA15539@pd.tnic>
 <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
 <20180226104921.GA4377@pd.tnic>
 <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
 <20180226111630.GB4377@pd.tnic>
 <CANRm+Cxw2-8Cf+6cg_yZC+SD66uNA5RO+ZaoHHmkpHLzjCih=A@mail.gmail.com>
 <20180226113000.GC4377@pd.tnic>
 <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
 <20180226114409.GD4377@pd.tnic>
 <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic>
 <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
Message-ID: <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com>
Date: Mon, 26 Feb 2018 13:18:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 13:16, Paolo Bonzini wrote:
> On 26/02/2018 13:15, Borislav Petkov wrote:
>> On Mon, Feb 26, 2018 at 12:54:52PM +0100, Paolo Bonzini wrote:
>>> I don't understand how one thing follows from the other.  How are writes
>>> to 0x8B related to having a virtualized microcode loaded (which is a
>>> concept that actually makes no sense at all)?
>>
>> I'm questioning the whole idea. 0x8b is the MSR which gives you the
>> microcode revision. Most CPUs don't even allow writing to it, AFAICT.
>> (SDM says "may prevent writing" on VM transitions.)
>>
>> So how is that host-initiated write to 0x8b is even going to work, in
>> reality? kvm module writes the microcode version in there? How does the
>> admin work around that?
> 
> In this context, "host-initiated" write means written by KVM userspace
> with ioctl(KVM_SET_MSR).  It generally happens only on VM startup, reset
> or live migration.

To be clear, the target of the write is still the vCPU's emulated MSR.

Paolo
