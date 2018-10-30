Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1590BC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EEB2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBJ09q/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EEB2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeJ3XEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:04:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34112 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeJ3XEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:04:31 -0400
Received: by mail-io1-f68.google.com with SMTP id d80-v6so7317315iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OaYZ6gYpMWu3K9PyytKUG3hwcvkHH0hWz+NChVlOHak=;
        b=OBJ09q/m4j39gkIy4E+3kDw85UX87qeUkQVdz6rxjRvPNvHbhi7SPjq/x3HK3/cDpM
         6UCVW6kHPiGl1KzhiXatKjICdhLIVRFVzZrv3zLB6dfph8Dd4DFjFJl1c0wpURcX1rMd
         FxZ/E7+KhqIi8aiMku4k80F/eTdHPD7C2nDD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OaYZ6gYpMWu3K9PyytKUG3hwcvkHH0hWz+NChVlOHak=;
        b=MYi8Dq48FocDAt+9Rpd0FokOsNFnwHB7NPnwCnqdBXpqargSCjet2Z5OSs3BivAjtv
         YA2GSTdY48PCF0ON5oU6vM8hLFMV4+ne7RY57EExeQuXttqDkxzq7oF3a/UmSC/SC/fu
         yPA+Pe/0OcMzv3q5p/3Qlq3lMxp41OGnMfeAGbq4LfPjDI0yne5R46LcPiReTx6NalFD
         460FY10aeOBD5MO01RY9HVImFltmI6DFd9KLFGdOPzt0YSxa1v39ZZ6cfUcBIUsgIKki
         xhQ1GiG3a9ExFUOtElbs4PS2kVActRF7z7LHqSaAiyvz6IQc+YNBEwJSx0foYQN5hly1
         Qvjw==
X-Gm-Message-State: AGRZ1gIRKHp6bGcWv54A428rRcqZFJuj4zm0uOBBMWfQJhHzkh/wbvNo
        iqQLRsxetFSVSI6X8I6UL5qc0xQ4qmmeVT1E0Yx0kg==
X-Google-Smtp-Source: AJdET5chjOU2HonJbh9QEqvE5h8FqxFcpncaFrv3KQifz5e12K45lBZhdyXEVYgn5l2FBaEHJbBr6tEzULnqF3XjdAY=
X-Received: by 2002:a6b:5d18:: with SMTP id r24-v6mr10810585iob.170.1540908652468;
 Tue, 30 Oct 2018 07:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 07:10:51
 -0700 (PDT)
In-Reply-To: <DAC371D3-7D52-49D5-BA99-9B90389F3197@linaro.org>
References: <20181030113850.31150-1-anders.roxell@linaro.org> <DAC371D3-7D52-49D5-BA99-9B90389F3197@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 30 Oct 2018 11:10:51 -0300
Message-ID: <CAKv+Gu_w1QaB_BEFgTHPUnMXwJGSsbT7wLYGazZDOAt7nNZNXw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: kprobe: make page to RO mode when allocate it
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 October 2018 at 08:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Hi Anders,
>
>> On 30 Oct 2018, at 08:38, Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> Commit 1404d6f13e47 ("arm64: dump: Add checking for writable and exectuable pages")
>> has successfully identified code that leaves a page with W+X
>> permissions.
>>
>> [    3.245140] arm64/mm: Found insecure W+X mapping at address (____ptrval____)/0xffff000000d90000
>> [    3.245771] WARNING: CPU: 0 PID: 1 at ../arch/arm64/mm/dump.c:232 note_page+0x410/0x420
>> [    3.246141] Modules linked in:
>> [    3.246653] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5-next-20180928-00001-ge70ae259b853-dirty #62
>> [    3.247008] Hardware name: linux,dummy-virt (DT)
>> [    3.247347] pstate: 80000005 (Nzcv daif -PAN -UAO)
>> [    3.247623] pc : note_page+0x410/0x420
>> [    3.247898] lr : note_page+0x410/0x420
>> [    3.248071] sp : ffff00000804bcd0
>> [    3.248254] x29: ffff00000804bcd0 x28: ffff000009274000
>> [    3.248578] x27: ffff00000921a000 x26: ffff80007dfff000
>> [    3.248845] x25: ffff0000093f5000 x24: ffff000009526f6a
>> [    3.249109] x23: 0000000000000004 x22: ffff000000d91000
>> [    3.249396] x21: ffff000000d90000 x20: 0000000000000000
>> [    3.249661] x19: ffff00000804bde8 x18: 0000000000000400
>> [    3.249924] x17: 0000000000000000 x16: 0000000000000000
>> [    3.250271] x15: ffffffffffffffff x14: 295f5f5f5f6c6176
>> [    3.250594] x13: 7274705f5f5f5f28 x12: 2073736572646461
>> [    3.250941] x11: 20746120676e6970 x10: 70616d20582b5720
>> [    3.251252] x9 : 6572756365736e69 x8 : 3039643030303030
>> [    3.251519] x7 : 306666666678302f x6 : ffff0000095467b2
>> [    3.251802] x5 : 0000000000000000 x4 : 0000000000000000
>> [    3.252060] x3 : 0000000000000000 x2 : ffffffffffffffff
>> [    3.252323] x1 : 4d151327adc50b00 x0 : 0000000000000000
>> [    3.252664] Call trace:
>> [    3.252953]  note_page+0x410/0x420
>> [    3.253186]  walk_pgd+0x12c/0x238
>> [    3.253417]  ptdump_check_wx+0x68/0xf8
>> [    3.253637]  mark_rodata_ro+0x68/0x98
>> [    3.253847]  kernel_init+0x38/0x160
>> [    3.254103]  ret_from_fork+0x10/0x18
>>
>> kprobes allocates a writable executable page with module_alloc() in
>> order to store executable code.
>> Reworked to that when allocate a page it sets mode RO. Inspired by
>> commit 63fef14fc98a ("kprobes/x86: Make insn buffer always ROX and use text_poke()").
>>
>> Cc: Laura Abbott <labbott@redhat.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
>> Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Please remove these SOBs, Arnd and I provided input to this patch but you are the one sending it (sob does not assert authorship or anything like that, it just asserts that the code in the patch was made available under a compatible license)
>

As Anders points out in a private communication, the Documentation/
explicitly requires signoffs for Co-developed-by credits. Perhaps we
should enhance that document to clarify that that does not mean you
can simply add signoffs on someone else's behalf.

But the patch is fine as it stands (with the received acks added)

> Also, please add the acks you received from Masami and Laura.
>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>> arch/arm64/kernel/probes/kprobes.c | 27 ++++++++++++++++++++-------
>> 1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index 9b65132e789a..decf483b4153 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -23,7 +23,9 @@
>> #include <linux/slab.h>
>> #include <linux/stop_machine.h>
>> #include <linux/sched/debug.h>
>> +#include <linux/set_memory.h>
>> #include <linux/stringify.h>
>> +#include <linux/vmalloc.h>
>> #include <asm/traps.h>
>> #include <asm/ptrace.h>
>> #include <asm/cacheflush.h>
>> @@ -42,10 +44,21 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>> static void __kprobes
>> post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
>>
>> +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
>> +{
>> +    void *addrs[1];
>> +    u32 insns[1];
>> +
>> +    addrs[0] = (void *)addr;
>> +    insns[0] = (u32)opcode;
>> +
>> +    return aarch64_insn_patch_text(addrs, insns, 1);
>> +}
>> +
>> static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>> {
>>    /* prepare insn slot */
>> -    p->ainsn.api.insn[0] = cpu_to_le32(p->opcode);
>> +    patch_text(p->ainsn.api.insn, p->opcode);
>>
>>    flush_icache_range((uintptr_t) (p->ainsn.api.insn),
>>               (uintptr_t) (p->ainsn.api.insn) +
>> @@ -118,15 +131,15 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>    return 0;
>> }
>>
>> -static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
>> +void *alloc_insn_page(void)
>> {
>> -    void *addrs[1];
>> -    u32 insns[1];
>> +    void *page;
>>
>> -    addrs[0] = (void *)addr;
>> -    insns[0] = (u32)opcode;
>> +    page = vmalloc_exec(PAGE_SIZE);
>> +    if (page)
>> +        set_memory_ro((unsigned long)page, 1);
>>
>> -    return aarch64_insn_patch_text(addrs, insns, 1);
>> +    return page;
>> }
>>
>> /* arm kprobe: install breakpoint in text */
>> --
>> 2.19.1
>>
