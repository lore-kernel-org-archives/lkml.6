Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC0CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 06:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B040A20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 06:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B040A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeIHLUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 07:20:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHLUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 07:20:46 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyWqi-0003ja-F4; Sat, 08 Sep 2018 08:36:04 +0200
Date:   Sat, 8 Sep 2018 08:36:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 3/3] x86/pti/64: Remove the SYSCALL64 entry
 trampoline
In-Reply-To: <CALCETrXw9kjeGTrGBy=VMV_2pqAUC4bRZVMgvTrqkZ-EzO80_A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809080833580.1402@nanos.tec.linutronix.de>
References: <cover.1536015544.git.luto@kernel.org> <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org> <20180904070455.GX24124@hirez.programming.kicks-ass.net> <CALCETrUZm3KsonYVd5sn=LhoGZ2ciO7xT_Fz=jD_HZ04tB9o=Q@mail.gmail.com>
 <alpine.DEB.2.21.1809072145460.1402@nanos.tec.linutronix.de> <CA+55aFz9aZUo0psXDqiQ4aTZSiiU-mRr_PSWkm_vzAZzpdhMmg@mail.gmail.com> <CALCETrXw9kjeGTrGBy=VMV_2pqAUC4bRZVMgvTrqkZ-EzO80_A@mail.gmail.com>
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

On Fri, 7 Sep 2018, Andy Lutomirski wrote:
> On Fri, Sep 7, 2018 at 5:04 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Virtual mapping tricks may be cool, but in the end, not having to use
> > them is better still, I think.
> >
> 
> If (and this is a *big* if) all the percpu data is within 2GB of the
> entry text, then we could avoid this extra TLB reference by accessing
> it directly instead of using an alias.
> 
> I suppose the summary is that the retpoline-free trampoline variant is
> even more complicated than the code I'm removing in this series, and
> that it would be at best a teeny tiny win.  Once all the Spectre dust
> settles and we get fixed CPUs, we could consider re-optimizing this.

That's going to be after my retirement ...


