Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbeBZMPf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:15:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54336 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752353AbeBZMPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:15:33 -0500
Date: Mon, 26 Feb 2018 13:15:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180226121509.GE4377@pd.tnic>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:54:52PM +0100, Paolo Bonzini wrote:
> I don't understand how one thing follows from the other.  How are writes
> to 0x8B related to having a virtualized microcode loaded (which is a
> concept that actually makes no sense at all)?

I'm questioning the whole idea. 0x8b is the MSR which gives you the
microcode revision. Most CPUs don't even allow writing to it, AFAICT.
(SDM says "may prevent writing" on VM transitions.)

So how is that host-initiated write to 0x8b is even going to work, in
reality? kvm module writes the microcode version in there? How does the
admin work around that?

> It has already been fixed for a few months, and fixing it is indeed the
> right thing to do independent of this patch.

Yap.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
