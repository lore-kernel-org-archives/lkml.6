Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeBSJjd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:39:33 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50636 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeBSJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:39:31 -0500
X-Google-Smtp-Source: AH8x224oQuw1LPnZG35JIJRBx8CoQr7fPfb+3WfoVj7Iwis0bgHRhGDRAzFsWqZJPcfEbgy+XBXJ1A==
Date: Mon, 19 Feb 2018 10:39:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180219093927.644jb6h5peworj62@gmail.com>
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
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

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

Note that PeterZ's boot troubles only match the *symptoms* of the spurious 
failures reported by Tim Chen. Your commit wasn't bisected to.

I linked these two reports on the (remote) possibility that they might be related 
via some alignment dependent bug somewhere else in the x86 kernel - possibly 
completely unrelated to any IBRS/IBPB details.

Thanks,

	Ingo
