Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E23520851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E23520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeKSXNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:13:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeKSXNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:13:32 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOizq-0006kW-BL; Mon, 19 Nov 2018 13:49:46 +0100
Date:   Mon, 19 Nov 2018 13:49:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable@vger.kernel.org
Subject: Re: STIBP by default.. Revert?
In-Reply-To: <32d00fb2-7187-ed6f-ab1e-287151e82b3a@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811191349010.1537@nanos.tec.linutronix.de>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com> <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm> <CAHk-=whH2daKsZTqVPb-G9mJ1g15XMse7j-9YqN+yBYk7M9=Dw@mail.gmail.com> <nycvar.YFH.7.76.1811182309540.21108@cbobk.fhfr.pm>
 <32d00fb2-7187-ed6f-ab1e-287151e82b3a@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018, Tim Chen wrote:
> On 11/18/2018 02:17 PM, Jiri Kosina wrote:
> > On Sun, 18 Nov 2018, Linus Torvalds wrote:
> > 
> >>> So, I think it's as theoretical as any other spectrev2 (only with the
> >>> extra "HT" condition added on top).
> >>
> >> What? No.
> >>
> >> It's *way* more theoretical than something like meltdown, which could
> >> be trivially used to get data from another protection domain.
> > 
> > Oh yeah, I absolutely agree that spectrev2 and Meltdown and completely 
> > different beasts.
> > 
> >> Have you seen any actual realistic attacks for normal human users?
> >> Things where the *kernel* should actually care?
> >>
> >> The javascript thing is for the browser to fix up, 
> > 
> > It's probably not just browsers, but anything running JITed sandboxed 
> > code. So the most straightforward way might be the prctl() aproach, where 
> > userspace would claim "I do care about this, please fix it up for me". So 
> > prctl() + perhaps SECCOMP.
> > 
> > Which gets us back to Tim's fixup patch. Do you still prefer the revert, 
> > given the existence of that? I think that if Tim's fixup makes it through 
> > (it's currently missing SECCOMP handling, but that is trivial to add on 
> > top), it might be the best compromise. We'd also have have to make IBPB 
> > obey it to be consistent (and get even a few more % of performance back), 
> > but that's easy as well.
> > 
> I think if Thomas can merge my patchset along with Jiri's, the default
> option will become opt in for tasks that want the extra security and we
> won't lose performance.

If it would be in mergeable state ....

Thanks,

	tglx
