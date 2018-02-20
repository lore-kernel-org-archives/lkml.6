Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeBTTOX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:14:23 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:38580 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBTTOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:14:21 -0500
X-Google-Smtp-Source: AG47ELvsrUBVy+tYpYqkEb6PFomZloy+USvWnz+ndu32P7mIY9/LB+1bymHeJKiyyQoN89u3tYJLDvz/NrRewhQIymk=
MIME-Version: 1.0
In-Reply-To: <20180219202826.19797-1-bp@alien8.de>
References: <20180219202826.19797-1-bp@alien8.de>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 20 Feb 2018 19:14:00 +0000
Message-ID: <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code: section
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 8:28 PM, Borislav Petkov <bp@alien8.de> wrote:
> From: Borislav Petkov <bp@suse.de>
>
> Hi,
>
> so I've been thinking about doing this for a while now: be able to dump
> the opcode bytes around the user rIP just like we do for kernel faults.
>
> Why?
>
> See patch 5's commit message. That's why I've marked it RFC.
>
> The rest is cleanups: we're copying the opcodes byte-by-byte and that's
> just wasteful.

Maybe this series already has this side-effect, but I'd really love to
see oopses show the code bytes for each kernel entry, not just the
innermode one.  We already dump full regs including RIP -- adding
Code: should be easy and would be very helpful.
