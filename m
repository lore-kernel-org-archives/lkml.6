Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964807AbeCGUh3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:37:29 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34979 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934760AbeCGUh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:37:26 -0500
X-Google-Smtp-Source: AG47ELveVc3FQadqpYeyu0y1zSRCdK9v8zV1V1sOyVq4y03OWsgz9SeC61lshqZOX5ARpf4kEVveWlW+J3UknG4zMYs=
MIME-Version: 1.0
In-Reply-To: <87muzoglga.fsf@concordia.ellerman.id.au>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-18-malat@debian.org>
 <87muzoglga.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 7 Mar 2018 21:37:05 +0100
X-Google-Sender-Auth: ytFHvUhn5-6SiqxfF2KOnz6mddE
Message-ID: <CA+7wUsyMQcvEOOAuthFg4Sc783x4KBqtjkgB81KzJqPxQnwdYA@mail.gmail.com>
Subject: Re: [PATCH 17/21] powerpc: Add missing prototype for sys_debug_setcontext
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w27Kba9G018965

On Sun, Mar 4, 2018 at 11:54 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Mathieu Malaterre <malat@debian.org> writes:
>
>> In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32.c")
>> the function sys_debug_setcontext was added without a prototype.
>>
>> Fix compilation warning (treated as error in W=1):
>>
>>   CC      arch/powerpc/kernel/signal_32.o
>> arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype for ‘sys_debug_setcontext’ [-Werror=missing-prototypes]
>>  int sys_debug_setcontext(struct ucontext __user *ctx,
>>      ^~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>
> This one should actually be using the SYSCALL_DEFINE syntax, so that it
> can be used with CONFIG_FTRACE_SYSCALLS.
>
> See eg. our mmap:
>
>   SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>                 unsigned long, prot, unsigned long, flags,
>                 unsigned long, fd, off_t, offset)
>   {
>         return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
>   }
>
>
> We probably still need this patch, but I'm not entirely sure because the
> SYSCALL_DEFINE macro does all sorts of shenanigans.

I see. Could you please drop this patch then. The patch does not look
that trivial anymore. I'll need to dig a bit more on how to do the
syscall stuff with a 7 params function.

Thanks
