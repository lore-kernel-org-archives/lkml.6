Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2A0C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE15024968
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE15024968
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbeGCOCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:02:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeGCOCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:02:20 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faLsn-0002GJ-MX; Tue, 03 Jul 2018 16:02:17 +0200
Date:   Tue, 3 Jul 2018 16:02:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Gabriel C <nix.or.die@gmail.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
In-Reply-To: <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
Message-ID: <alpine.DEB.2.21.1807031600550.1601@nanos.tec.linutronix.de>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com> <20180701213243.GA20180@trogon.sfo.coreos.systems> <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com> <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, Kirill A. Shutemov wrote:
> On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
> > 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> > > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
> > >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
> > >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
> > >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
> > >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
> > >> config for reference, and am happy to test patches, provide sample QCOW
> > >> images, etc.
> > >
> > 
> > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> > 
> > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> > too with the same symptoms
> 
> I tracked it down to -flto in LDFLAGS. I'll look more into this.

And what sets -flto in LDFLAGS? I can't find anything in the kernel
build/Makefiles.

Thanks,

	tglx
