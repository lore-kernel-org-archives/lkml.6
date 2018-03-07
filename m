Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934006AbeCGPk2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:40:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933386AbeCGPkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:40:23 -0500
Date: Wed, 7 Mar 2018 16:39:42 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH] KVM: VMX: expose the host's ARCH_CAPABILITIES MSR to
 userspace
Message-ID: <20180307153942.GC12290@flask>
References: <1519433546-33879-1-git-send-email-pbonzini@redhat.com>
 <20180226221300.GK22024@char.us.oracle.com>
 <20180301213205.GB29001@flask>
 <ccead1df-ba70-f365-c816-7892834a290c@redhat.com>
 <20180302214212.GB13606@flask>
 <9cad32c8-fdb6-95db-2cd3-a0e3297b1811@redhat.com>
 <20180307145628.GA12299@flask>
 <37a89c09-e933-9256-1b7a-3a9df846a672@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37a89c09-e933-9256-1b7a-3a9df846a672@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-07 16:10+0100, Paolo Bonzini:
> On 07/03/2018 15:56, Radim Krčmář wrote:
> > The MSR_F10H_DECFG default is questionable -- MSR_F10H_DECFG is an
> > architectural MSR, so we'd be changing the guest under the sight of
> > existing userspaces.
> > A potential security risk if they migrate the guest to a CPU that
> > doesn't serialize LFENCE.  ARCH_CAPABILITIES are at least hidden by a
> > new CPUID bit.
> 
> Good point.  Perhaps we should add a KVM-specific CPUID bit for
> serializing LFENCE.

I reckon it wouldn't help much in the wild: we'd need userspace changes
(at least for QEMU) and at that point, userspace can as well just
implement MSR_F10H_DECFG and use an unmodified guest.

We can't easily intercept LFENCE to emulate the feature either, so it
seems like a waste of effort to me.
