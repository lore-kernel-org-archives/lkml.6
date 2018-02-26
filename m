Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeBZLoe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:44:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53120 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752264AbeBZLob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:44:31 -0500
Date: Mon, 26 Feb 2018 12:44:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180226114409.GD4377@pd.tnic>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
 <20180226094148.GA15539@pd.tnic>
 <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
 <20180226104921.GA4377@pd.tnic>
 <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
 <20180226111630.GB4377@pd.tnic>
 <CANRm+Cxw2-8Cf+6cg_yZC+SD66uNA5RO+ZaoHHmkpHLzjCih=A@mail.gmail.com>
 <20180226113000.GC4377@pd.tnic>
 <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 07:37:32PM +0800, Wanpeng Li wrote:
> The guest write is ignored as the original kvm implementation before the patch.

That will never work because there's no virtualized microcode loader.
Which will be a dumb idea anyway.

Goes to show that dealing with microcode revisions for a guest is the
wrong approach.

> Hmm, the apic_check_deadline_errata() example can be referred to.

So that's basically what I'm saying - fix apic_check_deadline_errata()
to check whether the kernel runs as a guest.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
