Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A200C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FCB205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I4nqVpcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfAVS6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:58:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38667 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfAVS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:58:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so12208515pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tBqlp10k4es8Fb0UZkrFAqNQyoizapiAG5ZARQOAZm8=;
        b=I4nqVpcqKpHwkjR7JfZnx6HxdJM0yqbLUXlR+F+/5wrZzng6pjHw9ibguUdpMNK+t1
         YC4rX/jcnydlpbGittwhDYy/+HkFBL4VRqLL7C06FYGBmPRDFNYAtc2KUNisqeT9T/ai
         9vIzJEq6mVWCurujXok3TSETcLPs9tzdqkSMZaC3D35UDK48tofbQPpj0gyUNU6oPA34
         lnU0GDb1SYwqt1ID1tCjHkyrnhjluiw2wUGBemSrHfF/FF6lS30BIWdE0eu8pV+R63FX
         PJc3kfC9roo30ZjQ4Lp/I5InCASXAUwiEjKfTAaXW+msdrvfUCNJNwn7K+UxbxobrPTz
         15eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tBqlp10k4es8Fb0UZkrFAqNQyoizapiAG5ZARQOAZm8=;
        b=GaPqN9OAcNX0C12AlFQgsSACRvTuUn7XJulE+6yfwSQnKu5h0P5LhifL3OMmu8PFpN
         iVNsZ1vH6K+n6mP2SXVG+Bk+H/pXH1kXMuetnomwuZ751BG6ecJ++ZLQ1SNMpkXZ4d31
         Uelv74sGG2Jy4V4Zg7WgjufPJGYcYLH3ElVtxyiH9DVpnYMIAl4c7Vaoix1tuwwZAFeJ
         qjOqvx5MP5Us7AR61Tlr6qvNx4dnkAjRPebMTwafrGeLxN8sCEerM/abk8rfipbmK5Jf
         vanFF2Tqe44T5HTEhwSLL3GsnE4njw2QVjPQb33kNqye1GN5dpzspA9zpVZA1lEBXtgK
         oIAg==
X-Gm-Message-State: AJcUukdOGIY1ERP5sDC7sW8ZnaPiNwG1XgkoMEKNmhqFRNsha7xU9r0P
        CA3nXdG7KSpsHy5DOa/6pvXaDXnHZTc=
X-Google-Smtp-Source: ALg8bN4GzYF0lR0u2zs/IIY/Z4fgzNmeu+63hMTEJxdA9BBdNYFI8ENW8oiIh1cBhA13U0TllyauBw==
X-Received: by 2002:a63:451a:: with SMTP id s26mr20467919pga.150.1548183532468;
        Tue, 22 Jan 2019 10:58:52 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n68sm25949284pfb.62.2019.01.22.10.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:58:51 -0800 (PST)
Date:   Tue, 22 Jan 2019 10:58:51 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 10:58:30 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Add _TIF_NEED_RESCHED check for kernel thread when CONFIG_PREEMPT=y
In-Reply-To: <20190103054555.GA30904@roeck-us.net>
CC:     vincentc@andestech.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-fd3c9beb-34ce-40c5-92ce-0a7d76d877aa@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jan 2019 21:45:55 PST (-0800), linux@roeck-us.net wrote:
> On Thu, Jan 03, 2019 at 11:32:33AM +0800, Vincent Chen wrote:
>> The cond_resched() can be used to yield the CPU resource if
>> CONFIG_PREEMPT is not defined. Otherwise, cond_resched() is a dummy
>> function. In order to avoid kernel thread occupying entire CPU,
>> when CONFIG_PREEMPT=y, the kernel thread needs to follow the
>> rescheduling mechanism like a user thread.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>
> This patch seems to do the trick. I no longer see a problem with
> CONFIG_PREEMPT=y and the various lock torture tests enabled, as
> previously reported.
>
> Nice catch and fix.
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> Guenter
>
>> ---
>>  arch/riscv/kernel/asm-offsets.c |    1 +
>>  arch/riscv/kernel/entry.S       |   18 +++++++++++++++++-
>>  2 files changed, 18 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>> index 6a92a2f..dac9834 100644
>> --- a/arch/riscv/kernel/asm-offsets.c
>> +++ b/arch/riscv/kernel/asm-offsets.c
>> @@ -39,6 +39,7 @@ void asm_offsets(void)
>>  	OFFSET(TASK_STACK, task_struct, stack);
>>  	OFFSET(TASK_TI, task_struct, thread_info);
>>  	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
>> +	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>>  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>>  	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 13d4826..728b72d 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -144,6 +144,10 @@ _save_context:
>>  	REG_L x2,  PT_SP(sp)
>>  	.endm
>>
>> +#if !IS_ENABLED(CONFIG_PREEMPT)
>> +#define resume_kernel restore_all
>> +#endif
>> +

I don't like preprocessor stuff if we can avoid it, are you OK if I squash in 
the following diff:

    diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
    index cfbad2f689c3..fd9b57c8b4ce 100644
    --- a/arch/riscv/kernel/entry.S
    +++ b/arch/riscv/kernel/entry.S
    @@ -145,7 +145,7 @@ _save_context:
     	.endm
    
     #if !IS_ENABLED(CONFIG_PREEMPT)
    -#define resume_kernel restore_all
    +.set resume_kernel, restore_all
     #endif
    
     ENTRY(handle_exception)

I think that should do the same thing, but at link time instead of in the 
preprocessor -- that makes it a bit less likely to bit us in the future.

>>  ENTRY(handle_exception)
>>  	SAVE_ALL
>>
>> @@ -228,7 +232,7 @@ ret_from_exception:
>>  	REG_L s0, PT_SSTATUS(sp)
>>  	csrc sstatus, SR_SIE
>>  	andi s0, s0, SR_SPP
>> -	bnez s0, restore_all
>> +	bnez s0, resume_kernel
>>
>>  resume_userspace:
>>  	/* Interrupts must be disabled here so flags are checked atomically */
>> @@ -250,6 +254,18 @@ restore_all:
>>  	RESTORE_ALL
>>  	sret
>>
>> +#if IS_ENABLED(CONFIG_PREEMPT)
>> +resume_kernel:
>> +	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
>> +	bnez s0, restore_all
>> +need_resched:
>> +	REG_L s0, TASK_TI_FLAGS(tp)
>> +	andi s0, s0, _TIF_NEED_RESCHED
>> +	beqz s0, restore_all
>> +	call preempt_schedule_irq
>> +	j need_resched
>> +#endif
>> +
>>  work_pending:
>>  	/* Enter slow path for supplementary processing */
>>  	la ra, ret_from_exception

I'm just going to assume you're OK with the squash and drop this into my plans 
for the next RC, let me know if that's not OK.

Thanks for fixing this!
