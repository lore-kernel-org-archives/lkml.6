Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeCLH1z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:27:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36140 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbeCLH1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:27:53 -0400
X-Google-Smtp-Source: AG47ELuWb8TMq3qLgTg2YMSzOsUz6sdTtJBTSaYGA1ZpHKHj9N1YzRxmpIq8j2mqqVvpG91PIPW+tA==
Date: Mon, 12 Mar 2018 08:27:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 01/35] syscalls: define goal to not call sys_xyzzy()
 from within the kernel
Message-ID: <20180312072749.5kerpqmvmg4gjagh@gmail.com>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
 <20180311105557.20807-2-linux@dominikbrodowski.net>
 <CALCETrV3gUrL3fpr5EEjMyoWtj5t64hpYxjO+qJfUVTq7z1rNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV3gUrL3fpr5EEjMyoWtj5t64hpYxjO+qJfUVTq7z1rNQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> On Sun, Mar 11, 2018 at 10:55 AM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
> > and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
> > through kernel entry points, but not from the kernel itself. This
> > will allow cleanups and optimizations to the entry paths *and* to
> > the parts of the kernel code which currently need to pretend to be
> > userspace in order to make use of syscalls.
> >
> 
> > +
> > +/*
> > + * The kernel should not use call syscalls (i.e., sys_xyzyyz()) directly.
> > + * Instead, use one of the following functions which work equivalent to
> > + * the syscall they are named for.
> 
> "Instead, use one of the functions which work equivalently, e.g. do_xysyyz()"

The previous sentence has a typo as well, should be:

  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.

or so.

Thanks,

	Ingo
