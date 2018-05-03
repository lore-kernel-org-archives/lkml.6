Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeECRdp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:33:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45311 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeECRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:33:43 -0400
X-Google-Smtp-Source: AB8JxZoPcLXUSxDIRBQwsyw0ao6flne582Jo9hLig+5iu3ALTBolQP5+FpAOU8CzlED1efSf9EMLhQ==
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH 2/2] arm64: Clear the stack
To: Mark Rutland <mark.rutland@arm.com>, Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180502203326.9491-1-labbott@redhat.com>
 <20180502203326.9491-3-labbott@redhat.com>
 <20180503071917.xm2xvgagvzkworay@salmiak>
From: Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <dd6ad26c-1d2c-88f3-8f01-e68d2b31d6ea@linux.com>
Date: Thu, 3 May 2018 20:33:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503071917.xm2xvgagvzkworay@salmiak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark and Laura,

Let me join the discussion. Mark, thanks for your feedback!

On 03.05.2018 10:19, Mark Rutland wrote:
> Hi Laura,
> 
> On Wed, May 02, 2018 at 01:33:26PM -0700, Laura Abbott wrote:
>>
>> Implementation of stackleak based heavily on the x86 version
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> Now written in C instead of a bunch of assembly.
> 
> This looks neat!
> 
> I have a few minor comments below.
> 
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index bf825f38d206..0ceea613c65b 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -55,6 +55,9 @@ arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
>>  arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
>>  arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
>>  
>> +arm64-obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += erase.o
>> +KASAN_SANITIZE_erase.o	:= n
> 
> I suspect we want to avoid the full set of instrumentation suspects here, e.g.
> GKOV, KASAN, UBSAN, and KCOV.

I've disabled KASAN instrumentation for that file on x86 because erase_kstack()
intentionally writes to the stack and causes KASAN false positive reports.

But I didn't see any conflicts with other types of instrumentation that you
mentioned.

>> +
>>  obj-y					+= $(arm64-obj-y) vdso/ probes/
>>  obj-m					+= $(arm64-obj-m)
>>  head-y					:= head.o
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index ec2ee720e33e..3144f1ebdc18 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -401,6 +401,11 @@ tsk	.req	x28		// current thread_info
>>  
>>  	.text
>>  
>> +	.macro	ERASE_KSTACK
>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +	bl	erase_kstack
>> +#endif
>> +	.endm
> 
> Nit: The rest of our asm macros are lower-case -- can we stick to that here?
> 
>>  /*
>>   * Exception vectors.
>>   */
>> @@ -906,6 +911,7 @@ ret_to_user:
>>  	cbnz	x2, work_pending
>>  finish_ret_to_user:
>>  	enable_step_tsk x1, x2
>> +	ERASE_KSTACK
>>  	kernel_exit 0
>>  ENDPROC(ret_to_user)
> 
> I believe we also need this in ret_fast_syscall.
> 
> [...]
> 
>> +asmlinkage void erase_kstack(void)
>> +{
>> +	unsigned long p = current->thread.lowest_stack;
>> +	unsigned long boundary = p & ~(THREAD_SIZE - 1);
>> +	unsigned long poison = 0;
>> +	const unsigned long check_depth = STACKLEAK_POISON_CHECK_DEPTH /
>> +							sizeof(unsigned long);
>> +
>> +	/*
>> +	 * Let's search for the poison value in the stack.
>> +	 * Start from the lowest_stack and go to the bottom.
>> +	 */
>> +	while (p > boundary && poison <= check_depth) {
>> +		if (*(unsigned long *)p == STACKLEAK_POISON)
>> +			poison++;
>> +		else
>> +			poison = 0;
>> +
>> +		p -= sizeof(unsigned long);
>> +	}
>> +
>> +	/*
>> +	 * One long int at the bottom of the thread stack is reserved and
>> +	 * should not be poisoned (see CONFIG_SCHED_STACK_END_CHECK).
>> +	 */
>> +	if (p == boundary)
>> +		p += sizeof(unsigned long);
> 
> I wonder if end_of_stack() should be taught about CONFIG_SCHED_STACK_END_CHECK,
> given that's supposed to return the last *usable* long on the stack, and we
> don't account for this elsewhere.

I would be afraid to change the meaning of end_of_stack()... Currently it
considers that magic long as usable (include/linux/sched/task_stack.h):

#define task_stack_end_corrupted(task) \
		(*(end_of_stack(task)) != STACK_END_MAGIC)


> If we did, then IIUC we could do:
> 
> 	unsigned long boundary = (unsigned long)end_of_stack(current);
> 
> ... at the start of the function, and not have to worry about this explicitly.

I should mention that erase_kstack() can be called from x86 trampoline stack.
That's why the boundary is calculated from the lowest_stack.

>> +
>> +#ifdef CONFIG_STACKLEAK_METRICS
>> +	current->thread.prev_lowest_stack = p;
>> +#endif
>> +
>> +	/*
>> +	 * So let's write the poison value to the kernel stack.
>> +	 * Start from the address in p and move up till the new boundary.
>> +	 */
>> +	boundary = current_stack_pointer;
> 
> I worry a little that the compiler can move the SP during a function's
> lifetime, but maybe that's only the case when there are VLAs, or something like
> that?

Oh, I don't know.

However, erase_kstack() doesn't call anything except simple inline functions.
And as I see from its disasm on x86, the local variables reside in registers.

>> +
>> +	BUG_ON(boundary - p >= THREAD_SIZE);
>> +
>> +	while (p < boundary) {
>> +		*(unsigned long *)p = STACKLEAK_POISON;
>> +		p += sizeof(unsigned long);
>> +	}
>> +
>> +	/* Reset the lowest_stack value for the next syscall */
>> +	current->thread.lowest_stack = current_stack_pointer;

Laura, that might be wrong and introduce huge performance impact.

I think, lowest_stack should be reset similarly to the original version.

>> +}
> 
> Once this function returns, its data is left on the stack. Is that not a problem?
> 
> No strong feelings either way, but it might be worth mentioning in the commit
> message.

I managed to bypass that with "register" specifier. Although it doesn't give an
absolute guarantee.

>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index f08a2ed9db0d..156fa0a0da19 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -364,6 +364,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>>  	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
>>  	p->thread.cpu_context.sp = (unsigned long)childregs;
>>  
>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +	p->thread.lowest_stack = (unsigned long)task_stack_page(p);
> 
> Nit: end_of_stack(p) would be slightly better semantically, even though
> currently equivalent to task_stack_page(p).

Thanks, I agree, I'll fix it in v12.

> [...]
> 
>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +void __used check_alloca(unsigned long size)
>> +{
>> +	unsigned long sp, stack_left;
>> +
>> +	sp = current_stack_pointer;
>> +
>> +	stack_left = sp & (THREAD_SIZE - 1);
>> +	BUG_ON(stack_left < 256 || size >= stack_left - 256);
>> +}
> 
> Is this arbitrary, or is there something special about 256?
> 
> Even if this is arbitrary, can we give it some mnemonic?

It's just a reasonable number. We can introduce a macro for it.

>> +EXPORT_SYMBOL(check_alloca);
>> +#endif
>> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> index a34e9290a699..25dd2a14560d 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
>>  KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>>  				   -D__NO_FORTIFY \
>>  				   $(call cc-option,-ffreestanding) \
>> -				   $(call cc-option,-fno-stack-protector)
>> +				   $(call cc-option,-fno-stack-protector) \
>> +				   $(DISABLE_STACKLEAK_PLUGIN)
>>  
>>  GCOV_PROFILE			:= n
>>  KASAN_SANITIZE			:= n
> 
> I believe we'll also need to do this for the KVM hyp code in arch/arm64/kvm/hyp/.

Could you please give more details on that? Why STACKLEAK breaks it?

Thanks a lot!

Best regards,
Alexander
