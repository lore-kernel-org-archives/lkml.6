Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeCLW0s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:26:48 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:44519 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:26:46 -0400
X-Google-Smtp-Source: AG47ELtgZEAUbQ0Z1ggB8j+KZ2vLSm2jbxVTEhSxreCROgvtEqliar/L1EA0NXAFV/VzMKwyA2wYKidDvz4fVSUmILw=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLFDFF6ggSLRbvgfQ7cqTGNqGf4i-FeCSn0SftOcVg3TQ@mail.gmail.com>
References: <CAGXu5jLFDFF6ggSLRbvgfQ7cqTGNqGf4i-FeCSn0SftOcVg3TQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 15:26:45 -0700
X-Google-Sender-Auth: C0O9RezIfeT_Z4nHyl0h1-Gw5OA
Message-ID: <CA+55aFzEQOvOipyDn7LYyD=_r+qhevD3+GCrTjj0OzjVF94giw@mail.gmail.com>
Subject: Re: Future of STACKLEAK plugin?
To: Kees Cook <keescook@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:06 AM, Kees Cook <keescook@google.com> wrote:
>
> I was curious, after the last week of discussion, what you thought of
> the future of Alexander's port of the STACKLEAK plugin[0]. Given that
> there is progress being made (by at least 8 people at last count) to
> actually remove VLAs (and bogus warnings)[1], and that there appears
> to be consensus[2] on the approach for how to deal with uninitialized
> stack variables, this still leaves an aspect of STACKLEAK unaddressed,
> which is reducing the lifetime of stack content validity.

Honestly, I consider that to be one of those crazy patches that people
can apply if they want to, but that there is no point in having
upstream.

Hundreds of extra lines of assembly for something that isn't even a
leak or a theoretical fix, when there is a better model for just
improving the compiler? Yeah, no.

The fact is, people can do their own thing. But for it to make sense
_mainline_, it has to improve kernel development, and I don't see it
doing that.

I just haven't seen an argument for why it makes sense to do the
belt-and-suspenders-and-glue-your-pants-on approach.

                  Linus
