Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933398AbeEWPZT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:25:19 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38211 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932534AbeEWPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:25:18 -0400
X-Google-Smtp-Source: AB8JxZqniNqOgLYTh41zezBPJS5ro+hVoXY6nmYjfEaL6Z8B/VY1XR2AgU/kpWqzYnp/kW8/OqENJDkBML9ECWwhlDI=
MIME-Version: 1.0
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org> <20180523130547.GF26965@arm.com>
In-Reply-To: <20180523130547.GF26965@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 May 2018 08:25:06 -0700
Message-ID: <CA+55aFwKLBKdf3gdWkJSdewQYYXYYfN29SPT+etPqpopxA0CMQ@mail.gmail.com>
Subject: Re: write_lock_irq(&tasklist_lock)
To: Will Deacon <will.deacon@arm.com>
Cc: psodagud@codeaurora.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, sherryy@android.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 6:05 AM Will Deacon <will.deacon@arm.com> wrote:

> Please use a newer kernel. We've addressed this in mainline by moving
> arm64 over to the qrwlock implementation which (after some other changes)
> guarantees forward progress for well-behaved readers and writers.

Oh, I didn't even realize that this wasn't x86, and that there was still
the very unfair rwlock issue on 4.14 on arm.

Yeah, the queuing rwlocks shouldn't show the really pathological problems
we used to have long ago.

               Linus
