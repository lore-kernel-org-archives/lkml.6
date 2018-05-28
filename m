Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939992AbeE1QSg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:18:36 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39636 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936740AbeE1QSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:18:30 -0400
X-Google-Smtp-Source: AB8JxZpY+vkW0w8iycjSn2xtMMqy3KJjDEmO8xCr1WQfWUUbW+ps+HY1HOcDxG6xDXXCUG5Yc49JY43WiCZRlfKX8Mc=
MIME-Version: 1.0
In-Reply-To: <20180528150726.GC17342@gate.crashing.org>
References: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
 <e81f81b7-2bf5-7f9a-919f-87972bf1a9db@c-s.fr> <20180528150726.GC17342@gate.crashing.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 28 May 2018 18:18:09 +0200
X-Google-Sender-Auth: MGXyDGWil2aVP3i0gpWZFyfOrgY
Message-ID: <CA+7wUszZ8Dq8S9ou7tTCF84MYh7De-K02GREVf+8cgqyn0wsSQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/Makefile: fix build failure by disabling
 attribute-alias warning
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 5:07 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Mon, May 28, 2018 at 02:39:37PM +0000, Christophe Leroy wrote:
>> In file included from arch/powerpc/kernel/syscalls.c:24:
>> ./include/linux/syscalls.h:233:18: warning: 'sys_mmap2' alias between
>> functions of incompatible types 'long int(long unsigned int,  size_t,
>> long unsigned int,  long unsigned int,  long unsigned int,  long
>> unsigned int)' {aka 'long int(long unsigned int,  unsigned int,  long
>> unsigned int,  long unsigned int,  long unsigned int,  long unsigned
>> int)'} and 'long int(long int,  long int,  long int,  long int,  long
>> int,  long int)' [-Wattribute-alias]
>
> So yes, these are actually different (int vs. long).
>
>> In file included from arch/powerpc/kernel/signal_32.c:29:
>> ./include/linux/syscalls.h:233:18: warning: 'sys_swapcontext' alias
>> between functions of incompatible types 'long int(struct ucontext *,
>> struct ucontext *, long int)' and 'long int(long int,  long int,  long
>> int)' [-Wattribute-alias]
>
> And this one is quite spectacularly different.

https://patchwork.kernel.org/patch/10375607/

>
> Try putting this before the wacko aliases:
>
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wattribute-alias"
>
> and this after:
>
> #pragma GCC diagnostic pop
>
> so that you will get this quite useful warning for all other code.
>
>
> Segher
