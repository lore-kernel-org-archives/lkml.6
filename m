Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCKPYY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeCKPYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:24:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B7C21778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELuXhwW0VoxaCeZi7VSSQY5wXvTLGpGnBSkY6jeJXArVKE+ViFsrmLaWxdgU/x0ICJGj/HytJluCJ9/ac+N+iIA=
MIME-Version: 1.0
In-Reply-To: <20180311105557.20807-2-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net> <20180311105557.20807-2-linux@dominikbrodowski.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 11 Mar 2018 15:24:01 +0000
X-Gmail-Original-Message-ID: <CALCETrV3gUrL3fpr5EEjMyoWtj5t64hpYxjO+qJfUVTq7z1rNQ@mail.gmail.com>
Message-ID: <CALCETrV3gUrL3fpr5EEjMyoWtj5t64hpYxjO+qJfUVTq7z1rNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/35] syscalls: define goal to not call sys_xyzzy()
 from within the kernel
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 10:55 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
> and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
> through kernel entry points, but not from the kernel itself. This
> will allow cleanups and optimizations to the entry paths *and* to
> the parts of the kernel code which currently need to pretend to be
> userspace in order to make use of syscalls.
>

> +
> +/*
> + * The kernel should not use call syscalls (i.e., sys_xyzyyz()) directly.
> + * Instead, use one of the following functions which work equivalent to
> + * the syscall they are named for.

"Instead, use one of the functions which work equivalently, e.g. do_xysyyz()"
