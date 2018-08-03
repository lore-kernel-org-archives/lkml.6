Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FA9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E77216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E77216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeHCIdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:33:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64637 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbeHCIdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:33:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41hcnD04kHz9tvQ2;
        Fri,  3 Aug 2018 08:38:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pScl_E4qz-9m; Fri,  3 Aug 2018 08:38:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41hcnC6YzCz9tvPl;
        Fri,  3 Aug 2018 08:38:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CB7518B79C;
        Fri,  3 Aug 2018 08:38:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EzcoYW9jCOSn; Fri,  3 Aug 2018 08:38:26 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 634F98B752;
        Fri,  3 Aug 2018 08:38:26 +0200 (CEST)
Subject: Re: [PATCH v4 5/6] powerpc: Add show_user_instructions()
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
 <20180801213320.11203-6-muriloo@linux.ibm.com>
 <7209fa95-8d40-14ca-f27a-ce3edb64191e@c-s.fr>
 <20180803004201.GA5891@kermit-br-ibm-com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <69cf990b-d4aa-97e7-be3b-7936caa91688@c-s.fr>
Date:   Fri, 3 Aug 2018 08:38:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803004201.GA5891@kermit-br-ibm-com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Murilo,

Le 03/08/2018 à 02:42, Murilo Opsfelder Araujo a écrit :
> Hi, Christophe.
> 
> On Thu, Aug 02, 2018 at 07:26:20AM +0200, Christophe LEROY wrote:
>>
>>
>> Le 01/08/2018 à 23:33, Murilo Opsfelder Araujo a écrit :
>>> show_user_instructions() is a slightly modified version of
>>> show_instructions() that allows userspace instruction dump.
>>>
>>> This will be useful within show_signal_msg() to dump userspace
>>> instructions of the faulty location.
>>>
>>> Here is a sample of what show_user_instructions() outputs:
>>>
>>>     pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>>>     pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
>>>
>>> The current->comm and current->pid printed can serve as a glue that
>>> links the instructions dump to its originator, allowing messages to be
>>> interleaved in the logs.
>>>
>>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>>> ---
>>>    arch/powerpc/include/asm/stacktrace.h | 13 +++++++++
>>>    arch/powerpc/kernel/process.c         | 40 +++++++++++++++++++++++++++
>>>    2 files changed, 53 insertions(+)
>>>    create mode 100644 arch/powerpc/include/asm/stacktrace.h
>>>
>>> diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
>>> new file mode 100644
>>> index 000000000000..6149b53b3bc8
>>> --- /dev/null
>>> +++ b/arch/powerpc/include/asm/stacktrace.h
>>> @@ -0,0 +1,13 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Stack trace functions.
>>> + *
>>> + * Copyright 2018, Murilo Opsfelder Araujo, IBM Corporation.
>>> + */
>>> +
>>> +#ifndef _ASM_POWERPC_STACKTRACE_H
>>> +#define _ASM_POWERPC_STACKTRACE_H
>>> +
>>> +void show_user_instructions(struct pt_regs *regs);
>>> +
>>> +#endif /* _ASM_POWERPC_STACKTRACE_H */
>>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>>> index e9533b4d2f08..364645ac732c 100644
>>> --- a/arch/powerpc/kernel/process.c
>>> +++ b/arch/powerpc/kernel/process.c
>>> @@ -1299,6 +1299,46 @@ static void show_instructions(struct pt_regs *regs)
>>>    	pr_cont("\n");
>>>    }
>>> +void show_user_instructions(struct pt_regs *regs)
>>> +{
>>> +	int i;
>>> +	const char *prefix = KERN_INFO "%s[%d]: code: ";
>>> +	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
>>> +					sizeof(int));
>>> +
>>> +	printk(prefix, current->comm, current->pid);
>>
>> Why not use pr_info() and remove KERN_INFO from *prefix ?
> 
> Because it doesn't compile:
> 
>    arch/powerpc/kernel/process.c:1317:10: error: expected ‘)’ before ‘prefix’
>      pr_info(prefix, current->comm, current->pid);
>              ^
>    ./include/linux/printk.h:288:21: note: in definition of macro ‘pr_fmt’
>     #define pr_fmt(fmt) fmt
>                       ^
> 
> `pr_info(prefix, ...)` expands to `printk("\001" "6" prefix, ...)`,
> which is an invalid string concatenation.
> 
> `pr_info("%s", ...)` expands to `printk("\001" "6" "%s", ...)`, which is
> valid.

Then what about using directly:

pr_info("%s[%d]: code: ", ...);

> 
>>> +
>>> +	for (i = 0; i < instructions_to_print; i++) {
>>> +		int instr;
>>> +
>>> +		if (!(i % 8) && (i > 0)) {
>>> +			pr_cont("\n");
>>> +			printk(prefix, current->comm, current->pid);
>>> +		}
>>> +
>>> +#if !defined(CONFIG_BOOKE)
>>> +		/* If executing with the IMMU off, adjust pc rather
>>> +		 * than print XXXXXXXX.
>>> +		 */
>>> +		if (!(regs->msr & MSR_IR))
>>> +			pc = (unsigned long)phys_to_virt(pc);
>>
>> Shouldn't this be done outside of the loop, only once ?
> 
> I don't think so.
> 
> pc gets incremented at the bottom of the loop:
> 
>    pc += sizeof(int);
> 
> Adjusting pc is necessary at each iteration.  Leaving this block inside
> the loop seems correct.

This looks pretty strange.
The first time, pc is a physical address, that you change to a virtual 
address. Then when you increment it it is still a virtual address.
So when you call phys_to_virt(pc) for the second time, pc is already a 
virt address, so what happens indeed ?

Christophe

> 
> Cheers
> Murilo
> 
