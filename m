Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeCOTnx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:43:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751497AbeCOTnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:43:51 -0400
Date: Thu, 15 Mar 2018 20:43:47 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
Message-ID: <20180315194347.GB5180@flask>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-8-vkuznets@redhat.com>
 <2747cc75-b549-61bb-9c1b-0f554a49b536@redhat.com>
 <87zi399xih.fsf@vitty.brq.redhat.com>
 <20180315170202.GA5180@flask>
 <alpine.DEB.2.21.1803152027370.1520@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1803152027370.1520@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-15 20:28+0100, Thomas Gleixner:
> On Thu, 15 Mar 2018, Radim Krčmář wrote:
> > 2018-03-15 16:19+0100, Vitaly Kuznetsov:
> > > This works. But hell, this is a crude hack :-) Not sure if there's a
> > > cleaner way to find what needs to be patched without something like jump
> > > label table ...
> > 
> > Yeah, I can see us accidently patching parts of other instructions. :)
> > 
> > The target instruction address can be made into a C-accessible symbol
> > with the same trick that vmx_return uses -- add a .global containing the
> > address of a label (not sure if a more direct approach would work).
> > 
> > The evil in me likes it.  (The good is too lazy to add a decent patching
> > infrastructure for just one user.)
> 
> Can we just use jump labels please? There is agreement that 4.17 will have
> a dependency on a jump label capable compiler for x86.

Luckily, it turned out that the path is very cold and should use the
simple test-and-jump.
