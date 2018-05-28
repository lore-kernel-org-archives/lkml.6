Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165843AbeE1Ojx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:39:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44130 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161710AbeE1Ojr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:39:47 -0400
Subject: Re: [PATCH] powerpc/Makefile: fix build failure by disabling
 attribute-alias warning
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, segher@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
Message-ID: <e81f81b7-2bf5-7f9a-919f-87972bf1a9db@c-s.fr>
Date: Mon, 28 May 2018 14:39:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/28/2018 02:17 PM, Christophe Leroy wrote:
> Latest GCC version emit many warnings similar to the following one.

Oops, forgot to include the failure text:

In file included from arch/powerpc/kernel/syscalls.c:24:
./include/linux/syscalls.h:233:18: warning: 'sys_mmap2' alias between 
functions of incompatible types 'long int(long unsigned int,  size_t, 
long unsigned int,  long unsigned int,  long unsigned int,  long 
unsigned int)' {aka 'long int(long unsigned int,  unsigned int,  long 
unsigned int,  long unsigned int,  long unsigned int,  long unsigned 
int)'} and 'long int(long int,  long int,  long int,  long int,  long 
int,  long int)' [-Wattribute-alias]
   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                   ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:65:1: note: in expansion of macro 
'SYSCALL_DEFINE6'
  SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
  ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
   asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                   ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:65:1: note: in expansion of macro 
'SYSCALL_DEFINE6'
  SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
  ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:233:18: warning: 'sys_mmap' alias between 
functions of incompatible types 'long int(long unsigned int,  size_t, 
long unsigned int,  long unsigned int,  long unsigned int,  off_t)' {aka 
'long int(long unsigned int,  unsigned int,  long unsigned int,  long 
unsigned int,  long unsigned int,  long int)'} and 'long int(long int, 
long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias]
   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                   ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:72:1: note: in expansion of macro 
'SYSCALL_DEFINE6'
  SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
  ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
   asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                   ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:216:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/syscalls.c:72:1: note: in expansion of macro 
'SYSCALL_DEFINE6'
  SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
  ^~~~~~~~~~~~~~~
   CC      arch/powerpc/kernel/irq.o
   CC      arch/powerpc/kernel/align.o
   CC      arch/powerpc/kernel/signal_32.o
In file included from arch/powerpc/kernel/signal_32.c:29:
./include/linux/syscalls.h:233:18: warning: 'sys_swapcontext' alias 
between functions of incompatible types 'long int(struct ucontext *, 
struct ucontext *, long int)' and 'long int(long int,  long int,  long 
int)' [-Wattribute-alias]
   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                   ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:213:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:1044:1: note: in expansion of macro 
'SYSCALL_DEFINE3'
  SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
  ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
   asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                   ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:213:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:1044:1: note: in expansion of macro 
'SYSCALL_DEFINE3'
  SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
  ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:233:18: warning: 'sys_debug_setcontext' alias 
between functions of incompatible types 'long int(struct ucontext *, 
int,  struct sig_dbg_op *)' and 'long int(long int,  long int,  long 
int)' [-Wattribute-alias]
   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                   ^~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:213:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:1232:1: note: in expansion of macro 
'SYSCALL_DEFINE3'
  SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
  ^~~~~~~~~~~~~~~
./include/linux/syscalls.h:238:18: note: aliased declaration here
   asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                   ^~~~~~~~
./include/linux/syscalls.h:222:2: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
   ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:213:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
  #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, 
__VA_ARGS__)
                                     ^~~~~~~~~~~~~~~
arch/powerpc/kernel/signal_32.c:1232:1: note: in expansion of macro 
'SYSCALL_DEFINE3'
  SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
  ^~~~~~~~~~~~~~~


Christophe

> 
> As arch/powerpc code is built with -Werror, this breaks build with
> GCC 8.1
> 
> This patch inhibits that warning
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 26ccd0b91512..d6c557530ce8 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -145,6 +145,8 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
>   CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
>   CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
>   
> +CFLAGS-y += $(call cc-option,-Wno-attribute-alias)
> +
>   ifeq ($(CONFIG_PPC_BOOK3S_64),y)
>   ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
>   CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=power8
> 
