Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCD9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F3E20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F3E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeKJIv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:51:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39532 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeKJIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:51:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so2489042lfh.6;
        Fri, 09 Nov 2018 15:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d6IVxQ6zhaRol4IcgLK1Bixtn7ex5sBMJpQQ6yaWyFY=;
        b=Vlxzwp+VaGsWIUOY/n9gkDmDQsDwK4UO+jH9W9fu2YQUmDENyLhhavIhq7DdK7eJeo
         HV0KUdQIapey2Burqd9/zG6ES8LVgJJ1fAjA51wPsDHrWa16yXUu/MnKkL2aYndcMvEx
         iEP9Yc2EK1a//jReOnCF6BVosYbaCs0/U5p2jHCg6hw4rHVShbKDz2QeUvGWLAip9B+z
         4iN+k3TPIgwOcmZrFb45Nhy+6JGrSWQzLZJyM7OVyCUDr0X7zIGCJfaH5YPlDT46FbqJ
         GhyzHuAmZcWnc077/K6aqpS86UCEhxdsXVQGeP0sDTGxGIhtNo3Ovq6bs6qcD7bb+l66
         g75w==
X-Gm-Message-State: AGRZ1gIjQAJiss5WtxofOyHL4EGHTtyvW6YlS3FxRiYNT+u359++WxaE
        0kTbwU7+oGWOpcEGByJ4vpo=
X-Google-Smtp-Source: AJdET5fNyyzZEFEPnKUvifbkrM8vfmM9morYkIprwOcepN8htrC+3XiuzJ3SFH0Tx7Ko57dUbO4+PA==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr6692953lfa.32.1541804951509;
        Fri, 09 Nov 2018 15:09:11 -0800 (PST)
Received: from [192.168.1.183] (128-68-186-150.broadband.corbina.ru. [128.68.186.150])
        by smtp.gmail.com with ESMTPSA id p91sm856297lfg.4.2018.11.09.15.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 15:09:10 -0800 (PST)
Reply-To: alex.popov@linux.com
Subject: Re: afaef01c00 ("x86/entry: Add STACKLEAK erasing the kernel stack
 .."): double fault: 0000 [#1]
To:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, lkp@01.org,
        lkp@intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <5be58a6e.w0IbLdKsiRknTygq%lkp@intel.com>
 <CAG48ez2xSLFGjMYSYJTLwEnZoZJuXUfdoCp6_vGrywBU4SQNkQ@mail.gmail.com>
 <2B681F10-752C-4327-9960-3987CE17A619@amacapital.net>
From:   Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <e902f017-43f3-2532-69ad-3cdfca6d75c8@linux.com>
Date:   Sat, 10 Nov 2018 02:09:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2B681F10-752C-4327-9960-3987CE17A619@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.11.2018 23:46, Andy Lutomirski wrote:
>> On Nov 9, 2018, at 12:06 PM, Jann Horn <jannh@google.com> wrote:
>>
>> +Andy, Thomas, Ingo
>>
>>> On Fri, Nov 9, 2018 at 2:24 PM kernel test robot <lkp@intel.com> wrote:
>>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>
>>> commit afaef01c001537fa97a25092d7f54d764dc7d8c1
>>> Author:     Alexander Popov <alex.popov@linux.com>
>>> AuthorDate: Fri Aug 17 01:16:58 2018 +0300
>>> Commit:     Kees Cook <keescook@chromium.org>
>>> CommitDate: Tue Sep 4 10:35:47 2018 -0700
>>>
>>>    x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls
>> [...]
>>> [  127.808225] double fault: 0000 [#1]
>>> [  127.808695] CPU: 0 PID: 414 Comm: trinity-main Tainted: G                T 4.19.0-rc2-00001-gafaef01 #1
>>> [  127.809799] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>>> [  127.810760] RIP: 0010:ftrace_ops_test+0x27/0xa0
>>> [  127.811289] Code: eb 9a 90 41 54 55 49 89 f4 53 48 89 d3 48 89 fd 48 81 ec b0 00 00 00 65 48 8b 04 25 28 00 00 00 48 89 84 24 a8 00 00 00 31 c0 <e8> 54 df ff ff 48 85 db 74 57 e8 4a df ff ff 48 8b 85 d0 00 00 00
>>> [  127.813385] RSP: 0018:fffffe0000001fb8 EFLAGS: 00010046
>> [...]
>>> [  127.819762] CR2: fffffe0000001fa8 CR3: 000000001579a000 CR4: 00000000000006b0
>> [...]
>>> [  127.822234] Call Trace:
>>> [  127.822530]  <ENTRY_TRAMPOLINE>
>>> [  127.822914]  ? __ia32_sys_rseq+0x2f0/0x2f0
>>> [  127.823395]  ftrace_ops_list_func+0xa5/0x1b0
>>> [  127.823922]  ftrace_call+0x5/0x34
>>> [  127.824318]  ? stackleak_erase+0x5/0xf0
>>> [  127.824789]  ? stackleak_erase+0x43/0xf0
>>> [  127.825260]  stackleak_erase+0x5/0xf0
>>> [  127.825699]  syscall_return_via_sysret+0x61/0x81
>>> [  127.826238] WARNING: stack recursion on stack type 4
>>> [  127.826243] WARNING: can't dereference registers at (____ptrval____) for ip syscall_return_via_sysret+0x61/0x81
>>> [  127.826246]  </ENTRY_TRAMPOLINE>
>>> [  127.828342] ---[ end trace e9f96d3f45575499 ]---
>>> [  127.828911] RIP: 0010:ftrace_ops_test+0x27/0xa0
>>
>> CR2: fffffe0000001fa8, RSP: 0018:fffffe0000001fb8; this is a pagefault
>> on the stack. fffffe0000000000 is CPU_ENTRY_AREA_RO_IDT;
>> fffffe0000001000 is CPU_ENTRY_AREA_PER_CPU; so fffffe0000002000 is the
>> page with the entry stack for cpu 0, and you overflowed from that into
>> the readonly gdt at fffffe0000001000, which doubles as a guard page
>> for the entry stack:
>>
>> struct cpu_entry_area {
>>        char gdt[PAGE_SIZE];
>>
>>        /*
>>         * The GDT is just below entry_stack and thus serves (on x86_64) as
>>         * a a read-only guard page.
>>         */
>>        struct entry_stack_page entry_stack_page;
>> [...]
>> };
>>
>> In other words: You're calling C code on the entry trampoline stack;
>> this C code can call into ftrace; and the entry trampoline stack isn't
>> big enough for ftrace shenanigans. I think you probably shouldn't be
>> calling C code on the entry stack, but maybe one of the X86 folks has
>> a different opinion?
>
> My opinion was that, on x86_32, the entry stack ought to be fairly large so
> that NMIs could execute on the entry stack.  I don’t remember what the code
> actually does, though.
> 
> But stackleak_erase should probably not run on the entry stack. That seems
> like it’s just asking for trouble.

Hello Jann and Andy,


The stackleak_erase() function is called on the trampoline stack at the end of
syscall, it erases the used part of the kernel thread stack after the syscall is
handled.


I've reproduced such a double fault with function tracing for stackleak_erase():

  # mount -t tracefs nodev /sys/kernel/tracing
  # echo 'p:myprobe stackleak_erase' > /sys/kernel/debug/tracing/kprobe_events
  # echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable


I think we should simply not allow function tracing for stackleak_*() functions:

diff --git a/kernel/Makefile b/kernel/Makefile
index 7343b3a..0906f6d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MULTIUSER) += groups.o
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace internal ftrace files
 CFLAGS_REMOVE_irq_work.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_stackleak.o = $(CC_FLAGS_FTRACE)
 endif


With this patch setting kprobe event for stackleak_erase() is not allowed. This
is the corresponding dmesg output:
  [   75.660478] trace_kprobe: Could not probe notrace function stackleak_erase


If you agree, I'll prepare the patch for LKML.

Best regards,
Alexander
