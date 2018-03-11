Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeCKUU1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 16:20:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35950 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbeCKUUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 16:20:25 -0400
X-Google-Smtp-Source: AG47ELugTXBvTwNe40J8Ct/HWlhf25IBr669Lp3rjkpY46TX0D6APvHesqAecm/lr/Xan0Y6KAIUVnLS951VOAR1Z/8=
MIME-Version: 1.0
In-Reply-To: <20180311123815.17916-2-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org> <20180311123815.17916-2-ard.biesheuvel@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Mar 2018 13:20:24 -0700
X-Google-Sender-Auth: 5LDp3sdd57w2Kx3-CLsW0J0YvmM
Message-ID: <CA+55aFxcB+5oB_hL83EASOJQrVRCrzT9iS+2+XtEUToG6VHiqA@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] arch: enable relative relocations for arm64, power
 and x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 5:38 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Before updating certain subsystems to use place relative 32-bit
> relocations in special sections, to save space and reduce the
> number of absolute relocations that need to be processed at runtime
> by relocatable kernels, introduce the Kconfig symbol and define it
> for some architectures that should be able to support and benefit
> from it.

Are there actually architectures hat _don't_ support those relative
32-bit relocations? That really feels pretty fundamental.

I would have expected all of them to do it - is your selection of
arm64/powerpc/x86 perhaps more about "I have tested these" than about
anything else?

Because I'd almost prefer to just do the switch-over unconditionally
if that is at all possible?

             Linus
