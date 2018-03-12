Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeCLQmd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:42:33 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44063 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeCLQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:42:29 -0400
X-Google-Smtp-Source: AG47ELt+bM6oEAXfq4DIZ9mcL3ZeiqZ9L31aaFMd78eEcgxjTApYFC1ker3PDuAqD/0ScRtneHUuLFj/hWUm+fbhodA=
MIME-Version: 1.0
In-Reply-To: <20180312145049.boh3wmaotim6sfh2@black.fi.intel.com>
References: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
 <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
 <20180312124027.GG4064@hirez.programming.kicks-ass.net> <20180312124337.vw7bchm6brfzghfa@node.shutemov.name>
 <20180312131055.GH4064@hirez.programming.kicks-ass.net> <20180312140449.oyngtgqppnjuh3lf@node.shutemov.name>
 <20180312143212.77z2ptyqbsbqdll3@gmail.com> <20180312145049.boh3wmaotim6sfh2@black.fi.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 09:42:27 -0700
X-Google-Sender-Auth: R2ojDWlOusnRtbu0sfCl7qCIoZ8
Message-ID: <CA+55aFyKOkO1BBYX+-SZyON2FA_FSc9YqVDLU9-pRj1=jh9sUw@mail.gmail.com>
Subject: Re: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind
 the LA57 check
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        linux-tip-commits@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 7:50 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> I disagree that we should decide usefulness of the 5-level paging based on
> size of physical memory on the machine.
>
> Consider use case when you have 100TiB database file. It's pretty
> reasonable to mmap() such file at once even if you don't have 100TiB of
> physical memory to back it up. 1/100 of the file size may still work
> fairly well.
>
> Virtual address space is useful on its own and we shouldn't take the
> value from the user just because he doesn't have tens of terabytes of
> memory.

Absolutely.

Also, I'd suggest enabling 5-level paging as aggressively as possible
by default (ie whenever the hardware supports it), just for test
coverage.

Maybe in a year or two, when we actually have a fair amount of
coverage, we'll then say "ok, this just hurts normal workstations that
have the capability but only have ridiculously small fraction of
memory", and at that point say that unless you have a ton of RAM we'll
default to 4-level.

               Linus
