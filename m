Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeCLVmS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:42:18 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:52608 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeCLVmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:42:17 -0400
Date: Mon, 12 Mar 2018 22:39:54 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 00/35] remove in-kernel syscall invocations
Message-ID: <20180312213954.GA5969@light.dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <CA+55aFx9eSF2X7Cu84hPym+ca+uO4HStZ4r5XFmneH44ZJPoyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx9eSF2X7Cu84hPym+ca+uO4HStZ4r5XFmneH44ZJPoyw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 01:15:59PM -0700, Linus Torvalds wrote:
> On Sun, Mar 11, 2018 at 3:55 AM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > Here is a first set of patches which reduce the number of syscall invocations
> > from within the kernel.
> 
> This all looks ok to me. I think there may be some room for cleanup
> and bikeshedding later (the "ksys_mmap_pgoff()" name made me go "that
> sounds more like a real helper than a kernel syscall", for example),
> but on the whole I think it's best to start with this kind of fairly
> direct translation.
> 
> In fact, because it all looks *so* mechanical, I'd even be willing to
> just pull this into 4.16, if that makes the real work that this
> depends on easier?
> 
> Anyway, ack from me, qith the only question being how you want to
> handle the patches. Direct pull request to me, go through the -mm
> tree, or just keep them in your own git tree and then build upon it
> and send it all later?

Thanks for your feedback! As I think this deserves at least another round of
review and some testing by 0day, I've set up a git tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux syscalls-next

This will allow me to re-base and tweak the patches for a while, and add
some more similar patches on top. For example, besides the first set of
35+1 patches in the aforementioned branch "syscalls-next" there are a few
other patches -- including one you might find familiar -- in "syscalls-WIP"
which are not fully ready yet.

The patches in that repository also include the following changes since
yesterday's RFC:

- rebase to v4.15-rc5
	- sys_ioperm already got its SYSCALL_DEFINE3

- add ACK from Richard Weinberger

- modify CC -> Cc (suggested by Ingo Molnar)

- update comment in include/linux/syscalls.h (suggested by Ingo Molnar and
	Andy Lutomirski)

- separate declarations from definitions with newlines in
	include/linux/syscalls.h; add comment on ksys_close() (suggested by
	Ingo Molnar)

- expand commit messages (suggested by Christoph Hellwig)

- add patch 36: fs: add ksys_open() wrapper; remove in-kernel calls to
	sys_open()

Thanks,
	Dominik
