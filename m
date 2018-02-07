Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754466AbeBGTPA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:15:00 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:35057 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754141AbeBGTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:14:59 -0500
Date: Wed, 7 Feb 2018 20:14:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180207191451.GC25201@hirez.programming.kicks-ass.net>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic>
 <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 11:03:42AM -0800, Linus Torvalds wrote:
> On Wed, Feb 7, 2018 at 10:49 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Right, we picked UD0 because we _thought_ everybody agreed it being 2
> > bytes, just like UD2. This is now not true anymore?
> 
> Both UD0 and UD1 are documented to have modrm in the latest Intel SDM
> I can find (Order number 325462-065US, December 2017):

Thanks, and yes :/ They changed it in October17 (which I actually had a copy
of so I'm not sure why I was looking at March17).

Back when we did that patch the SDM didn't have that extra ModR/M on,
and binutils disassembled it as the 2 byte (bad) thing, which was all
good.

Then someone went and wrecked it.
