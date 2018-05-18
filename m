Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeERTLQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:11:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40365 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbeERTLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:11:13 -0400
X-Google-Smtp-Source: AB8JxZqw0IM5Cdf0GhWDUSppoXRV/u/+dk2guyRWS2Q16Rl0VMkpxikbCwwaj/JAIgi+KTdsEIwCtFcuPUY9UVzKCdc=
MIME-Version: 1.0
References: <20180517161402.78089-1-namit@vmware.com> <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net> <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
 <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com> <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com>
 <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com> <CA+55aFzLhG1L0WXvJiUSWrAN5ghzn4XFAK64wgFoyVAHTHZH-A@mail.gmail.com>
 <2F760FAE-C19C-4BC3-A8CC-7D17CEF3B116@zytor.com> <6A3E90AA-7838-4C2A-B628-908F34902B75@vmware.com>
In-Reply-To: <6A3E90AA-7838-4C2A-B628-908F34902B75@vmware.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 May 2018 12:11:01 -0700
Message-ID: <CA+55aFysH5iiJWCVFu1J6GQfN2G1AbMcHyc4RhpnrnPjtM3L0Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
To: namit@vmware.com
Cc: Peter Anvin <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:02 PM Nadav Amit <namit@vmware.com> wrote:

> I can add a -Wa,[filename.s] switch. It works, but sort of undocumented.

Oh, if it assembles things together, then that sounds optimal.

And yes, like hpa says, we should make sure that behavior is acknowledged
by the GNU as people, so that they then don't come back and say "hey, now
we assemble things as separate units".

That said, the "separate units" model really doesn't make much sense now
that I think about it, because 'as' supports only one output file. So I
guess the as people wouldn't have any issues with just accepting the
"concatenate all input files" syntax.

              Linus
