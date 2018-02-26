Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeBZLy5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:54:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752322AbeBZLyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:54:55 -0500
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Borislav Petkov <bp@alien8.de>, Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
 <20180226094148.GA15539@pd.tnic>
 <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
 <20180226104921.GA4377@pd.tnic>
 <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
 <20180226111630.GB4377@pd.tnic>
 <CANRm+Cxw2-8Cf+6cg_yZC+SD66uNA5RO+ZaoHHmkpHLzjCih=A@mail.gmail.com>
 <20180226113000.GC4377@pd.tnic>
 <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
 <20180226114409.GD4377@pd.tnic>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
Date: Mon, 26 Feb 2018 12:54:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226114409.GD4377@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 12:44, Borislav Petkov wrote:
>> The guest write is ignored as the original kvm implementation before the patch.
>
> That will never work because there's no virtualized microcode loader.
> Which will be a dumb idea anyway.
> 
> Goes to show that dealing with microcode revisions for a guest is the
> wrong approach.

I don't understand how one thing follows from the other.  How are writes
to 0x8B related to having a virtualized microcode loaded (which is a
concept that actually makes no sense at all)?

> So that's basically what I'm saying - fix apic_check_deadline_errata()
> to check whether the kernel runs as a guest.

It has already been fixed for a few months, and fixing it is indeed the
right thing to do independent of this patch.

Paolo
