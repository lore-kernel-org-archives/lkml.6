Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1002C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B514208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B514208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeK0Hx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:53:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeK0Hxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:53:55 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gRNxc-0000w7-9S; Mon, 26 Nov 2018 21:58:28 +0100
Date:   Mon, 26 Nov 2018 21:58:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
In-Reply-To: <20181126204842.GC16136@redhat.com>
Message-ID: <alpine.DEB.2.21.1811262156480.1682@nanos.tec.linutronix.de>
References: <20181125183328.318175777@linutronix.de> <20181125185006.051663132@linutronix.de> <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com> <alpine.DEB.2.21.1811252321300.1684@nanos.tec.linutronix.de>
 <20181126204842.GC16136@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018, Andrea Arcangeli wrote:

> Hello,
> 
> On Sun, Nov 25, 2018 at 11:28:59PM +0100, Thomas Gleixner wrote:
> > Indeed. Just checked the documentation again, it's also not clear whether
> > IBPB is required if STIPB is in use.
> 
> I tried to ask this question too earlier:
> 
> https://lkml.kernel.org/r/20181119234528.GJ29258@redhat.com
> 
> If the BTB mistraining in SECCOMP context with STIBP set in SPEC_CTRL,
> can still influence the hyperthreading sibling after STIBP is cleared,
> IBPB is needed before clearing STIBP. Otherwise it's not. Unless told
> otherwise, it'd be safe to assume IBPB is needed in such case.

IBPB is still issued. I won't change that before we have clarification.

But I doubt it's necessary. STIBP seems to be a rather big hammer.

Thanks,

	tglx
