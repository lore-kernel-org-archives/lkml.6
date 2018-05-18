Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeERSxr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:53:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34203 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbeERSxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:53:45 -0400
Date: Fri, 18 May 2018 11:53:25 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+55aFzLhG1L0WXvJiUSWrAN5ghzn4XFAK64wgFoyVAHTHZH-A@mail.gmail.com>
References: <20180517161402.78089-1-namit@vmware.com> <20180517161402.78089-3-namit@vmware.com> <20180518075853.GD12217@hirez.programming.kicks-ass.net> <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com> <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com> <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com> <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com> <CA+55aFzLhG1L0WXvJiUSWrAN5ghzn4XFAK64wgFoyVAHTHZH-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: namit@vmware.com, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
From: hpa@zytor.com
Message-ID: <2F760FAE-C19C-4BC3-A8CC-7D17CEF3B116@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2018 11:50:12 AM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Fri, May 18, 2018 at 11:34 AM <hpa@zytor.com> wrote:
>
>> On May 18, 2018 11:25:32 AM PDT, Linus Torvalds <
>torvalds@linux-foundation.org> wrote:
>
>> Unfortunately gcc doesn't guarantee that global assembly inlines will
>appear at the top of the file.
>
>Yeah. It really would be better to do the "asm version of -inline".
>
>We already do something like that for real *.S files on some
>architectures
>(because their assembly really wants it, eg
>
>  arch/arm/Makefile:
>KBUILD_AFLAGS +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y)
>-include
>asm/unified.h -msoft-float
>
>but I do want to point out that KBUILD_AFLAGS is *not* used for
>compiler-generated assembly, only for actual *.S files.
>
>Sadly, I don't actually know any way to make gcc call the 'as' phase
>with
>particular options. We can use "-Wa,xyzzy" to pass in xyzzy to the
>assembler, but there is no "-include" option for GNU as afaik.
>
>Can you perhaps define a macro symbol for "--defsym"? Probably not.
>
>                       Linus

I looked at this thing a long time ago; it's not there, and the best would probably be to get global asm() working properly in gcc.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
