Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936080AbeCHSAN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:00:13 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:36296 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbeCHSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:00:11 -0500
X-Google-Smtp-Source: AG47ELvbHWc5MgBQ4qNEequ8d5ZherLGmOOnwCekK3GBaZSNlp/NoYMjigBcxk/M+y6a/nv+92cxQtTfmgDbdJG6PcI=
MIME-Version: 1.0
In-Reply-To: <20180308101628.GA21166@pd.tnic>
References: <20180306094920.16917-1-bp@alien8.de> <20180306094920.16917-6-bp@alien8.de>
 <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
 <20180307101314.GC23662@pd.tnic> <20180307132535.g7c2jro5n7okavbh@treble>
 <CA+55aFwxPBNk+kh+rmNzLViOqu-GFoJD-FsRe0oahDiwMXy-xw@mail.gmail.com> <20180308101628.GA21166@pd.tnic>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Mar 2018 10:00:09 -0800
X-Google-Sender-Auth: ROCbWNV2_8qk9RR_3jefsl6v7Qw
Message-ID: <CA+55aFxBivWhvrMzowmb60M=aek3xWkrpOu3Rj6CtDbA77crFw@mail.gmail.com>
Subject: Re: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code: section
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 2:16 AM, Borislav Petkov <bp@alien8.de> wrote:
> +#define OPCODE_BUFSIZE 64
> +       unsigned int code_prologue = OPCODE_BUFSIZE * 43 / OPCODE_BUFSIZE;

Heh.

That's a very odd way of writing "43".

Honestly, the "43" is just "two thirds" rounded to closest, and it's
not important anyway, so I think you should just write it as

        unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;

and never mind that it will now be 42.

42 is obviously the right answer anyway, which makes me think we got
it wrong earlier.

         Linus
