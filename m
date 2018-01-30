Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeA3RpY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:45:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeA3RpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:45:23 -0500
Date: Tue, 30 Jan 2018 18:45:19 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: Jim Mattson <jmattson@google.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [9/8] KVM: x86: limit MSR_IA32_SPEC_CTRL access based on CPUID
 availability
In-Reply-To: <1517332457.18619.132.camel@infradead.org>
Message-ID: <alpine.DEB.2.20.1801301842310.1797@nanos>
References: <20180109120311.27565-10-pbonzini@redhat.com>  <6dc02278-7004-1794-3705-69c8cad86be4@oracle.com>  <CALMp9eSVC=LO-SrPkA3m6eSpgJ6X4rNCRCf3uvtJEdMG_B72cQ@mail.gmail.com>  <beb9f9b4-7bc0-4a3a-73c2-0828febbd06c@oracle.com>
 <CALMp9eT6i9bhG005S5sqV-Y1RUhsc+AXE42ww8Ej+TXSjD6tEg@mail.gmail.com> <1517332457.18619.132.camel@infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018, David Woodhouse wrote:

> On Tue, 2018-01-30 at 08:57 -0800, Jim Mattson wrote:
> > It's really hard to tell which patches are being proposed for which
> > repositories, but assuming that everything else is correct, I don't
> > think your condition is adequate. What if the physical CPU and the
> > virtual CPU both have CPUID.(EAX=7H,ECX=0):EDX[26], but only the
> > physical CPU has CPUID.(EAX=7H,ECX=0):EDX[27]? If the guest has write
> > access to MSR_IA32_SPEC_CTRL, it can set MSR_IA32_SPEC_CTRL[1]
> > (STIBP), even though setting that bit in the guest should raise #GP.
> 
> Everything we're talking about here is for tip/x86/pti. Which I note
> has just updated to be 4.15-based, although I thought it was going to
> stay on 4.14 for now. So I've updated my tree at
> http://git.infradead.org/linux-retpoline.git/shortlog/refs/heads/ibpb
> accordingly.

Yes, we tried to stay on 4.14 base but this started to created nasty merge
conflicts for no value. Merging in v4.15 turned out to resolve those issues
while still serving as the feed branch for Gregs stable work. For the time
being we try to make stable backporting at least for 4.14/15 as painless as
possible.

Thanks,

	tglx
