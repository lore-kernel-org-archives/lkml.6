Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9F3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424F2208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424F2208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHTTl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:41:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55956 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHTTl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:41:26 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1frmz5-0000xI-5u; Mon, 20 Aug 2018 18:24:51 +0200
Date:   Mon, 20 Aug 2018 18:24:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jim Mattson <jmattson@google.com>
cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Fred Jacobs <fjacobs@vmware.com>,
        Peter Shier <pshier@google.com>
Subject: Re: [PATCH] x86/spectre: Expand test for vulnerability to empty RSB
 exploits
In-Reply-To: <CALMp9eTSNA_52tdgqeqMpBYMkPTvhGtwwWyGMwQKH3cyiS0agA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808201823560.1551@nanos.tec.linutronix.de>
References: <20180807222535.143193-1-jmattson@google.com> <alpine.DEB.2.21.1808201758250.1551@nanos.tec.linutronix.de> <CALMp9eTSNA_52tdgqeqMpBYMkPTvhGtwwWyGMwQKH3cyiS0agA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018, Jim Mattson wrote:
> On Mon, Aug 20, 2018 at 9:00 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Tue, 7 Aug 2018, Jim Mattson wrote:
> >
> > > Skylake-era Intel CPUs are vulnerable to exploits of empty RSB
> > > conditions. On hardware, platform vulnerability can be determined
> > > simply by checking the processor's DisplayModel/DisplayFamily
> > > signature.  However, when running in a VM, the operating system should
> > > also query IA32_ARCH_CAPABILITIES.RSBA[bit 2], a synthetic bit that
> > > can be set by a hypervisor to indicate that the VM might run on a
> > > vulnerable physical processor, regardless of the
> > > DisplayModel/DisplayFamily reported by CPUID.
> > >
> > > Note that IA32_ARCH_CAPABILITIES.RSBA[bit 2] is always clear on
> > > hardware, so the DisplayModel/DisplayFamily check is still required.
> > >
> > > For all of the details, see the Intel white paper, "Retpoline: A
> > > Branch Target Injection Mitigation" (document number 337131-001),
> > > section 5.3: Virtual Machine CPU Identification.
> > >
> > > Signed-off-by: Jim Mattson <jmattson@google.com>
> > > Reviewed-by: Peter Shier <pshier@google.com>
> >
> > That has been superseeded by:
> >
> >   fdf82a7856b3 ("x86/speculation: Protect against userspace-userspace spectreRSB")
> >
> > right? At least it does not apply anymore...
> 
> Right. It doesn't appear that Skylake CPUs get any special treatment any more.

Yeah, it's universally f*cked up by now.

Thanks,

	tglx

