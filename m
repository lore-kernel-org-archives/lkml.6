Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeBZMRA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:17:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752353AbeBZMQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:16:58 -0500
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
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
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
Date: Mon, 26 Feb 2018 13:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226121509.GE4377@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 13:15, Borislav Petkov wrote:
> On Mon, Feb 26, 2018 at 12:54:52PM +0100, Paolo Bonzini wrote:
>> I don't understand how one thing follows from the other.  How are writes
>> to 0x8B related to having a virtualized microcode loaded (which is a
>> concept that actually makes no sense at all)?
> 
> I'm questioning the whole idea. 0x8b is the MSR which gives you the
> microcode revision. Most CPUs don't even allow writing to it, AFAICT.
> (SDM says "may prevent writing" on VM transitions.)
> 
> So how is that host-initiated write to 0x8b is even going to work, in
> reality? kvm module writes the microcode version in there? How does the
> admin work around that?

In this context, "host-initiated" write means written by KVM userspace
with ioctl(KVM_SET_MSR).  It generally happens only on VM startup, reset
or live migration.

Thanks,

Paolo

>> It has already been fixed for a few months, and fixing it is indeed the
>> right thing to do independent of this patch.
> 
> Yap.
> 
