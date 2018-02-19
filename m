Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeBSKIc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:08:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43452 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeBSKIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:08:31 -0500
Date: Mon, 19 Feb 2018 11:08:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180219100817.GO25201@hirez.programming.kicks-ass.net>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <c77b3da9-136d-9988-119f-e94c86fd34a3@linux.intel.com>
 <1518808600.7876.49.camel@infradead.org>
 <66f94cb1-8160-56e0-680c-2e847ae05893@linux.intel.com>
 <20180217102616.vcwatxsgj2vunlew@gmail.com>
 <20180219092017.GN25201@hirez.programming.kicks-ass.net>
 <1519032552.7876.55.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519032552.7876.55.camel@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 09:29:12AM +0000, David Woodhouse wrote:
> On Mon, 2018-02-19 at 10:20 +0100, Peter Zijlstra wrote:
> > 
> > I did not update or otherwise change packages while I was bisecting; the
> > machine is:
> > 
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 62
> > model name      : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz
> > stepping        : 4
> > microcode       : 0x428
> 
> That's IVX with a microcode that doesn't *have* IBRS/IBPB. I don't
> think there's a publicly available microcode that does; I assume you
> didn't have one and build it into your kernel for early loading, and
> thus you really weren't even using IBRS here? The code never even gets
> patched in?

I wasn't using IRBS afaik. I was bisceting tip/master before the
IBRS/firmware patches (not sure they're in now or not).

No fancy ucode setup, I think I have ucode image in the initrd, but that
would be same for all kernels.
