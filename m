Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeBTT36 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:29:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751994AbeBTT35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:29:57 -0500
Date: Tue, 20 Feb 2018 13:29:56 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code:
 section
Message-ID: <20180220192956.si2a6m3ckskexvte@treble>
References: <20180219202826.19797-1-bp@alien8.de>
 <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 07:14:00PM +0000, Andy Lutomirski wrote:
> On Mon, Feb 19, 2018 at 8:28 PM, Borislav Petkov <bp@alien8.de> wrote:
> > From: Borislav Petkov <bp@suse.de>
> >
> > Hi,
> >
> > so I've been thinking about doing this for a while now: be able to dump
> > the opcode bytes around the user rIP just like we do for kernel faults.
> >
> > Why?
> >
> > See patch 5's commit message. That's why I've marked it RFC.
> >
> > The rest is cleanups: we're copying the opcodes byte-by-byte and that's
> > just wasteful.
> 
> Maybe this series already has this side-effect, but I'd really love to
> see oopses show the code bytes for each kernel entry, not just the
> innermode one.  We already dump full regs including RIP -- adding
> Code: should be easy and would be very helpful.

Just to clarify, I think you want to show the Code: around regs->ip
every time we show the registers?

-- 
Josh
