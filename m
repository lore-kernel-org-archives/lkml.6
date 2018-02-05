Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeBES5f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:57:35 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34106 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbeBES5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:57:20 -0500
X-Google-Smtp-Source: AH8x226V3U7y9y1aJ7guQR2eGT/v6gCqE9hsfCmVCDlMVrnYdJWtdypBIRI2f6g5fHxJCusfPGnfvJhhBI9mNWYfD/E=
MIME-Version: 1.0
In-Reply-To: <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
References: <20180204174521.21383-1-kilobyte@angband.pl> <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 6 Feb 2018 05:57:17 +1100
X-Google-Sender-Auth: xzzltZ0RMfZIAwTtIFclBgxOQ9M
Message-ID: <CAGXu5j+rWhT7_DH5Z96_7naPou96-6736x4mjq0r_8EG4iiQ_g@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
To: Petr Mladek <pmladek@suse.com>
Cc: Adam Borowski <kilobyte@angband.pl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 8:44 PM, Petr Mladek <pmladek@suse.com> wrote:
> Hi,
>
> I add people who actively commented on adding %px modifier,
> see the thread starting at
> https://lkml.kernel.org/r/1511921105-3647-5-git-send-email-me@tobin.cc
>
> Just for reference. It seems to be related to the commit 9f36e2c448007b54
> ("printk: use %pK for /proc/kallsyms and /proc/modules").
>
>
> On Sun 2018-02-04 18:45:21, Adam Borowski wrote:
>> Like %pK already does, print "00000000" instead.
>>
>> This confused people -- the convention is that "(null)" means you tried to
>> dereference a null pointer as opposed to printing the address.
>
> By other words, this avoids regressions when people convert
> %x to %px. Do I get it right, please?

Nothing should be converting from %x to %px, it's %p to %px. %p print
"(null)" for 0x0, so it would be surprising for a conversion from %p
to %px to change that. (Though generally speaking "(null)" is never
useful...)

-Kees

-- 
Kees Cook
Pixel Security
