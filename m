Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeCPOUw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:20:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44658 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeCPOUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:20:50 -0400
Date: Fri, 16 Mar 2018 14:20:43 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/36] remove in-kernel syscall invocations (part 1)
Message-ID: <20180316142043.GC30522@ZenIV.linux.org.uk>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <CAK8P3a2-XfeM5J0dq0kiOSiQC4T4p7cggNbuMDoCmnqjKC9tEQ@mail.gmail.com>
 <CALCETrX_1pxfB10k-uj7vSyXm7hH4MeJiEY=+A3FzViaozb+BA@mail.gmail.com>
 <CA+55aFyJBTaBuA1LjG5RjcD7ZCivYYQWqb3A+HbJZGUdZE9i6w@mail.gmail.com>
 <20180316085423.GH4151@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316085423.GH4151@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 01:54:23AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 15, 2018 at 05:54:27PM -0700, Linus Torvalds wrote:
> > Yes. And honestly, I'd rather have these kinds of "just change the
> > calling convention" almost automated patches separately - and then the
> > cleanups later.
> > 
> > Mixing the calling convention change and the cleanup together is just
> > confusing and potentially causes subtle issues.
> 
> A lot of the issues here is that the initramfs / do_mount code
> is written as if it was user space code, but in kernel space.  E.g.
> using file desriptors etc.

... and I still wonder if it would make more sense to kick that crap
out into userland.
