Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C2AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA7E24B1C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA7E24B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lindev.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932664AbeGCOND convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:13:03 -0400
Received: from mail.lindev.ch ([5.39.83.55]:42054 "EHLO mail.lindev.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932409AbeGCONB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:13:01 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2018 10:13:00 EDT
Received: from localhost (localhost [127.0.0.1])
        (Authenticated sender: bero@lindev.ch)
        by mail.lindev.ch (Postfix) with ESMTPA id 20167409FF;
        Tue,  3 Jul 2018 16:07:44 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <alpine.DEB.2.21.1807031600550.1601@nanos.tec.linutronix.de>
From:   "Bernhard Rosenkraenzer" <bero@lindev.ch>
X-Forward: 85.2.153.167
Date:   Tue, 03 Jul 2018 16:07:43 +0200
Cc:     =?utf-8?q?Kirill_A=2E_Shutemov?= <kirill@shutemov.name>,
        "Gabriel C" <nix.or.die@gmail.com>,
        "Benjamin Gilbert" <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        =?utf-8?q?Kirill_A=2E_Shutemov?= <kirill.shutemov@linux.intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        =?utf-8?q?H=2E_Peter_Anvin?= <hpa@zytor.com>,
        "X86 ML" <x86@kernel.org>
To:     "Thomas Gleixner" <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <54cf-5b3b8300-1-6d99ad80@111178718>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_4=2E17=2Ex?= won't boot due to 
 =?utf-8?q?=22x86=2Fboot=2Fcompressed=2F64=3A?= Handle 5-level paging boot 
 if kernel is above =?utf-8?q?4G=22?=
User-Agent: SOGoMail 4.0.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 03, 2018 16:02 CEST, Thomas Gleixner <tglx@linutronix.de> wrote: 
> On Tue, 3 Jul 2018, Kirill A. Shutemov wrote:
> > On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
> > > 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> > > > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > > >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
> > > >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
> > > >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
> > > >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
> > > >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
> > > >> config for reference, and am happy to test patches, provide sample QCOW
> > > >> images, etc.
> > > >
> > > 
> > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> > > 
> > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> > > too with the same symptoms
> > 
> > I tracked it down to -flto in LDFLAGS. I'll look more into this.
> 
> And what sets -flto in LDFLAGS? I can't find anything in the kernel
> build/Makefiles.

The kernel doesn't use -flto by default. Some people (and distros) set -flto in CFLAGS and LDFLAGS manually hoping to get a few extra optimizations.
This never caused any problems before 0a1756bd - would be nice to keep it working.

ttyl
bero

