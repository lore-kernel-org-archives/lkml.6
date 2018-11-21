Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49125C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0957120831
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0957120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390271AbeKVJZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:25:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45866 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbeKVJZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:25:11 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPbIX-00025E-QI; Wed, 21 Nov 2018 23:48:41 +0100
Date:   Wed, 21 Nov 2018 23:48:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [patch 01/24] x86/speculation: Update the TIF_SSBD comment
In-Reply-To: <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811212345180.1665@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201722.337599561@linutronix.de> <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com> <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
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

On Wed, 21 Nov 2018, Linus Torvalds wrote:

> On Wed, Nov 21, 2018 at 12:28 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ugh. Now you're using the broken quilt thing that makes a mush of emails for me.
> 
> Reading the series in alpine makes it look fine. No testing, but each
> patch seems sensible.
> 
> And yes, triggering on seccomp makes more sense than dumpable to me.

That's what we ended up with SSBD as well. We had the same discussion before.

Btw, I really do not like the app2app wording. I'd rather go for usr2usr,
but that's kinda horrible as well. But then, all of this is horrible.

Any better ideas?

Thanks,

	tglx
