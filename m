Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCNPUD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:20:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCNPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:20:01 -0400
Date: Wed, 14 Mar 2018 16:19:56 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
In-Reply-To: <87r2opcr6u.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.21.1803141618320.2481@nanos.tec.linutronix.de>
References: <20180309140249.2840-1-vkuznets@redhat.com> <20180309140249.2840-8-vkuznets@redhat.com> <alpine.DEB.2.21.1803091507300.1364@nanos.tec.linutronix.de> <87r2opcr6u.fsf@vitty.brq.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018, Vitaly Kuznetsov wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > On Fri, 9 Mar 2018, Vitaly Kuznetsov wrote:
> >> Static key is being used to avoid performance penalty for non-Hyper-V
> >> deployments. Tests show we add around 3 (three) CPU cycles on each
> >> VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
> >> loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
> >> but I don't see a clean way to use static key in assembly.
> >
> > STATIC_JUMP_IF_TRUE, STATIC_JUMP_IF_FALSE are your friends.
> >
> 
> Thanks for the tip,
> 
> with a single kernel user of these APIs it was easy to miss :-)
> 
> Unfortunately, these APIs are only present if HAVE_JUMP_LABEL and
> (afaiu) we still care about KVM on !HAVE_JUMP_LABEL builds. It would be
> nice if we can make them behave the same way static_branch_likely() and
> friends do: compile into something else when !HAVE_JUMP_LABEL so we can
> avoid nasty #ifdefs in C code.

What's the reason for !jump label builds of a recent kernel? Old compilers?

Thanks,

	tglx
