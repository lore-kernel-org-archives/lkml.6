Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeERSeR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:34:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34727 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeERSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:34:14 -0400
Date: Fri, 18 May 2018 11:33:51 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com>
References: <20180517161402.78089-1-namit@vmware.com> <20180517161402.78089-3-namit@vmware.com> <20180518075853.GD12217@hirez.programming.kicks-ass.net> <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com> <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com> <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
To: Linus Torvalds <torvalds@linux-foundation.org>, namit@vmware.com
CC: Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
From: hpa@zytor.com
Message-ID: <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2018 11:25:32 AM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Fri, May 18, 2018 at 10:24 AM Nadav Amit <namit@vmware.com> wrote:
>
>> Will it be ok just to use a global inline asm to set an “.include”
>directive
>> that gas would later process? (I can probably wrap it in a C macro so
>it
>> won’t be too disgusting)
>
>Maybe. I'd almost prefer it to be the automatic kind of thing that we
>already do for C files using "-include".
>
>                  Linus

Unfortunately gcc doesn't guarantee that global assembly inlines will appear at the top of the file.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
