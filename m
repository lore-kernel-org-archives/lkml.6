Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932782AbeCBUWO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 15:22:14 -0500
Received: from mail-ua0-f176.google.com ([209.85.217.176]:37636 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932546AbeCBUWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 15:22:13 -0500
X-Google-Smtp-Source: AG47ELtSsjQxclBO8fnnFJxIDY8H+VVY7J4ttGtyBxhBkgv+Tlok9Ijak3JdzwfhA7QdnbJS3A+xy2/b4SaFriZ2dOA=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzG6od5cy_mmepygSb_9m3Em336T00LoOK-MVkVPsJ-hg@mail.gmail.com>
References: <20180301225934.GA34350@beast> <CA+55aFzG6od5cy_mmepygSb_9m3Em336T00LoOK-MVkVPsJ-hg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 2 Mar 2018 12:22:10 -0800
X-Google-Sender-Auth: _Xc6zS1GGGnqYs8EWWPbzXxoNSs
Message-ID: <CAGXu5jKCsWvRRZRhdcFdDTipjWZcL_UO6jekH2R-_C3f8Mi1-A@mail.gmail.com>
Subject: Re: [RESEND][PATCH] bug: Exclude non-BUG/WARN exceptions from report_bug()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:53 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Which brings me to my point: maybe we should encourage people to make
> this "for whom the patch tolls" information more obvious and more
> explicit. It wasn't obvious in the first submission (yes, I saw the
> patch then too), and even in this second one I actually initially
> didn't notice this one line in between the commit message and the
> actual patch. Maybe I get too much email, but I bet _that_ is very
> true of others too.

Yeah, a lot of people miss the "comment" line. I try to use it
sparingly, but really that only contributes to it not getting noticed.
;)

> The obvious place to encourage people to do it is in the [PATCH] part
> in the subject, ie something like [PATCH/mm] or similar if you expect
> it to go through Andrew's mm tree, or [PATCH/x86] it you expect the
> x86 maintainers to pick it up. Or [PATCH/linus] if it's something that
> you really expect to bypass all maintainers (why? I'd prefer for that
> to then be explained).

This may be redundant for some cases where the target is already in
the commit subject prefix: "x86/locking: Fixes foo", but I regularly
touch code without super-clear maintainership, or end up in places
where it spans multiple areas (e.g. this patch was a fix for an
x86-tree commit but the fix only touches the generic bug area, whee).

But for non-"obvious" cases, I like this idea; it could help me when
I'm sending to lots of different trees.

> But maybe other potential patch recipients would hate that kind of
> extra mess in the subject line?

My question would be, will the existing automated systems that parse
the "PATCH" subject deal with a non-whitespaced suffix like this?

-Kees

-- 
Kees Cook
Pixel Security
