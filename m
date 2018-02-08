Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeBHRje (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:39:34 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34728 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:39:33 -0500
X-Google-Smtp-Source: AH8x224jurcnBAy37e5AfNoVqyTq5dZChny1iIX4jDIyT2UhoZhjBVD0LwCm8SRSG5ohwKKR3OD/O6lYmAGkEXSInFA=
MIME-Version: 1.0
In-Reply-To: <20180208094710.qnjixhm6hybebdv7@gmail.com>
References: <20180207201517.6518-1-linux@dominikbrodowski.net>
 <20180207201517.6518-7-linux@dominikbrodowski.net> <CA+55aFxZ-pyx88rwykT0Dzh-_bwGQcmc00GhrMQ4OEwXqMO+pA@mail.gmail.com>
 <20180207212915.GA4633@isilmar-4.linta.de> <20180208094710.qnjixhm6hybebdv7@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 09:39:31 -0800
X-Google-Sender-Auth: Mi6_EJSEfmVOZ05DAlhmkRwY0uw
Message-ID: <CA+55aFwWDfzgfiJNQCZkrOd8uUXp13TupPhNYrKSeeXMY-dr2g@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 6/7] x86/entry: get rid of ALLOC_PT_GPREGS_ON_STACK
 and SAVE_AND_CLEAR_REGS
To: Ingo Molnar <mingo@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 1:47 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> So for those reasons I'm really tempted by the all around simplification offered
> by this series:
>
>    2 files changed, 62 insertions(+), 160 deletions(-)
>
> Basically in this specific case I'd like to turn the argument around,
> use this simpler design and put the burden of proof on the patches that
> want to _complicate it_ beyond this simple, straightforward model

You make a good argument.

If the only real downside is slightly bigger static footprint (but the
actual real dynamic I$ footprint is not really impacted), then let's
just go for the simpler code.

It really would be lovely if our entry asm was understandable to mere mortals.

               Linus
