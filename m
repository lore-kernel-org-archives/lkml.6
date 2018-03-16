Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeCPAyb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:54:31 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:41525 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbeCPAy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:54:29 -0400
X-Google-Smtp-Source: AG47ELs6RK+Z+JyL9MFPzSYD1K0PFhnHUzaD/NSJIT2gL/boA12Pciaqs2K4yZOR2yNBNJz5k5n1WOiA3mXyG8H41Pw=
MIME-Version: 1.0
In-Reply-To: <CALCETrX_1pxfB10k-uj7vSyXm7hH4MeJiEY=+A3FzViaozb+BA@mail.gmail.com>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <CAK8P3a2-XfeM5J0dq0kiOSiQC4T4p7cggNbuMDoCmnqjKC9tEQ@mail.gmail.com> <CALCETrX_1pxfB10k-uj7vSyXm7hH4MeJiEY=+A3FzViaozb+BA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 17:54:27 -0700
X-Google-Sender-Auth: GTpuzadTmD3Oms8Yyf30WwCnCxA
Message-ID: <CA+55aFyJBTaBuA1LjG5RjcD7ZCivYYQWqb3A+HbJZGUdZE9i6w@mail.gmail.com>
Subject: Re: [PATCH v2 00/36] remove in-kernel syscall invocations (part 1)
To: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 5:38 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> I don't think this patch series should wait for any of these cleanups,
> though.  We need these patches to change the x86_64 internal syscall
> function signature, which we've been wanting to do for a little while.

Yes. And honestly, I'd rather have these kinds of "just change the
calling convention" almost automated patches separately - and then the
cleanups later.

Mixing the calling convention change and the cleanup together is just
confusing and potentially causes subtle issues.

                         Linus
