Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeCPIy1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:54:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbeCPIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:54:26 -0400
Date: Fri, 16 Mar 2018 01:54:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/36] remove in-kernel syscall invocations (part 1)
Message-ID: <20180316085423.GH4151@infradead.org>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <CAK8P3a2-XfeM5J0dq0kiOSiQC4T4p7cggNbuMDoCmnqjKC9tEQ@mail.gmail.com>
 <CALCETrX_1pxfB10k-uj7vSyXm7hH4MeJiEY=+A3FzViaozb+BA@mail.gmail.com>
 <CA+55aFyJBTaBuA1LjG5RjcD7ZCivYYQWqb3A+HbJZGUdZE9i6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyJBTaBuA1LjG5RjcD7ZCivYYQWqb3A+HbJZGUdZE9i6w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 05:54:27PM -0700, Linus Torvalds wrote:
> Yes. And honestly, I'd rather have these kinds of "just change the
> calling convention" almost automated patches separately - and then the
> cleanups later.
> 
> Mixing the calling convention change and the cleanup together is just
> confusing and potentially causes subtle issues.

A lot of the issues here is that the initramfs / do_mount code
is written as if it was user space code, but in kernel space.  E.g.
using file desriptors etc.  I think doing one or a few patches
before this series to sort this out would really reduce the scope
of work and be the right thing.  For any additional minor cleanups
I agree that it might make sense to postpone them.
