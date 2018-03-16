Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeCPML6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:11:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeCPML5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:11:57 -0400
Date: Fri, 16 Mar 2018 13:11:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive
 summary
Message-ID: <20180316121117.GE5852@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-9-bp@alien8.de>
 <20180315190132.2d653yu7ezf2zplh@treble>
 <20180316114849.GD5852@pd.tnic>
 <20180316120112.mqjvkdgl27scds6p@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316120112.mqjvkdgl27scds6p@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 07:01:12AM -0500, Josh Poimboeuf wrote:
> Hm, the "Code: Bad RIP value" will always be shown for syscall regs,
> which will probably cause some unnecessary confusion/worry.  Should we
> just skip printing it for the "regs->ip < PAGE_OFFSET" case?

How about we remove that check altogether?

I mean, __copy_from_user_inatomic() by way of probe_kernel_read() should
be able to handle every address.

And if it doesn't, it says so:

        if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
                pr_cont("Bad RIP value.\n");


And if we *can* print opcode bytes, why not do so? It is one more hint
when debugging, who knows, might prove useful...

Hmm?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
