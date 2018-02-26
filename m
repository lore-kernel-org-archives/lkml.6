Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbeBZLQ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:16:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51904 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752157AbeBZLQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:16:52 -0500
Date: Mon, 26 Feb 2018 12:16:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180226111630.GB4377@pd.tnic>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
 <20180226094148.GA15539@pd.tnic>
 <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
 <20180226104921.GA4377@pd.tnic>
 <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 07:02:29PM +0800, Wanpeng Li wrote:
> > So a guest will have *two* microcode revisions - both of which are most
> > likely wrong?!
> 
> Just one revision.

So what does "the non-sensical value which is written by the guest will
not reflect to guest-visible microcode revision" even mean then?

cat /proc/cpuinfo

in the guest shows what exactly?

And what would RDMSR 0x8b show then?

> https://lkml.org/lkml/2017/12/9/29 The original discussion explain in
> more details.

My argument stands: exposing microcode revisions to guests is the wrong
approach. Instead, the kernel should not look at microcode revisions if
it runs virtualized.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
