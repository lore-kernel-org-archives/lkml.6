Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeCLHdB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:33:01 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:38039 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeCLHc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:32:59 -0400
X-Google-Smtp-Source: AG47ELvOU1vfvmB8Uqj6v9Y6HpgOcZreH6qMEddDR7k38c44FeQTvXWUcLRXj/pW33rRwdkYLqdsKw==
Date: Mon, 12 Mar 2018 08:32:56 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 00/35] remove in-kernel syscall invocations
Message-ID: <20180312073256.xo5vdh4ss7g32yma@gmail.com>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> I'm a bit more unsure about these remaining patches. They use inline stubs
> named ksys_xyzzy() which (mostly) call fs-internal functions. Another
> alternative would be to define these in fs/*, but then we'd get more and
> more indirections.
> 
> 	syscalls: do not call sys_unlink() within the kernel
> 	syscalls: do not call sys_rmdir() within the kernel
> 	syscalls: do not call sys_mkdir{,at}() within the kernel
> 	syscalls: do not call sys_symlink{,at}() within the kernel
> 	syscalls: do not call sys_mknod{,at}() within the kernel
> 	syscalls: do not call sys_link{,at}() within the kernel
> 	syscalls: do not call sys_{f,}chmod{at,}() within the kernel
> 	syscalls: do not call sys_{f,}access{,at}() within the kernel
> 	syscalls: do not call sys_ftruncate() within the kernel
> 	syscalls: do not call sys_{,l,f}chown() within the kernel
> 	syscalls: do not call sys_close() within the kernel

>  72 files changed, 572 insertions(+), 274 deletions(-)

Just curious, have you done a before/after vmlinux /usr/bin/size comparison?
How do these changes impact generated code?

My expectation would be for there to be a noticeable decrease in text size.

Thanks,

	Ingo
