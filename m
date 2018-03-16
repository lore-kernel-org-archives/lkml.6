Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeCPNQJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:16:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750748AbeCPNQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:16:08 -0400
Date: Fri, 16 Mar 2018 08:16:06 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive
 summary
Message-ID: <20180316131606.l7tcqleeipx7vz6e@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-9-bp@alien8.de>
 <20180315190132.2d653yu7ezf2zplh@treble>
 <20180316114849.GD5852@pd.tnic>
 <20180316120112.mqjvkdgl27scds6p@treble>
 <20180316121117.GE5852@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316121117.GE5852@pd.tnic>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 01:11:17PM +0100, Borislav Petkov wrote:
> On Fri, Mar 16, 2018 at 07:01:12AM -0500, Josh Poimboeuf wrote:
> > Hm, the "Code: Bad RIP value" will always be shown for syscall regs,
> > which will probably cause some unnecessary confusion/worry.  Should we
> > just skip printing it for the "regs->ip < PAGE_OFFSET" case?
> 
> How about we remove that check altogether?
> 
> I mean, __copy_from_user_inatomic() by way of probe_kernel_read() should
> be able to handle every address.
> 
> And if it doesn't, it says so:
> 
>         if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
>                 pr_cont("Bad RIP value.\n");
> 
> 
> And if we *can* print opcode bytes, why not do so? It is one more hint
> when debugging, who knows, might prove useful...
> 
> Hmm?

Yeah, sounds good to me.  I think an earlier version of your patches
already printed the user space opcodes anyway.

-- 
Josh
