Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756130AbeEAPhT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:37:19 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:39235 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756032AbeEAPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:37:17 -0400
X-Google-Smtp-Source: AB8JxZqEvbkOEPCjM3xRtvZJ0swz1hanVcUZ0etQLjISJn5ddQ8PTYS96jeZSb/inFThp3iDO6HVdLESC7LVWXUHVqc=
MIME-Version: 1.0
References: <A74E4351-A9FA-434D-AD47-3A509F802FFB@vmware.com> <20180501134020.fonel3x6plea5xdt@treble>
In-Reply-To: <20180501134020.fonel3x6plea5xdt@treble>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 May 2018 15:37:06 +0000
Message-ID: <CA+55aFz-11bMkZHWdiiwys32H5jvB4gATvUHT0Vx6pJkFYLb4w@mail.gmail.com>
Subject: Re: Suboptimal inline heuristics due to non-code sections
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: namit@vmware.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 6:40 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> But if I remove the section completely by removing the
> pushsection/popsection, then copy_overflow() gets inlined.

> So GCC's inlining decisions are somehow influenced by the existence of
> some random empty section.  This definitely seems like a GCC bug to me.

I think gcc uses the size of the string to approximate the size of an
inline asm.

So I don't think it's the "empty section" that makes gcc do this, I think
it's literally "our inline asms _look_ big".

                Linus "does this section directive make me look fat?"
Torvalds
