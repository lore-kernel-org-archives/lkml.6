Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F296CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB54F24457
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB54F24457
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeGBSsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:48:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34160 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbeGBSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:48:09 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so5879384ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2v1n7h8dw4jOBjHaBMLqjjLuYbYcV/xFB4s2s3bt5HA=;
        b=Os1mi4zCFtddp/saUvg3t+eqEbE00YaoUEpO6FyL5atXj+6M2n2/0+xVzhYyC47VU0
         DpamNMGnX8/3wQFTftcILwnQnRxHBZEIyCD1faiHN7GwRV5McsclqHaTQIEWhjhPtvzL
         2GUSzZaj/aWJsQ5F2n9+icKQg4wasLcHo1+PcmCRW2BrRiMsiNMKSziwMAOm5ce5yI0g
         4H8VsBYbpWIWqLdoZkTLSCXWDaywjATcST1j81PBhl95b6jId332lQYOvlftDdR5VGnY
         5Lza0cyqAFNORiYHGt1HvlbWWfVREtgFYuzTvDhv778rJR5xFg2Zq6rkIVtTPRhUyH7J
         6Wlg==
X-Gm-Message-State: APt69E1BOecEWp9hgiQjNQBqVdKckCtnjX2Igo3LX49Tkf3pJCdudC8S
        2CVtMXDbq4/48/Q7I9mSPAKvxcjKwoc=
X-Google-Smtp-Source: AAOMgpdYva3BoW5H9XYhLNNlq6NLloSY9eR0KtBBrYFe6SKj/kp+D1FIjOFhjRJdfgOlvpRPD3EO4g==
X-Received: by 2002:aca:cf43:: with SMTP id f64-v6mr15385221oig.113.1530557288135;
        Mon, 02 Jul 2018 11:48:08 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::f0c1? ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id c2-v6sm8515039oia.53.2018.07.02.11.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:48:06 -0700 (PDT)
Subject: Re: [PATCH] arm64: Clear the stack
To:     alex.popov@linux.com, Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180629190553.7282-1-labbott@redhat.com>
 <9733d929-3c6a-40e1-6110-8f79975323d3@linux.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <1b97aa7d-2b6c-a5df-0caa-1cd16e18a816@redhat.com>
Date:   Mon, 2 Jul 2018 11:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9733d929-3c6a-40e1-6110-8f79975323d3@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 06:02 AM, Alexander Popov wrote:
> Hello Laura,
> 
> Thanks for your work!
> Please see my comments below.
> 
> On 29.06.2018 22:05, Laura Abbott wrote:
>> Implementation of stackleak based heavily on the x86 version
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> Changes since last time:
>> - Minor name change in entry.S
>> - Converted to use the generic interfaces so there's minimal additions.
>> - Added the fast syscall path.
>> - Addition of on_thread_stack and current_top_of_stack
>> - Disable stackleak on hyp per suggestion
>> - Added a define for check_alloca. I'm still not sure about keeping it
>>    since the x86 version got reworked?
>>
>> I've mostly kept this as one patch with a minimal commit text. I can
>> split it up and elaborate more before final merging.
>> ---
>>   arch/arm64/Kconfig                    |  1 +
>>   arch/arm64/include/asm/processor.h    |  9 +++++++++
>>   arch/arm64/kernel/entry.S             |  7 +++++++
>>   arch/arm64/kernel/process.c           | 16 ++++++++++++++++
>>   arch/arm64/kvm/hyp/Makefile           |  3 ++-
>>   drivers/firmware/efi/libstub/Makefile |  3 ++-
>>   include/linux/stackleak.h             |  1 +
>>   scripts/Makefile.gcc-plugins          |  5 ++++-
>>   8 files changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index eb2cf4938f6d..b0221db95dc9 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -92,6 +92,7 @@ config ARM64
>>   	select HAVE_ARCH_MMAP_RND_BITS
>>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>>   	select HAVE_ARCH_SECCOMP_FILTER
>> +	select HAVE_ARCH_STACKLEAK
>>   	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>>   	select HAVE_ARCH_TRACEHOOK
>>   	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>> index 767598932549..73914fd7e142 100644
>> --- a/arch/arm64/include/asm/processor.h
>> +++ b/arch/arm64/include/asm/processor.h
>> @@ -248,5 +248,14 @@ void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused);
>>   #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
>>   #define SVE_GET_VL()	sve_get_current_vl()
>>   
>> +/*
>> + * For stackleak
> 
> May I ask you to call it STACKLEAK here and in other places for easier grep?
> 

Sure

>> + *
>> + * These need to be macros because otherwise we get stuck in a nightmare
>> + * of header definitions for the use of task_stack_page.
>> + */
>> +#define current_top_of_stack()	(task_stack_page(current) + THREAD_SIZE)
>> +#define on_thread_stack()	(on_task_stack(current, current_stack_pointer))
>> +
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* __ASM_PROCESSOR_H */
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index ec2ee720e33e..31c9da7d401e 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -401,6 +401,11 @@ tsk	.req	x28		// current thread_info
>>   
>>   	.text
>>   
>> +	.macro	stackleak_erase
> 
> Could you rename the macro to STACKLEAK_ERASE for similarity with x86?
> 

Mark Rutland had previously asked for this to be lowercase.
I really don't care one way or the other so I'll defer to
someone else to have the final word.

>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +	bl	stackleak_erase_kstack
>> +#endif
>> +	.endm
>>   /*
>>    * Exception vectors.
>>    */
>> @@ -880,6 +885,7 @@ ret_fast_syscall:
>>   	and	x2, x1, #_TIF_WORK_MASK
>>   	cbnz	x2, work_pending
>>   	enable_step_tsk x1, x2
>> +	stackleak_erase
>>   	kernel_exit 0
>>   ret_fast_syscall_trace:
>>   	enable_daif
>> @@ -906,6 +912,7 @@ ret_to_user:
>>   	cbnz	x2, work_pending
>>   finish_ret_to_user:
>>   	enable_step_tsk x1, x2
>> +	stackleak_erase
>>   	kernel_exit 0
>>   ENDPROC(ret_to_user)
>>   
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index f08a2ed9db0d..9f0f135f8b66 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -493,3 +493,19 @@ void arch_setup_new_exec(void)
>>   {
>>   	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
>>   }
>> +
>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +#define MIN_STACK_LEFT	256
>> +
>> +void __used stackleak_check_alloca(unsigned long size)
>> +{
>> +	unsigned long sp, stack_left;
>> +
>> +	sp = current_stack_pointer;
>> +
>> +	stack_left = sp & (THREAD_SIZE - 1);
>> +	BUG_ON(stack_left < MIN_STACK_LEFT ||
>> +		size >= stack_left - MIN_STACK_LEFT);
>> +}
>> +EXPORT_SYMBOL(stackleak_check_alloca);
>> +#endif
> 
> This code should be updated.
> You may remember the troubles I had with MIN_STACK_LEFT:
> http://openwall.com/lists/kernel-hardening/2018/05/11/12
> Please see that thread where Mark Rutland and I worked out the solution.
> 

Ah yeah, I missed the details in that thread. Thanks for
that pointer.

> By the way, different stacks on x86_64 have different sizes. Is it false for arm64?
> 

Currently everything except the overflow stack looks to be
the same size but there's also another stack I missed. It might
be cleaner just to use on_accessible_stack and then another
function to get the top of stack. This also might just be
reimplementing what x86 already has? (Mark, Ard?)

Thanks,
Laura


>> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
>> index 4313f7475333..2fabc2dc1966 100644
>> --- a/arch/arm64/kvm/hyp/Makefile
>> +++ b/arch/arm64/kvm/hyp/Makefile
>> @@ -3,7 +3,8 @@
>>   # Makefile for Kernel-based Virtual Machine module, HYP part
>>   #
>>   
>> -ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
>> +ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
>> +		$(DISABLE_STACKLEAK_PLUGIN)
>>   
>>   KVM=../../../../virt/kvm
>>   
>> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> index a34e9290a699..25dd2a14560d 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
>>   KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>>   				   -D__NO_FORTIFY \
>>   				   $(call cc-option,-ffreestanding) \
>> -				   $(call cc-option,-fno-stack-protector)
>> +				   $(call cc-option,-fno-stack-protector) \
>> +				   $(DISABLE_STACKLEAK_PLUGIN)
>>   
>>   GCOV_PROFILE			:= n
>>   KASAN_SANITIZE			:= n
>> diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
>> index e2da99b3a191..00d62b302efb 100644
>> --- a/include/linux/stackleak.h
>> +++ b/include/linux/stackleak.h
>> @@ -5,6 +5,7 @@
>>   #include <linux/sched.h>
>>   #include <linux/sched/task_stack.h>
>>   
>> +#include <asm/stacktrace.h>
>>   /*
>>    * Check that the poison value points to the unused hole in the
>>    * virtual memory map for your platform.
>> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
>> index a535742a1c06..972ce4ca7f6a 100644
>> --- a/scripts/Makefile.gcc-plugins
>> +++ b/scripts/Makefile.gcc-plugins
>> @@ -37,11 +37,14 @@ ifdef CONFIG_GCC_PLUGINS
>>   
>>     gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)	+= stackleak_plugin.so
>>     gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)	+= -DSTACKLEAK_PLUGIN -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
>> +  ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +    DISABLE_STACKLEAK_PLUGIN		+= -fplugin-arg-stackleak_plugin-disable
>> +  endif
>>   
>>     GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
>>   
>>     export PLUGINCC GCC_PLUGINS_CFLAGS GCC_PLUGIN GCC_PLUGIN_SUBDIR
>> -  export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN
>> +  export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN DISABLE_STACKLEAK_PLUGIN
>>   
>>     ifneq ($(PLUGINCC),)
>>       # SANCOV_PLUGIN can be only in CFLAGS_KCOV because avoid duplication.
>>
> 

