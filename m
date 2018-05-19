Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbeESEQ3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 00:16:29 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39326 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESEQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 00:16:28 -0400
X-Google-Smtp-Source: AB8JxZq9Xa5WybVmpxkW3w3O+TGubwq3twwnkohALjftHvThSPn1YrR6Yhhv5gZAwLFJVQa5ZQmQNNfqqWqqJMeYei4=
MIME-Version: 1.0
References: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
 <patch-1.thread-4f3684.git-4f3684ca2aad.your-ad-here.call-01526696764-ext-9375@work.hours>
 <CA+55aFxJb9P2TMCc2Pao-uXcVACK-CTBHmzObAQu=rvs87itvw@mail.gmail.com>
 <CA+55aFwxEiiAC+dMMVqQ4igqb7rmn23Bq=BM8fqU=MFRWF1JSw@mail.gmail.com>
 <20180519034338.GV30522@ZenIV.linux.org.uk> <CA+55aFyHLFnGv8yFJs7-vGVe6tDeDAbSJ6=09iTqsegRZN_nGw@mail.gmail.com>
In-Reply-To: <CA+55aFyHLFnGv8yFJs7-vGVe6tDeDAbSJ6=09iTqsegRZN_nGw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 May 2018 21:16:16 -0700
Message-ID: <CA+55aFzaPA04abVKKL8_CEpj960sE731-BttF5L733U1A-kd4Q@mail.gmail.com>
Subject: Re: [PATCH] procfs: fix mmap() for /proc/vmcore
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: gor@linux.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 9:12 PM Linus Torvalds <
torvalds@linux-foundation.org> wrote:

> (So we'd still have a "sb_maxbytes" that filesystems would fill in, but it
> would only be used as a "fill in inode value for regular files for this
> superblock").

Actually, maybe we could just make rw_verify_area() use the new
file_mmap_size_max() function.

We'd just remove the "mmap" part of the name, and have all IO (and all
mmap) use that limit.

That doesn't sound like a horrible idea to try for 4.18. Hmm?

               Linus
