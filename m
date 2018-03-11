Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeCKUQB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 16:16:01 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:50411 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbeCKUQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 16:16:00 -0400
X-Google-Smtp-Source: AG47ELuBh+WMr2sVjWVK6IwW0TW3mqSjEbbbobLaD9TjncDtMZd1TNFa/dVJrmK0pdt7Ns0DSAxWlYLPaXQmAnaI0bc=
MIME-Version: 1.0
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Mar 2018 13:15:59 -0700
X-Google-Sender-Auth: XT3RMxmEg_qvMM1UDaUHvzBk-3Y
Message-ID: <CA+55aFx9eSF2X7Cu84hPym+ca+uO4HStZ4r5XFmneH44ZJPoyw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] remove in-kernel syscall invocations
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 3:55 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Here is a first set of patches which reduce the number of syscall invocations
> from within the kernel.

This all looks ok to me. I think there may be some room for cleanup
and bikeshedding later (the "ksys_mmap_pgoff()" name made me go "that
sounds more like a real helper than a kernel syscall", for example),
but on the whole I think it's best to start with this kind of fairly
direct translation.

In fact, because it all looks *so* mechanical, I'd even be willing to
just pull this into 4.16, if that makes the real work that this
depends on easier?

Anyway, ack from me, qith the only question being how you want to
handle the patches. Direct pull request to me, go through the -mm
tree, or just keep them in your own git tree and then build upon it
and send it all later?

                       Linus
