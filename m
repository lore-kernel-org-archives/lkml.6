Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbeDRN0f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:26:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753566AbeDRN0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:26:34 -0400
Date: Wed, 18 Apr 2018 08:26:33 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] x86/dumpstack: Cleanups and user opcode bytes Code:
 section, v2
Message-ID: <20180418132633.y66zoykoahaoylyq@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <CA+55aFyvwdG49eCgX9Bs9UGEo4VWgS7dY6ZuEkBuugxTR58GnA@mail.gmail.com>
 <20180417144042.GB20840@pd.tnic>
 <20180417201655.szlq2oxur4mg24uh@treble>
 <20180417210650.GD3633@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180417210650.GD3633@pd.tnic>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 11:06:50PM +0200, Borislav Petkov wrote:
> On Tue, Apr 17, 2018 at 03:16:55PM -0500, Josh Poimboeuf wrote:
> > I don't think the stack tracing code could do anything better here.  #3
> > and #4 seem like an issue with the scheduler, it doesn't realize the
> > rest of the CPUs have all been taken offline due to the panic().
> 
> So maybe teach the WARN code to check whether a panic() has happened?

I get the feeling that disabling warnings could be papering over a real
bug, but maybe we don't care about bugs in the post-panic state?

Ideally we could just leave interrupts disabled, but I don't know if
that's generally feasible since it looks like sparc is waiting for
keyboard interrupts to allow breaking out to the boot prom.

-- 
Josh
