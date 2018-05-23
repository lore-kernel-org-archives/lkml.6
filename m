Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754768AbeEWQ0w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:26:52 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34836 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754438AbeEWQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:26:47 -0400
X-Google-Smtp-Source: AB8JxZrq2V0pH7s7FOUi7iBY0SP122A2GESXz6LdyIu3Bm8Ee9WhZ5BsXEwsAnuGXGdFpkmT+SCKdPzH2OpcT9l5BFk=
MIME-Version: 1.0
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
 <20180523130547.GF26965@arm.com> <CA+55aFwKLBKdf3gdWkJSdewQYYXYYfN29SPT+etPqpopxA0CMQ@mail.gmail.com>
 <20180523153607.GD2983@arm.com>
In-Reply-To: <20180523153607.GD2983@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 May 2018 09:26:35 -0700
Message-ID: <CA+55aFy9mVCJUniAMVvJjqaa=ke2mx6HfkPhCGP54ncdh70peQ@mail.gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 8:35 AM Will Deacon <will.deacon@arm.com> wrote:

> In other words, qrwlock requires consistent locking order wrt spinlocks.

I *thought* lockdep already tracked and detected this. Or is that only with
with the sleeping versions?

But yes, that's equivalent to the irq-unfairness thing we have a special
case for.

              Linus
