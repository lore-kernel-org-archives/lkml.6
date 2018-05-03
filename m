Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeECQFv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:05:51 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42125 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbeECQFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:05:48 -0400
X-Google-Smtp-Source: AB8JxZqrEBW3KXpUWcQFT8EQZhZYa3E1Qyd55vsasoA97DCT+T2A2T23pP8dLgOga9OFKYu/1z+cGA==
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH 2/2] arm64: Clear the stack
To: Laura Abbott <labbott@redhat.com>, Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180502203326.9491-1-labbott@redhat.com>
 <20180502203326.9491-3-labbott@redhat.com>
 <CAGXu5jK1_--omGSqz03sfB8twQVzy9ZQR9Xzi-uxseekp+r1jQ@mail.gmail.com>
 <4b7e94c1-79c9-0380-25c6-762762ed595f@redhat.com>
From: Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <fc4f2832-4e8f-3e70-6ab0-9f077790eca0@linux.com>
Date: Thu, 3 May 2018 19:05:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <4b7e94c1-79c9-0380-25c6-762762ed595f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laura and Kees,

On 03.05.2018 02:07, Laura Abbott wrote:
> On 05/02/2018 02:31 PM, Kees Cook wrote:
>> On Wed, May 2, 2018 at 1:33 PM, Laura Abbott <labbott@redhat.com> wrote:
>>>
>>> Implementation of stackleak based heavily on the x86 version
>>
>> Awesome! Notes below for both you and Alexander, since I think we can
>> create a common code base instead of having near-duplicates in the
>> arch/ trees...

Yes, sure.

I will extract the common part and send v12 for x86. Then Laura will be able to
add arm64 support in a separate patch series. Is it fine?

>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>> Now written in C instead of a bunch of assembly.
>>> ---
>>>   arch/arm64/Kconfig                    |  1 +
>>>   arch/arm64/include/asm/processor.h    |  6 ++++
>>>   arch/arm64/kernel/Makefile            |  3 ++
>>>   arch/arm64/kernel/entry.S             |  6 ++++
>>>   arch/arm64/kernel/erase.c             | 55 +++++++++++++++++++++++++++++++++++
>>>   arch/arm64/kernel/process.c           | 16 ++++++++++
>>>   drivers/firmware/efi/libstub/Makefile |  3 +-
>>>   scripts/Makefile.gcc-plugins          |  5 +++-
>>>   8 files changed, 93 insertions(+), 2 deletions(-)
>>>   create mode 100644 arch/arm64/kernel/erase.c
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index eb2cf4938f6d..b0221db95dc9 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -92,6 +92,7 @@ config ARM64
>>>          select HAVE_ARCH_MMAP_RND_BITS
>>>          select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>>>          select HAVE_ARCH_SECCOMP_FILTER
>>> +       select HAVE_ARCH_STACKLEAK
>>>          select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>>>          select HAVE_ARCH_TRACEHOOK
>>>          select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>>> index 767598932549..d31ab80ff647 100644
>>> --- a/arch/arm64/include/asm/processor.h
>>> +++ b/arch/arm64/include/asm/processor.h
>>> @@ -124,6 +124,12 @@ struct thread_struct {
>>>          unsigned long           fault_address;  /* fault info */
>>>          unsigned long           fault_code;     /* ESR_EL1 value */
>>>          struct debug_info       debug;          /* debugging */
>>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>> +       unsigned long           lowest_stack;
>>> +#ifdef CONFIG_STACKLEAK_METRICS
>>> +       unsigned long           prev_lowest_stack;
>>> +#endif
>>> +#endif
>>
>> I wonder if x86 and arm64 could include a common struct here that was
>> empty when the plugin is disabled... it would keep the ifdefs in one
>> place. Maybe include/linux/stackleak.h could be:
>>
>> ---start---
>> /* Poison value points to the unused hole in the virtual memory map */
>> #define STACKLEAK_POISON -0xBEEF
>> #define STACKLEAK_POISON_CHECK_DEPTH 128
>>
>> struct stackleak {
>> #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>         unsigned long           lowest;
>> #ifdef CONFIG_STACKLEAK_METRICS
>>         unsigned long           prev_lowest;
>> #endif
>> #endif
>> };
>>
> 
> Is this well defined across all compilers if the plugin is off?
> This seems to compile with gcc at least but 0 sized structs
> make me a little uneasy.

Empty struct is not defined by C standard but is permitted by gcc
https://gcc.gnu.org/onlinedocs/gcc/Empty-Structures.html#Empty-Structures

Fast example:

#include <stdio.h>

int main(void)
{
	struct a {};

	printf("size %zu\n", sizeof(struct a));

	return 0;
}

# gcc -pedantic t.c -o t
t.c: In function ‘main’:
t.c:5:9: warning: struct has no members [-Wpedantic]
  struct a {};
         ^

# clang -Weverything t.c -o tc
t.c:5:2: warning: empty struct has size 0 in C, size 1 in C++ [-Wc++-compat]
        struct a {};
        ^
t.c:5:2: warning: empty struct is a GNU extension [-Wgnu-empty-struct]
2 warnings generated.


But both programs print "size 0". There are a lot of empty structs around the
kernel, so I'll create another one.

>> asmlinkage void erase_kstack(void);
>> ---eof---
>>
>> and arch/*/include/asm/processor.h could do:
>>
>> @@ -124,6 +124,12 @@ struct thread_struct {
>>          unsigned long           fault_address;  /* fault info */
>>          unsigned long           fault_code;     /* ESR_EL1 value */
>>          struct debug_info       debug;          /* debugging */
>> +       struct stackleak         stackleak;
>>
>> and arch/x86/entry/erase.c could move to maybe kernel/stackleak.c?
>> (Oh, I notice this needs an SPDX line too.)

Thanks, I'll add it.

>>>   static inline void arch_thread_struct_whitelist(unsigned long *offset,
>>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>>> index bf825f38d206..0ceea613c65b 100644
>>> --- a/arch/arm64/kernel/Makefile
>>> +++ b/arch/arm64/kernel/Makefile
>>> @@ -55,6 +55,9 @@ arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
>>>   arm64-obj-$(CONFIG_CRASH_DUMP)         += crash_dump.o
>>>   arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)  += sdei.o
>>>
>>> +arm64-obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += erase.o
>>> +KASAN_SANITIZE_erase.o := n
>>> +
>>>   obj-y                                  += $(arm64-obj-y) vdso/ probes/
>>>   obj-m                                  += $(arm64-obj-m)
>>>   head-y                                 := head.o
>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>> index ec2ee720e33e..3144f1ebdc18 100644
>>> --- a/arch/arm64/kernel/entry.S
>>> +++ b/arch/arm64/kernel/entry.S
>>> @@ -401,6 +401,11 @@ tsk        .req    x28             // current thread_info
>>>
>>>          .text
>>>
>>> +       .macro  ERASE_KSTACK
>>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>> +       bl      erase_kstack
>>> +#endif
>>> +       .endm
>>>   /*
>>>    * Exception vectors.
>>>    */
>>> @@ -906,6 +911,7 @@ ret_to_user:
>>>          cbnz    x2, work_pending
>>>   finish_ret_to_user:
>>>          enable_step_tsk x1, x2
>>> +       ERASE_KSTACK
>>>          kernel_exit 0
>>>   ENDPROC(ret_to_user)
>>
>> Nice. All of the return paths end up here (I went looking for
>> ret_from_fork's path). :)
>>
>>>
>>> diff --git a/arch/arm64/kernel/erase.c b/arch/arm64/kernel/erase.c
>>> new file mode 100644
>>> index 000000000000..b8b5648d893b
>>> --- /dev/null
>>> +++ b/arch/arm64/kernel/erase.c
>>> @@ -0,0 +1,55 @@
>>> +#include <linux/bug.h>
>>> +#include <linux/sched.h>
>>> +#include <asm/current.h>
>>> +#include <asm/linkage.h>
>>> +#include <asm/processor.h>
>>> +
>>> +asmlinkage void erase_kstack(void)
>>> +{
>>> +       unsigned long p = current->thread.lowest_stack;
>>> +       unsigned long boundary = p & ~(THREAD_SIZE - 1);
>>> +       unsigned long poison = 0;
>>> +       const unsigned long check_depth = STACKLEAK_POISON_CHECK_DEPTH /
>>> +                                                       sizeof(unsigned long);
>>> +
>>> +       /*
>>> +        * Let's search for the poison value in the stack.
>>> +        * Start from the lowest_stack and go to the bottom.
>>> +        */
>>> +       while (p > boundary && poison <= check_depth) {
>>> +               if (*(unsigned long *)p == STACKLEAK_POISON)
>>> +                       poison++;
>>> +               else
>>> +                       poison = 0;
>>> +
>>> +               p -= sizeof(unsigned long);
>>> +       }
>>> +
>>> +       /*
>>> +        * One long int at the bottom of the thread stack is reserved and
>>> +        * should not be poisoned (see CONFIG_SCHED_STACK_END_CHECK).
>>> +        */
>>> +       if (p == boundary)
>>> +               p += sizeof(unsigned long);
>>> +
>>> +#ifdef CONFIG_STACKLEAK_METRICS
>>> +       current->thread.prev_lowest_stack = p;
>>> +#endif
>>> +
>>> +       /*
>>> +        * So let's write the poison value to the kernel stack.
>>> +        * Start from the address in p and move up till the new boundary.
>>> +        */
>>> +       boundary = current_stack_pointer;
>>
>> This is the only difference between x86 and arm64 in this code. What
>> do you think about implementing on_thread_stack() to match x86:
>>
>>          if (on_thread_stack())
>>                  boundary = current_stack_pointer;
>>          else
>>                  boundary = current_top_of_stack();
>>
>> then we could make this common code too instead of having two copies in arch/?
>>
> 
> The issue isn't on_thread_stack, it's current_top_of_stack which isn't
> defined on arm64. I agree it would be good if the code would be common
> but I'm not sure how much we want to start trying to force APIs.
> 
>>> +       BUG_ON(boundary - p >= THREAD_SIZE);
>>> +
>>> +       while (p < boundary) {
>>> +               *(unsigned long *)p = STACKLEAK_POISON;
>>> +               p += sizeof(unsigned long);
>>> +       }
>>> +
>>> +       /* Reset the lowest_stack value for the next syscall */
>>> +       current->thread.lowest_stack = current_stack_pointer;
>>> +}
>>> +
>>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>>> index f08a2ed9db0d..156fa0a0da19 100644
>>> --- a/arch/arm64/kernel/process.c
>>> +++ b/arch/arm64/kernel/process.c
>>> @@ -364,6 +364,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>>>          p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
>>>          p->thread.cpu_context.sp = (unsigned long)childregs;
>>>
>>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>> +       p->thread.lowest_stack = (unsigned long)task_stack_page(p);
>>> +#endif

I think it should be (unsigned long)task_stack_page(p) + sizeof(unsigned long).

>>>          ptrace_hw_copy_thread(p);
>>>
>>>          return 0;
>>> @@ -493,3 +496,16 @@ void arch_setup_new_exec(void)
>>>   {
>>>          current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
>>>   }
>>> +
>>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>> +void __used check_alloca(unsigned long size)
>>> +{
>>> +       unsigned long sp, stack_left;
>>> +
>>> +       sp = current_stack_pointer;
>>> +
>>> +       stack_left = sp & (THREAD_SIZE - 1);
>>> +       BUG_ON(stack_left < 256 || size >= stack_left - 256);
>>> +}
>>> +EXPORT_SYMBOL(check_alloca);
>>
>> This is pretty different from x86. Is this just an artifact of ORC, or
>> something else?
>>
> 
> This was based on the earlier version of x86. I'll confess to
> not seeing how the current x86 version ended up with get_stack_info
> but I suspect it's either related to ORC unwinding or it's best
> practice.

I've changed that in v4. Quote from the changelog:
  - Fixed the surplus and erroneous code for calculating stack_left in
     check_alloca() on x86_64. That code repeats the work which is already
     done in get_stack_info() and it misses the fact that different
     exception stacks on x86_64 have different size.

http://www.openwall.com/lists/kernel-hardening/2017/10/04/68

We can see that in arch/x86/kernel/dumpstack_64.c.

Is it fine if check_alloca() would be arch-specific?

>>> +#endif
>>> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>>> index a34e9290a699..25dd2a14560d 100644
>>> --- a/drivers/firmware/efi/libstub/Makefile
>>> +++ b/drivers/firmware/efi/libstub/Makefile
>>> @@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)  += -I$(srctree)/scripts/dtc/libfdt
>>>   KBUILD_CFLAGS                  := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>>>                                     -D__NO_FORTIFY \
>>>                                     $(call cc-option,-ffreestanding) \
>>> -                                  $(call cc-option,-fno-stack-protector)
>>> +                                  $(call cc-option,-fno-stack-protector) \
>>> +                                  $(DISABLE_STACKLEAK_PLUGIN)
>>>
>>>   GCOV_PROFILE                   := n
>>>   KASAN_SANITIZE                 := n
>>> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
>>> index 8d6070fc538f..6cc0e35d3324 100644
>>> --- a/scripts/Makefile.gcc-plugins
>>> +++ b/scripts/Makefile.gcc-plugins
>>> @@ -37,11 +37,14 @@ ifdef CONFIG_GCC_PLUGINS
>>>
>>>     gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)    += stackleak_plugin.so
>>>     gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)     += -DSTACKLEAK_PLUGIN -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
>>> +  ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>> +    DISABLE_STACKLEAK_PLUGIN           += -fplugin-arg-stackleak_plugin-disable
>>> +  endif
>>>
>>>     GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
>>>
>>>     export PLUGINCC GCC_PLUGINS_CFLAGS GCC_PLUGIN GCC_PLUGIN_SUBDIR
>>> -  export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN
>>> +  export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN DISABLE_STACKLEAK_PLUGIN
>>>
>>>     ifneq ($(PLUGINCC),)
>>>       # SANCOV_PLUGIN can be only in CFLAGS_KCOV because avoid duplication.
>>> --
>>> 2.14.3
>>>

Best regards,
Alexander
