Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbeCGORB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:17:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34124 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbeCGORA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:17:00 -0500
Date: Wed, 7 Mar 2018 15:16:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Ebbert <cebbert.lkml@gmail.com>
Subject: Re: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180307141647.GI23662@pd.tnic>
References: <20180306094920.16917-1-bp@alien8.de>
 <20180306094920.16917-6-bp@alien8.de>
 <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
 <20180307101314.GC23662@pd.tnic>
 <20180307132535.g7c2jro5n7okavbh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307132535.g7c2jro5n7okavbh@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 07:25:35AM -0600, Josh Poimboeuf wrote:
> How about we just remove the 'code_bytes=' option?

Haha, removing stuff is my usual solution :-)

I'd love to.

> (Or at the very
> least, reduce its possible range to a reasonable max?)
> 
> I doubt anybody actually uses it.  I'd never heard of it before, nor
> have I ever seen an oops with a long code dump.  I can't fathom why
> somebody would even need it.  64 bytes is plenty, and an 8k code dump
> just sounds insane.

Yeah, I see a Chuck Ebbert in git log output with a gmail account, maybe
that's the same person. (I've assumed he's not at RH anymore, otherwise
you would've CCed him :-)).

Let's ask him. CCed.

> It comes from the following commit:
> 
> commit 86c418374223be3f328b5522545196db02c8ceda
> Author: Chuck Ebbert <cebbert@redhat.com>
> Date:   Tue Feb 13 13:26:25 2007 +0100
> 
>     [PATCH] i386: add option to show more code in oops reports
> 
>     Sometimes developers need to see more object code in an oops report,
>     e.g. when kernel may be corrupted at runtime.
> 
>     Add the "code_bytes" option for this.
> 
>     Signed-off-by: Chuck Ebbert <cebbert@redhat.com>
>     Signed-off-by: Andi Kleen <ak@suse.de>
>     Cc: Andi Kleen <ak@suse.de>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> But I've never seen a case where somebody needed to use it.
> 
> -- 
> Josh

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
