Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeBZMVY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:21:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54618 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752383AbeBZMVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:21:18 -0500
Date: Mon, 26 Feb 2018 13:20:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180226122058.GF4377@pd.tnic>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
 <20180226094148.GA15539@pd.tnic>
 <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
 <20180226104921.GA4377@pd.tnic>
 <eeae3e95-c908-695a-043f-a99f8ed39919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eeae3e95-c908-695a-043f-a99f8ed39919@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:47:27PM +0100, Paolo Bonzini wrote:
> It's actually 0x100000000.

Even more wrong. Revision ID is bits [31:0].

> Actually I think this patch makes sense, since some errata actually can
> be worked around in the guest in the same way as the host.  However, it
> should also be tied to the recently introduced mechanism to read MSR
> contents from the host.

So if we decide to do microcode revisions in the guest, we should
consider the fact that microcode revisions need to be handled the same
way as CPUID bits: a revision number means something on baremetal and
implies a certain functionality, just like a set CPUID bit does.

So we either have that same functionality in the guest or we don't talk
about revisions at all. Because if we end up lying by coming up with
revision numbers, all hell will break loose in the guest.

IMO, of course.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
