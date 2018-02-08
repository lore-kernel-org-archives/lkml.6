Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeBHSEL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:04:11 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:35175 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeBHSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:04:10 -0500
Date: Thu, 8 Feb 2018 19:03:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180208180357.GC25181@hirez.programming.kicks-ass.net>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic>
 <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
 <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
 <20180208091302.GD25201@hirez.programming.kicks-ass.net>
 <CA+55aFySLxYkUQyNf5YcEvitjm2O1whEp4-iKNASPaOpxG1j9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFySLxYkUQyNf5YcEvitjm2O1whEp4-iKNASPaOpxG1j9w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 09:27:56AM -0800, Linus Torvalds wrote:
> On Thu, Feb 8, 2018 at 1:13 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > _The_ problem is that new binutils cannot sanely decode any function
> > that has a WARN in (this very much includes perf annotate):
> 
> Ugh.
> 
> Is there any reason why we don't just use UD2 and avoid this whole issue?

That's what I initially had, but then Arjan told me that a number of
emulators fatally terminate on UD2 since they assume it to be BUG. Which
is when we all went looking at UD1/UD0.

But yes, for our purposes UD2 is perfectly fine too, it will just mess
up the people doing bringup and the like.
