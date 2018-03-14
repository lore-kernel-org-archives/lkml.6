Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeCNJ2t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:49 -0400
Received: from ozlabs.org ([103.22.144.67]:47959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbeCNJ2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:46 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ef85dffd4251ff6c23056651f6f83bdce83cd1cf
In-Reply-To: <20180302195051.4472-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2, 06/21] powerpc: Avoid comparison of unsigned long >= 0 in __access_ok
Message-Id: <401RHG4l43z9sTl@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:27 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-02 at 19:50:51 UTC, Mathieu Malaterre wrote:
> Rewrite function-like macro into regular static inline function to avoid a
> warning during macro expansion.
> Fix warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/signal_32.o
> In file included from ./include/linux/uaccess.h:14:0,
>                  from ./include/asm-generic/termios-base.h:8,
>                  from ./arch/powerpc/include/asm/termios.h:20,
>                  from ./include/uapi/linux/termios.h:6,
>                  from ./include/linux/tty.h:7,
>                  from arch/powerpc/kernel/signal_32.c:36:
> ./include/asm-generic/termios-base.h: In function ‘user_termio_to_kernel_termios’:
> ./arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>    (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
>                                    ^
> ./arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro ‘__access_ok’
>    __access_ok((__force unsigned long)(addr), (size), get_fs()))
>    ^~~~~~~~~~~
> ./arch/powerpc/include/asm/uaccess.h:262:6: note: in expansion of macro ‘access_ok’
>   if (access_ok(VERIFY_READ, __gu_addr, (size)))   \
>       ^~~~~~~~~
> ./arch/powerpc/include/asm/uaccess.h:80:2: note: in expansion of macro ‘__get_user_check’
>   __get_user_check((x), (ptr), sizeof(*(ptr)))
>   ^~~~~~~~~~~~~~~~
> ./include/asm-generic/termios-base.h:36:6: note: in expansion of macro ‘get_user’
>   if (get_user(termios->c_line, &termio->c_line) < 0)
>       ^~~~~~~~
> [...]
> cc1: all warnings being treated as errors
> 
> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ef85dffd4251ff6c23056651f6f83b

cheers
