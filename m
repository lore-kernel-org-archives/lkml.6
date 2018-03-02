Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947557AbeCBSxT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:53:19 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:33793 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947528AbeCBSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:53:08 -0500
X-Google-Smtp-Source: AG47ELse83ziafawl6yNR1xU95vxjrOZZN+kusFDOsTA8w5zll1J6QnPlNqBjjV0REiq3+nZbRZ/5t4GMu3/lD3WIMY=
MIME-Version: 1.0
In-Reply-To: <20180301225934.GA34350@beast>
References: <20180301225934.GA34350@beast>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Mar 2018 10:53:07 -0800
X-Google-Sender-Auth: WhqYTwst5x5GCGiFPuvZkC7jj6Y
Message-ID: <CA+55aFzG6od5cy_mmepygSb_9m3Em336T00LoOK-MVkVPsJ-hg@mail.gmail.com>
Subject: Re: [RESEND][PATCH] bug: Exclude non-BUG/WARN exceptions from report_bug()
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 2:59 PM, Kees Cook <keescook@chromium.org> wrote:
>
> Resending through akpm since this technically isn't x86-specific.

Just a note on this part, because I think this is a general issue (and
has nothing to do with the particular patch itself).

Saying who you expect things to go through can definitely be a good
idea, because I generally ignore patches that get sent to me from
people I take pull requests from - I assume that I'm on the
participants list as a heads-up for for comments, rather than
applying. In fact, even if you don't send me pull requests, that's
generally what I assume, because the bulk of patches should be going
through some submaintainer that _does_ send me pull requests (or, like
Andrew, is known to send patches).

I'd expect that many other people face the same issue - particularly
when a patch doesn't have a very clear area, and there are multiple
people on the participants list, it's easy to assume that the intended
target is "somebody else". I do not, for example, tend to look at my
emails so closely that I care who is in the "To:" field, and who is in
the "Cc:" fields. I'd have to be very curious indeed to care that
deeply.

Which brings me to my point: maybe we should encourage people to make
this "for whom the patch tolls" information more obvious and more
explicit. It wasn't obvious in the first submission (yes, I saw the
patch then too), and even in this second one I actually initially
didn't notice this one line in between the commit message and the
actual patch. Maybe I get too much email, but I bet _that_ is very
true of others too.

The obvious place to encourage people to do it is in the [PATCH] part
in the subject, ie something like [PATCH/mm] or similar if you expect
it to go through Andrew's mm tree, or [PATCH/x86] it you expect the
x86 maintainers to pick it up. Or [PATCH/linus] if it's something that
you really expect to bypass all maintainers (why? I'd prefer for that
to then be explained).

But maybe other potential patch recipients would hate that kind of
extra mess in the subject line?

                   Linus
